local LIST = script:GetCustomProperty("List"):WaitForObject()
local PLAYER_ENTRY = script:GetCustomProperty("PlayerEntry")
local WRAPPER = script:GetCustomProperty("Wrapper"):WaitForObject()

local function clear_list()
	for index, child in ipairs(LIST:GetChildren()) do
		child:Destroy()
	end
end

local function refresh_list(the_player, reduce)
	clear_list()

	local offset = 0
	local total_players = #Game.GetPlayers() + reduce

	for index, player in ipairs(Game.GetPlayers()) do
		if(player ~= the_player or reduce == 0) then
			local entry = World.SpawnAsset(PLAYER_ENTRY, { parent = LIST })

			entry:FindDescendantByName("Player Name").text = "dddsds"--player.name

			if(player.team == 2) then
				entry:FindDescendantByName("VIP").visibility = Visibility.FORCE_ON
			end

			entry:FindDescendantByName("Avatar"):SetPlayerProfile(player)

			if(total_players > 1 and index < total_players) then
				entry:FindDescendantByName("Line").visibility = Visibility.FORCE_ON
			end

			entry.y = offset
			offset = offset + 30
		end
	end

	WRAPPER.height = 56 + (total_players * 30)
end

Game.playerJoinedEvent:Connect(refresh_list, 0)
Game.playerLeftEvent:Connect(refresh_list, -1)

Events.Connect("RefreshPlayerList", refresh_list)