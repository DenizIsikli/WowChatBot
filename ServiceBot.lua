-- ChatBotAddon.lua

local frame = CreateFrame("FRAME", "Frame");
frame:RegisterEvent("CHAT_MSG_SELF")

frame:SetScript("OnEvent", function(self, event, message)
    if string.sub(message, 1, 1) == "!" then
        local command, args = string.match(message, "!(%w+)%s*(.*)")
        
        if command then
            commandList(command, args)
            main()
        end
    end
end)

Commands = {
    -- List of all available commands
        -- Predominantly random commands for all purposes of gathering information

    -- Help command
    ["help"] = function(command, args)
        SendChatMessage("Available commands: !help, !crit", "GUILD")
    end,

    -- Crit command
    ["crit"] = function(command, args)
        local crit = GetCritChance()
        SendChatMessage("Your current crit chance is: " .. crit .. "%")
    end,

    -- Attack power command
    ["ap"] = function(command, args)
        local ap = GetAttackPower()
        SendChatMessage("Your current attack power is: " .. ap .. " AP")
    end,

    -- Spell power command
    ["sp"] = function(command, args)
        local sp = GetSpellBonusDamage(2)
        SendChatMessage("Your current spell power is: " .. sp .. " SP")
    end,
}

-- Command List function that executes the specified command 
-- depending on the input from the user
function commandList(command, args)
    local commandFunction = Commands[command]
    
    if commandFunction then
        commandFunction(command, args)
    else
        SendChatMessage("Unknown command. Type !help for a list of commands.", "GUILD")
    end
end


-- Main function
function main ()
    commandList()
end

