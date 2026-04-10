local move = {}
move.__index = move

local exportTypes = require(script.Parent.Parent.utils.export_types)
type moveType = exportTypes.Move
type characterType = exportTypes.character
type moveClass = exportTypes.MoveClass

function move.new(name:string) 
    local self = setmetatable({}, move)
    self.name = name
    self.currentCooldown = 0
    self.owner = nil :: characterType
    return self :: moveType
end

local function _moveCanTrigger(self: moveType)
    if self.currentCooldown > 0 then
        return false
    end
end

function move:use(data: {Shared: table, Client: table, Server: table})

end

function move:triggerServer(data: {Shared: table, Server: table})

end

function move:triggerClient(data: {Shared: table, Client: table})

end

return move :: moveClass