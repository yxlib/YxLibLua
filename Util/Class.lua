-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

-- class example
-- local TestClass = class(
--     "TestClass",
--     {
--         size = 2,
--         count = 0
--     },
--     nil
-- )

-- function TestClass:_ctor(...)
--     local params = {...}
--     self.count = params[1]
--     self.age = params[2]
-- end

-- local TestClass2 = class("TestClass2", nil, TestClass)
-- function TestClass2:_ctor(...)
--     local params = {...}
--     super(self, params[1], params[2])
    
--     self.fdsl = 3256
-- end

-- local testobj1 = TestClass.new(2, 15)
-- local testobj2 = TestClass2.new(3,66)

-- print("testobj1._className: ", testobj1._className)
-- print("testobj1.count: ", testobj1.count)
-- print("testobj1.age: ", testobj1.age)

-- print("testobj2._className: ", testobj2._className)
-- print("testobj2.count: ", testobj2.count)
-- print("testobj2.age: ", testobj2.age)
-- print("testobj2.fdsl: ", testobj2.fdsl)


--- define a class
--- t._className string, class name
--- t._super table, super class
--- t._ctor function, define member fields
---@param className string @class name
---@param staticFields table @define static fields
---@param super table @super class
---@return table @class template
function class(className, staticFields, super)
    local t = {
        _className = className,
        _super = super,
        _ctor = nil
    }

    -- static fields
    if staticFields ~= nil then
        for k, v in pairs(staticFields) do
            if k == "_ctor" then
                goto continue
            end

            t[k] = v

            ::continue::
        end
    end

    -- extends super
    if t._super ~= nil then
        -- static fields and methods
        local superStaticClone = {}
        for k, v in pairs(t._super) do
            if k == "_ctor" then
                goto continue
            end

            superStaticClone[k] = v

            ::continue::
        end

        setmetatable(t, superStaticClone)
    end
    
    t.__index = t
    -- new method
    t.new = function(...)
        local o = {}
        -- invokeCtor(o, t, ...)

        setmetatable(o, t) -- bind class
        o:_ctor(...)
        return o
    end

    -- function invokeCtor(o, cls, ...)
    --     if cls._super ~= nil then
    --         invokeCtor(o, cls._super, ...)
    --     end

    --     if cls._ctor ~= nil then
    --         setmetatable(o, cls)
    --         o:_ctor(...)
    --         setmetatable(o, nil)
    --     end
    -- end

    return t
end

function super(o, ...)
    assert(o._super, "super class is nil")

    if o._super._ctor ~= nil then
        o._super._ctor(o, ...)
    end
end

--- define a interface
--- t._interfaceName string, interface name
--- @param interfaceName string @interface name
function interface(interfaceName, ...)
    local supers = {...}
    local t = {
        _interfaceName = interfaceName
    }

    t.__index = t

    if #supers == 0 then
        return t
    end

    for i, super in ipairs(supers) do
        for k, v in pairs(super) do
            if k == "_ctor" then
                goto continue
            end

            t[k] = v

            ::continue::
        end
    end
    
    return t
end
