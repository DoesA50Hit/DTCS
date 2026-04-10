local RunService = game:GetService("RunService")

if RunService:IsServer() then
    return require(script.server)
else
    local replicaServer = script.Parent:FindFirstChild("server")
    if replicaServer and RunService:IsRunning() then
        replicaServer:Destroy()
    end

    return require(script.client)
end
