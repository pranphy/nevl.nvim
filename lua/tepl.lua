-- author: Prakash
-- date: 2023-11-18
local utl = require("tepl.utils")

local termid = nil
local buf = nil

local M = {}

local config = {
    shell ={
        default =  "python",
        cpp = "reroot -l",
        julia = "julia",
        python = "python",
    }
}

local function on_close()
    if buf ~= nil then vim.api.nvim_buf_delete(buf,{force=true}) end
    termid = nil
end

local function open_window(shell)
    if shell == nil then shell = config.shell.default end
    vim.cmd('split')
    local win = vim.api.nvim_get_current_win()
    buf = vim.api.nvim_create_buf(true, true)
    vim.api.nvim_win_set_buf(win, buf)
    local jobid = vim.fn.termopen(shell,{detach=false,on_exit=on_close})
    return jobid
end

local function run_command(lines,jobid)
    if termid == nil then print("No Active") else
        local str = ""
        for _,ln in ipairs(lines) do str = str..ln.."\n" end
        vim.api.nvim_chan_send(jobid,str)
    end
end

local function execute_cur_line()
    local str = vim.api.nvim_get_current_line()
    run_command(str.."\n",termid)
end

-- https://stackoverflow.com/a/72197874
local run_motion = function ()
  local old_func = vim.go.operatorfunc
  _G.op_run_motion = function()

    local start = vim.fn.getpos("'[")[2]
    local finish  = vim.fn.getpos("']")[2]
    local lines = vim.fn.getline(start,finish)

    run_command(lines,termid)

    vim.go.operatorfunc = old_func
    _G.op_run_motion = nil
  end
  vim.go.operatorfunc = 'v:lua.op_run_motion'
end

M.operator =  function(motion)
    return function()
        run_motion()
        vim.api.nvim_feedkeys('g@'..(motion or ''), 'n', false)
    end
end


M.whid = function(arg)
  if termid ~= nil then print("There is an existing REPL") else termid = open_window(arg) end
end

M.setup = function(configp)
    if configp ~= nil then config = utl.merge(config,configp) end
    vim.keymap.set("n", "gz", M.operator(),{noremap=true}) --, {noremap = true})
    vim.keymap.set("n", "gzz", M.operator("_j"),{noremap=true}) --, {noremap = true})
    vim.keymap.set("n", "<leader><cr>", M.operator("ap}"),{noremap=true}) --, {noremap = true})

    local command = vim.api.nvim_create_user_command
    command("Tepl",function(opts)
        local shell = opts.args
        if shell == nil or shell == '' then
            shell = config.shell[vim.bo.filetype] or config.shell.default
        end
        require("tepl").whid(shell)
    end, {nargs='?'})
end

return M

