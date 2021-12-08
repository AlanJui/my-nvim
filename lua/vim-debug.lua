local is_empty = require('utils.path').is_empty
local path_sep = require('utils.path').get_separator
local join_paths = require('utils.path').join_paths

local function print_rtp()
    print( string.format('rtp = %s', vim.opt.rtp['_value']) )
end

local function start()
end

print_rtp()
