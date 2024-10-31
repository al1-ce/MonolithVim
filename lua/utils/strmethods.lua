local function iter_to_array(iter)
	local arr = {};
	local item = nil;
	while true do
		item = iter();
		if item == nil then
			break
		end;
		table.insert(arr, item)
	end;
	return arr
end;
function string:split(separator)
	local t = {};
	local items = iter_to_array((function()
		local __tmp = self
		return __tmp:gmatch(string.format([=[[^%s]+]=], separator))
	end)());
	do
		local i = 0
		while i < # items do
			table.insert(t, items[i + 1]);
			local _null
			i = i + 1
		end
	end;
	return t
end;
function string:contains(pattern)
	return (function()
		local __tmp = self
		return __tmp:find(pattern, 1, true)
	end)() ~= nil
end;
function string:starts_with(pattern)
	return (function()
		local __tmp = self
		return __tmp:sub(1, # pattern)
	end)() == pattern
end;
function string:ends_with(pattern)
	return pattern == "" or (function()
		local __tmp = self
		return __tmp:sub(- # pattern)
	end)() == pattern
end;
function string:replace(pattern, replacement)
	local str = self;
	local search_start_idx = 1;
	local idx_1, idx_2 = str:find(pattern, search_start_idx, true);
	if not idx_1 then
		return str
	end;
	local postfix = str:sub(idx_2 + 1);
	str = string.format([=[%s%s%s]=], str:sub(1, idx_1 - 1), replacement, postfix);
	return str
end;
function string:replace_all(pattern, replacement)
	return (function()
		local __tmp = self
		return __tmp:gsub(pattern, replacement)
	end)()
end;
function string:insert(pos, text)
	return string.format([=[%s%s%s]=], (function()
		local __tmp = self
		return __tmp:sub(1, pos - 1)
	end)(), text, (function()
		local __tmp = self
		return __tmp:sub(pos)
	end)())
end;
string["repeat"] = function(self, count)
	local out = "";
	do
		local i = 0
		while i < count do
			out = string.format([=[%s%s]=], out, self);
			local _null
			i = i + 1
		end
	end;
	return out
end;


