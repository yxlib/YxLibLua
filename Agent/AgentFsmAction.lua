-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")

---@class AgentFsmAction @AgentFsmAction class
---@field name string @name
---@field listener IAgentFsmActionListener @listener
local AgentFsmAction = {
    ---@param name string @name
    ---@param listener IAgentFsmActionListener @listener
    ---@return AgentFsmAction @AgentFsmAction object
    new = function(name, listener) end
}
class(AgentFsmAction, "AgentFsmAction", nil)

--- ctor method
function AgentFsmAction:_ctor(...)
    local params = {...}
    self.name = params[1]
    self.listener = params[2]
end

--- get name
---@return string @name
function AgentFsmAction:getName()
    return self.name
end

--- doAction
---@param evt string @event
---@param params any[] @event params
---@return boolean @is success
function AgentFsmAction:doAction(evt, ...)
    if self.listener ~= nil then
        return self.listener:onFsmAction(self.name, evt, ...)
    end

    return false
end

return AgentFsmAction
