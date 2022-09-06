-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Util = require("Assets.YxLibLua.Util.Util")
local Const = require("Assets.YxLibLua.BT.Const")
local ControlNode = require("Assets.YxLibLua.BT.ControlNode")

---@class SelectNode @SelectNode class
local SelectNode = class("SelectNode", nil, ControlNode)

--- ctor method
function SelectNode:_ctor(...)
    local params = {...}
    super(self, params[1], Const.BNODE_TYPE_SELECT)

    -- self.nodeType = Const.BNODE_TYPE_SELECT
end

--- execute
function SelectNode:execute()
    if self:isCompleted() then
        return
    end

    self.state = Const.BNODE_STAT_EXECUTING

    for i, child in ipairs(self.subNodes) do
        if child:isCompleted() then
            goto continue
        end

        child:execute()
        if not child:isCompleted() then
            break
        end

        if child:getState() == Const.BNODE_STAT_SUCC then
            self.state = Const.BNODE_STAT_SUCC
        elseif i == #(self.subNodes) then
            self.state = Const.BNODE_STAT_FAIL
        end

        break

        ::continue::
    end
end

return SelectNode