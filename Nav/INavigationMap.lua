-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")

---@class INavigationMap @INavigationMap interface
local INavigationMap = interface("INavigationMap")

--- get col row
---@return number @col
---@return number @row
function INavigationMap:getColRow() end

--- can cross
---@param col number @col
---@param row number @row
---@return boolean @can cross
function INavigationMap:canCross(col, row) end

--- get G value
---@param col number @col
---@param row number @row
---@return number @G value
function INavigationMap:getGValue(col, row) end

--- get min G value
---@return number @min G value
function INavigationMap:getMinGValue() end

return INavigationMap
