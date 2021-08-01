for i,v in pairs(workspace["__THINGS"].Orbs:GetChildren()) do
    local args = {
        [1] = {
            [1] = {
                [1] = v.Name
            }
        }
    }
    workspace.__THINGS.__REMOTES:FindFirstChild("claim orbs"):FireServer(unpack(args));
end
