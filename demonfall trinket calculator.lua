local configs = game:GetService("ReplicatedStorage").Trinkets;
local calculatedPrice = 0;

for i,v in next, getrenv()._G.PlayerData.Inventory do
    if configs:FindFirstChild(v) then
        calculatedPrice = calculatedPrice + configs:FindFirstChild(v).Configuration.Price.Value;
    end
end
game:service"StarterGui":SetCore("SendNotification", 
{
    Title = "Trinket Calculator",
    Text = tostring(calculatedPrice) .. " yen";
});
