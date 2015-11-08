defmodule BingTranslator.Mixfile do
  use Mix.Project

  @description """
    Translate strings using the Bing HTTP API. Requires that you have a Client ID and Secret. See README.md for information.
  """

  def project do
    [ app: :bing_translator,
      name: "BingTranslator",
      version: "0.0.1",
      elixir: "~> 1.1",
      description: @description,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      package: package,
      deps: deps,
      source_url: "https://github.com/ikeikeikeike/bing_translator" 
    ]
  end

  def application do
    [ applications: [:httpoison, :logger, :tzdata]]
  end

  defp deps do
    [ {:httpoison, "~> 0.7.2"}, 
      {:poison, "~> 1.5"},
      {:timex, "~> 0.19"}
    ]
  end

  defp package do
    [ contributors: ["Tatsuo Ikeda / ikeikeikeike"],
      licenses: ["MIT"],
      links: %{"Github" => "https://github.com/ikeikeikeike/bing_translator"} ]
  end
end
