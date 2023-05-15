local Path = require("plenary.path")

local M = {}

local function create_dir_if_not_exists(path)
    if not Path:new(path):exists() then
        Path:new(path):mkdir({ parents = true })
    end
end
M.create_dir_if_not_exists = create_dir_if_not_exists

local function create_file_if_not_exists(path)
    if not Path:new(path):exists() then
        Path:new(path):touch()
    end
end
M.create_file_if_not_exists = create_file_if_not_exists

local function list_files_in_dir(path)
    return vim.fn.readdir(path)
end
M.list_files_in_dir = list_files_in_dir

local function check_if_file_exists(path)
    return Path:new(path):exists()
end
M.check_if_file_exists = check_if_file_exists

local function get_file_basename(path)
    return path:match("(.+)%..+")
end
M.get_file_basename = get_file_basename

return M
