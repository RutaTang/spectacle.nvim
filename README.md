# Spectacle.nvim

The plugin is designed for working with mutiple sessions. With it, you can easily store and change your session.

In addition, it also supports the integration with telescope.nvim.


## Installnation

Useing any plugin you like, here is how to use with lazy.nvim plugin manager:

```lua
require("lazy").setup({
  { 
    "RutaTang/spectacle.nvim",
    config = function()
        require("spectacle").setup()
    end,
    dependencies = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim'
    } 
  },
})
```

## API

| API | Description |
|-----|-------------|
|  `SpectacleSave()`   |      Save session       |
| `SpectacleLoad()`     | Load session             |
|  `SpectacleList()`    |     List all saved session        |
| `SpectacleRename()` | Rename session |
| `SpectacleTelescope()` | Open a telescope picker to pick an avaible session | 

For example, you can call `SpectacleTelescope` like this:

```lua
:lua require('spectacle').SpectacleTelescope()
```

You can also set a keymap to conviniently call the function like this:

```lua
vim.api.nvim_set_keymap("n", "<leader>t", "<cmd>:lua require('spectacle').SpectacleTelescope()<cr>",{})
```
