--[[

lab.nvim
Copyright: (c) 2022, Dan Peterson <hi@dan-peterson.ca>

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.

--]]

local Process = require 'lab.process'
local CodeRunner = require 'lab.code_runner'

local Lab = {}
local state = { active = false }

local c = require 'lab.config'

function Lab.setup(opts)
	if state.active == true then return end
	
  c.load(opts)

	if c.opts.code_runner.enabled or c.opts.quick_data.enabled then
		Process:start()
	end

	if c.opts.code_runner.enabled then
		CodeRunner.setup(c.opts);
	end

	if c.opts.quick_data.enabled then
		local has_cmp, cmp = pcall(require, 'cmp')
		if has_cmp then
			require('lab.quick_data').init()
		else
			vim.notify("Quick data feature requires nvim cmp", "error", { title = "Lab.nvim" });
		end
	end

	state.active = true;
end

function Lab.reset()
	Process:stop()
	Process:start()
end

function Lab.stop()
	Process:stop()
end

return Lab
