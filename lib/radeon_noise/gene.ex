defmodule RadeonNoise.Gene do
  # This module represents the core
  # operations that can be shared between
  # various submodules.
  alias String, as: Str
  
  # Just a shorthand to read all the
  # data from any one of the module files
  # and return it, stripped -- borderline
  # aliasing a function
  def read(filename), do: Str.trim(File.read!(filename))
  
  # Divide by 2 ^ 10 (gigabytes -> megabytes), etc.
  # Also, some valuable aliases
  def dkilo(val), do: val / 1024 # 1024
  def dmega(val), do: dkilo(dkilo(val)) # 1,048,576
  def dgiga(val), do: dkilo(dmega(val)) # 1,073,741,824
end