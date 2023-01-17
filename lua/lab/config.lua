local config = {}

local default_config = {
	code_runner = {
		enabled = true,
	},
	quick_data = {
		enabled = true,
	},
	runnerconf_path = vim.fn.stdpath("data") .. "/lab/runnerconf",
}

config.opts = {}

config.load = function(user_config)
	config.opts = vim.tbl_deep_extend("force", default_config, user_config or {})
end

return config
