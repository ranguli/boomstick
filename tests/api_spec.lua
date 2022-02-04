package.path = "../?.lua;" .. package.path

require("boomstick/api")

describe("boomstick.item_is_weapon()", function()
    it("should return true if passed a weapon", function()
        fake_item = {}
        fake_item.boomstick_weapon_data = {}
        assert.True(boomstick.item_is_weapon(fake_item))
    end)
    it("should return false if not ", function()
        fake_item = {}
        assert.False(boomstick.item_is_weapon(fake_item))
    end)
end)
