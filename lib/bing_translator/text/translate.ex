defmodule BingTranslator.Text.Translate do
  @moduledoc """
  http://docs.microsofttranslator.com/text-translate.html#!/default/get_Translate
  """
  use BingTranslator.Base, "http://api.microsofttranslator.com/v2/Http.svc"

  def run(params) do
    case get "/Translate", [], params: params do
      {:ok, %{body: xml}} when is_binary(xml) ->
        Floki.text Floki.find(xml, "string")
      error ->
        error
    end
  end

end
