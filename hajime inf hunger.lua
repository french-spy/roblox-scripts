local lp = game:service"Players".LocalPlayer;

_G.infHunger = true;

coroutine.wrap(function()
    while _G.infHunger do wait()
        lp.data.stats.hunger.Value = lp.data.notSavable.max_hgr.Value;
    end
end)();
