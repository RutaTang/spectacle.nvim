local util = require("spectacle.util")
local actions = require("telescope.actions")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values

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
    if #files == 0 then
        print("No sessions found")
        return
    end
    for i, file in ipairs(files) do
        print(i .. ":", util.get_file_basename(file))
    end
end
M.SpectacleList = SpectacleList

local _load_session = function(session_name)
    local p = ".spectacle/" .. session_name .. ".vim"
    local session_exists = util.check_if_file_exists(p)
    if not session_exists then
        print("Session does not exist")
        return
    end
    vim.cmd("source " .. p)
end

local SpectacleLoad = function()
    local session_name = vim.fn.input("Session name: ")
    if session_name == "" then
        print("Session name cannot be empty")
        return
    end
    _load_session(session_name)
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

local SpectacleTelescope = function()
    -- get all session names
    local files = util.list_files_in_dir(".spectacle")
    local results = {}
    for _, file in ipairs(files) do
        table.insert(results, util.get_file_basename(file))
    end
    -- create telescope picker
    local sessions = function(opts)
        opts = opts or {}
        pickers
            .new(opts, {
                prompt_title = "Sessions",
                finder = finders.new_table({
                    results = results,
                }),
                sorter = conf.generic_sorter(opts),
                attach_mappings = function(prompt_bufnr, map)
                    local load_session_map = function()
                        local selection = action_state.get_selected_entry()
                        actions.close(prompt_bufnr)
                        _load_session(selection.value)
                    end
                    map("n", "<CR>", load_session_map)
                    map("i", "<CR>", function()
                    end)
                    return true
                end,
            })
            :find()
    end
    sessions(require("telescope.themes").get_dropdown({}))
end
M.SpectacleTelescope = SpectacleTelescope

return M
