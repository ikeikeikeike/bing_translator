defmodule BingTranslator.Base do
  @moduledoc """
  Base API Client
  """
  defmacro __using__(endpoint) do
    quote do
      use HTTPoison.Base
      alias BingTranslator.Config

      @endpoint unquote(endpoint)
      # secs
      @expires 480

      def process_url(path) do
        Path.join(@endpoint, path)
      end

      def process_request_body(body) do
        case body do
          {:form, form} ->
            {:form, transform(form)}

          body ->
            body
        end
      end

      def process_request_headers(headers) when is_map(headers) do
        headers
        |> Map.merge(%{"Authorization" => "Bearer #{access_token!()}"})
        |> Enum.into([])
      end

      def process_request_headers(headers) do
        Keyword.merge(headers, Authorization: "Bearer #{access_token!()}")
      end

      def process_request_options(options) do
        Keyword.merge(options, parse_http_options())
      end

      def process_response_body(body) do
        body
        # case Poison.decode body do
        #   {:ok,    body}        -> body
        #   {:error, body}        -> body
        #   {:error, :invalid, 0} -> body
        # end
      end

      defp transform(payload) do
        for {k, v} <- payload, into: [], do: {:"#{k}", v}
      end

      @token_uri "https://api.cognitive.microsoft.com/sts/v1.0/issueToken?Subscription-Key="
      defp access_token! do
        cfg = Config.get()

        if cfg.expires_in && rightnow() < cfg.expires_in do
          cfg.token
        else
          uri = @token_uri <> parse_env(cfg.subscription_key)
          r = HTTPoison.post!(uri, 'nothing', [], parse_http_options(:ssl))
          Config.update(token: r.body, expires_in: rightnow() + @expires)

          r.body
        end
      end

      defp rightnow do
        :os.system_time(:seconds)
      end

      defp parse_env({:system, env}) when is_binary(env) do
        System.get_env(env) || ""
      end

      defp parse_env(uri) do
        uri
      end

      @base_http_options [ssl: [{:versions, [:"tlsv1.2"]}]]
      defp parse_http_options(:ssl) do
        Keyword.merge(@base_http_options, Config.get().http_client_options)
      end

      defp parse_http_options do
        base =
          if String.starts_with?(@endpoint, "https") do
            @base_http_options
          else
            []
          end

        Keyword.merge(base, Config.get().http_client_options)
      end
    end
  end
end
