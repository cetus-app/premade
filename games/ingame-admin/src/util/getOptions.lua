-- Retrieves the options from an access and returns them in a flat array.
local function split(s, delimiter)
    local result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end
local function getOptions(str)
	return split(str, ":")
end


return getOptions