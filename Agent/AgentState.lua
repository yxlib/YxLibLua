-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")

---@class AgentState @AgentState class
local AgentState = class("AgentState", nil, nil)

--- ctor method
function AgentState:_ctor(...)
    local params = {...}
    self.bt = params[1]
    self.enterFunc = params[2]
    self.updateFunc = params[3]
    self.exitFunc = params[4]
end

return AgentState
