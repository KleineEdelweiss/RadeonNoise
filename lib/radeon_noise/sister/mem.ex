defmodule RadeonNoise.Sister.Mem do
  # This submodule is for the GPU memory
  # functions of the Sister (card) module
  alias String, as: Str
  alias RadeonNoise.Gene

  # VRAM amount
  # File: device/mem_info_vram_total
  def total(card) do
    Gene.read("#{card}/device/mem_info_vram_total")
    |> Float.parse
    |> elem(0)
    |> Gene.dmega # Chose to use MB, b/c of cheaper cards
    |> (fn x -> "#{x} MB" end).()
  end

  # Read VRAM usage
  # File: device/mem_busy_percent
  def usage(card) do
    Gene.read("#{card}/device/mem_busy_percent")
    |> (fn x -> "#{x}%" end).()
  end

  # Read the VRAM speed
  # File: device/pp_dpm_mclk
  def get_speed(card) do
    Gene.read("#{card}/device/pp_dpm_mclk")
    |> Str.split("\n")
    |> Enum.filter(fn x -> Str.ends_with?(x, "*") end)
    |> hd
    |> Str.split(~r{\s})
    |> Enum.take(-2)
    |> hd
    |> Str.trim()
  end
  
  #Set the VRAM speed
  # File: device/pp_dpm_mclk
  # Will have to add this, once I figure out why
  # it doesn't work through the driver's direct API...
  #def set_speed(card) do
  #  
  #end
end