defmodule BingTranslator.Translator do
  use HTTPoison.Base

  @default_endpoint "https://api.github.com"

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
    client_id = Application.get_env(:bing_translator, :client_id)
    client_secret = Application.get_env(:bing_translator, :client_secret)
    endpoint = Application.get_env(:bing_translator, :endpoint, @default_endpoint)
    # "#{endpoint}/api/v3/projects/#{client_id}/notices?key=#{client_secret}"
    "#{endpoint}/zen"
  end

end
