-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")
local Grid = require("Assets.YxLibLua.Nav.Grid")

---@class BasePathNode @BasePathNode class
---@field parent IPathNode @parent node
---@field vecParent Vector @parent vector
---@field minGValue number @min G value
---@field grid Grid @grid
---@field children Array @children
---@field new function @function(parent, vecParent, minGValue, col, row)
local BasePathNode = class("BasePathNode", nil, nil)

--- ctor method
function BasePathNode:_ctor(...)
    local params = {...}
    self.parent = params[1]
    self.vecParent = params[2]
    self.minGValue = params[3]
    self.grid = Grid.new(params[4], params[5])

    self.children = Util.Array.new()

    if self.parent ~= nil then
        self.parent:addChild(self)
    end
end

--- set parent
---@param parent IPathNode @parent
function BasePathNode:setParent(parent)
    self.parent = parent
end

--- get parent
---@return IPathNode @parent
function BasePathNode:getParent()
    return self.parent
end

--- update parent
---@param parent IPathNode @parent
---@param vec Vector @vector
function BasePathNode:updateParent(parent, vec)
    if self.parent ~= nil then
        self.parent:removeChild(self)
    end

    self.parent = parent
    self.vecParent = vec
end

--- get parent vector
---@return Vector @parent vector
function BasePathNode:getParentVector()
    return self.vecParent
end

--- add child
---@param node IPathNode @child
function BasePathNode:addChild(node)
    assert(node, "node is nil")

    self.children:pushBack(node)
end

--- remove child
---@param node IPathNode @child
function BasePathNode:removeChild(node)
    assert(node, "node is nil")

    for i, exist in ipairs(self.children) do
        if exist == node then
            self.children:erase(i)
            return
        end
    end
end

--- set min G value
---@param minGValue number @min G value
---@param navMap INavigationMap @navigation map
function BasePathNode:setMinGValue(minGValue, navMap)
    local gValueChange = minGValue - self.minGValue
    self.minGValue = minGValue
    self:updateChildrenGValue(navMap, gValueChange)
end

--- get min G value
---@return number @min G value
function BasePathNode:getMinGValue()
    return self.minGValue
end

--- get grid
---@return Grid @grid
function BasePathNode:getGrid()
    return self.grid
end

--- update children G value
---@param navMap INavigationMap @navigation map
---@param gValueChange number @G value has change
function BasePathNode:updateChildrenGValue(navMap, gValueChange)
    for i, child in ipairs(self.children) do
        local oldMinGValue = child:getMinGValue()
        local minGValue = oldMinGValue + gValueChange
        if minGValue < 0 then
            minGValue = 0
        end

        child:setMinGValue(minGValue, navMap)
    end
end

return BasePathNode
