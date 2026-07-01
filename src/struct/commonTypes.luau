export type TypeRule = {
		_size : number,
		_serialize : (buffer, number, any) -> nil,
		_deserialize : (buffer, number) -> any,
}


-- Basic types
local module = {
	-- Signed
	INT8 = {
		_size = 1,
		_serialize = function(buf: buffer,offset, value)
			local val = math.clamp(value,-127,128)
			buffer.writei8(buf,offset,val)
		end,
		_deserialize = function(buf : buffer,offset)
			return buffer.readu8(buf,offset)
		end,
	},
	INT16 = {
		_size = 2,
		_serialize = function(buf: buffer,offset, value)
			local val = math.clamp(value,-32767,32768)
			buffer.writei16(buf,offset,val)
		end,
		_deserialize = function(buf : buffer,offset)
			return buffer.readu16(buf,offset)
		end,
	},
	INT32 = {
		_size = 4,
		_serialize = function(buf: buffer,offset, value)
			local val = math.clamp(value,-2147483647,2147483648)
			buffer.writei32(buf,offset,val)
		end,
		_deserialize = function(buf : buffer,offset)
			return buffer.readu32(buf,offset)
		end,
	},
	INT64 = {
		_size = 8,
		_serialize = function(buf: buffer,offset, value)
			local val = math.clamp(value,-9223372036854775807,9223372036854775808)
			buffer.writei64(buf,offset,val)
		end,
		_deserialize = function(buf : buffer,offset)
			return buffer.readu64(buf,offset)
		end,
	},
	--unsigned
	UINT8 = {
		_size = 1,
		_serialize = function(buf: buffer,offset, value)
			local val = math.clamp(value,0,255)
			buffer.writeu8(buf,offset,val)
		end,
		_deserialize = function(buf : buffer,offset)
			return buffer.readu8(buf,offset)
		end,
	},
	UINT16 = {
		_size = 2,
		_serialize = function(buf: buffer,offset, value)
			local val = math.clamp(value,0,65535)
			buffer.writeu16(buf,offset,val)
		end,
		_deserialize = function(buf : buffer,offset)
			return buffer.readu16(buf,offset)
		end,
	},
	UINT32 = {
		_size = 4,
		_serialize = function(buf: buffer,offset, value)
			local val = math.clamp(value,0,4294967295)
			buffer.writeu32(buf,offset,val)
		end,
		_deserialize = function(buf : buffer,offset)
			return buffer.readu32(buf,offset)
		end,
	},
	UINT64 = {
		_size = 8,
		_serialize = function(buf: buffer,offset, value)
			local val = math.clamp(value,0,18446744073709551615)
			buffer.writeu64(buf,offset,val)
		end,
		_deserialize = function(buf : buffer,offset)
			return buffer.readu64(buf,offset)
		end,
	},
	--float
	FLOAT32 = {
		_size = 4,
		_serialize = function(buf: buffer,offset, value)
			buffer.writef32(buf,offset,value)
		end,
		_deserialize = function(buf : buffer,offset)
			return buffer.readf32(buf,offset)
		end,
	},
	FLOAT64 = {
		_size = 8,
		_serialize = function(buf: buffer,offset, value)
			buffer.writef64(buf,offset,value)
		end,
		_deserialize = function(buf : buffer,offset)
			return buffer.readf64(buf,offset)
		end,
		
	},
	-- Char
	CHAR = {
		_size = 1,
		_serialize = function(buf: buffer,offset, value)
			buffer.writeu8(buf,offset,string.byte(value))
		end,
		_deserialize = function(buf : buffer,offset)
			return string.char(buffer.readu8(buf,offset))
		end,
	},
	-- String
	getStringType  = function(Size)
		return {
			_size = Size+1,
			_serialize = function(buf: buffer,offset, value)
				local str = string.sub(value,1,Size) .. string.char(0)
				local strLen = #str
				buffer.writestring(buf,offset,str,strLen)
			end,
			_deserialize = function(buf : buffer,offset)
				local str = buffer.readstring(buf,offset,Size)
				return string.sub(str,1,#str)
			end,
		}
	end :: (Size :number) -> TypeRule,
}


-- Studio Specific
module.VECTOR2 = {
	_size = 8,
	_serialize = function(buf: buffer,offset, value)
		buffer.writef32(buf,offset,value.X)
		buffer.writef32(buf,offset+4,value.Y)
	end,
	_deserialize = function(buf : buffer,offset)
		return Vector2.new(buffer.readf32(buf,offset),buffer.readf32(buf,offset+4))
	end,
}
module.VECTOR3 = {
	_size = 12,
	_serialize = function(buf: buffer,offset, value)
		buffer.writef32(buf,offset,value.X)
		buffer.writef32(buf,offset+4,value.Y)
		buffer.writef32(buf,offset+8,value.Z)
	end,
	_deserialize = function(buf : buffer,offset)
		return Vector3.new(buffer.readf32(buf,offset),buffer.readf32(buf,offset+4),buffer.readf32(buf,offset+8))
	end,
}

return module
