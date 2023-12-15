defmodule ExXendit.MixProject do
  use Mix.Project

  @version "0.1.7"
  @name "ExXendit"
  @organization "pragtechnologies"
  @description "Elixir library for Xendit based on https://developers.xendit.co/api-reference"
  @git "https://github.com/Pragtechnologies/ex_xendit"

  @deps [
    {:finch, "~> 0.16"},
    {:req, "~> 0.4.0"},
    {:exvcr, "~> 0.14", only: :test},
    {:ex_doc, "~> 0.27", only: :dev, runtime: false},
    {:excoveralls, "~> 0.10", only: :test},
    {:credo, "~> 1.7", only: [:dev], runtime: false},
    {:dialyxir, "~> 1.1", only: [:dev], runtime: false}
  ]

  def project do
    [
      app: :ex_xendit,
      version: @version,
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: @deps,
      # Docs
      name: @name,
      source_url: @git,
      homepage_url: "https://www.pragtechnologies.com/",
      description: @description,
      package: package(),
      aliases: aliases(),
      docs: [
        # The main page in the docs
        main: @name,
        logo: "logo.svg",
        extras: ["README.md", "CHANGELOG.md"]
      ],
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      dialyzer: [
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp aliases do
    [
      check: ["coveralls --env=test", "dialyzer", "credo"]
    ]
  end

  defp package do
    [
      licenses: ["Apache-2.0"],
      links: %{"GitHub" => @git},
      maintainers: [@organization]
    ]
  end
end
