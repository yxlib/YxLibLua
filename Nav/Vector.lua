-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")

---@class Vector @Vector class
---@field x number @x
---@field y number @y
local Vector = {
    ---@param x number @x
    ---@param y number @y
    ---@return Vector @Vector object
    new = function(x, y) end
}
class(Vector, "Vector", nil)

--- ctor method
function Vector:_ctor(...)
    local params = {...}
    self.x = params[1]
    self.y = params[2]
end

--- is empty vector
---@return boolean @is empty vector
function Vector:isEmptyVector()
    if self.x ~= 0 then
        return false
    end
    
    if self.y ~= 0 then
        return false
    end

    return true
end

--- is oblique
---@return boolean @is oblique
function Vector:isOblique()
    if self.x == 0 then
        return false
    end
    
    if self.y == 0 then
        return false
    end

    return true
end

return Vector
