-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")
local BT = require("LuaScripts.YxLibLua.BT.BT")

---@class AgentState @AgentState class
---@field obj any @object to invoke callback functions
---@field bt BehaviorTree @behavior tree
---@field enterFunc function @function(fromState string)
---@field updateFunc function @function(dt number)
---@field exitFunc function @function(toState string)
local AgentState = {
    ---@param obj any @object to invoke callback functions
    ---@param bt BehaviorTree @behavior tree
    ---@param enterFunc function @function(fromState string)
    ---@param updateFunc function @function(dt number)
    ---@param exitFunc function @function(toState string)
    ---@return AgentState @AgentState object
    new = function(obj, bt, enterFunc, updateFunc, exitFunc) end
}
class(AgentState, "AgentState", nil)

--- ctor method
function AgentState:_ctor(...)
    local params = {...}
    self.obj = params[1]
    self.bt = params[2]
    self.enterFunc = params[3]
    self.updateFunc = params[4]
    self.exitFunc = params[5]
end

return AgentState
