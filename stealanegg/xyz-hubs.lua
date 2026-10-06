local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ProximityPromptService = game:GetService("ProximityPromptService")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")
local hum = char:WaitForChild("Humanoid")

local LOGO_ID = "rbxassetid://74014978236029"
local POS_ANTIHIT = Vector3.new(544.7, 70.8, -364.4)
local POS_H1_AWAL = Vector3.new(971.9, 70.8, -410.2)
local POS_H1_AKHIR = Vector3.new(544.7, 70.8, -364.4)
local POS_H2_AWAL = Vector3.new(657.2, 70.8, -429.6)
local POS_H2_AKHIR = Vector3.new(544.7, 70.8, -364.4)
local POS_V1 = Vector3.new(657.7, 70.8, -432.5)
local POS_V2 = Vector3.new(543.3, 76.2, -409.2)
local WALK_TIMEOUT = 5

local antiEnabled, antiLooping, antiStop, antiPosAwal = false, false, 0, nil
local antiShield = {Value=nil}
local h1Enabled, h1Looping, h1Jalan, h1Stop, h1PosAwal = false, false, false, 0, nil
local h1Shield = {Value=nil}
local h2Enabled, h2Looping, h2Jalan, h2Stop, h2PosAwal = false, false, false, 0, nil
local h2Shield = {Value=nil}
local v1Enabled, v1Looping, v1Stop, v1PosAwal = false, false, 0, nil
local v1Shield = {Value=nil}
local v2Enabled, v2Looping, v2Stop, v2PosAwal = false, false, 0, nil
local v2Shield = {Value=nil}
local grabEnabled, trapEnabled = false, false
local trapConns = {}

local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.ResetOnSpawn = false
gui.Name = "Xyz-HUB"

local mainFrame = Instance.new("Frame", gui)
mainFrame.Size = UDim2.new(0, 300, 0, 420)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -210)
mainFrame.BackgroundColor3 = Color3.fromRGB(12, 8, 20)
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.ClipsDescendants = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 14)
local stroke = Instance.new("UIStroke", mainFrame)
stroke.Color = Color3.fromRGB(130, 60, 255)
stroke.Thickness = 2

-- BACKGROUND JELAS
local bgImage = Instance.new("ImageLabel", mainFrame)
bgImage.Size = UDim2.new(0, 500, 0, 500)
bgImage.Position = UDim2.new(0.5, -250, 0.5, -100)
bgImage.BackgroundTransparency = 1
bgImage.Image = LOGO_ID
bgImage.ImageTransparency = 0.5
bgImage.ImageColor3 = Color3.fromRGB(130, 60, 255)
bgImage.ZIndex = 1

-- LOGO GEDE KIRI ATAS
local logo = Instance.new("ImageLabel", mainFrame)
logo.Size = UDim2.new(0, 44, 0, 44)
logo.Position = UDim2.new(0, 8, 0, 6)
logo.BackgroundTransparency = 1
logo.Image = LOGO_ID
logo.ZIndex = 2
Instance.new("UICorner", logo).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", mainFrame)
title.Size = UDim2.new(0, 120, 0, 16)
title.Position = UDim2.new(0, 58, 0, 10)
title.BackgroundTransparency = 1
title.Text = "Xyz-HUB"
title.TextColor3 = Color3.fromRGB(170, 110, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 15
title.TextXAlignment = Enum.TextXAlignment.Left
title.ZIndex = 2

local disc = Instance.new("TextLabel", mainFrame)
disc.Size = UDim2.new(0, 120, 0, 12)
disc.Position = UDim2.new(0, 58, 0, 26)
disc.BackgroundTransparency = 1
disc.Text = "Ceo_WL Buliding"
disc.TextColor3 = Color3.fromRGB(140, 120, 180)
disc.Font = Enum.Font.Gotham
disc.TextSize = 9
disc.TextXAlignment = Enum.TextXAlignment.Left
disc.ZIndex = 2

local closeBtn = Instance.new("TextButton", mainFrame)
closeBtn.Size = UDim2.new(0, 28, 0, 28)
closeBtn.Position = UDim2.new(1, -32, 0, 6)
closeBtn.Text = "x"
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 14
closeBtn.TextColor3 = Color3.new(1,1,1)
closeBtn.BackgroundColor3 = Color3.fromRGB(130, 60, 255)
closeBtn.ZIndex = 2
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)

local minBtn = Instance.new("TextButton", mainFrame)
minBtn.Size = UDim2.new(0, 28, 0, 28)
minBtn.Position = UDim2.new(1, -64, 0, 6)
minBtn.Text = "-"
minBtn.Font = Enum.Font.GothamBold
minBtn.TextSize = 18
minBtn.TextColor3 = Color3.new(1,1,1)
minBtn.BackgroundColor3 = Color3.fromRGB(20, 15, 30)
minBtn.ZIndex = 2
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 6)

local viewBtn = Instance.new("ImageButton", gui)
viewBtn.Size = UDim2.new(0, 50, 0, 50)
viewBtn.Position = UDim2.new(0, 10, 0, 60)
viewBtn.Image = LOGO_ID
viewBtn.BackgroundColor3 = Color3.fromRGB(15, 10, 25)
viewBtn.Active = true
viewBtn.Draggable = true
viewBtn.ZIndex = 10
Instance.new("UICorner", viewBtn).CornerRadius = UDim.new(1, 0)
local viewStroke = Instance.new("UIStroke", viewBtn)
viewStroke.Color = Color3.fromRGB(130, 60, 255)
viewStroke.Thickness = 2

local tabMain = Instance.new("TextButton", mainFrame)
tabMain.Size = UDim2.new(0, 280, 0, 28)
tabMain.Position = UDim2.new(0, 10, 0, 52)
tabMain.Text = "Main"
tabMain.Font = Enum.Font.GothamBold
tabMain.TextSize = 12
tabMain.TextColor3 = Color3.new(1,1,1)
tabMain.BackgroundColor3 = Color3.fromRGB(125, 60, 255)
tabMain.ZIndex = 2
Instance.new("UICorner", tabMain).CornerRadius = UDim.new(0, 7)

local function buatBtn(y, text)
    local b = Instance.new("TextButton", mainFrame)
    b.Size = UDim2.new(0, 280, 0, 36)
    b.Position = UDim2.new(0, 10, 0, y)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(30, 20, 45)
    b.BackgroundTransparency = 0.2
    b.ZIndex = 2
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
    return b
end

local btnAnti = buatBtn(86, "Anti-Hit: OFF")
local btnGrab = buatBtn(126, "Instant Grab: OFF")
local btnTrap = buatBtn(166, "Anti-Trap: OFF")
local btnH1 = buatBtn(206, "Helper-Ler V1: OFF")
local btnH2 = buatBtn(246, "Helper-Ler V2: OFF")
local btnV1 = buatBtn(286, "Instant StealV1: OFF [300ms]")
local btnV2 = buatBtn(326, "Instant StealV2: OFF [300ms]")

local note = Instance.new("TextLabel", mainFrame)
note.Size = UDim2.new(0, 280, 0, 28)
note.Position = UDim2.new(0, 10, 0, 368)
note.BackgroundTransparency = 1
note.Text = "Note: Instant Steal only works on admin abuse (always)"
note.TextColor3 = Color3.fromRGB(160, 140, 200)
note.Font = Enum.Font.GothamBold
note.TextSize = 9
note.TextWrapped = true
note.TextXAlignment = Enum.TextXAlignment.Left
note.ZIndex = 2

local function setOnOff(btn, on)
    btn.BackgroundColor3 = on and Color3.fromRGB(125, 60, 255) or Color3.fromRGB(30, 20, 45)
    btn.BackgroundTransparency = on and 0 or 0.3
end
local function buatShield(pos, ref)
	if ref.Value then ref.Value:Destroy() end
	local p = Instance.new("Part")
	p.Size = Vector3.new(80,80,80)
	p.Position = pos
	p.Anchored = true
	p.CanCollide = false
	p.Transparency = 0.4
	p.Color = Color3.fromRGB(125,60,255)
	p.Material = Enum.Material.ForceField
	p.Parent = workspace
	ref.Value = p
end
local function hapus(ref) if ref.Value then ref.Value:Destroy() ref.Value=nil end end
local function enableGrab() for _,v in pairs(workspace:GetDescendants()) do if v:IsA("ProximityPrompt") then v.HoldDuration = 0 end end end
workspace.DescendantAdded:Connect(function(v) if grabEnabled and v:IsA("ProximityPrompt") then v.HoldDuration = 0 end end)
local function isTrap(obj) return string.find(string.lower(obj.Name), "trap") ~= nil end
local function hapusTrap() for _,obj in pairs(workspace:GetDescendants()) do if isTrap(obj) then pcall(function() obj:Destroy() end) end end end
local function startAntiTrap() hapusTrap() trapConns[1] = workspace.DescendantAdded:Connect(function(obj) if trapEnabled and isTrap(obj) then task.wait() pcall(function() obj:Destroy() end) end end) end
local function stopAntiTrap() for _,c in pairs(trapConns) do pcall(function() c:Disconnect() end) end trapConns = {} end
local function triggerAnti() if not antiEnabled or antiLooping then return end antiPosAwal=hrp.CFrame antiLooping=true antiStop=tick()+0.321 btnAnti.Text="Anti-Hit: ON" buatShield(POS_ANTIHIT, antiShield) end
local function triggerH1()
	if not h1Enabled or h1Looping or h1Jalan then return end
	if (hrp.Position - POS_H1_AWAL).Magnitude <= 10 then btnH1.Text="Helper-Ler V1: AUTO 10" task.wait(0.001) h1Jalan=true hum:MoveTo(POS_H1_AKHIR) task.spawn(function() task.wait(WALK_TIMEOUT) if h1Jalan then h1Jalan=false hum:MoveTo(hrp.Position) btnH1.Text="Helper-Ler V1: ON" end end) return end
	h1PosAwal=hrp.CFrame h1Looping=true h1Stop=tick()+2 btnH1.Text="Helper-Ler V1: ACTIVE" buatShield(POS_H1_AWAL, h1Shield)
	task.spawn(function() task.wait(0.001) if h1Looping and not h1Jalan then h1Jalan=true hum.WalkSpeed=16 hum:MoveTo(POS_H1_AKHIR) task.spawn(function() task.wait(WALK_TIMEOUT) if h1Jalan then h1Jalan=false hum:MoveTo(hrp.Position) btnH1.Text="Helper-Ler V1: ON" end end) end end)
end
local function triggerH2()
	if not h2Enabled or h2Looping or h2Jalan then return end
	if (hrp.Position - POS_H2_AWAL).Magnitude <= 10 then btnH2.Text="Helper-Ler V2: AUTO 10" task.wait(0.001) h2Jalan=true hum:MoveTo(POS_H2_AKHIR) task.spawn(function() task.wait(WALK_TIMEOUT) if h2Jalan then h2Jalan=false hum:MoveTo(hrp.Position) btnH2.Text="Helper-Ler V2: ON" end end) return end
	h2PosAwal=hrp.CFrame h2Looping=true h2Stop=tick()+2 btnH2.Text="Helper-Ler V2: ACTIVE" buatShield(POS_H2_AWAL, h2Shield)
	task.spawn(function() task.wait(0.001) if h2Looping and not h2Jalan then h2Jalan=true hum.WalkSpeed=16 hum:MoveTo(POS_H2_AKHIR) task.spawn(function() task.wait(WALK_TIMEOUT) if h2Jalan then h2Jalan=false hum:MoveTo(hrp.Position) btnH2.Text="Helper-Ler V2: ON" end end) end end)
end
local function triggerV1() if not v1Enabled or v1Looping then return end v1PosAwal=hrp.CFrame v1Looping=true v1Stop=tick()+0.3 btnV1.Text="Instant StealV1: ACTIVE" buatShield(POS_V1, v1Shield) end
local function triggerV2() if not v2Enabled or v2Looping then return end v2PosAwal=hrp.CFrame v2Looping=true v2Stop=tick()+0.3 btnV2.Text="Instant StealV2: ACTIVE" buatShield(POS_V2, v2Shield) end

btnAnti.MouseButton1Click:Connect(function() antiEnabled=not antiEnabled btnAnti.Text=antiEnabled and "Anti-Hit: ON" or "Anti-Hit: OFF" setOnOff(btnAnti, antiEnabled) if not antiEnabled and antiLooping then antiLooping=false hapus(antiShield) if antiPosAwal and hrp then pcall(function() hrp.CFrame=antiPosAwal end) end end end)
btnGrab.MouseButton1Click:Connect(function() grabEnabled=not grabEnabled btnGrab.Text=grabEnabled and "Instant Grab: ON" or "Instant Grab: OFF" setOnOff(btnGrab, grabEnabled) if grabEnabled then enableGrab() end end)
btnTrap.MouseButton1Click:Connect(function() trapEnabled=not trapEnabled btnTrap.Text=trapEnabled and "Anti-Trap: ON" or "Anti-Trap: OFF" setOnOff(btnTrap, trapEnabled) if trapEnabled then startAntiTrap() else stopAntiTrap() end end)
btnH1.MouseButton1Click:Connect(function() h1Enabled=not h1Enabled btnH1.Text=h1Enabled and "Helper-Ler V1: ON" or "Helper-Ler V1: OFF" setOnOff(btnH1, h1Enabled) if not h1Enabled then h1Looping=false h1Jalan=false hapus(h1Shield) end end)
btnH2.MouseButton1Click:Connect(function() h2Enabled=not h2Enabled btnH2.Text=h2Enabled and "Helper-Ler V2: ON" or "Helper-Ler V2: OFF" setOnOff(btnH2, h2Enabled) if not h2Enabled then h2Looping=false h2Jalan=false hapus(h2Shield) end end)
btnV1.MouseButton1Click:Connect(function() v1Enabled=not v1Enabled btnV1.Text=v1Enabled and "Instant StealV1: ON [300ms]" or "Instant StealV1: OFF [300ms]" setOnOff(btnV1, v1Enabled) end)
btnV2.MouseButton1Click:Connect(function() v2Enabled=not v2Enabled btnV2.Text=v2Enabled and "Instant StealV2: ON [300ms]" or "Instant StealV2: OFF [300ms]" setOnOff(btnV2, v2Enabled) end)
viewBtn.MouseButton1Click:Connect(function() mainFrame.Visible=not mainFrame.Visible end)
minBtn.MouseButton1Click:Connect(function() mainFrame.Visible=false end)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() stopAntiTrap() end)
ProximityPromptService.PromptTriggered:Connect(function(prompt, plr)
	if plr~=player then return end
	if not string.find(string.lower(prompt.ObjectText), "egg") and not string.find(string.lower(prompt.Parent.Name), "egg") then return end
	if antiEnabled and not antiLooping then triggerAnti() end
	if h1Enabled and not h1Looping and not h1Jalan then triggerH1() end
	if h2Enabled and not h2Looping and not h2Jalan then triggerH2() end
	if v1Enabled and not v1Looping then triggerV1() end
	if v2Enabled and not v2Looping then triggerV2() end
end)
RunService.Heartbeat:Connect(function()
	if antiLooping then pcall(function() hrp.CFrame=CFrame.new(POS_ANTIHIT) end) if tick()>=antiStop then antiLooping=false hapus(antiShield) btnAnti.Text="Anti-Hit: ON" if antiPosAwal and hrp then pcall(function() hrp.CFrame=antiPosAwal end) end antiPosAwal=nil end end
	if h1Enabled and h1Looping then if tick()<h1Stop then pcall(function() hrp.CFrame=CFrame.new(POS_H1_AWAL) end) else h1Looping=false hapus(h1Shield) btnH1.Text="Helper-Ler V1: WALK" if not h1Jalan then h1Jalan=true hum.WalkSpeed=16 hum:MoveTo(POS_H1_AKHIR) end end end
	if h2Enabled and h2Looping then if tick()<h2Stop then pcall(function() hrp.CFrame=CFrame.new(POS_H2_AWAL) end) else h2Looping=false hapus(h2Shield) btnH2.Text="Helper-Ler V2: WALK" if not h2Jalan then h2Jalan=true hum.WalkSpeed=16 hum:MoveTo(POS_H2_AKHIR) end end end
	if v1Looping then pcall(function() hrp.CFrame=CFrame.new(POS_V1) end) if tick()>=v1Stop then v1Looping=false hapus(v1Shield) if v1PosAwal and hrp then hrp.CFrame=v1PosAwal end v1PosAwal=nil btnV1.Text="Instant StealV1: ON [300ms]" end end
	if v2Looping then pcall(function() hrp.CFrame=CFrame.new(POS_V2) end) if tick()>=v2Stop then v2Looping=false hapus(v2Shield) if v2PosAwal and hrp then hrp.CFrame=v2PosAwal end v2PosAwal=nil btnV2.Text="Instant StealV2: ON [300ms]" end end
end)
player.CharacterAdded:Connect(function(c) char=c hrp=c:WaitForChild("HumanoidRootPart") hum=c:WaitForChild("Humanoid") antiLooping=false h1Looping=false h1Jalan=false h2Looping=false h2Jalan=false v1Looping=false v2Looping=false hapus(antiShield) hapus(h1Shield) hapus(h2Shield) hapus(v1Shield) hapus(v2Shield) end)
