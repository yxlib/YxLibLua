-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")
local BT = require("Assets.YxLibLua.BT.BT")

---@class AgentBNode @AgentBNode class
local AgentBNode = class("AgentBNode", nil, BT.BaseBehaviorNode)

--- ctor method
function AgentBNode:_ctor(...)
    local params = {...}
    super(self, params[1], params[2], params[3])

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
