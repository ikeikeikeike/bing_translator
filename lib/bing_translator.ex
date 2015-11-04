defmodule BingTranslator do
  use HTTPoison.Base

  @endpoint "https://api.github.com"

  # def zen do
    # url = "https://api.github.com/zen"
    # @endpoint <> url
    # response = get!(url)
    # response
  # end

  defp process_url(url) do
    @endpoint <> url
  end

end
