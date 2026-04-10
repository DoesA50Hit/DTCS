local exportTypes ={}

export type Move = {
    name: string,
    owner: character,
}

export type MoveClass = {
    new: (name: string) -> Move,
}

export type CharacterClass = {
    new: (name: string) -> character,
}

export type character = {
    moves : {[string]: Move},
    humanoid : Humanoid,
}

export type dtcsServer = {
    Started: boolean,
    moves: {[string]: Move},
    passives: {[string]: any},
    statusEffects: {[string]: any},
    registerMoves: (self: dtcsServer, folder: Folder) -> nil,
    viewRegisteredMoves: (self: dtcsServer) -> {[string]: Move},
    startServer: (self: dtcsServer) -> boolean,
}

export type dtcsClient = {
    Started: boolean,
    moves: {[string]: Move},
    passives: {[string]: any},
    statusEffects: {[string]: any},
    registerMoves: (self: dtcsClient, folder: Folder) -> nil,
    viewRegisteredMoves: (self: dtcsClient) -> {[string]: Move},
    startClient: (self: dtcsClient) -> boolean,
}

export type dtcs = {
    createServer: () -> dtcsServer?,
    createClient: () -> dtcsClient?,
    Moves: MoveClass,
    Character: CharacterClass
}



return exportTypes
