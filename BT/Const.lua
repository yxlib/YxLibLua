-- Copyright 2022 Guan Jianchang. All rights reserved.
-- Use of this source code is governed by a BSD-style
-- license that can be found in the LICENSE file.

local Const = {}

-- state
Const.BNODE_STAT_NOT_EXECUTE = 1
Const.BNODE_STAT_EXECUTING = 2
Const.BNODE_STAT_SUCC = 3
Const.BNODE_STAT_FAIL = 4

-- type
Const.BNODE_TYPE_ACTION = 1
Const.BNODE_TYPE_SEQUENCE = 2
Const.BNODE_TYPE_SELECT = 3
Const.BNODE_TYPE_PARALLEL = 4

-- id
Const.BTREE_ROOT_NODE_ID = 1

return Const