local FindFirstChild, WaitForChild, GetService, GetChildren, GetDescendants = game.FindFirstChild, game.WaitForChild, game.GetService, game.GetChildren, game.GetDescendants

--| Variables
local Players = GetService(game, "Players")
local CoreGui = game.CoreGui

local Player = Players.LocalPlayer

local PlayerList = WaitForChild(CoreGui, "PlayerList")

--| Player Colors
local ColorList = {
    Friends = BrickColor.new(255/255, 255/255, 0/255),
}

local PlayerColorList = {
    [266723646] = BrickColor.new(255/255, 0/255, 0/255),
    [Players.LocalPlayer.UserId] = BrickColor.new(0/255,255/255,0/255)
}

function changeColor(uid, color)
    for _, v in pairs(GetDescendants(PlayerList)) do
        local a,b = string.find(v.Name, uid)
        if a == 3 and b == (string.len(uid) + 2) then
            for _, g in pairs(GetDescendants(v)) do
                if g:IsA("TextLabel") and g.Name == "PlayerName" then
                    g.TextColor = color
                end
            end
        end
    end
end

function updateColors()
    for _, plr in pairs(GetChildren(Players)) do
        local uid = plr.UserId
        if Player:IsFriendsWith(uid) then
            changeColor(uid, ColorList.Friends)
        end
        for id, col in pairs(PlayerColorList) do
            if id == uid then
                changeColor(uid, col)
            end
        end
    end
end

updateColors()

Players.PlayerAdded:Connect(updateColors)
Players.PlayerRemoving:Connect(updateColors)
