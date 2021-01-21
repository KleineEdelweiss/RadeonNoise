defmodule RadeonNoise.Application do
	use Application
	
	def start(_type, _init_list) do
		children = [
			
		]
		
		opts = [strategy: :one_for_one, name: RadeonNoise.Supervisor]
		Supervisor.start_link(children, opts)
	end
end