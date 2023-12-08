# nevl.nvim
`nevl.nvim` is a neovim plugin to run any intepretar in neovim's internal terminal buffer and send text from buffer to the terminal to run on repl. This is very small plugin that just allows you to run neovim as if it was some sort of notebook session (with the obvious caveats and limitations).


# Installation
Uset your favourate plugin manager to install it. For example using lazy.nvim

```
"pranphy/nevl.nvim"
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
Based on your config it will first use the filetype shell, then try the default shell or else it will open "python" shell.

You can also pass the shell argument, and it will open that in a split window. For example, `:Nevl octave` will open a octave repl on split buffer. 

Or you can use
```lua
reqire("nevl").open_repl("bash")
```



# Mapping

There is a operator pending mapping that will send whatever text in the buffer is selected by motion and execute in the REPL.  The operator pending mapping is
```
gz
```


Lets say you have python shell. You can simply do
```
gzip
```
and it will execute current block of code from the buffer in the shell.

 I find it easier to map `<Leader><cr>` to run this, so simply map this.

```lua
vim.keymap.set("n","<leader><cr>","g@ap")
```
Which is already defined too. Other defined mappings are

 - `gzz` to execute current line

 # TODO
 - [ ] Improve mapping for execution.
 - [ ] Visual mode support ), or may be even insert mode? (currently only normal mode


# Also Look
[zepl.vim](https://github.com/axvr/zepl.vim). Massive credit to this plugin, which I was using for a long time, and now this has been archived. I had developed so much dependency on this plugin I could not find any useful alternative so I decided to write this myself.   
[toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim)

