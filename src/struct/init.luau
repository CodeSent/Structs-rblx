local commonTypes = require(script.commonTypes)
local module = {}
module.Types = commonTypes 

local function isvalidType(check : commonTypes.TypeRule?)
	return check and type(check._size) == "number" and type(check._serialize) == "function" and check._serialize ~= nil and type(check._deserialize) == "function"
end

module.new = function(structure : {[string] : commonTypes.TypeRule})
	local _data = {}
	_data._size = 0
	_data._fields = {}
	for _, struct_field in structure do
		assert(isvalidType(struct_field[2]),`invalid struct rule for {struct_field[1]}`)
		local fieldData = {}
		fieldData._index = _data._size
		_data._size += struct_field[2]._size
		fieldData._rule = struct_field[2]
		_data._fields[struct_field[1]] = fieldData
	end
	_data._buffer = buffer.create(_data._size)
	local meta = {
		__index = function(self, key)
			assert(_data._fields[key],`field name {key} doesnt exist in struct`)
			return _data._fields[key]._rule._deserialize(_data._buffer,_data._fields[key]._index)
		end,
		__newindex = function(self, key, value)
			assert(_data._fields[key],`field name "{key}"" doesnt exist in struct`)
			_data._fields[key]._rule._serialize(_data._buffer,_data._fields[key]._index,value)
		end,
		__len = function(self)
			return _data._size
		end,
		__tostring = function(self)
			return buffer.tostring(_data._buffer)
		end,
		__Call = function(self,wData : string)
			buffer.writestring(_data._buffer,0,wData,math.min(_data._size,#wData))
		end,
	}
	return setmetatable({},meta)
end

return module
