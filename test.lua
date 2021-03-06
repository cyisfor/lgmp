local s = require("say")
local gmp = require('gmp')

s:set("assertion.close.positive", "%s is close to %s")
s:set("assertion.close.negative", "\n%s not close to \n%s")
assert:register("assertion", "close",
    function(state,arguments)
        local diff = arguments[1] - arguments[2]
        if type(diff)=="userdata" then            
            prec = gmp.f("1e-1000")
        else
            prec = 1e-10
        end
        return state.mod == (diff < prec and diff > -prec)
    end,
"assertion.close.negative", "assertion.close.positive")

describe("GNU Multiprecision Library",function()
    gmp.set_default_prec(10000)
    it("shifting",function()
        assert.same(gmp.z(0x20),gmp.z(0x10):lshift(2):rshift(1))
    end)
    it("boolean integer ops", function()
        assert.same(gmp.z(0x30),gmp.z(0x20):OR(gmp.z(0x10)))
        assert.same(gmp.z(0x20),gmp.z(0x30):AND(gmp.z(0x20)))
        assert.same(gmp.z(0x10),gmp.z(0x30):XOR(gmp.z(0x20)))
    end)
    it("long numbers",function()
        assert.same(gmp.z("4999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999"),
        (gmp.z(10)^1000-1)/2)
    end)
    it("addition", function()
        assert.same(gmp.z(2),gmp.z(1)+1)
        assert.same(gmp.z(2),gmp.z(1)+gmp.z(1))
    end)
    it("multiplication", function()
        assert.same(gmp.z(2),gmp.z(1)*2)
    end)
    it("division", function()
        assert.same(gmp.z(2),gmp.z(4)/2)
    end)
    it("real numbers, downconverting",function()
        assert.close(gmp.f("4.2"):get_d(),4.2)
    end)
    it("real upconverting",function()
        assert.close(gmp.f("0.25"),gmp.f(0.25))
    end)
    it("real adding",function()
        assert.close(gmp.f("5.2"),gmp.f("3.2")+2)
    end)
    it("real multiplication", function()
        assert.close(gmp.f("0.8"),gmp.f("0.2")*4)
    end)
    it("real division", function()
        assert.close(gmp.f("0.7"..string.rep("142857",1000)),gmp.f("5")/gmp.f("7"))
    end)
    it("real fractions", function()
        assert.same(gmp.f("3")/gmp.f("4"),gmp.f("6")/gmp.f("8"))
    end)
    it("real powers", function()
        assert.same(gmp.f("2")^3,gmp.f("2")*4)
    end)

    it("import/export", function()
        for _,n in ipairs({
            gmp.z(0),
            gmp.z(42^20),
            gmp.z(2)^0x200-1}) do
            assert.same(n,gmp.importz(n:export()))
        end
    end)
end)
