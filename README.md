
# nevl
nevl is a neovim plugin to run any intepretar in neovi internal terminal buffer and send text from buffer to the terminal to run on repl. This is very small plugin that just allows you to run neovim as if it was some sort of notebook session (with the obvious caveats and limitations).


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

# Example usage

Open up a buffer with some python code for example. Then run the command "Nevl"

Or you can use
```
reqire("nevl").open_repl()
```

Based on your config it will first use the filetype shell, then try the default shell or else it will open "python" shell.


Lets say you have python shell. You can simply do
```
g@ip
```

To execute the current block of code in the repl.


