-------------------------------
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

-------------------------------

----------------
-- Initialize --
----------------
function ENT:Initialize()
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    local phys = self:GetPhysicsObject()

    if (phys:IsValid()) then
        phys:Wake()
    end

    self.time = timer.Simple(300, function()
        if self:IsValid() then
            self:Remove()
        end
    end)
end

-----------------
-- Take Damage -- 
-----------------
function ENT:OnTakeDamage(dmginfo)
    self:TakePhysicsDamage(dmginfo)
end

------------
-- On use --
------------
function ENT:Use(activator, caller)
    if IsValid(caller) and caller:IsPlayer() then
        for _, class in pairs(self.items) do
            DEATHDROP.log("Giving " .. class .. " to " .. tostring(caller), true)
            caller:Give(class)
        end

        self:Remove()
    end
end

-----------
-- Think --
-----------
function ENT:Think()
    -- Removing after some time?
end

--------------------
-- PhysicsCollide -- 
--------------------
function ENT:PhysicsCollide(data, phys)
    if (data.Speed > 100) then
        self:EmitSound(Sound("Flashbang.Bounce"))
    end
end