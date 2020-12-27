alias String, as: Str

gpu_mode = File.read("/sys/class/hwmon/hwmon3/device/power_dpm_force_performance_level")

case gpu_mode do
  {:ok, mode} -> IO.puts("Mode is: #{Str.trim(mode)}")
  _ -> IO.puts("Error")
end

{who, _} = System.cmd("whoami", [])

auth = fn u ->
  user = Str.trim(u)
  case user do
    "root" -> IO.puts("You are #{user}. You may pass")
    _ -> IO.puts("#{user}, stop! You have no power here!")
  end
end
auth.(who)

hwmon_dir = "/sys/class/hwmon/"

devices = File.ls!(hwmon_dir)
cards = Enum.map(devices, fn item ->
    name = Str.trim(File.read!("#{hwmon_dir}/#{item}/name"))
    case name do
      #"amdgpu" -> IO.puts("Item #{item} is a graphics card (#{name}).")
      "amdgpu" -> item
      _ -> nil
    end
  end)
  |> Enum.filter(fn x -> x != nil end)

Enum.each(cards, fn c -> IO.puts("Device at #{c} is a GPU") end)

IO.puts("Testing each card for mode setting...")
Enum.each(cards, fn c ->
    IO.puts("#{hwmon_dir}#{c}/device/power_dpm_force_performance_level")
    
    path = "#{hwmon_dir}/#{c}/device/"
    mode = "power_dpm_force_performance_level"
    options = "pp_dpm_sclk"
    
    {_, val} = File.read("#{path}#{mode}")
    IO.puts("File contains: #{val}")
    IO.puts("Setting card at #{c} to auto")
    File.write("#{path}#{mode}", "auto")
    :timer.sleep(2000)
    IO.puts("Setting it back to manual")
    File.write("#{path}#{mode}", "manual")
    
    {_, speeds} = File.read("#{path}#{options}")
    choices = String.split(speeds, "\n")
    Enum.each(choices, fn choice ->
        IO.puts("Choice is: #{choice}")
        case String.contains?(choice, "*") do
          true -> IO.puts("  THIS IS THE CURRENT SETTING")
          false -> nil
        end
      end)
    IO.puts("Available speeds: #{speeds}")
    
  end)