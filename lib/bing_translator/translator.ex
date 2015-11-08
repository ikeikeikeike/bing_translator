defmodule BingTranslator.Translator do
  use HTTPoison.Base

  @translate_uri "http://api.microsofttranslator.com/V2/Http.svc/Translate"
  @detect_uri "http://api.microsofttranslator.com/V2/Http.svc/Detect"
  @lang_code_list_uri "http://api.microsofttranslator.com/V2/Http.svc/GetLanguagesForTranslate"
  @access_token_uri "https://datamarket.accesscontrol.windows.net/v2/OAuth2-13"
  @speak_uri "http://api.microsofttranslator.com/v2/Http.svc/Speak"

  @info %{
    name: "BingTranslator",
    version: BingTranslator.Mixfile.project[:version],
    url: BingTranslator.Mixfile.project[:package][:links][:github]
  }

  def translate(text, options \\ []) do
    url 
    |> get
  end

  def get_access_token! do
    config = BingTranslator.Config.get
    
    body = {:form, [
        client_id: config.client_id, 
        client_secret: config.client_secret, 
        scope: "http://api.microsofttranslator.com", 
        grant_type: "client_credentials"
      ]
    }

    token = HTTPoison.post!(@access_token_uri, body).body 
            |> Poison.decode! 
            |> Enum.filter(fn{k,_} -> k in ["expires_in", "access_token"] end)

    token |> BingTranslator.Config.set_token 
    token
  end

  @test_endpoint "https://api.github.com"

  defp url do
    "#{@test_endpoint}/zen"
  end

end
