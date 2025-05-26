--!strict

local Table = {}

Table.clear = table.clear
Table.concat = table.concat
Table.create = table.create
Table.find = table.find
Table.freeze = table.freeze
Table.insert = table.insert
Table.isfrozen = table.isfrozen
Table.maxn = table.maxn
Table.move = table.move
Table.pack = table.pack
Table.sort = table.sort
Table.unpack = table.unpack

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
Table.getn = function(tbl: {[any]: any}): number
	local i: number = 0
	for _ in tbl do
		i += 1
	end
	return i
end
Table.isarray = function(tbl: {[any]: any}): boolean
	return #tbl == Table.getn(tbl)
end
Table.remove = function(tbl: {[any]: any}, k: any): any?
	local v: any? = nil
	if Table.isarray(tbl) then
		v = table.remove(tbl, k)
	else
		v = tbl[k]
		tbl[k] = nil
	end
	return v
end
Table.filter = function(tbl: {[any]: any}, f: (any, any, {[any]: any}) -> boolean): {[any]: any}
	local isArray: boolean = Table.isarray(tbl)
	tbl = Table.clone(tbl, true)

	local hasRemovedSomething: boolean = false

	repeat
		hasRemovedSomething = false
		Table.foreach(tbl, function(v, k)
			if f(v, k, tbl) then
				return
			end
			hasRemovedSomething = true
			Table.remove(tbl, k)
		end)
	until not hasRemovedSomething
	return tbl
end

return Table
