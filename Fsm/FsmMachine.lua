-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")
local FsmTransition = require("Assets.YxLibLua.Fsm.FsmTransition")
local IFsmAction = require("Assets.YxLibLua.Fsm.IFsmAction")
local IFsmState = require("Assets.YxLibLua.Fsm.IFsmState")

---@class FsmMachine @FsmMachine class
---@field id number @id
---@field state string @state
---@field oldStates Array @old states
---@field dictName2State Dict @bind name and state
---@field dictName2Action Dict @bind name and action
---@field transitions Array @transitions
local FsmMachine = {
    ---@param id number @id
    ---@return FsmMachine @FsmMachine object
    new = function(id) end
}
class(FsmMachine, "FsmMachine", nil)

--- ctor method
function FsmMachine:_ctor(...)
    local params = {...}
    self.id = params[1]

    self.state = ""
    self.oldStates = Util.Array.new()
    self.dictName2State = Util.Dict.new()
    self.dictName2Action = Util.Dict.new()
    self.transitions = Util.Array.new()
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
    assert(name ~= "", "name is empty")
    assert(stat, "stat is nil")

    self.dictName2State:set(name, stat)
end

--- remove state
---@param name string @name
function FsmMachine:removeState(name)
    assert(name, "name is nil")
    assert(name ~= "", "name is empty")

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
    assert(name ~= "", "name is empty")

    local stat, ok = self.dictName2State:get(name)
    return stat, ok
end

--- add action
---@param name string @name
---@param act IFsmAction @action
function FsmMachine:addAction(name, act)
    assert(name, "name is nil")
    assert(name ~= "", "name is empty")
    assert(act, "act is nil")

    self.dictName2Action:set(name, act)
end

--- remove action
---@param name string @name
function FsmMachine:removeAction(name)
    assert(name, "name is nil")
    assert(name ~= "", "name is empty")

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
    assert(name ~= "", "name is empty")

    local act, ok = self.dictName2Action:get(name)
    return act, ok
end

--- add transition
---@param from string @from state
---@param event string @event
---@param to string @to state
---@param action string @action
function FsmMachine:addTransition(from, event, to, action)
    assert(from, "from is nil")
    assert(from ~= "", "from is empty")

    assert(event, "event is nil")
    assert(event ~= "", "event is empty")

    assert(to, "event is nil")
    assert(to ~= "", "event is empty")

    local tran = FsmTransition.new(from, event, to, action)
    self.transitions:pushBack(tran)
end

--- remove transition
---@param from string @from state
---@param event string @event
function FsmMachine:removeTransition(from, event)
    assert(from, "from is nil")
    assert(from ~= "", "from is empty")

    assert(event, "event is nil")
    assert(event ~= "", "event is empty")

    for i, tran in ipairs(self.transitions) do
        if tran.from == from and tran.event == event then
            self.transitions:erase(i)
            break
        end
    end
end

--- get transition
---@param from string @from state
---@param event string @event
---@return FsmTransition @fsm transition
---@return boolean @ok
function FsmMachine:getTransition(from, event)
    assert(from, "from is nil")
    assert(from ~= "", "from is empty")

    assert(event, "event is nil")
    assert(event ~= "", "event is empty")

    for i, tran in ipairs(self.transitions) do
        if tran.from == from and tran.event == event then
            return tran, true
        end
    end

    return nil, false
end

--- start
---@param firstState string @name of first state
function FsmMachine:start(firstState)
    assert(firstState, "firstState is nil")
    assert(firstState ~= "", "firstState is empty")

    local stat, ok = self:getState(firstState)
    if ok then
        self.state = firstState
        stat:onEnter("")
    end
end

--- stop
function FsmMachine:stop()
    assert(self.state, "state is nil")
    assert(self.state ~= "", "state is empty")

    local stat, ok = self:getState(self.state)
    if ok then
        stat:onExit("")
    end
end

--- update
---@param dt number @delta time
function FsmMachine:update(dt)
    assert(self.state, "state is nil")
    assert(self.state ~= "", "state is empty")

    local stat, ok = self:getState(self.state)
    if ok then
        stat:onUpdate(dt)
    end
end

--- trigger event
---@param evt string @event
---@param params any[] @event params
function FsmMachine:trigger(evt, ...)
    assert(evt, "evt is nil")
    assert(evt ~= "", "event is empty")
    assert(self.state, "state is nil")
    assert(self.state ~= "", "state is empty")

    local triggerTran, ok = self:getTransition(self.state, evt)
    if not ok then
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
