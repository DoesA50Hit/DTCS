local logger = {}

function logger.warn(message: string)
    warn("[DTCS] [WARN] " .. message)
end

return logger