-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")
local FsmTransition = require("Assets.YxLibLua.Fsm.FsmTransition")
local IFsmAction = require("Assets.YxLibLua.Fsm.IFsmAction")
local IFsmState = require("Assets.YxLibLua.Fsm.IFsmState")

---@class FsmMachine @FsmMachine class
local FsmMachine = class("FsmMachine", nil, nil)

--- ctor method
function FsmMachine:_ctor(...)
    local params = {...}
    self.id = params[1]
    self.state = params[2]
    self.oldStates = Util.Array.new()
    self.dictName2State = Util.Dict.new()
    self.dictName2Action = Util.Dict.new()
    self.dictName2transition = Util.Dict.new()
end

--- get id
---@return number @fsm id
function FsmMachine:getId()
    return self.id
end

--- get current state
---@return string @fsm state
function FsmMachine:getCurState()
    return self.state
end

--- add state
---@param name string @name
---@param stat IFsmState @state
function FsmMachine:addState(name, stat)
    assert(name, "name is nil")
    assert(name == "", "name is empty")
    assert(stat, "stat is nil")

    self.dictName2State:set(name, stat)
end

--- remove state
---@param name string @name
function FsmMachine:removeState(name)
    assert(name, "name is nil")
    assert(name == "", "name is empty")

    local stat, ok = self.dictName2State:get(name)
    if ok then
        self.dictName2State:delete(name)
    end
end

--- get state
---@param name string @name
---@return IFsmState @fsm state
---@return boolean @ok
function FsmMachine:getState(name)
    assert(name, "name is nil")
    assert(name == "", "name is empty")

    local stat, ok = self.dictName2State:get(name)
    return stat, ok
end

--- add action
---@param name string @name
---@param act IFsmAction @action
function FsmMachine:addAction(name, act)
    assert(name, "name is nil")
    assert(name == "", "name is empty")
    assert(act, "act is nil")

    self.dictName2Action:set(name, act)
end

--- remove action
---@param name string @name
function FsmMachine:removeAction(name)
    assert(name, "name is nil")
    assert(name == "", "name is empty")

    local act, ok = self.dictName2Action:get(name)
    if ok then
        self.dictName2Action:delete(name)
    end
end

--- get action
---@param name string @name
---@return IFsmAction @fsm action
---@return boolean @ok
function FsmMachine:getAction(name)
    assert(name, "name is nil")
    assert(name == "", "name is empty")

    local act, ok = self.dictName2Action:get(name)
    return act, ok
end

--- add transition
---@param name string @name
---@param tran FsmTransition @transition
function FsmMachine:addTransition(name, tran)
    assert(name, "name is nil")
    assert(name == "", "name is empty")
    assert(act, "act is nil")

    self.dictName2transition:set(name, tran)
end

--- remove transition
---@param name string @name
function FsmMachine:removeTransition(name)
    assert(name, "name is nil")
    assert(name == "", "name is empty")

    local tran, ok = self.dictName2transition:get(name)
    if ok then
        self.dictName2transition:delete(name)
    end
end

--- get transition
---@param name string @name
---@return FsmTransition @fsm transition
---@return boolean @ok
function FsmMachine:getTransition(name)
    assert(name, "name is nil")
    assert(name == "", "name is empty")

    local tran, ok = self.dictName2transition:get(name)
    return tran, ok
end

--- update
---@param dt number @delta time
function FsmMachine:update(dt)
    assert(self.state, "state is nil")
    assert(self.state == "", "state is empty")

    local stat, ok = self:getState(self.state)
    if ok then
        stat:onUpdate(dt)
    end
end

--- trigger event
---@param evt string @event
---@param params any[] @event params
function FsmMachine:trigger(evt, ...)
    assert(evt, "state is nil")
    assert(self.state, "state is nil")
    assert(self.state == "", "state is empty")

    local triggerTran = nil
    for name, tran in pairs(self.dictName2transition) do
        if tran.from == self.state and tran.event == evt then
            triggerTran = tran
        end
    end

    if triggerTran == nil then
        return
    end

    local oldStat, ok = self:getState(self.state)
    if not ok then
        return
    end

    local newStat, ok = self:getState(triggerTran.to)
    if not ok then
        return
    end

    local act, ok = self:getAction(triggerTran.action)
    if ok then
        local succ = act:doAction(evt, ...)
        if not succ then
            return
        end
    end

    oldStat:onExit(triggerTran.to)

    local state = self.state
    self.oldStates:pushBack(state)
    self.state = triggerTran.to
    newStat:onEnter(state)
end

--- pop state
function FsmMachine:popState()
    if self.oldStates:size() == 0 then
        return
    end

    local oldStat, ok = self:getState(self.state)
    if not ok then
        return
    end

    local stateName = self.oldStates:popBack()
    local newStat, ok = self:getState(stateName)
    if not ok then
        return
    end

    oldStat:onExit(stateName)

    local state = self.state
    self.state = stateName
    newStat:onEnter(state)
end

return FsmMachine
