# nevl
nevl is a neovim plugin to run any intepretar in neovi internal terminal buffer and send text from buffer to the terminal to run on nevl. This is very small plugin that just allows you to run neovim as if it was some sort of notebook session (with the obvious caveats and limitations).


# Installation
Uset your favourate plugin manager to install it. For example using lazy.nvim

```
"pranphy/nevl"
```

# Usage
Make sure that the plugin is available in the runtime path, either through plugin manager or through manual setup of runtimepath. Then

```lua
require("nevl").setup()
```


# Configuration
This plugin comes with a default configuration:

```lua
    {
        shell ={
            default =  "python",
            cpp = "root -l",
            julia = "julia",
            python = "python",
        }
    }
```
To change th config simply pass new config table to setup.
```lua
require("nevl").setup({shell = { default="julia",python="python3"}})
```

# Example usage

Open up a buffer with some python code for example. Then run the command ":Nevl"

Or you can use
```lua
reqire("nevl").open_nevl()
```

Based on your config it will first use the filetype shell, then try the default shell or else it will open "python" shell.


Lets say you have python shell. You can simply do
```
g@ip
```

To execute the current block of code in the nevl. I find it easier to map `<Leader><cr>` to run this, so simply map this.

```lua
vim.keymap.set("n","<leader><cr>","g@ap")
```

# Also Look
[zepl.vim](https://github.com/axvr/zepl.vim)
[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)

