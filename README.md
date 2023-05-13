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
| `Spectacletelescope()` | Open a telescope picker to pick an avaible session | 

