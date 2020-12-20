defmodule RadeonNoise.Sisters.Sister do
	# This module represents an individual graphics card
	alias String, as: Str
	
	# Return some known variables
	def basedir, do: "/sys/class/hwmon/"
	
	# Authenticate user -- only root can modify
	# GPU driver settings
	def authenticate do
		{who, _} = System.cmd("whoami", [])
		user = Str.trim(who)
		case user do
			"root" -> true
			_ -> user
		end
	end
	
	# Enumerate the GPUs in the system, return them
	# as a list
	def enumerate do
		bd = basedir()
		case authenticate() do
			true ->
					File.ls!(bd)
					|> Enum.map(fn item ->
						name = Str.trim(File.read!("#{bd}/#{item}/name"))
						case name do
							"amdgpu" -> "#{bd}#{item}"
							_ -> nil
						end
					end)
					|> Enum.filter(fn x -> x != nil end)
			name ->
					IO.puts("User #{name} is not root -- you must run this module as root")
					nil
		end
	end
	
	# Get the transfer speed of the PCIe slot
	# File: device/pp_dpm_pcie
	def pcie_speed(card) do
		
	end
	
	
end