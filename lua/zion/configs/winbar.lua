-- Automatically loaded on the VeryLazy event
-- see lua/configs/init.lua for more details

local exclude_filetypes = {
	"help",
	"startify",
	"dashboard",
	"packer",
	"neogitstatus",
	"NvimTree",
	"Trouble",
	"alpha",
	"lir",
	"Outline",
	"spectre_panel",
	"toggleterm",
	"qf",
	"dapui_hover",
	"TelescopePrompt",
}

local function set_winbar_value(value)
	-- pcall stands for protected call
	-- in some cases (e.g. telescope) setting winbar fails
	pcall(vim.api.nvim_set_option_value, "winbar", value, { scope = "local" })
end

local function is_excluded()
	return vim.tbl_contains(exclude_filetypes, vim.bo.filetype)
end

local function get_navic_output()
	local navic = require("nvim-navic")

	if navic == nil or not navic.is_available() then
		return nil
	end

	local location = navic.get_location({})

	if location == nil or location == "" then
		return nil
	end

	return location
end

local function update_winbar()
	if is_excluded() then
		--set_winbar_value("[no data]")
		return
	end

	set_winbar_value("  " .. (get_navic_output() or ""))
end

-- vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
-- 	callback = function()
-- 		pcall(update_winbar)
-- 	end,
-- })
