defmodule RadeonNoise.Gene do
  @moduledoc """
    This module represents the core, general-purpose
    operations that can be shared between
    various submodules.
    
    Additionally, it includes various shorthands
    for frequently-used operations.
  """
  alias String, as: Str
  
  @doc """
    Just a shorthand to read all the
    data from any one of the module files
    and return it, stripped -- borderline
    aliasing a function
  """
  def read(filename), do: Str.trim(File.read!(filename))
  
  @doc """
    Divide by 2 ^ 10 (kilobytes -> bytes), etc.
  """
  def dkilo(val), do: val / 1024 # 1024
  
  @doc """
    Divide by 2 ^ 20 (megabytes -> kilobytes), etc.
  """
  def dmega(val), do: dkilo(dkilo(val)) # 1,048,576
  
  @doc """
    Divide by 2 ^ 30 (gigabytes -> megabytes), etc.
  """
  def dgiga(val), do: dkilo(dmega(val)) # 1,073,741,824
end