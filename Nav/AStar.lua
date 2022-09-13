-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")
local Grid = require("Assets.YxLibLua.Nav.Grid")
local BasePathFinder = require("Assets.YxLibLua.Nav.BasePathFinder")
local AStarNode = require("Assets.YxLibLua.Nav.AStarNode")

---@class AStar : BasePathFinder @AStar class
---@field impl IPathFinderImpl @implement
---@field openList Array @open list
---@field closeList Array @close list
---@field lastNode IPathNode @last node
local AStar = {
    ---@return AStar @AStar object
    new = function() end
}
class(AStar, "AStar", BasePathFinder)

--- ctor method
function AStar:_ctor(...)
    super(self, BasePathFinder, self)
end

--- create first node
---@param col number @col
---@param row number @row
---@return IPathNode @first path node
function AStar:createFirstNode(col, row)
    return AStarNode.new(nil, nil, 0, col, row)
end

--- unfold node
---@param navMap INavigationMap @navigation map
---@param dstGrid Grid @dest grid
---@param node IPathNode @unfold node
function AStar:unfoldNode(navMap, dstGrid, node)
    local grid = node:getGrid()
    if self:handleGrid(navMap, grid.col - 1, grid.row, node, dstGrid) then
        return
    end

    if self:handleGrid(navMap, grid.col + 1, grid.row, node, dstGrid) then
        return
    end

    if self:handleGrid(navMap, grid.col, grid.row - 1, node, dstGrid) then
        return
    end

    if self:handleGrid(navMap, grid.col, grid.row + 1, node, dstGrid) then
        return
    end

    self:addNodeToCloseList(node)
end

--- unfold node
---@param navMap INavigationMap @navigation map
---@param col number @col
---@param row number @row
---@param parent IPathNode @parent
---@param dstGrid Grid @dest grid
---@return boolean @is find out dest grid
function AStar:handleGrid(navMap, col, row, parent, dstGrid)
    if dstGrid:isSameGrid2(col, row) then
        self.lastNode = AStarNode.new(parent, nil, 0, col, row)
        return true
    end

    local grid = parent:getGrid()
    if grid:isSameGrid2(col, row) then
        return false
    end

    if navMap:canCross(col, row) then
        return false
    end

    local addGValue = navMap:getGValue(col, row)
    local minGValue = parent:getMinGValue() + addGValue
    if self:updateExistList(navMap, col, row, parent, nil, minGValue) then
        return false
    end

    local node = AStarNode.new(parent, nil, minGValue, col, row)
    self:addNodeToOpenList(node)
    return false
end

return AStar
