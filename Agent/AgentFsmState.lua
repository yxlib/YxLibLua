-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")

---@class AgentFsmState @AgentFsmState class
---@field name string @name
---@field listener IAgentFsmStateListener @listener
local AgentFsmState = {
    ---@param name string @name
    ---@param listener IAgentFsmStateListener @listener
    ---@return AgentFsmState @AgentFsmState object
    new = function(name, listener) end
}
class(AgentFsmState, "AgentFsmState", nil)

--- ctor method
function AgentFsmState:_ctor(...)
    local params = {...}
    self.name = params[1]
    self.listener = params[2]
end

--- get name
---@return string @name
function AgentFsmState:getName()
    return self.name
end

--- onEnter
---@param fromState string @enter from state
function AgentFsmState:onEnter(fromState)
    if self.listener ~= nil then
        self.listener:onEnterFsmState(self.name, fromState)
    end
end

--- onUpdate
---@param dt number @delta time
function AgentFsmState:onUpdate(dt)
    if self.listener ~= nil then
        self.listener:onUpdateFsmState(self.name, dt)
    end
end

--- onExit
---@param toState string @exit to state
function AgentFsmState:onExit(toState)
    if self.listener ~= nil then
        self.listener:onExitFsmState(self.name, toState)
    end
end

return AgentFsmState
