local Camera = workspace.CurrentCamera
local Holding = false
_G.Enabled = false -- Global variable to enable/disable the functionality

function findGoals()
    for i, v in pairs(workspace:GetDescendants()) do
        if v.Name == "Lol" then
            v.Parent = workspace
        end
    end
end

local function findClosestPart(position)
    local closestPart, closestPartMagnitude
    local tmpMagnitude
    for i, v in pairs(workspace:GetChildren()) do
        if v.Name == "Lol" then
            if closestPart then
                tmpMagnitude = (position - v.Position).magnitude
                if tmpMagnitude < closestPartMagnitude then
                    closestPart = v
                    closestPartMagnitude = tmpMagnitude
                end
            else
                closestPart = v
                closestPartMagnitude = (position - v.Position).magnitude
            end
        end
    end
    return closestPart
end

findGoals()

local UIS = game:GetService('UserInputService')
UIS.InputBegan:connect(function(Input, GPE)
    if _G.Enabled and not GPE and Input.KeyCode == Enum.KeyCode.X then
        local lookthat = findClosestPart(game.Players.LocalPlayer.Character.Torso.Position)
        Holding = true
        repeat
            wait(0.01)
            Camera.CFrame = CFrame.new(Camera.CFrame.p, lookthat.Position + Vector3.new(0, 40.5, 0)) 
        until Holding == false or not _G.Enabled
    end
end)

UIS.InputEnded:connect(function(Input, GPE)
    if not GPE and Input.KeyCode == Enum.KeyCode.X then
        Holding = false
    end
end)
