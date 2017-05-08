defmodule BingTranslator.AzureTranslator do
  alias BingTranslator.Config

  @moduledoc """
  https://azure.microsoft.com/services/cognitive-services/translator-text-api/
  """
  @access_token_uri "https://api.cognitive.microsoft.com/sts/v1.0/issueToken?Subscription-Key="

  @speak_uri ""
  @detect_uri ""
  @translate_uri ""
  @translate_array_uri ""
  @lang_code_list_uri ""

  def access_token! do
    cfg = Config.get

    if cfg.expires_in && now() < cfg.expires_in do
      cfg.token
    else
      uri = @access_token_uri <> parse_env(cfg.subscription_key)
      r = HTTPoison.post! uri, 'no meaning', [], parse_http_options()
      Config.update token: r.body, expires_in: now() + 480

      r.body
    end
  end

  defp parse_http_options do
    cfg     = Config.get
    base    = [ssl: [{:versions, [:"tlsv1.2"]}]]
    options = cfg.http_client_options || []

    Keyword.merge base, options
  end

  defp now do
    :os.system_time(:second)
  end

  defp parse_env({:system, env}) when is_binary(env) do
    System.get_env(env) || ""
  end
  defp parse_env(uri) do
    uri
  end
end
