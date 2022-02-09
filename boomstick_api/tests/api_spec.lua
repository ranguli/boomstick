package.path = "../?.lua;" .. package.path

_G.boomstick = {}

require("boomstick/api")

describe("boomstick.item_is_weapon()", function()
    local fake_item = {}
    it("should return false if not ", function()
        assert.False(boomstick.item_is_weapon(fake_item))
    end)
    it("should return true if passed a weapon", function()
        fake_item.boomstick_weapon_data = {}
        assert.True(boomstick.item_is_weapon(fake_item))
    end)
end)
