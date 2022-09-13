-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")
local Grid = require("LuaScripts.YxLibLua.Nav.Grid")
local INavigationMap = require("LuaScripts.YxLibLua.Nav.INavigationMap")
local IPathNode = require("LuaScripts.YxLibLua.Nav.IPathNode")

---@class IPathFinder @IPathFinder interface
local IPathFinder = interface("IPathFinder")

--- reset
function IPathFinder:reset() end

--- find path
---@param navMap INavigationMap @navigation map
---@param startGrid Grid @start grid
---@param dstGrid Grid @dest grid
---@return IPathNode[] @path nodes
---@return boolean @is success
function IPathFinder:findPath(navMap, startGrid, dstGrid) end

return IPathFinder
