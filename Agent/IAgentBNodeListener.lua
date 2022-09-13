-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")
local BT = require("LuaScripts.YxLibLua.BT.BT")

---@class IAgentBNodeListener @IAgentBNodeListener interface
local IAgentBNodeListener = interface("IAgentBNodeListener")

--- onFsmAction
---@param node IBehaviorNode @behavior node
---@param params any[] @action params
---@return number @behavior node state
function IAgentBNodeListener:onBNodeAction(node, params) end

return IAgentBNodeListener
