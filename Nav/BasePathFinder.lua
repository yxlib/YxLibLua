-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")
local Grid = require("LuaScripts.YxLibLua.Nav.Grid")

local logger = Util.Logger.new("Monster")

---@class BasePathFinder @BasePathFinder class
---@field impl IPathFinderImpl @implement
---@field openList Array @open list
---@field closeList Array @close list
---@field lastNode IPathNode @last node
local BasePathFinder = {
    ---@param impl IPathFinderImpl @implement
    ---@return BasePathFinder @BasePathFinder object
    new = function(impl) end
}
class(BasePathFinder, "BasePathFinder", nil)

--- ctor method
function BasePathFinder:_ctor(...)
    local params = {...}
    self.impl = params[1]
    self.openList = Util.Array.new()
    self.closeList = Util.Array.new()
    self.lastNode = nil
end

--- reset
function BasePathFinder:reset()
    self.openList = Util.Array.new()
    self.closeList = Util.Array.new()
    self.lastNode = nil
end

--- find path
---@param navMap INavigationMap @navigation map
---@param startGrid Grid @start grid
---@param dstGrid Grid @dest grid
---@return Array @IPathNode array
---@return boolean @is success
function BasePathFinder:findPath(navMap, startGrid, dstGrid)
    local fullPath, bSucc, bFinish = self:preCheck(navMap, startGrid, dstGrid)
    if bFinish then
        return fullPath, bSucc
    end

    local firstNode = self.impl:createFirstNode(startGrid.col, startGrid.row)
    self:addNodeToOpenList(firstNode)
    
    while self.openList:size() > 0 do
        local node, ok = self:popMinValueNode(navMap, dstGrid)
        if not ok then
            break
        end

        self.impl:unfoldNode(navMap, dstGrid, node)
        if self.lastNode ~= nil then
            break
        end
    end

    return self:getFullPath()
end

--- pre check
---@param navMap INavigationMap @navigation map
---@param startGrid Grid @start grid
---@param dstGrid Grid @dest grid
---@return Array @IPathNode array
---@return boolean @is success
---@return boolean @is finish
function BasePathFinder:preCheck(navMap, startGrid, dstGrid)
    if not navMap:canCross(startGrid.col, startGrid.row) then
        logger:w("start grid can not cross")
        return nil, false, true
    end

    if not navMap:canCross(dstGrid.col, dstGrid.row) then
        logger:w("dest grid can not cross")
        return nil, false, true
    end

    if startGrid:isSameGrid(dstGrid) then
        local node = self.impl:createFirstNode(startGrid.col, startGrid.row)
        local fullPath = Util.Array.new()
        fullPath:pushBack(node)

        return fullPath, true, true
    end

    return nil, false, false
end

--- add node to open list
---@param node IPathNode @node to add
function BasePathFinder:addNodeToOpenList(node)
    self.openList:pushBack(node)
end

--- get open node
---@param col number @col
---@param row number @row
---@return IPathNode @node
---@return boolean @is success
function BasePathFinder:getOpenNode(col, row)
    local existNode = nil
    local bSucc = false

    self.openList:foreach(function(i, node)
        local grid = node:getGrid()
        if grid:isSameGrid2(col, row) then
            existNode = node
            bSucc = true
            return false
        end

        return true
    end)

    -- for i, node in ipairs(self.openList) do
    --     local grid = node:getGrid()
    --     if grid:isSameGrid2(col, row) then
    --         return node, true
    --     end
    -- end

    return existNode, bSucc
end

--- add node to close list
---@param node IPathNode @node to add
function BasePathFinder:addNodeToCloseList(node)
    self.closeList:pushBack(node)
end

--- get close node
---@param col number @col
---@param row number @row
---@return IPathNode @node
---@return boolean @is success
function BasePathFinder:getCloseNode(col, row)
    local existNode = nil
    local bSucc = false

    self.closeList:foreach(function(i, node)
        local grid = node:getGrid()
        if grid:isSameGrid2(col, row) then
            existNode = node
            bSucc = true
            return false
        end

        return true
    end)

    -- for i, node in ipairs(self.closeList) do
    --     local grid = node:getGrid()
    --     if grid:isSameGrid2(col, row) then
    --         return node, true
    --     end
    -- end

    return existNode, bSucc
end

--- update exist list
---@param navMap INavigationMap @navigation map
---@param col number @col
---@param row number @row
---@param parent IPathNode @parent
---@param vecParent Vector @vector
---@param minGValue number @min G value
---@return boolean @is success
function BasePathFinder:updateExistList(navMap, col, row, parent, vecParent, minGValue)
    local exist, ok = self:getOpenNode(col, row)
    if not ok then
        exist, ok = self:getCloseNode(col, row)
    end

    if ok and exist:getMinGValue() > minGValue then
        exist:updateParent(parent, vecParent)
        exist:setMinGValue(minGValue, navMap)
    end

    return ok
end

--- pop min value node
---@param navMap INavigationMap @navigation map
---@param dstGrid Grid @dest grid
---@return IPathNode @path node
---@return boolean @is success
function BasePathFinder:popMinValueNode(navMap, dstGrid)
    local minF = math.maxinteger
    local minIdx = -1
    local baseGValue = navMap:getMinGValue()
    
    self.openList:foreach(function(i, node)
        local h = self:calH(node, dstGrid, baseGValue)
        local f = node:getMinGValue() + h
        if minF > f then
            minF = f
            minIdx = i
        end

        return true
    end)

    -- for i, node in ipairs(self.openList) do
    --     local h = self:calH(node, dstGrid, baseGValue)
    --     local f = node:getMinGValue() + h
    --     if minF > f then
    --         minF = f
    --         minIdx = i
    --     end
    -- end

    if minIdx == -1 then
        return nil, false
    end

    local minNode = self.openList:at(minIdx)
    self.openList:erase(minIdx)
    return minNode, true
end


--- calculate H value
---@param node IPathNode @node to calculate
---@param dstGrid Grid @dest grid
---@param baseGValue number @base G value
---@return number @H value
function BasePathFinder:calH(node, dstGrid, baseGValue)
    local grid = node:getGrid()
    local xAbs = math.abs((dstGrid.col - grid.col) * baseGValue)
    local yAbs = math.abs((dstGrid.row - grid.row) * baseGValue)
    return xAbs + yAbs
end

--- get full path
---@return Array @IPathNode array
---@return boolean @is success
function BasePathFinder:getFullPath()
    if self.lastNode == nil then
        return nil, false
    end

    local fullPath = Util.Array.new()
    local node = self.lastNode
    while node ~= nil do
        fullPath:pushBack(node)
        node = node:getParent()
    end

    local fullPathLen = fullPath:size()
    local step = math.floor(fullPathLen / 2)
    for i = 1, step, 1 do
        local j = fullPathLen - i + 1
        local tmp = fullPath:at(i)
        fullPath:set(i, fullPath:at(j))
        fullPath:set(j, tmp)
    end

    return fullPath, true
end

return BasePathFinder