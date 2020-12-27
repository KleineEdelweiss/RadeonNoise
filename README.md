# RadeonNoise

"Radeon Noise" is going to be a supervisory server to handle Radeon graphics on Linux, acting as an API layer through the ``amdgpu`` driver. The naming scheme is a play on Raildex's "Radio Noise Project", with the Misaka clones ("sisters").

This is going to be ported from and added on to a script I made privately.

## TO-DO

1) Finish adding the processor clocking functionality
1) Add in the fan functionality
1) Add in a fan curve configurator
1) Add in other configurators, such as temp limits to throttle the GPU processor clock, etc.
1) Add in minimum fan speed configurator
1) Add in an initializer to set a default profile for each GPU in the system, including determining the possible settings through an initial test run
1) Add in the ability to identify different GPU models, possibly identify different GPUs by a customizable name or identifier
1) Add in function to format and change memory clock speed
1) Get a proper way to install this

## UPDATES

1) Added "Gene" module to offer simplified functions for use throughout the project
1) Simplified project structure, by removing 1 supermodule, as it appears not to be necessary
1) Added enumerate Radeon cards in the system
1) Added pcie_speed reader for the generic Sister module
1) Added function to read and format video RAM usage
1) Added function to read and format video RAM size
1) Added function to read and format current video RAM speed setting

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `radeon_noise` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:radeon_noise, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/radeon_noise](https://hexdocs.pm/radeon_noise).

