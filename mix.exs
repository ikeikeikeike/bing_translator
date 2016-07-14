defmodule BingTranslator.Mixfile do
  use Mix.Project

  @description """
    Translate strings using the Bing HTTP API. Requires that you have a Client ID and Secret. See README.md for information.
  """

  def project do
    [ app: :bing_translator,
      name: "BingTranslator",
      version: "0.3.0",
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
        :httpoison]]
  end

  defp deps do
    [ {:httpoison, ">= 0.0.0"},
      {:poison, ">= 0.0.0"},
      {:floki, ">= 0.0.0"},
      {:earmark, "~> 0.1", only: :dev},
      {:ex_doc, "~> 0.11", only: :dev},
      {:inch_ex, only: :docs},
    ]
  end

  defp package do
    [ maintainers: ["Tatsuo Ikeda / ikeikeikeike"],
      licenses: ["MIT"],
      links: %{"github" => "https://github.com/ikeikeikeike/bing_translator"} ]
  end
end
