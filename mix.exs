defmodule JiraClient.Mixfile do
  use Mix.Project

  def project do
    [app: :jira_client,
     version: "0.1.0",
     elixir: "~> 1.6.4",
     escript: [
       main_module: JiraClient,
       name: "bin/jira_client",
       strip_beam: false,
     ],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [extra_applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpotion, "~> 3.0"},
      {:poison, "~> 3.1"},
      {:dialyxir, "~> 0.5", only: [:dev], runtime: false},
      {:mix_test_watch, "~> 0.8", only: :dev, runtime: false}
    ]
  end
end
