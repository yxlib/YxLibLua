-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("LuaScripts.YxLibLua.Util.Util")
local Msg = require("LuaScripts.YxLibLua.Notify.Msg")
local Dispatcher = require("LuaScripts.YxLibLua.Notify.Dispatcher")

---@class NotifyCenter @NotifyCenter class
---@field dictName2Dispatcher Dict
local NotifyCenter = {
    ---@return NotifyCenter @NotifyCenter object
    new = function() end
}
class(NotifyCenter, "NotifyCenter", nil)

--- ctor method
function NotifyCenter:_ctor(...)
    self.dictName2Dispatcher = Util.Dict.new()
end

--- add dispatcher
---@param dispatcher Dispatcher
function NotifyCenter:addDispatcher(dispatcher)
    assert(dispatcher, "dispatcher is nil")

    local msgName = dispatcher:getMsgName()
    assert(msgName, "msgName is nil")
    assert(msgName ~= "", "msgName is empty")

    self.dictName2Dispatcher:set(msgName, dispatcher)
end

--- remove dispatcher
---@param msgName string
function NotifyCenter:removeDispatcher(msgName)
    assert(msgName, "msgName is nil")
    assert(msgName ~= "", "msgName is empty")

    self.dictName2Dispatcher:delete(msgName)
end

--- get dispatcher
---@param msgName string
---@return Dispatcher
---@return boolean
function NotifyCenter:getDispatcher(msgName)
    assert(msgName, "msgName is nil")
    assert(msgName ~= "", "msgName is empty")

    local dispatcher, ok = self.dictName2Dispatcher:get(msgName)
    return dispatcher, ok
end

--- add observer
---@param msgName string
---@param obj any
---@param cb function @(msg: Msg) => void
function NotifyCenter:addObserver(msgName, obj, cb)
    assert(msgName, "msgName is nil")
    assert(msgName ~= "", "msgName is empty")
    -- assert(obj, "object is nil")
    assert(cb, "callback is nil")

    local dispatcher, ok = self.dictName2Dispatcher:get(msgName)
    if not ok then
        dispatcher = Dispatcher.new(msgName)
        self.dictName2Dispatcher:set(msgName, dispatcher)
    end

    dispatcher:addObserver(obj, cb)
end

--- add once observer
---@param msgName string
---@param obj any
---@param cb function @(msg: Msg) => void
function NotifyCenter:addOnceObserver(msgName, obj, cb)
    assert(msgName, "msgName is nil")
    assert(msgName ~= "", "msgName is empty")
    -- assert(obj, "object is nil")
    assert(cb, "callback is nil")

    local dispatcher, ok = self.dictName2Dispatcher:get(msgName)
    if not ok then
        dispatcher = Dispatcher.new(msgName)
        self.dictName2Dispatcher:set(msgName, dispatcher)
    end

    dispatcher:addOnceObserver(obj, cb)
end

--- remove observer
---@param msgName string
---@param obj any
---@param cb function @(msg: Msg) => void
function NotifyCenter:removeObserver(msgName, obj, cb)
    assert(msgName, "msgName is nil")
    assert(msgName ~= "", "msgName is empty")
    -- assert(obj, "object is nil")
    assert(cb, "callback is nil")

    local dispatcher, ok = self.dictName2Dispatcher:get(msgName)
    if ok then
        dispatcher:removeObserver(obj, cb)
    end
end

--- remove observers
---@param msgName string
---@param obj any
function NotifyCenter:removeObservers(msgName, obj)
    assert(msgName, "msgName is nil")
    assert(msgName ~= "", "msgName is empty")
    -- assert(obj, "object is nil")

    local dispatcher, ok = self.dictName2Dispatcher:get(msgName)
    if ok then
        dispatcher:removeObservers(obj)
    end
end

--- remove observers by target
---@param obj any
function NotifyCenter:removeObserversByTarget(obj)
    assert(obj, "object is nil")

    self.dictName2Dispatcher:foreach(function(msgName, dispatcher)
        dispatcher:removeObservers(obj)
        return true
    end)

    -- for msgName, dispatcher in pairs(self.dictName2Dispatcher) do
    --     dispatcher:removeObservers(obj)
    -- end
end

--- remove observers by message
---@param msgName string
function NotifyCenter:removeObserversByMsg(msgName)
    self.dictName2Dispatcher:delete(msgName)
end

--- notify
---@param msgName string
function NotifyCenter:notify(msgName, ...)
    assert(msgName, "msgName is nil")
    assert(msgName ~= "", "msgName is empty")

    -- local params = {...}

    ---@type Dispatcher
    ---@type boolean
    local dispatcher, ok = self.dictName2Dispatcher:get(msgName)
    if ok then
        dispatcher:notify(...)
    end
end

return NotifyCenter