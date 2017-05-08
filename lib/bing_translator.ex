defmodule BingTranslator do
  @moduledoc """
  All of delegation for API.
  """
  defdelegate translate(params), to: BingTranslator.Text.Translate, as: :run
  defdelegate translate_array(params), to: BingTranslator.Text.TranslateArray, as: :run
  defdelegate detect(params), to: BingTranslator.Text.Detect, as: :run
  defdelegate speak(params), to: BingTranslator.Text.Speak, as: :run
  defdelegate supported_language_codes, to: BingTranslator.Text.SupportedLanguageCodes, as: :run
end
