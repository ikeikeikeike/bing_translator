defmodule BingTranslator.Mixfile do
  use Mix.Project

  @description """
    Translate strings using the Bing HTTP API. Requires that you have a Client ID and Secret. See README.md for information.
  """

  def project do
    [
      app: :bing_translator,
      name: "BingTranslator",
      version: "1.0.1",
      elixir: ">= 1.0.0",
      description: @description,
      build_embedded: Mix.env == :prod,
      start_permanent: Mix.env == :prod,
      package: package(),
      deps: deps(),
      source_url: "https://github.com/ikeikeikeike/bing_translator"
    ]
  end

  def application do
    [extra_applications: [:logger],
     mod: {BingTranslator.Application, []}]
  end

  defp deps do
    [
      {:httpoison, "~> 0.11"},
      {:floki, "~> 0.17"},
      {:xml_builder, "~> 0.0"},
      {:credo, "~> 0.7", only: :dev},
      {:earmark, "~> 1.2", only: :dev},
      {:ex_doc, "~> 0.15", only: :dev},
      {:inch_ex, ">= 0.0.0", only: :docs},
    ]
  end

  defp package do
    [
      maintainers: ["Tatsuo Ikeda / ikeikeikeike"],
      licenses: ["MIT"],
      links: %{"github" => "https://github.com/ikeikeikeike/bing_translator"}
    ]
  end
end
