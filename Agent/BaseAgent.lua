-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")
local Fsm = require("Assets.YxLibLua.Fsm.Fsm")
local BT = require("Assets.YxLibLua.BT.BT")
local Const = require("Assets.YxLibLua.Agent.Const")
local AgentFsmState = require("Assets.YxLibLua.Agent.AgentFsmState")
local AgentState = require("Assets.YxLibLua.Agent.AgentState")
local AgentFsmAction = require("Assets.YxLibLua.Agent.AgentFsmAction")

---@class BaseAgent @BaseAgent class
local BaseAgent = class("BaseAgent", nil, nil)

--- ctor method
function BaseAgent:_ctor(...)
    local params = {...}
    self.agentId = params[1]
    self.fsm = Fsm.FsmMachine.new(self.agentId, Const.AGENT_STATE_IDLE)
    self.dictName2State = Util.Dict.new()
    self.dictName2FsmActionFunc = Util.Dict.new()
    self.dictId2BNodeActionFunc = Util.Dict.new()
end

--- getId
---@return number @agent id
function BaseAgent:getId()
    return self.agentId
end

--- update
---@param dt number @delta time
function BaseAgent:update(dt)
    self.fsm:update(dt)
end

--- add state
---@param name string @state name
---@param bt BehaviorTree @behavior tree
---@param enterFunc function @function(fromState string)
---@param updateFunc function @function(dt number)
---@param exitFunc function @function(toState string)
function BaseAgent:addState(name, bt, enterFunc, updateFunc, exitFunc)
    assert(name, "name is nil")
    assert(name == "", "name is empty")

    local stat = AgentFsmState.new(name, self)
    self.fsm:addState(name, stat)

    local agentState = AgentState.new(bt, enterFunc, updateFunc, exitFunc)
    self.dictName2State:set(name, agentState)
end

--- remove state
---@param name string @state name
function BaseAgent:removeState(name)
    assert(name, "name is nil")
    assert(name == "", "name is empty")

    self.fsm:removeState(name)

    local stat, ok = self.dictName2State:get(name)
    if ok then
        self.dictName2State:delete(name)
    end
end

--- add action
---@param name string @action name
---@param actionFunc function @function(evt string, ...)
function BaseAgent:addAction(name, actionFunc)
    assert(name, "name is nil")
    assert(name == "", "name is empty")

    local act = AgentFsmAction.new(name, self)
    self.fsm:addAction(name, act)
    self.dictName2FsmActionFunc:set(name, actionFunc)
end

--- remove action
---@param name string @action name
function BaseAgent:removeAction(name)
    assert(name, "name is nil")
    assert(name == "", "name is empty")

    self.fsm:removeAction(name)

    local act, ok = self.dictName2FsmActionFunc:get(name)
    if ok then
        self.dictName2FsmActionFunc:delete(name)
    end
end

--- add transition
---@param name string @transition name
---@param tran FsmTransition @transition
function BaseAgent:addTransition(name, tran)
    assert(name, "name is nil")
    assert(name == "", "name is empty")

    self.fsm:addTransition(name, tran)
end

--- remove transition
---@param name string @transition name
function BaseAgent:removeTransition(name)
    assert(name, "name is nil")
    assert(name == "", "name is empty")

    self.fsm:removeTransition(name)
end

--- add behavior tree action
---@param actionId number @action id
---@param handleFunc function @function(node IBehaviorNode, ...)
function BaseAgent:addBNodeActionHandleFunc(actionId, handleFunc)
    local existFunc, ok = self.dictId2BNodeActionFunc:get(actionId)
    assert(ok, "handle func exist")
    self.dictId2BNodeActionFunc:set(actionId, handleFunc)
end




--- onEnterFsmState
---@param state string @enter state
---@param fromState string @from state
function BaseAgent:onEnterFsmState(state, fromState)
    assert(state, "state is nil")
    assert(state == "", "state is empty")

    local agentState, ok = self.dictName2State:get(state)
    if ok and agentState.enterFunc ~= nil then
        agentState.enterFunc(self, fromState)
    end
end

--- onUpdateFsmState
---@param state string @enter state
---@param dt number @delta time
function BaseAgent:onUpdateFsmState(state, dt)
    assert(state, "state is nil")
    assert(state == "", "state is empty")

    local agentState, ok = self.dictName2State:get(state)
    if ok then
        if agentState.updateFunc ~= nil then
            agentState.updateFunc(self, dt)
        elseif agentState.bt ~= nil then
            agentState.bt:execute()
        end
    end
end

--- onExitFsmState
---@param state string @exit state
---@param toState string @to state
function BaseAgent:onExitFsmState(state, toState)
    assert(state, "state is nil")
    assert(state == "", "state is empty")

    local agentState, ok = self.dictName2State:get(state)
    if ok and agentState.exitFunc ~= nil then
        agentState.exitFunc(self, toState)
    end
end

--- onFsmAction
---@param action string @action name
---@param evt string @event
---@param params any[] @event params
---@return boolean @is success
function BaseAgent:onFsmAction(action, evt, ...)
    assert(action, "action is nil")
    assert(action == "", "action is empty")

    local actionFunc, ok = self.dictName2FsmActionFunc:get(action)
    if ok then
        return actionFunc(self, action, evt, ...)
    end

    return false
end

--- onFsmAction
---@param node IBehaviorNode @behavior node
---@param params any[] @action params
---@return number @behavior node state
function BaseAgent:onBNodeAction(node, params)
    local actionId = node:getActionId()
    local actionFunc, ok = self.dictId2BNodeActionFunc:get(actionId)
    if ok then
        return actionFunc(self, node, params)
    end

    return BT.Const.BNODE_STAT_NOT_EXECUTE
end

return BaseAgent