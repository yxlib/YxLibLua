-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")
local Observer = require("Assets.YxLibLua.Notify.Observer")
local Msg = require("Assets.YxLibLua.Notify.Msg")

---@class Dispatcher @Dispatcher class
local Dispatcher = class("Dispatcher", nil, nil)

--- ctor method
function Dispatcher:_ctor(...)
    local params = {...}
    self.msgName = params[1]
    self.observers = Util.Array.new()
end

--- get msg name
---@return string @msg name
function Dispatcher:getMsgName()
    return self.msgName
end

--- add observer
---@param obj any
---@param cb function @(msg: Msg) => void
function Dispatcher:addObserver(obj, cb)
    self:_addObserverImpl(obj, cb, false)
end

--- add once observer
---@param obj any
---@param cb function @(msg: Msg) => void
function Dispatcher:addOnceObserver(obj, cb)
    self:_addObserverImpl(obj, cb, true)
end

--- remove observer
---@param obj any
---@param cb function @(msg: Msg) => void
function Dispatcher:removeObserver(obj, cb)
    assert(obj, "object is nil")
    assert(cb, "callback is nil")

    for i = self.observers:size(), 1, -1 do
        local observer = self.observers[i]
        if obj == observer.object and cb == observer.callback then
            self.observers:erase(i)
            break
        end
    end
end

--- remove observers
---@param obj any
function Dispatcher:removeObservers(obj)
    assert(obj, "object is nil")

    for i = self.observers:size(), 1, -1 do
        local observer = self.observers[i]
        if obj == observer.object then
            self.observers:erase(i)
        end
    end
end

--- notify
---@param params any[] @any array
function Dispatcher:notify(params)
    local msg = Msg.new(self.msgName, params)
    local observers = self.observers:clone()

    for i, observer in ipairs(observers) do
        if not self:_isObserverExist(observer.object, observer.callback) then
            goto continue
        end

        observer.callback(observer.object, msg)
        if observer.once then
            self:removeObserver(observer.object, observer.callback)
        end

        ::continue::
    end
end

--- add observer implement
---@param obj any
---@param cb function @(msg: Msg) => void
---@param once boolean
function Dispatcher:_addObserverImpl(obj, cb, once)
    assert(obj, "object is nil")
    assert(cb, "callback is nil")

    if self:_isObserverExist(obj, cb) then
        return
    end

    local o = Observer.new(obj, cb, once)
    self.observers:pushBack(o)
end

--- is observer exist
---@param obj any
---@param cb function @(msg: Msg) => void
---@return boolean
function Dispatcher:_isObserverExist(obj, cb)
    for i = 1, self.observers:size() do
        local observer = self.observers[i]
        if obj == observer.object and cb == observer.callback then
            return true
        end
    end

    return false
end

return Dispatcher