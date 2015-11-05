defmodule BingTranslator.Translator do
  use HTTPoison.Base

  @translate_uri = 'http://api.microsofttranslator.com/V2/Http.svc/Translate'
  @detect_uri = 'http://api.microsofttranslator.com/V2/Http.svc/Detect'
  @lang_code_list_uri = 'http://api.microsofttranslator.com/V2/Http.svc/GetLanguagesForTranslate'
  @access_token_uri = 'https://datamarket.accesscontrol.windows.net/v2/OAuth2-13'
  @speak_uri = 'http://api.microsofttranslator.com/v2/Http.svc/Speak'

  @info %{
    name: "BingTranslator",
    version: BingTranslator.Mixfile.project[:version],
    url: BingTranslator.Mixfile.project[:package][:links][:github]
  }

  def translate(text, options \\ []) do
    url 
    |> get
  end

  defp url do
  end

end
