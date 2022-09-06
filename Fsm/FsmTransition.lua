-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")

---@class FsmTransition @FsmTransition class
local FsmTransition = class("FsmTransition", nil, nil)

--- ctor method
function FsmTransition:_ctor(...)
    local params = {...}
    self.from = params[1]
    self.event = params[2]
    self.to = params[3]
    self.action = params[4]
end

return FsmTransition
