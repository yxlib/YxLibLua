-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

require("LuaScripts.YxLibLua.Util.Util")

---@class Msg @Msg class
---@field name string
---@field params any[]
local Msg = {
    ---@param name string @name
    ---@param params any[]
    ---@return Msg @Msg object
    new = function(name, params) end
}
class(Msg, "Msg", nil)

--- ctor method
function Msg:_ctor(...)
    local params = {...}
    self.name = params[1]
    self.params = params[2]
end

return Msg