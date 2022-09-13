-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

require("LuaScripts.YxLibLua.Util.Util")

---@class Observer @Observer class
---@field object any
---@field callback function
---@field once boolean
local Observer = {
    ---@param object any @object
    ---@param callback function @callback
    ---@param once boolean @is on notify once
    ---@return Observer @Observer object
    new = function(object, callback, once) end
}
class(Observer, "Observer", nil)

--- ctor method
function Observer:_ctor(...)
    local params = {...}
    self.object = params[1]
    self.callback = params[2]
    self.once = params[3]
end

return Observer