-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")
local Grid = require("LuaScripts.YxLibLua.Nav.Grid")
local INavigationMap = require("LuaScripts.YxLibLua.Nav.INavigationMap")
local IPathNode = require("LuaScripts.YxLibLua.Nav.IPathNode")

---@class IPathFinderImpl @IPathFinderImpl interface
local IPathFinderImpl = interface("IPathFinderImpl")

--- create first node
---@param col number @col
---@param row number @row
---@return IPathNode @first path node
function IPathFinderImpl:createFirstNode(col, row) end

--- unfold node
---@param navMap INavigationMap @navigation map
---@param dstGrid Grid @dest grid
---@param node IPathNode @unfold node
function IPathFinderImpl:unfoldNode(navMap, dstGrid, node) end

return IPathFinderImpl
