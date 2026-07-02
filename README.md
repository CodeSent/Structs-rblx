# Struct-rblx

an implementation of C like structs on luau for roblox studio using buffers. this module helps to make a defined structure type with set fields and their data types, which is reusable and lets you compress data into a byte string.

#### Usage
to make your own struct, firstly get the module from the rbxm file or by cloning the project, then import the struct module into your script. Then you can create a usable struct like this.
```lua
local struct = require(game.ReplicatedStorage.Modules.struct)

local structRule = {
	{"name", struct.Types.getStringType(10)},
	{"Position",struct.Types.VECTOR3},
	{"Level",struct.Types.UINT8},
	{"gravity", struct.Types.FLOAT64},
}

local newStruct = struct.new(structRule, {
	name = "CodeSent",
	Position = Vector3.new(0,0,0),
	Level = 10,
})


newStruct.name = "Testbot379"
newStruct.Level = 70
newStruct.Position = Vector3.new(10,10,10)
newStruct.gravity = 100.199

print(newStruct.name)
print(newStruct.Level)
print(newStruct.Position)
print(newStruct.gravity)
print("buffer: ",newStruct) -- prints the byte string of the struct
```
firstly we create a `structRule` which defines the structure of our struct, its a array which contains a `Key`, `Type` pair where the first is the Key of an field of the struct the second is a special data structure called a `TypeRule`.

### TypeRule
it is an important data structure which defines 
  - what's the size of the field.
  - how should it be serialized or deserialized to be placed in a buffer.
  - Optionally what type it can only accept.
    
the module contains pre-defined type rules for the most common luau datatypes (`number`,`string`) as C datatypes (`INT32`,`UINT8`,`CHAR`,etc) and other studio datatypes like `Vector3` under `struct.Types` as shown in the above example.

also, if you noticed above that, the `name` key has a function called `getStringType()` with 10 as it's parameter. its to create a string data type with a set Size as, in a struct everything has a set size.

#### creating a struct

After we have made our own structRule we can pass it to `struct.new()` to make a new struct object along with some initial values for the defined fields,we can now access the fields we have defined by indexing from the object like any other table, however whatever key you are indexing must be defined in the struct's rule otherwise it will assert. Also you cant add 2 diffrent fields with the same name, the field defined last will overwrite the previous fields.

the struct object has no build in or reserved indecies, it works purely through operators defined in it's metatable, key features include:
  - `newStruct["keyname"]` or `newStruct.keyname` can we used to index any existing field in the struct.
  - `#newStruct` returns the Size of the struct in bytes.
  - `tostring(newStruct)` returns the byte data of the struct as a string, and
  - `newStruct(data)` can be used to set the struct's data to be a byte string pass as a parameter.

to delete an struct object, simply remove any strong refrences to the object and let the GC clear it up automatically, or explicitly delete a struct by calling `struct.deleteStruct(newStruct)` passing in the struct object as the parameter

## Credits
made by [CodeSent](https://github.com/CodeSent)/[Testbot379](https://www.roblox.com/users/1076046274/profile).

This is my first time making an open source project ever, so any feedback will be greatly appriciated!


