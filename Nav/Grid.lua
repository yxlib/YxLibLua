-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")

---@class Grid @Grid class
---@field col number @col
---@field row number @row
local Grid = {
    ---@param col number @col
    ---@param row number @row
    ---@return Grid @Grid object
    new = function(col, row) end
}
class(Grid, "Grid", nil)

--- ctor method
function Grid:_ctor(...)
    local params = {...}
    self.col = params[1]
    self.row = params[2]
end

--- update
---@param col number @col
---@param row number @row
function Grid:update(col, row)
    self.col = col
    self.row = row
end

--- is same grid
---@param grid2 Grid @grid to compare
---@return boolean @is same grid
function Grid:isSameGrid(grid2)
    if self.col ~= grid2.col then
        return false
    end

    if self.row ~= grid2.row then
        return false
    end

    return true
end

--- is same grid
---@param col number @col
---@param row number @row
---@return boolean @is same grid
function Grid:isSameGrid2(col, row)
    if self.col ~= col then
        return false
    end

    if self.row ~= row then
        return false
    end

    return true
end

return Grid
