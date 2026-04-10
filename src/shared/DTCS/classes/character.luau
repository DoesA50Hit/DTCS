local character = {}
character.__index = character

local exportTypes = require(script.Parent.Parent.utils.export_types)
type characterClass = exportTypes.CharacterClass
type character = exportTypes.character
type moves = exportTypes.Move


function character.new(humanoid: Humanoid) : character
  local self: character = setmetatable({}, character)
  self.humanoid = humanoid
  self.moves = {}
  return self
end

function character:_cleanup()
  for _, move in pairs(self.moves) do
      move:cleanup()
  end
  self = nil
end

return character :: characterClass