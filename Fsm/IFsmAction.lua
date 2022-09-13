-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")

---@class IFsmAction @IFsmAction interface
local IFsmAction = interface("IFsmAction")

--- get name
---@return string @name
function IFsmAction:getName() end

--- doAction
---@param evt string @event
---@param params any[] @event params
---@return boolean @is success
function IFsmAction:doAction(evt, ...) end

return IFsmAction
