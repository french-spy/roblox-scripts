local lp = game:service"Players".LocalPlayer;

_G.infStamina = true;

coroutine.wrap(function()
    pcall(function()
        while _G.infStamina do wait(); lp.data.notSavable.stm.Value = lp.data.notSavable.max_stm.Value; end
    end)
end)();
