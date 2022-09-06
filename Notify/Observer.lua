-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

require("Assets.YxLibLua.Util.Util")

---@class Observer @Observer class
local Observer = class("Observer", nil, nil)

--- ctor method
function Observer:_ctor(...)
    local params = {...}
    self.object = params[1]
    self.callback = params[2]
    self.once = params[3]
end

return Observer