-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")
local BT = require("LuaScripts.YxLibLua.BT.BT")
local IAgentBNodeListener = require("LuaScripts.YxLibLua.Agent.IAgentBNodeListener")

---@class AgentBNode : BaseBehaviorNode @AgentBNode class
---@field listener IAgentBNodeListener @listener
---@field params any[] @params
local AgentBNode = {
    ---@param nodeId number @node id
    ---@param actionId number @action id
    ---@param maxStep number @max step
    ---@param listener IAgentBNodeListener @listener
    ---@param params any[] @params
    ---@return AgentBNode @AgentBNode object
    new = function(nodeId, actionId, maxStep, listener, params) end
}
class(AgentBNode, "AgentBNode", BT.BaseBehaviorNode)

--- ctor method
function AgentBNode:_ctor(...)
    local params = {...}
    super(self, BT.BaseBehaviorNode, params[1], params[2], params[3])

    self.listener = params[4]
    self.params = params[5]
end

--- execute
function AgentBNode:execute()
    if self.listener ~= nil then
        local stat = self.listener:onBNodeAction(self, self.params)
        self:setState(stat)
    end
end

return AgentBNode
