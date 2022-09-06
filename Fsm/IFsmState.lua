-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")

---@class IFsmState @IFsmState interface
local IFsmState = interface("IFsmState")

--- get name
---@return string @name
function IFsmState:getName() end

--- onEnter
---@param fromState string @enter from state
function IFsmState:onEnter(fromState) end

--- onUpdate
---@param dt number @delta time
function IFsmState:onUpdate(dt) end

--- onExit
---@param toState string @exit to state
function IFsmState:onExit(toState) end

return IFsmState
