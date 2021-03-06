DEATHDROP = DEATHDROP or {}

DEATHDROP.DEBUG = false
DEATHDROP.enabled = true -- 1 = Enabled; 0 = Disabled
DEATHDROP.removalTime = 120 -- in seconds

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
local function shouldDrop(tbl, swep)
    if not isstring(swep) then return true end
    return not table.HasValue(tbl, swep)
end

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

        if shouldDrop(DEATHDROP.blacklist, SWEPClass) and shouldDrop(PlyTeam.weapons, SWEPClass) then
            table.insert(ItemBag, SWEPClass)
        end
    end

    if table.Count(ItemBag) > 0 then
        local bag = ents.Create("deathdrop_items")
        bag:SetModel("models/props_junk/cardboard_box001a.mdl")
        bag:SetPos(ply:GetPos() + Vector(0, 0, 30))
        bag.items = ItemBag
        bag.Owner = ply
        bag:Spawn()
        DEATHDROP.log("Created Bag #" .. bag:EntIndex() .. " containing " .. #bag.items .. " items.", true)
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