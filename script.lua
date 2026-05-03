local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local remote = game.ReplicatedStorage:WaitForChild("AtaqueRemote")

local cooldown = false

UIS.InputBegan:Connect(function(input, gp)
	if gp then return end
	
	if input.KeyCode == Enum.KeyCode.E and not cooldown then
		cooldown = true
		
		remote:FireServer()
		
		wait(2)
		cooldown = false
	end
end)
local remote = game.ReplicatedStorage:WaitForChild("AtaqueRemote")

remote.OnServerEvent:Connect(function(player)
	local char = player.Character
	if not char then return end
	
	local root = char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	

	local hitbox = Instance.new("Part")
	hitbox.Size = Vector3.new(5,5,5)
	hitbox.CFrame = root.CFrame * CFrame.new(0,0,-5)
	hitbox.Anchored = true
	hitbox.CanCollide = false
	hitbox.Transparency = 0.5
	hitbox.Parent = workspace
	
	for _, obj in pairs(workspace:GetChildren()) do
		if obj:FindFirstChild("Humanoid") and obj ~= char then
			local hrp = obj:FindFirstChild("HumanoidRootPart")
			if hrp and (hrp.Position - hitbox.Position).Magnitude < 6 then
				obj.Humanoid:TakeDamage(20)
			end
		end
	end
	
	game.Debris:AddItem(hitbox, 0.2)
end)