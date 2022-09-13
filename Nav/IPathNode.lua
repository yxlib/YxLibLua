-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")
local Grid = require("LuaScripts.YxLibLua.Nav.Grid")
local Vector = require("LuaScripts.YxLibLua.Nav.Vector")
local INavigationMap = require("LuaScripts.YxLibLua.Nav.INavigationMap")

---@class IPathNode @IPathNode interface
local IPathNode = interface("IPathNode")

--- set parent
---@param parent IPathNode @parent
function IPathNode:setParent(parent) end

--- get parent
---@return IPathNode @parent
function IPathNode:getParent() end

--- update parent
---@param parent IPathNode @parent
---@param vec Vector @vector
function IPathNode:updateParent(parent, vec) end

--- get parent vector
---@return Vector @parent vector
function IPathNode:getParentVector() end

--- add child
---@param node IPathNode @child
function IPathNode:addChild(node) end

--- remove child
---@param node IPathNode @child
function IPathNode:removeChild(node) end

--- set min G value
---@param minGValue number @min G value
---@param navMap INavigationMap @navigation map
function IPathNode:setMinGValue(minGValue, navMap) end

--- get min G value
---@return number @min G value
function IPathNode:getMinGValue() end

--- get grid
---@return Grid @grid
function IPathNode:getGrid() end

return IPathNode
