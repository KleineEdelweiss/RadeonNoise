defmodule RadeonNoise.MixProject do
  use Mix.Project

  def project do
    [
      app: :radeon_noise,
      name: "RadeonNoise",
      version: "0.1.0",
      elixir: "~> 1.10",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      source_url: github_link(),
      description: description(),
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ex_doc, "~> 0.23", only: :dev, runtime: false},
      {:json, "~> 1.4"},
    ]
  end
  
  defp description() do
    "'Radeon Noise' is going to be a supervisory server to handle Radeon graphics on Linux, acting as an API layer through the amdgpu driver. The name is a play on the Index/Railgun/Accelerator franchise, by Kazuma Kamachi."
  end
  
  defp package() do
    [
      maintainers: ["KleineEdelweiss"],
      licenses: ["LGPL-3.0-only"],
      links: %{"GitHub" => github_link()},
    ]
  end
  
  defp github_link() do
    "https://github.com/KleineEdelweiss/RadeonNoise"
  end
end
