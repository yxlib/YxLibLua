-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")
local Grid = require("Assets.YxLibLua.Nav.Grid")
local BasePathNode = require("Assets.YxLibLua.Nav.BasePathNode")

---@class AStarNode @AStarNode class
---@field parent IPathNode @parent node
---@field vecParent Vector @parent vector
---@field minGValue number @min G value
---@field grid Grid @grid
---@field children Array @children
---@field new function @function(parent, vecParent, minGValue, col, row)
local AStarNode = class("AStarNode", nil, BasePathNode)

--- ctor method
function AStarNode:_ctor(...)
    local params = {...}
    super(self, params[1], params[2], params[3], params[4], params[5])
end

return AStarNode