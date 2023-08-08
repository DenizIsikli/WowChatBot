-- ChatBotAddon.lua

local frame = CreateFrame("FRAME", "Frame");
frame:RegisterEvent("CHAT_MSG_SELF")

frame:SetScript("OnEvent", function(self, event, message)
    if string.sub(message, 1, 1) == "!" then
        local command, args = string.match(message, "!(%w+)%s*(.*)")
        
        if command then
            commandList(command, args)
        end
    end
end)

Commands = {
    -- List of all available commands

    ["help"] = function(command, args)
        SendChatMessage("Available commands: !help, !crit", "GUILD")
    end,
    ["crit"] = function(command, args)
        local crit = GetCritChance()
        SendChatMessage("Your current crit chance is: " .. crit .. "%")
    end,
}



function commandList(command, args)
    local commandFunction = Commands[command]
    
    if commandFunction then
        commandFunction(command, args)
    else
        SendChatMessage("Unknown command. Type !help for a list of commands.", "GUILD")
    end
end



    