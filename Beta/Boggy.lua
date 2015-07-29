boggy_pointer = 0x36E560;

-- Slot data
slot_base = 0x28;
slot_size = 0x180;
number_of_slots = 100;

-- Relative to slot start
slot_variables = {
	0x1C = "4_Unknown",
	0x24 = "4_Unknown",

	0x2C = "Float",
	0x30 = "Float",

	0x38 = "4_Unknown",

	0x44 = "Float",

	0x58 = "4_Unknown",

	0xD4 = "Byte",
	0xD5 = "Byte",
	0xD6 = "Byte",
	0xD7 = "Byte",

	0xDC = "Float",

	0xF8 = "Float",
	0xFC = "Float",
	0x100 = "Float",

	0x104 = "Byte",
	0x105 = "Byte",
	0x106 = "Byte",
	0x107 = "Byte",

	0x108 = "Float",
	0x10C = "Pointer",

	0x118 = "4_Unknown",
	0x134 = "4_Unknown",

	0x140 = "Pointer",

	0x144 = "4_Unknown",
	0x14C = "4_Unknown",

	0x150 = "Float",
	0x154 = "Float",
	0x158 = "Float",

	0x160 = "Pointer",

	0x164 = "Float",
	0x168 = "Float",
	0x16C = "Float",

	0x170 = "4_Unknown"
};

slot_data = {};

function get_minimum_value(variable)
	if slot_variables[variable] ~= nil then
		local i;
		local min = slot_data[1][variable];
		for i=1,#slot_data do
			if slot_data[i][variable] < min then
				min = slot_data[i][variable];
			end
		end
		return min;
	end
	return 0;
end

function get_maximum_value(variable)
	if slot_variables[variable] ~= nil then
		local i;
		local max = slot_data[1][variable];
		for i=1,#slot_data do
			if slot_data[i][variable] > max then
				max = slot_data[i][variable];
			end
		end
		return max;
	end
	return 0;
end

function process_slot(slot_base)
	local current_slot_variables = {};
	local k, v;
	for k, v in pairs(slot_variables) do
		if v == "Byte" then
			current_slot_variables[k] = mainmemory.readbyte(slot_base + k);
		elseif v == "4_Unknown" or v == "Pointer" then
			current_slot_variables[k] = mainmemory.read_u32_be(slot_base + k);
		elseif v == "Float" then
			current_slot_variables[k] = mainmemory.readfloat(slot_base + k, true);
		end
	end
end

function parse_slot_data()
	local boggy_state = mainmemory.read_u24_be(boggy_pointer + 1);
	local i;
	local current_slot_base;

	-- Clear out old data
	slot_data = {};

	for i=0,number_of_slots do
		current_slot_base = boggy_state + slot_base + i * slot_size;
		table.insert(slot_data, process_slot(current_slot_base));
	end
end