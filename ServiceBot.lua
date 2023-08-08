-- ChatBotAddon.lua

local frame = CreateFrame("FRAME", "Frame");
frame:RegisterEvent("CHAT_MSG_SELF")


-- Event handler for the chat message event
frame:SetScript("OnEvent", function(self, event, message)
    if string.sub(message, 1, 1) == "!" then
        local command, args = string.match(message, "!(%w+)%s*(.*)")
        
        if command then
            commandList(command, args)
        else
            SendChatMessage("Unknown command. Type !help for a list of commands.", "GUILD")
        end
    end
end)


Commands = {
    -- List of all available commands
        -- Predominantly random commands for all purposes of gathering information

    -- Help commands
    ["help"] = function(command, args)
        SendChatMessage("Available commands: !help, !basestats, !separated, !crit, !ap, !app, !sp, !armor, !health", "GUILD")
    end,

    ["separatedCmds"]  = function(command, args)
        SendChatMessage("Stat commands separated: !crit, !ap, !app, !sp, !armor, !health, !block, !dodge, !parry, !resil, !haste, !mastery", "GUILD")
    end,


    -- Base Stats: Strength, Agility, Stamina, Intellect, Spirit, Armor
    ["basestats"] = function(command, args)
        local strength = UnitStat("player", 1) or 0
        local agility = UnitStat("player", 2) or 0
        local stamina = UnitStat("player", 3) or 0
        local intellect = UnitStat("player", 4) or 0
        local spirit = UnitStat("player", 5) or 0
        local armor = UnitArmor("player") or 0
        SendChatMessage("Base Stats: Strength: " .. strength .. "\n" .. "Agility: " .. agility .. "\n" .. "Stamina: " .. stamina .. "\n" .. "Intellect: " .. intellect .. "\n" .. "Spirit: " .. spirit .. "\n" .. "Armor: " .. armor, "GUILD")
    end,

    -- Offense Stats: Damage, Attack Power, Attack Speed, DPS
    ["offense"] = function(command, args)
        local damage = GetSpellBonusDamage(2) or 0
        local attackPower = UnitAttackPower("player") or 0
        local attackSpeed = UnitAttackSpeed("player") or 0 
        local dps = attackPower / attackSpeed
        SendChatMessage("Offense stats: Damage: " .. damage .. "\n" .. "Attack Power: " .. attackPower .. "\n" .. "Attack Speed: " .. attackSpeed .. "\n" .. "DPS: " .. dps, "GUILD")
    end,

    -- Defense Stats: Armor, Block, Dodge, Parry, Resilience, Haste, Mastery
    ["defense"] = function(command, args)
        local armor = UnitArmor("player") or 0
        local dodge = GetDodgeChance() or 0
        local parry = GetParryChance() or 0
        local block = GetBlockChance() or 0
        local defense = GetCombatRating(2) or 0
        SendChatMessage("Defense stats: Armor: " .. armor .. "\n" .. "Dodge: " .. dodge .. "\n" .. "Parry: " .. parry .. "\n" .. "Block: " .. block .. "\n" .. "Defense: " .. defense, "GUILD")
    end,

    -- Melee Enhancements Stats: Melee Hit, Melee +Damage, Melee Critical Strike, Ranged Critical Strike
    ["melee"] = function(command, args)
        local meleeHit = GetCombatRating(6) or 0
        local meleeDamage = GetCombatRating(7) or 0
        local meleeCrit = GetCombatRating(8) or 0
        local rangedCrit = GetCombatRating(9) or 0
        SendChatMessage("Melee Enhancement stats: Melee Hit: " .. meleeHit .. "\n" .. "Melee Damage: " .. meleeDamage .. "\n" .. "Melee Critical Strike: " .. meleeCrit .. "\n" .. "Ranged Critical Strike: " .. rangedCrit, "GUILD")
    end,

    -- Spell Enhancements Stats: Spell Hit, Spell +Damage, Spell Critical Strike, Spell Haste, +Healing, Mana Regen Not Casting, Mana Regen Casting
    ["spell"] = function(command, args)
        local spellHit = GetCombatRating(10) or 0
        local spellDamage = GetCombatRating(11) or 0
        local spellCrit = GetCombatRating(12) or 0
        local spellHaste = GetCombatRating(13) or 0
        local healing = GetCombatRating(14) or 0
        local manaRegenNotCasting = GetCombatRating(15) or 0
        local manaRegenCasting = GetCombatRating(16) or 0
        SendChatMessage("Spell Enhancement stats: Spell Hit: " .. spellHit .. "\n" .. "Spell Damage: " .. spellDamage .. "\n" .. "Spell Critical Strike: " .. spellCrit .. "\n" .. "Spell Haste: " .. spellHaste .. "\n" .. "Healing: " .. healing .. "\n" .. "Mana regen (not casting): " .. manaRegenNotCasting .. "\n" .. "Mana regen (casting): " .. manaRegenCasting, "GUILD")
    end,

    -- print next server reset
    ["reset"] = function(command, args)
        local reset = GetQuestResetTime()
        SendChatMessage("The next server reset is in: " .. reset .. " seconds.", "GUILD")
    end,


    -- Separated stat commands for "separatedCmds" command
    -- ---------------------------------------------------

    -- Non dynamic commands - not within the API
    -- Base Stats
        -- Strength command
    ["str"] = function(command, args)
        local strength = UnitStat("player", 1) or 0
        SendChatMessage("Your current strength is: " .. strength, "GUILD")
    end,

        -- Agility command
    ["agi"] = function(command, args)
        local agility = UnitStat("player", 2) or 0
        SendChatMessage("Your current agility is: " .. agility, "GUILD")
    end,

        -- Stamina command
    ["sta"] = function(command, args)
        local stamina = UnitStat("player", 3) or 0
        SendChatMessage("Your current stamina is: " .. stamina, "GUILD")
    end,

        -- Intellect command
    ["int"] = function(command, args)
        local intellect = UnitStat("player", 4) or 0
        SendChatMessage("Your current intellect is: " .. intellect, "GUILD")
    end,

        -- Spirit command
    ["spi"] = function(command, args)
        local spirit = UnitStat("player", 5) or 0
        SendChatMessage("Your current spirit is: " .. spirit, "GUILD")
    end,
 
    ["armor"] = function() return UnitArmor("player") end,
    ["crit"] = GetCritChance,
    ["ap"] = UnitAttackPower,
    ["app"] = function() return UnitAttackPower("pet") end,
    ["sp"] = function() return GetSpellBonusDamage(2) end,
    ["health"] = function() return UnitHealth("player") end,
    ["block"] = GetBlockChance,
    ["dodge"] = GetDodgeChance,
    ["parry"] = GetParryChance,
    ["resil"] = function() return GetCombatRating(24) end,
    ["haste"] = function() return GetCombatRating(18) end,
    ["mastery"] = GetMastery,

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
