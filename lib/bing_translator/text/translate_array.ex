defmodule BingTranslator.Text.TranslateArray do
  @moduledoc """
  <TranslateArrayRequest>
    <AppId />
    <From>language-code</From>
    <Texts>
      <string xmlns="http://schemas.microsoft.com/2003/10/Serialization/Arrays">fu*k</string>
      <string xmlns="http://schemas.microsoft.com/2003/10/Serialization/Arrays">fu*king</string>
    </Texts>
    <To>ja</To>
  </TranslateArrayRequest>
  """
  use BingTranslator.Base, "https://api.microsofttranslator.com/v2/Http.svc"
  import XmlBuilder

  def run(params) do
    case post("/TranslateArray", build(params), %{"Content-type" => "application/xml"}) do
      {:ok, %{body: xml}} when is_binary(xml) ->
        parse(xml)

      error ->
        error
    end
  end

  @xmlns "http://schemas.microsoft.com/2003/10/Serialization/Arrays"
  defp build(params) do
    kw = transform(params)

    built =
      element(
        :TranslateArrayRequest,
        erase([
          element(:AppId, "Bearer #{access_token!()}"),
          if(kw[:from], do: element(:From, kw[:from])),
          element(
            :Texts,
            Enum.map(kw[:texts], fn text ->
              element(:string, %{xmlns: @xmlns}, text)
            end)
          ),
          element(:To, kw[:to])
        ])
      )

    generate(built)
  end

  defp parse(xml) do
    Floki.find(xml, "translatedtext")
    |> Floki.text(sep: " ")
    |> String.split()
  end

  defp erase(elems) do
    Enum.filter(elems, fn
      e when is_list(e) -> erase(e)
      nil -> false
      elm -> !!elem(elm, 2)
    end)
  end
end
