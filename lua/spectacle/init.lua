local core = require("spectacle.core")
local util = require("spectacle.util")

local setup = function(opts)
    -- init session fodler
    util.create_dir_if_not_exists(".spectacle")
end

return {
    setup = setup,
    SpectacleSave = core.SpectacleSave,
    SpectacleLoad = core.SpectacleLoad,
    SpectacleList = core.SpectacleList,
    SpectacleRename = core.SpectacleRename,
    SpectacleTelescope = core.SpectacleTelescope,
}
