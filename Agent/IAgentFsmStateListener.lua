-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")

---@class IAgentFsmStateListener @IAgentFsmStateListener interface
local IAgentFsmStateListener = interface("IAgentFsmStateListener")

--- onEnterFsmState
---@param state string @enter state
---@param fromState string @from state
function IAgentFsmStateListener:onEnterFsmState(state, fromState) end

--- onUpdateFsmState
---@param state string @enter state
---@param dt number @delta time
function IAgentFsmStateListener:onUpdateFsmState(state, dt) end

--- onExitFsmState
---@param state string @exit state
---@param toState string @to state
function IAgentFsmStateListener:onExitFsmState(state, toState) end

return IAgentFsmStateListener
