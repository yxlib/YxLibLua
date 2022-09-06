-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")

---@class IAgentFsmActionListener @IAgentFsmActionListener interface
local IAgentFsmActionListener = interface("IAgentFsmActionListener")

--- onFsmAction
---@param action string @action name
---@param evt string @event
---@param params any[] @event params
---@return boolean @is success
function IAgentFsmActionListener:onFsmAction(action, evt, ...) end

return IAgentFsmActionListener