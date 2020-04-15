DEATHDROP = DEATHDROP or {}
DEATHDROP.DEBUG = true
DEATHDROP.enabled = true -- 1 = Enabled; 0 = Disabled
DEATHDROP.blacklist = { -- Here the entity names of the Weapons that you dont want to drop on death
    "weapon_fist",
    "weapon_gpee",
    "weapon_physcannon",
    "weapon_rape",
    "weapon_admin_gun_pro",
    "gmod_camera",
    "weapon_keypadchecker",
    "stunstick",
    "unarrest_stick",
    "arrest_stick",
    "door_ram",
    "weapon_physgun",
    "pocket",
    "keys",
    "weapon_physgun",
    "gmod_tool",
    "weaponchecker",
    "med_kit",
    "lockpick",
    "pist_weagon"
}
--[[
    DO NOT TOUCH
]]
function DEATHDROP.log(str, debug)
    if debug and not DEATHDROP.DEBUG then return end
    print("[DEATHDROP" .. (debug and " DEBUG" or "") .. "] " .. tostring(str))
end

local RPExtraTeams = RPExtraTeams or {}

function droptheweapon(ply)
    if not DEATHDROP.enabled then return end
    local ItemBag = {}
    local PlyTeam = RPExtraTeams[ply:Team()]

    --local droppos = ply:GetPos() + Vector(0, 0, 30)
    for k, v in pairs(ply:GetWeapons()) do
        local SWEPClass = v:GetClass()

        if not (table.HasValue(DEATHDROP.blacklist, SWEPClass) or table.HasValue(PlyTeam.weapons, SWEPClass)) then
            table.insert(ItemBag, SWEPClass)
        end
    end

    if table.Count(ItemBag) > 0 then
        local bag = ents.Create("dead_items_nirurp")
        bag:SetModel("models/props_junk/cardboard_box001a.mdl")
        bag:SetPos(ply:GetPos() + Vector(0, 0, 30))
        bag:SetUseType(SIMPLE_USE)
        bag.items = ItemBag
        bag.Owner = ply
        bag:Spawn()
    end
end
function toggledropweps(caller)
    if caller:EntIndex() == 0 or caller:IsAdmin() then
        DEATHDROP.enabled = not DEATHDROP.enabled

        if DEATHDROP.enabled then
            if caller:EntIndex() == 0 then
                DEATHDROP.log("Disabled!")
            else
                caller:ChatPrint("Deahdrop Disabled!")
            end
        else
            if caller:EntIndex() == 0 then
                DEATHDROP.log("Enabled!")
            else
                caller:ChatPrint("Deahdrop Enabled!")
            end
        end
    end
end

concommand.Add("toggledeathdrop", toggledropweps)
hook.Add("DoPlayerDeath", "DEATHDROP:dropsweps", droptheweapon)