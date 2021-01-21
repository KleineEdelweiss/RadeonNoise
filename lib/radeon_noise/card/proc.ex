defmodule RadeonNoise.Card.Proc do
  @moduledoc """
    This submodule is for the GPU core
    functions of the Card module
  """
  alias String, as: Str
  alias RadeonNoise.Gene

  @doc """
    Processor files
  """
  def proc_files(idx, card) do
    suffix = case idx do
      :perf -> "device/power_dpm_force_performance_level"
      :clock -> "device/pp_dpm_sclk"
    end
    "#{card}/#{suffix}"
  end

  @doc """
    Read the processor clock mode (manual/auto)
    File: device/power_dpm_force_performance_level
  """
  def rcms(card) do
    Gene.read(proc_files(:perf, card))
  end

  @doc """
    Toggle the processor clock mode (manual/auto)
    File: device/power_dpm_force_performance_level
    "auto" or "manual"
  """
  def tcms(card) do
    f = proc_files(:perf, card)
    case rcms(card) do
      "auto" -> File.write(f, "manual")
      _ -> File.write(f, "auto")
    end
    rcms(card)
  end

  @doc """
    Read the currently-allowed clock speeds
    File: device/pp_dpm_sclk
  """
  def rcl(card) do
    cls(card)
    |> Enum.filter(&(Enum.fetch!(&1, -1) == "*"))
    |> Enum.map(&(Enum.fetch!(&1, 1)))
  end

  @doc """
    Set the clock speed
    File: device/pp_dpm_sclk
  """
  def scl(card) do
    
  end
  
  @doc """
    Return the complete list of
    clock speeds the card can accept
    File: device/pp_dpm_sclk
  """
  def cls(card) do
    File.read!(proc_files(:clock, card))
    |> Str.split("\n")
    |> Enum.map(fn speed ->
        Str.split(speed, ~r{\s})
        |> Enum.map(&(Str.replace(&1, ":", ""))) end)
    |> Enum.filter(&(length(&1) > 1))
  end
end