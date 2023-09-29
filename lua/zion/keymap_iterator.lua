local call_and_report_on_error = function(fn)
	local ok, err = pcall(fn)
	if not ok then
		print(vim.inspect(err))
		print(err)
	end
end

local M = {}

M.last_iterator = nil

function M.handle_next(iter)
	if iter ~= nil then
		M.last_iterator = iter
		call_and_report_on_error(iter.next)
	elseif M.last_iterator ~= nil then
		call_and_report_on_error(M.last_iterator.next)
	end
end

function M.handle_prev(iter)
	if iter ~= nil then
		M.last_iterator = iter
		call_and_report_on_error(iter.prev)
	elseif M.last_iterator ~= nil then
		call_and_report_on_error(M.last_iterator.prev)
	end
end

function M.setup_iterator(name, key, prev, next, open)
	vim.keymap.set("n", "]]", M.handle_next, { desc = "Next <<Iter>>" })
	vim.keymap.set("n", "[[", M.handle_prev, { desc = "Prev <<Iter>>" })

	local iter = { name = name, prev = prev, next = next, open = open }

	vim.keymap.set("n", "]" .. key, function()
		M.handle_next(iter)
	end, { desc = "Next " .. name })

	vim.keymap.set("n", "[" .. key, function()
		M.handle_prev(iter)
	end, { desc = "Prev " .. name })
end

return M
