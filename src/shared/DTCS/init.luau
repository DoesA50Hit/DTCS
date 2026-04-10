local dtcs = {}
dtcs.__index = dtcs

local utils = script.utils

local exportTypes = require(utils:WaitForChild("export_types"))
type moveTypes = exportTypes.Move
type dtcsServer = exportTypes.dtcsServer
type dtcsClient = exportTypes.dtcsClient
type dtcsType = exportTypes.dtcs

local logger = require(utils:WaitForChild("logger"))

local server:dtcsServer = {}
local client:dtcsClient = {}

-- SERVER METHODS
local serverMethods = {}
serverMethods.__index = serverMethods
function serverMethods:registerMoves(folder: Folder)
    if self.started == true then
        logger.warn("Attempted to registere moves after starting the server. This is not allowed.")
        return nil
    end
    for _, move in pairs(folder:GetChildren()) do
        if move:IsA("ModuleScript") then
            local moveModule:moveTypes = require(move)
            server.moves[moveModule.name] = moveModule
        end
    end
end

function  serverMethods:viewRegisteredMoves()
    return server.moves
end

function serverMethods:startServer()
    self.started = true
    return true
end

-- Create The Server

function dtcs.createServer()
    if game:GetService("RunService"):IsServer() then
        if server.Started == true then
            logger.warn("Attempted to create multiple DTCS servers. This is not allowed.")
            return server
        end
        local self = setmetatable({}, serverMethods)
        self.Started = false
        self.moves = {}
        self.passives = {}
        self.statusEffects = {}
        server = self
        return self
    else
        logger.warn("Attempted to create a DTCS server on the client. This is not allowed.")
        return nil
    end
end

-- CLIENT METHODS
local clientMethods = {}
clientMethods.__index = clientMethods
function clientMethods:registerMoves(folder: Folder)
    if self.started == true then
        logger.warn("Attempted to registere moves after starting the client. This is not allowed.")
        return nil
    end
    for _, move in pairs(folder:GetChildren()) do
        if move:IsA("ModuleScript") then
            local moveModule:moveTypes = require(move)
            client.moves[moveModule.name] = moveModule
        end
    end
end

function  clientMethods:viewRegisteredMoves()
    return client.moves
end

function clientMethods:startClient()
    self.started = true
    return true
end


-- Create The Client

function dtcs.createClient()
    if game:GetService("RunService"):IsClient() then
        if client.started == true then
            logger.warn("Attempted to create multiple DTCS clients. This is not allowed.")
            return client
        end
        local self = setmetatable({}, clientMethods)
        self.started = false
        self.moves = {}
        self.passives = {}
        self.statusEffects = {}
        client = self
        return self
    else
        logger.warn("Attempted to create a DTCS client on the server. This is not allowed.")
        return nil
    end
end

-- Forward the classes

dtcs.Moves = require(script:WaitForChild("classes"):WaitForChild("move"))
dtcs.Character = require(script:WaitForChild("classes"):WaitForChild("character"))

return dtcs :: dtcsType