local combat = {}
combat.__index = combat

local exportTypes = require(script.Parent.Parent.utils.export_types)
type moveTypes = exportTypes.Move


return combat