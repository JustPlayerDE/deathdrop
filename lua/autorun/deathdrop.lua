


dropweps = 1 -- 1 = Enabled; 0 = Disabled

dontdrop = { // Here the entity names of the Weapons that you dont want to drop on death
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
"pist_weagon",
}


RPExtraTeams = RPExtraTeams or {}
ItemBag = {}

function droptheweapon(ply)
	if dropweps == 1 then
	droppos = ply:GetPos() + Vector(0, 0, 30)
		for k, v in pairs (ply:GetWeapons()) do
			loopwep = v:GetClass()
			if not table.HasValue(dontdrop, loopwep) and not table.HasValue(RPExtraTeams[ply:Team()].weapons, loopwep) then
		
				local dropthiswep = loopwep
				ItemBag[k] = loopwep

			end
		end
		
		if table.Count( ItemBag ) > 0 then
		local bag = ents.Create( "dead_items_nirurp" )
		bag:SetModel( "models/props_junk/cardboard_box001a.mdl" )
		bag:SetPos( ply:GetPos()+ Vector(0, 0, 30) )
		bag:SetUseType( SIMPLE_USE )
		bag.items = ItemBag
		bag.Owner = ply
		bag:Spawn()
		ItemBag = {}
		else
		
		end
	end
end


function toggledropweps(caller)
	if caller:IsAdmin() then
		if dropweps == 1 then
			dropweps = 0
			caller:ChatPrint("Deathdrop Disabled!")
		elseif dropweps == 0 then
			dropweps = 1
			caller:ChatPrint("Deahdrop Enabled!")
		end
	end
end

concommand.Add("toggleweapondrop", toggledropweps)
hook.Add("DoPlayerDeath", "pldrophook", droptheweapon)


