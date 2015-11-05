defmodule BingTranslator do
  def translate(text, options \\ []) do
    BingTranslator.Translator.translate(text, options)
  end
end
