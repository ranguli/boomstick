package.path = "../?.lua;" .. package.path

boomstick = {}

require("weapons.lua")

describe ("boomstick.get_weapon_texture_name", function()
    it("gets weapon texture names", function()
        assert.equals("boomstick_rustington_icon.png",
        get_weapon_texture_name("boomstick", "rustington", "icon", "png"))
    end)
end)
