-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

require("Assets.YxLibLua.Util.Util")

---@class Msg @Msg class
local Msg = class("Msg", nil, nil)

--- ctor method
function Msg:_ctor(...)
    local params = {...}
    self.name = params[1]
    self.params = params[2]
end

return Msg