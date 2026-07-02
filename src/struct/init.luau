local commonTypes = require(script.commonTypes)
local module = {}
module.Types = commonTypes 

local function isvalidType(check : commonTypes.TypeRule?)
	return check and type(check._size) == "number" and type(check._serialize) == "function" and check._serialize ~= nil and type(check._deserialize) == "function"
end
-- Holds a weak refrence to the struct data with the holder.
-- If the holder has no valid refrences, the struct rule will be removed
-- This is to avoid memory Leaks and to have a way to delete structs in a simple way
local _structHolders = setmetatable({},{__mode = "k"})
-- main metatable body
local _meta = {
	__index = function(self, key)
		--print(structHolder[self])
		assert(_structHolders[self],"struct has been dereferenced, and cannot be used anymore")
		assert(_structHolders[self]._fields[key],`field name {key} doesnt exist in struct`)
		return _structHolders[self]._fields[key]._rule._deserialize(_structHolders[self]._buffer,_structHolders[self]._fields[key]._index)
	end,
	__newindex = function(self, key, value)
		assert(_structHolders[self],"struct has been dereferenced, and cannot be used anymore")
		assert(_structHolders[self]._fields[key],`field name "{key}"" doesnt exist in struct`)
		_structHolders[self]._fields[key]._rule._serialize(_structHolders[self]._buffer,_structHolders[self]._fields[key]._index,value)
	end,
	__len = function(self)
		assert(_structHolders[self],"struct has been dereferenced, and cannot be used anymore")
		return _structHolders[self]._size
	end,
	__tostring = function(self)
		assert(_structHolders[self],"struct has been dereferenced, and cannot be used anymore")
		return buffer.tostring(_structHolders[self]._buffer)
	end,
	__call = function(self,wData : string)
		assert(_structHolders[self],"struct has been dereferenced, and cannot be used anymore")
		buffer.writestring(_structHolders[self]._buffer,0,wData,math.min(_structHolders[self]._size,#wData))
	end,
}
export type StructRule = {{string | commonTypes.TypeRule}}
-- Create a struct object, from a defined struct rule
--@param structure  a table where the fields of the struct is defined, it's a array of tables, where the first value is the name of the field, and the second value is a special Type object, you can find most predefined special Types for the most common studio objects in <code>.Types</code> of the same class
module.new = function(structure : StructRule)
	local _holder = {}
	_structHolders[_holder] = {}
	_structHolders[_holder]._size = 0
	_structHolders[_holder]._fields = {}
	for _, struct_field in structure do
		assert(isvalidType(struct_field[2]),`invalid struct rule for {struct_field[1]}`)
		local fieldData = {}
		fieldData._index = _structHolders[_holder]._size
		_structHolders[_holder]._size += struct_field[2]._size
		fieldData._rule = struct_field[2]
		_structHolders[_holder]._fields[struct_field[1]] = fieldData
	end
	_structHolders[_holder]._buffer = buffer.create(_structHolders[_holder]._size)
	_holder = setmetatable(_holder,_meta)
	return _holder
end
-- Testing function to print all active structs in memory
module._printAllActiveStructs = function()
	print(_structHolders)
end

return module
