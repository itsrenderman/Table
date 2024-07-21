--!strict

local Table = {
	clear = table.clear,
	clone = table.clone,
	concat = table.concat,
	create = table.create,
	find = table.find,
	foreach = function(t: {[any]: any}, f: (any, any, {[any]: any}) -> ()): ()
		for k, v in t do
			f(v, k, t)
		end
	end,
	foreachi = function(t: {[any]: any}, f: (any, any, {[any]: any}) -> ()): ()
		for i, v in ipairs(t) do
			f(v, i, t)
		end
	end,
	freeze = table.freeze,
	getn = function(t: {[any]: any}): number
		local i: number = 0
		for _ in t do
			i += 1
		end
		return i
	end,
	insert = table.insert,
	isfrozen = table.isfrozen,
	maxn = table.maxn,
	move = table.move,
	pack = table.pack,
	remove = table.remove,
	sort = table.sort,
	unpack = table.unpack
}

return Table
