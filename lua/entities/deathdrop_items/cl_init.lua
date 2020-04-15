include('shared.lua')

function ENT:Initialize()
    self.Color = Color(255, 255, 255, 255)
end

function ENT:Draw()
    self:DrawModel()
end