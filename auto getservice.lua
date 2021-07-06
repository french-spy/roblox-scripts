local services = {};
setmetatable(services, 
{
    __index = function(t, k)
        if not rawget(t, k) then
            rawset(t, k, game:GetService(k));
            return game:GetService(k);
        end
    end;
});
