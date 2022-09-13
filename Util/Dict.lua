-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

require("LuaScripts.YxLibLua.Util.Class")

---@class Dict @Dict class
local Dict = {
    ---@return Dict @Dict object
    new = function() end
}
class(Dict, "Dict", nil)

--- set
---@param k any
---@param v any
function Dict:set(k, v)
    assert(k ~= nil, "key is nil")

    self[k] = v
end

--- get
---@param k any
---@return any @value
---@return boolean @ok
function Dict:get(k)
    assert(k ~= nil, "key is nil")

    return self[k], self[k] ~= nil
end

--- hasKey
---@param k any
---@return boolean @ok
function Dict:hasKey(k)
    return self[k] ~= nil
end

--- delete
---@param k any
function Dict:delete(k)
    assert(k ~= nil, "key is nil")

    self[k] = nil
end

--- get the size of the dictionary
---@return number
function Dict:size()
    local cnt = 0
    for k, v in pairs(self) do
        if v then
            cnt = cnt + 1
        end
    end

    return cnt
end

function Dict:foreach(callback)
    assert(callback, "callback is nil")

    for k, v in pairs(self) do
        local bSucc = callback(k, v)
        if not bSucc then
            break
        end
    end
end

--- get all keys
---@return table @ key array
function Dict:allKeys()
    local keys = {}
    for k, v in pairs(self) do
        table.insert(keys, k)
    end

    return keys
end

return Dict