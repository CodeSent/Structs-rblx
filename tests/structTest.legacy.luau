local struct = require(game.ReplicatedStorage.Modules.struct)

local test = struct.new({
	{"name", struct.Types.getStringType(10)},
	{"Position",struct.Types.VECTOR3},
	{"Level",struct.Types.UINT8},
	{"gravity", struct.Types.FLOAT64},
})


test.name = "Testbot379"
test.Level = 70
test.Position = Vector3.new(10,10,10)
test.gravity = 100.199
print(test.name)
print(test.Level)
print(test.Position)
print(test.gravity)
print("buffer: ",test)