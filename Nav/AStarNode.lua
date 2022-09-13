-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")
local Grid = require("LuaScripts.YxLibLua.Nav.Grid")
local BasePathNode = require("LuaScripts.YxLibLua.Nav.BasePathNode")

---@class AStarNode : BasePathNode @AStarNode class
---@field parent IPathNode @parent node
---@field vecParent Vector @parent vector
---@field minGValue number @min G value
---@field grid Grid @grid
---@field children Array @children
local AStarNode = {
    ---@param parent IPathNode @parent node
    ---@param vecParent Vector @parent vector
    ---@param minGValue number @min G value
    ---@param col number @col
    ---@param row number @row
    ---@return AStarNode @AStarNode object
    new = function(parent, vecParent, minGValue, col, row) end
}
class(AStarNode, "AStarNode", BasePathNode)

--- ctor method
function AStarNode:_ctor(...)
    local params = {...}
    super(self, BasePathNode, params[1], params[2], params[3], params[4], params[5])
end

return AStarNode
