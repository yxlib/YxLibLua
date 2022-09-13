-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")

---@class FsmTransition @FsmTransition class
---@field from string @from state
---@field event string @event
---@field to string @to state
---@field action string @action
local FsmTransition = {
    ---@param from string @from state
    ---@param event string @event
    ---@param to string @to state
    ---@param action string @action
    ---@return FsmTransition @FsmTransition object
    new = function(from, event, to, action) end
}
class(FsmTransition, "FsmTransition", nil)

--- ctor method
function FsmTransition:_ctor(...)
    local params = {...}
    self.from = params[1]
    self.event = params[2]
    self.to = params[3]
    self.action = params[4]
end

return FsmTransition
