local move = require(script.Parent.Parent.Parent.Shared.DTCS).Moves

local Testing = move.new("Testing")

Testing.test = function()
    print("This is a test move!")
end

return Testing