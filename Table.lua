--!strict
--!native

local Table = {}

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

Table.clear = table.clear
Table.clone = function(tbl: {[any]: any}, isDeepClone: boolean): {[any]: any}
	local newTbl = {}
	for k, v in tbl do
		newTbl[k] = if isDeepClone and typeof(v) == "table" then Table.clone(v, isDeepClone) else v
	end
	return newTbl
end
Table.concat = table.concat
Table.create = table.create
Table.filter = function(tbl: {[any]: any}, f: (any, any, {[any]: any}) -> boolean): {[any]: any}
	local newTbl = Table.clone(tbl, true)
	local hasRemovedSomething: boolean = true
	repeat
		hasRemovedSomething = false
		for k, v in newTbl do
			if f(v, k, newTbl) then
				continue
			end
			Table.remove(newTbl, k)
			hasRemovedSomething = true
			break
		end
	until not hasRemovedSomething
	return newTbl
end
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
Table.insert = table.insert
Table.isfrozen = table.isfrozen
Table.map = function(tbl: {[any]: any}, f: (any, any, {[any]: any}) -> any): {[any]: any}
	local newTbl = Table.clone(tbl, true)
	for k, v in newTbl do
		newTbl[k] = f(v, k, newTbl)
	end
	return newTbl
end
Table.maxn = table.maxn
Table.move = table.move
Table.pack = table.pack
Table.sort = table.sort
Table.unpack = table.unpack

return Table
