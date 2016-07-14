defmodule BingTranslator.Translator do
  use HTTPoison.Base

  @access_token_uri "https://datamarket.accesscontrol.windows.net/v2/OAuth2-13"

  @speak_uri "http://api.microsofttranslator.com/v2/Http.svc/Speak"
  @detect_uri "http://api.microsofttranslator.com/V2/Http.svc/Detect"
  @translate_uri "http://api.microsofttranslator.com/V2/Http.svc/Translate"
  @translate_array_uri "http://api.microsofttranslator.com/V2/Http.svc/TranslateArray"
  @lang_code_list_uri "http://api.microsofttranslator.com/V2/Http.svc/GetLanguagesForTranslate"

  def translate(text, options \\ []) do
    params = %{
      text: text,
      to: options[:to],
      from: options[:from],
      category: "general",
      contentType: "text/plain"
    }

    result(@translate_uri, params).body
    |> Floki.find("string") |> Floki.text
  end

  def detect(text) do
    params = %{
      text: text,
      category: "general",
      contentType: "text/plain"
    }

    result(@detect_uri, params).body
    |> Floki.find("string") |> Floki.text
  end

  # format:   "audio/wav" [default] or "audio/mp3"
  # language: valid translator language code
  # options:  "MinSize" [default] or "MaxQuality"
  def speak(text, options \\ []) do
    params = %{
      text: text,
      format: options[:format],
      language: options[:language]
    }

    result(@speak_uri, params, %{"Content-Type" => options[:format]}).body
  end

  def supported_language_codes do
    result(@lang_code_list_uri, %{}).body
    |> Floki.find("string") |> Enum.map(fn(lang) -> Floki.text(lang) end)
  end

  def get_access_token! do
    config = BingTranslator.Config.get
    token = config.token

    case token && token[:access_token] && :os.system_time(:seconds) < token[:expires_in] do
      true ->
        token
      _ ->
        body = {:form, [
            client_id: config.client_id,
            client_secret: config.client_secret,
            scope: "http://api.microsofttranslator.com",
            grant_type: "client_credentials"
          ]
        }
        token =
          post!(@access_token_uri, body)
          |> parse_token

        BingTranslator.Config.set_token(token)
        token
    end
  end

  defp parse_token(response) do
    response.body
    |> Poison.decode!
    |> Enum.filter(fn{k, _} ->
      k in ["expires_in", "access_token"]
    end)
    |> Enum.map(fn{k, v} ->
      value =
        case k do
          "expires_in" ->
            :os.system_time(:seconds) + String.to_integer(v)
          _ ->
            v
        end
      {String.to_atom(k), value}
    end)
  end

  defp result(url, params, headers \\ []) do
    auth = "Bearer #{get_access_token![:access_token]}"

    headers =
      headers
      |> Enum.into(%{})
      |> Map.merge(%{"Authorization" => auth})

    get!("#{url}?#{URI.encode_query(params)}", headers)
  end

end
