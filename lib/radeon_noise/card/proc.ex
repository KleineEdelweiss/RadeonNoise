defmodule RadeonNoise.Card.Proc do
  # This submodule is for the GPU core
  # functions of the Card module
  alias String, as: Str
  alias RadeonNoise.Gene

  # Processor files
  def proc_files, do: %{:perf => "device/power_dpm_force_performance_level",
      :clock => "device/pp_dpm_sclk"}

  # Read the processor clock mode (manual/auto)
  # File: device/power_dpm_force_performance_level
  def rcms(card) do
    Str.trim(File.read!("#{card}/#{proc_files()[:perf]}"))
  end

  # Toggle the processor clock mode (manual/auto)
  # File: device/power_dpm_force_performance_level
  # "auto" or "manual"
  def tcms(card) do
    
  end

  # Read the clock speed
  # File: device/pp_dpm_sclk
  def rcl(card) do
    
  end

  # Set the clock speed
  # File: device/pp_dpm_sclk
  def scl(card) do
    
  end
end