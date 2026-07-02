local struct = require(game.ReplicatedStorage.Modules.struct)

local Rule = {
	{"name", struct.Types.getStringType(10)},
	{"Position",struct.Types.VECTOR3},
	{"Level",struct.Types.UINT8},
	{"gravity", struct.Types.FLOAT64},
}

local test = struct.new(Rule)
local test2= struct.new(Rule)


test.name = "Testbot379"
test.Level = 800
test.Position = Vector3.new(10,10,10)
test.gravity = 100.199
print("buffer 1: ",test)
print(test.name)
print(test.Level)
print(test.Position)
print(test.gravity)
test2(tostring(test))
print("buffer 2: ",test2)
print(test2.name)
print(test2.Level)
print(test2.Position)
print(test2.gravity)