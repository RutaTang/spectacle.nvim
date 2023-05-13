local util = require("spectacle.util")

local M = {}

local loadFrom = "" -- load from which session

local SpectacleSave = function()
    if loadFrom ~= "" then
        local p = ".spectacle/" .. loadFrom .. ".vim"
        vim.cmd("mksession! " .. p)
    else
        -- get user input for seesion name
        local session_name = vim.fn.input("Session name: ")
        if session_name == "" then
            print("Session name cannot be empty")
            return
        end
        -- form session file path
        local p = ".spectacle/" .. session_name .. ".vim"
        -- check if session name already exists
        local session_exists = util.check_if_file_exists(p)
        if session_exists then
            print("Session name already exists")
        end
        -- save session
        vim.cmd("mksession! " .. p)
        -- update loadFrom
        loadFrom = session_name
    end
end
M.SpectacleSave = SpectacleSave

local SpectacleList = function()
    local files = util.list_files_in_dir(".spectacle")
    for i, file in ipairs(files) do
        print(i .. ":", util.get_file_basename(file))
    end
end
M.SpectacleList = SpectacleList

local SpectacleLoad = function()
    local session_name = vim.fn.input("Session name: ")
    if session_name == "" then
        print("Session name cannot be empty")
        return
    end
    local p = ".spectacle/" .. session_name .. ".vim"
    local session_exists = util.check_if_file_exists(p)
    if not session_exists then
        print("Session does not exist")
        return
    end
    vim.cmd("source " .. p)
    -- Update loadFrom
    loadFrom = session_name
end
M.SpectacleLoad = SpectacleLoad

local SpectacleRename = function()
    if loadFrom == "" then
        print("No session loaded")
        return
    end
    local new_name = vim.fn.input("New name: ")
    if new_name == "" then
        print("Session name cannot be empty")
        return
    end
    local old_path = ".spectacle/" .. loadFrom .. ".vim"
    local new_path = ".spectacle/" .. new_name .. ".vim"
    local session_exists = util.check_if_file_exists(new_path)
    if session_exists then
        print("Session name already exists")
        return
    end
    -- rename session
    vim.loop.fs_rename(old_path, new_path)
    -- update loadFrom
    loadFrom = new_name
end
M.SpectacleRename = SpectacleRename

return M
