local struct = require(game.ReplicatedStorage.Modules.struct)

local structRule = {
	{"name", struct.Types.getStringType(10)},
	{"Position",struct.Types.VECTOR3},
	{"Level",struct.Types.UINT8},
	{"gravity", struct.Types.FLOAT64},
}

local newStruct = struct.new(structRule)
newStruct.name = "Testbot379"
newStruct.Level = 70
newStruct.Position = Vector3.new(10,10,10)
newStruct.gravity = 100.199

print(newStruct.name)
print(newStruct.Level)
print(newStruct.Position)
print(newStruct.gravity)
print("buffer: ",newStruct) -- prints the byte string of the struct