-- Set font
if vim.fn.has("unix") == 1 then
	local uname = vim.fn.system("uname")
	if uname == "Darwin\n" then
		vim.opt.guifont = "JetBrainsMono Nerd Font:h15"
	else
		vim.opt.guifont = "JetBrainsMono Nerd Font:h14"
	end
end
