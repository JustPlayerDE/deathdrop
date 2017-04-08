local model = "" -- What model should it be?
local classname = "dead_items_nirurp" -- This should be the name of the folder containing this file.
local ShouldSetOwner = true -- Set the entity's owner?

-------------------------------
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
include( 'shared.lua' )
-------------------------------

--------------------
-- Spawn Function --
--------------------
function ENT:SpawnFunction( ply, tr )

	if ( !tr.Hit ) then return end
	local SpawnPos = tr.HitPos + tr.HitNormal * 25
	local ent = ents.Create( classname )
	ent:SetPos( SpawnPos )
	ent:Spawn()
	ent:Activate()
	if ShouldSetOwner then
		ent.Owner = ply
	end
	return ent
	
end

----------------
-- Initialize --
----------------
function ENT:Initialize()
	self.Entity:SetCollisionGroup( 11 )
	self.Entity:SetModel( model )
	self.Entity:PhysicsInit( SOLID_VPHYSICS )
	self.Entity:SetMoveType( MOVETYPE_VPHYSICS )
	self.Entity:SetSolid( SOLID_VPHYSICS )
	local phys = self.Entity:GetPhysicsObject()
	if (phys:IsValid()) then
		phys:Wake()
	end
	self.time = timer.Simple(300, function() if self:IsValid() then self:Remove() end end)
end

-----------------
-- Take Damage -- 
-----------------
function ENT:OnTakeDamage( dmginfo )
	self.Entity:TakePhysicsDamage( dmginfo )

end

------------
-- On use --
------------
function ENT:Use( activator, caller )
	if IsValid( caller ) and caller:IsPlayer() then
	local Items = self.items

	
				for weapon, v in pairs (Items) do
				
				
				--[[dropthiswep = ents.Create(v)
				dropthiswep:SetPos(droppos)
				dropthiswep:Spawn()
				caller:dropDRPWeapon(dropthiswep)]]--
				caller:Give(v)
				print("Give: "..v)
				self:Remove()
				end
				caller:ChatPrint("Du hast die sachen von "..self.Owner:Name().." gefunden!")
	end
end

-----------
-- Think --
-----------
function ENT:Think()

end

-----------
-- Touch --
-----------
function ENT:Touch(ent)
if ent:IsValid() and ent:IsPlayer() then



end 
end

--------------------
-- PhysicsCollide -- 
--------------------
function ENT:PhysicsCollide( data, phys )
	if ( data.Speed > 100 ) then self:EmitSound( Sound( "Flashbang.Bounce" ) ) end
end
function ENT:OnRemove() 



				--timer.Remove(self)
end