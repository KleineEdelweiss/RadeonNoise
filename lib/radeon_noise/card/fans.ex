defmodule RadeonNoise.Card.Fans do
  @moduledoc """
    This submodule is for the GPU fans
    functions of the Card module
    
    Default fan validation settings include
    every number, 1 to 255, with either
    the output number as its value, 
    and its key being the number, with an 
    'n' before it.
    e.g.:
    {
      n1: 0,
      n153: 153,
      n155: 153,
      n158: 155,
      [etc.]
    }
    
    Default fan configuration settings include
    every VALID number, 1 to 255, set to TRUE,
    ONLY IF the number rounds closest to one of
    the 10% marks.
    
    EXACT 10% mark matches are automatically true.
    e.g.:
    153 is valid on my test card, and it is 60%
    158 is valid, but it is not closer to 60% than 153
    188 is valid, but it is 73.73%
    204 is valid, and it is 80%
    {
      [..]
      n153: true,
      n158: false,
      [..]
      n188: false,
      [..]
      n204: true,
      [etc.]
    }
  """
  alias String, as: Str
  alias RadeonNoise.Gene
  
  @doc """
    Return the speed configuration file
  """
  defp speed_file(card), do: "#{speed_vfile(card)}.json"
  
  @doc """
    Return the file containing valid speeds
  """
  defp speed_vfile(card), do: "#{File.cwd!}/configs/#{hd Enum.reverse(Str.split(card, "/"))}"
  
  @doc """
    PWM files
  """
  defp pwm_files(card, item) do
    case item do
     :setting -> "#{card}/pwm1_enable"
     :state -> "#{card}/pwm1"
    end
  end

  def get_speeds(card) do
    IO.puts("Card config found? #{File.exists?(speed_file(card))}")
    
  end
  
  @doc """
    Check if a card has a defined configuration
      Will eventually need to check based on a card
      unique identifier
    Returns the config file
  """
  def check_config(card) do
    cfg = speed_file(card)
    case File.exists?(cfg) do
      true -> validate_config(card)
      false -> gen_def_config(card)
    end
    cfg
  end
  
  @doc """
    Validate an existing config file
  """
  defp validate_config(card) do
    IO.puts("Validating existing config file")
  end
  
  @doc """
    Test the speeds for a given card and return
    only valid PWM numbers
    
    File: pwm1
  """
  defp test_speeds(card) do
    IO.puts("Testing speeds, writing new validation file")
    Gene.read()
  end
  
  @doc """
    Generate a default config for the card
  """
  def gen_def_config(card) do
    vcfg = speed_vfile(card)
    case File.exists?(vcfg) do
      false -> test_speeds(card)
      true -> IO.puts("Validation config already exists")
    end
    #File.copy!(vcfg, speed_file(card))
  end
  
  @doc """
    Set the PWM manual
  """
  def manual(card) do
    File.write!(pwm_files(card, :setting), "1")
  end
  
  @doc """
    Set the PWM auto
  """
  def auto(card) do
    File.write!(pwm_files(card, :setting), "2")
  end
  
  @doc """
    Set a numeric value for the fans
  """
  def numeric(card, number) when is_integer(number) do
    manual(card)
    val = case number do
      n when number > 255 -> 255
      n when number < 0 -> 0
      _ -> number
    end
    File.write!(pwm_files(card, :state), "#{val}")
  end
  def numeric(card, number) when is_float(number), do: numeric(card, trunc(number))
  def numeric(_, _), do: raise("Fan speed can only be integers! (Only floats are automatically converted)")
  
  @doc """
    Set a percentage value for the fans
  """
  def set_perc(card, number) do
    manual(card)
    IO.puts("Set some percentage")
  end
end