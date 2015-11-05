defmodule BingTranslator do

  @doc """
  configuration
  """
  defdelegate configure, to: BingTranslator.Config, as: :configure
  defdelegate configure(client_id, client_secret), to: BingTranslator.Config, as: :configure
  defdelegate configure(client_id, client_secret, skip_ssl_verify), to: BingTranslator.Config, as: :configure
  defdelegate set_access_token(token), to: BingTranslator.Config, as: :set_access_token

  @doc """
  translattion
  """
  defdelegate translate(text), to: BingTranslator.Translator, as: :translate
  defdelegate translate(text, options), to: BingTranslator.Translator, as: :translate
end
