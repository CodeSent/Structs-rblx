local struct = require(game.ReplicatedStorage.Modules.struct)


task.spawn( function()
	while task.wait(0.5) do
		struct._printAllActiveStructs()
	end
end)


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
print("buffer: ",test)
task.wait(15)
print("derefrenced 1")
test = nil
for i = 1, 100000 do math.sqrt(i) end