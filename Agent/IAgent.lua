-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")

---@class IAgent @IAgent interface
local IAgent = interface("IAgent")

--- getId
---@return number @agent id
function IAgent:getId() end

--- update
---@param dt number @delta time
function IAgent:update(dt) end

return IAgent
