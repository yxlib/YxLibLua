-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

require("LuaScripts.YxLibLua.Util.Class")

---@class Logger @Logger class
---@field tag string @log tag
local Logger = {
    LOG_LEVEL_DEBUG = 0,
    LOG_LEVEL_INFO = 1,
    LOG_LEVEL_WARN = 2,
    LOG_LEVEL_ERROR = 3,

    level = 0,

    ---@param tag string @log tag
    ---@return Logger @Logger object
    new = function(tag) end
}
class(Logger, "Logger", nil)

--- ctor method
function Logger:_ctor(...)
    local params = {...}
    self.tag = params[1]
end

function Logger:d(s, ...)
    if Logger.level > Logger.LOG_LEVEL_DEBUG then
        return
    end

    local msg = string.format(s, ...)
    local log = string.format("[DEBUG] [%s]   %s", self.tag, msg)
    print(log)
end

function Logger:i(s, ...)
    if Logger.level > Logger.LOG_LEVEL_INFO then
        return
    end
    
    local msg = string.format(s, ...)
    local log = string.format("[INFO ] [%s]   %s", self.tag, msg)
    print(log)
end

function Logger:w(s, ...)
    if Logger.level > Logger.LOG_LEVEL_WARN then
        return
    end

    local msg = string.format(s, ...)
    local log = string.format("[WARN ] [%s]   %s", self.tag, msg)
    print(log)
end

function Logger:e(s, ...)
    local msg = string.format(s, ...)
    local log = string.format("[ERROR] [%s]   %s", self.tag, msg)
    print(log)
end

return Logger
