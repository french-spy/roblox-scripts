local gc = getgc(true);

local b;
for i = #gc, 1, -1 do
    if type(gc[i]) == "table" then
        if rawget(gc[i], "A") and #(rawget(gc[i], "A")) > 2 then
            b = rawget(gc[i], "A");
            break;
        end
    end
end
