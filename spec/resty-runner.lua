#!/usr/bin/env resty

-- script to run Busted tests using Openresty while setting some extra flags.
--
-- This script should be specified as:
--   busted --lua=<this-file>
--
-- Alternatively specify it in the `.busted` config file
--
local RESTY_FLAGS="-c 4096 -e 'setmetatable(_G, nil)'"

-- rebuild the invoked commandline, while inserting extra resty-flags
local cmd = {
  "exec",
  arg[-1],
  RESTY_FLAGS,
}
for i, param in ipairs(arg) do
  table.insert(cmd, "'" .. param .. "'")
end

local _, _, rc = os.execute(table.concat(cmd, " "))
os.exit(rc)
