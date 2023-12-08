-- author: Prakash
-- date: 2023-11-18
local utl = require("nevl.utils")

local termid = nil
local buf = nil

local M = {}

local config = {
    shell ={
        default = "python", cpp = "reroot -l",
        julia = "julia",
        python = "python",
    }
}

local function on_close()
    if buf ~= nil then vim.api.nvim_buf_delete(buf,{force=true}) end
    termid = nil
end

local function open_window(shell)
    shell = shell or config.shell.default
    vim.cmd('split')
    local win = vim.api.nvim_get_current_win()
    buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(win, buf)
    local jobid = vim.fn.termopen(shell,{detach=false,on_exit=on_close})
    return jobid
end

local function run_command(lines,jobid)
    if termid == nil then print("No Active REPL") else
        local str = ""
        for _,ln in ipairs(lines) do if ln:gsub("%s+","") ~= "" then str = str..ln.."\n" end end
        vim.api.nvim_chan_send(jobid,str)
    end
end

function Execute_lines()
    local start = vim.fn.getpos("'[")[2]
    local finish  = vim.fn.getpos("']")[2]
    local lines = vim.fn.getline(start,finish)

    run_command(lines,termid)
end

M.repl = function(arg)
  if termid ~= nil then print("There is an existing REPL") else termid = open_window(arg) end
end

M.setup = function(configp)
    if configp ~= nil then config = utl.merge(config,configp) end
    vim.go.operatorfunc = "v:lua.Execute_lines"
    vim.keymap.set("n", "gz", "g@")
    vim.keymap.set("n", "gzz", "g@_")
    vim.keymap.set("n", "<leader><cr>", "g@ap}",{remap=true})

    vim.api.nvim_create_user_command("Revl",function(opts)
        local shell = opts.args or ''
        if shell == '' then shell =  config.shell[vim.bo.filetype] or config.shell.default end
        M.repl(shell)
    end, {nargs='*'})
end

return M

