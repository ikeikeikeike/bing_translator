defmodule BingTranslator do

  @info %{
    name: "BingTranslator",
    version: BingTranslator.Mixfile.project[:version],
    url: BingTranslator.Mixfile.project[:package][:links][:github]
  }

  @doc """
  configuration
  """
  defdelegate configure, to: BingTranslator.Config, as: :configure
  defdelegate configure(client_id, client_secret), to: BingTranslator.Config, as: :configure
  defdelegate configure(client_id, client_secret, skip_ssl_verify), to: BingTranslator.Config, as: :configure

  @doc """
  translations
  """
  defdelegate translate(text), to: BingTranslator.Translator, as: :translate
  defdelegate translate(text, options), to: BingTranslator.Translator, as: :translate
  # defdelegate translate_array(text), to: BingTranslator.Translator, as: :translate_array
  # defdelegate translate_array(text, options), to: BingTranslator.Translator, as: :translate_array
  defdelegate detect(text), to: BingTranslator.Translator, as: :detect
  defdelegate speak(text), to: BingTranslator.Translator, as: :speak
  defdelegate speak(text, options), to: BingTranslator.Translator, as: :speak
  defdelegate supported_language_codes, to: BingTranslator.Translator, as: :supported_language_codes
end
