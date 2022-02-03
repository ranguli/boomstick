package.path = "../?.lua;" .. package.path

_G.ggg = {}

require("weapons")

describe ("get_weapon_texture_name", function()
    it("gets weapon texture names", function()
        assert.equals("ggg_rustington_icon.png", get_weapon_texture_name("ggg", "rustington", "icon", "png"))
    end)
end)
