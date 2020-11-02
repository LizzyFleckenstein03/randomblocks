local channel = minetest.mod_channel_join("randomblocks")

local nodes = {}

minetest.register_on_mods_loaded(function()
	for nodename, nodedef in pairs(minetest.registered_nodes) do
		if nodedef.node_placement_prediction ~= "" and nodename ~= "ignore" and nodename ~= "air" then
			table.insert(nodes, nodename)
		end
	end
end)

minetest.register_on_modchannel_message(function(channel_name, _, message)
	if channel_name == "randomblocks" then
		local pos = minetest.string_to_pos(message)
		if pos then
			local node = minetest.get_node(pos)
			if node and node.name ~= "air" and node.name ~= "ignore" and node.name ~= "mcl_core:obsidian" and node.name ~= "mcl_core:bedrock" and node.name ~= "mcl_portals:nether_portal" then
				minetest.set_node(pos, {name = nodes[math.random(#nodes)]})
			end
		end
	end
end) 
