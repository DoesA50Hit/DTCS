# DTCS - DoesA50Hit's Turn Combat System

> **Work in Progress** Core architecture is being established. Move execution, passives, and status effects are not yet implemented.

DTCS is a Roblox turn based combat framework built with Luau, designed around a client-server split. It provides a structured way to define moves, attach them to characters, and eventually support passives and status effects. It uses [Replica](https://github.com/thehoosky/replica) for state replication and is managed with [Wally](https://wally.run/) and [Rojo](https://rojo.space/). 

---

## Architecture

```
src/
├── server/         # Server entry point (init.server.luau)
├── client/         # Client entry point (init.client.luau) - stub
└── shared/
    └── DTCS/ 
        ├── init.luau               # Main module - createServer / createClient
        ├── classes/
        │   ├── move.luau           # Move class
        │   ├── character.luau      # Character class
        │   └── combat.luau         # Combat class - stub
        └── utils/
            ├── export_types.luau   # Shared Luau type definitions
            └── logger.luau         # Internal warn logger

DTCS_Tests/
├── Moves/          # test_move.luau
├── Passives/       # test_passive.luau - empty
└── StatusEffects/  # test_statusEffect.luau - empty
```

---

## Core Concepts

### Server / Client Instances

DTCS enforces a single server and single client instance per context. Call the appropriate factory once at startup:

```lua
-- Server script
local dtcs = require(replicatedStorage.Shared.DTCS)
local server = dtcs.createServer()

-- Client script
local dtcs = require(replicatedStorage.Shared.DTCS)
local client = dtcs.createClient()
```

Calling `createServer()` on the client (or vice versa) logs a warning and returns `nil`. Creating duplicates returns the existing instance.

### Registering Moves

Moves must be registered **before** calling `startServer()` / `startClient()`. Pass a `Folder` containing `ModuleScript`s that each return a Move object.

```lua
server:registerMoves(replicatedStorage.DTCS_Tests.Moves)
server:startServer()
```

After starting, further registration attempts are blocked and logged as warnings.

### Move

The `Move` class is the base for all combat actions.

```lua
local move = dtcs.Moves.new("FireBall")
-- move.name          -> "FireBall"
-- move.currentCooldown -> 0
-- move.owner         -> nil (set when attached to a Character)
```

**Planned methods** (stubs - not yet implemented):
- `move:use(data)` - unified entry point
- `move:triggerServer(data)` - server-side logic
- `move:triggerClient(data)` - client-side logic / effects

### Character

Wraps a `Humanoid` and holds a collection of moves. Intended to be created per player character.

```lua
local character = dtcs.Character.new(player.Character:WaitForChild("Humanoid"))

character.humanoid.Died:Connect(function()
    character:_cleanup()   -- cleans up all attached moves
end)
```

---

## Types

All shared types live in [src/shared/DTCS/utils/export_types.luau](src/shared/DTCS/utils/export_types.luau):

| Type | Description |
|---|---|
| `Move` | A single combat move with `name` and `owner` |
| `MoveClass` | Constructor for `Move` |
| `character` | Holds a `humanoid` and `moves` table |
| `CharacterClass` | Constructor for `character` |
| `dtcsServer` | Server instance |
| `dtcsClient` | Client instance |
| `dtcs` | Top-level module type |

---

## Dependencies

| Package | Source |
|---|---|
| [Replica](https://github.com/thehoosky/replica) `1.0.2` | State replication |

Managed via [Wally](https://wally.run/). To install:

## What's Not Done Yet

- `combat.luau` | entirely stubbed out
- `move:use()`, `move:triggerServer()`, `move:triggerClient()` | no logic
- Cooldown enforcement (`_moveCanTrigger` exists but is not wired up)
- Passives system | registered on server/client but no class defined
- Status effects system | registered on server/client but no class defined
- Move ownership | `move.owner` is never set automatically when attached to a character
- Replication via Replica | dependency installed but not yet integrated
- STILL A MAJOR WIP.