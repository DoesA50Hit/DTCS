local replicatedStorage = game:GetService("ReplicatedStorage")
local dtcs = require(replicatedStorage:WaitForChild("Shared"):WaitForChild("DTCS"))
local Players = game:GetService("Players")

local server = dtcs.createServer()

local character = dtcs.Character

server:registerMoves(replicatedStorage:WaitForChild("DTCS_Tests").Moves)
server:startServer()
print(server:viewRegisteredMoves())

task.wait(5)
for _, player in pairs(Players:GetPlayers()) do
    local Char = character.new(player.Character:WaitForChild("Humanoid"))
    Char.humanoid.Died:Connect(function()
        print(player.Name .. " has died. Cleaning up their character.")
        Char:_cleanup()
    end)
end