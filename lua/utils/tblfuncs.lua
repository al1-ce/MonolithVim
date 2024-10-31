table.shift = function(tbl)
	table.remove(tbl, 1)
end;
table.pop = function(tbl)
	table.remove(tbl)
end;
table.map = function(sequence, transformation)
	local newlist = {};
	do
		local i = 0
		while i < # sequence do
			table.insert(newlist, transformation(sequence[i + 1]));
			local _null
			i = i + 1
		end
	end;
	return newlist
end;
table.filter = function(sequence, predicate)
	local newlist = {};
	do
		local i = 0
		while i < # sequence do
			if predicate(sequence[i + 1]) then
				table.insert(newlist, sequence[i + 1])
			end
			i = i + 1
		end
	end;
	return newlist
end;
table.reduce = function(sequence, operator)
	if # sequence == 0 then
		return nil
	end;
	local out = nil;
	do
		local i = 0
		while i < # sequence do
			out = operator(out, sequence[i + 1]);
			local _null
			i = i + 1
		end
	end;
	return out
end
