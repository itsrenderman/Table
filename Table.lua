--!strict

local Table = {}

Table.clear = table.clear
Table.clone = function(tbl: {[any]: any}, shouldDeepClone: boolean?): {[any]: any}
	if shouldDeepClone then
		local cloneTbl = Table.clone(tbl, false)
		for key, value in tbl do
			if type(value) == "table" then
				cloneTbl[key] = Table.clone(value, true)
			end
		end
		return cloneTbl
	end
	return table.clone(tbl)
end
Table.concat = table.concat
Table.create = table.create
Table.find = table.find
Table.foreach = function(tbl: {[any]: any}, f: (any, any, {[any]: any}) -> ()): ()
	for k, v in tbl do
		f(v, k, tbl)
	end
end
Table.foreachi = function(tbl: {[any]: any}, f: (any, number, {[any]: any}) -> ()): ()
	for i, v in ipairs(tbl) do
		f(v, i, tbl)
	end
end
Table.freeze = table.freeze
Table.getn = function(tbl: {[any]: any}): number
	local i: number = 0
	for _ in tbl do
		i += 1
	end
	return i
end
Table.insert = table.insert
Table.isfrozen = table.isfrozen
Table.maxn = table.maxn
Table.move = table.move
Table.pack = table.pack
Table.remove = table.remove
Table.sort = table.sort
Table.unpack = table.unpack

return Table
