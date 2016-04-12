defmodule BingTranslator.Mixfile do
  use Mix.Project

  @description """
    Translate strings using the Bing HTTP API. Requires that you have a Client ID and Secret. See README.md for information.
  """

  def project do
    [ app: :bing_translator,
      name: "BingTranslator",
      version: "0.2.7",
      elixir: ">= 1.0.0",
      description: @description,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      package: package,
      deps: deps,
      source_url: "https://github.com/ikeikeikeike/bing_translator"
    ]
  end

  def application do
    [ applications: [
        :logger,
        :tzdata,
        :httpoison]]
  end

  defp deps do
    [ {:httpoison, "~> 0.8"},
      {:poison, "~> 1.5"},
      {:timex, "~> 2.0"},
      {:floki, "~> 0.7"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev}
    ]
  end

  defp package do
    [ maintainers: ["Tatsuo Ikeda / ikeikeikeike"],
      licenses: ["MIT"],
      links: %{"github" => "https://github.com/ikeikeikeike/bing_translator"} ]
  end
end
