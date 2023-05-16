local core = require("spectacle.core")
local util = require("spectacle.util")

local setup = function(opts)
    -- init session fodler
    util.create_dir_if_not_exists(".spectacle")
end

return {
    setup = setup,
    SpectacleSave = core.SpectacleSave,
    SpectacleSaveAs = core.SpectacleSaveAs,
    SpectacleTelescope = core.SpectacleTelescope,
}
