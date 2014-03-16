if CLIENT then
	local cmdModule
	-- ULX XGUI Autocomplete hack
	for i,m in pairs(xgui.modules.tab) do
		if m.name == "Cmds" then
			cmdModule = xgui.modules.tab[i].panel
		end
	end
	
	local oldArgsList = cmdModule.buildArgsList
	
	cmdModule.plist.OnRowSelected = function(panel,line)
		cmdModule.selectedPlayer = panel:GetLine(line).ply or false
	end
	
	cmdModule.buildArgsList = function(cmd)
		if cmd.args[3] and cmd.args[3].completes then
			local oldCompletes = cmd.args[3].completes
			if ( cmd.cmd == "ulx takeitem") then
				local ulxPSitems = {}
				for k,v in pairs(cmdModule.selectedPlayer.PS_Items) do
					table.insert(ulxPSitems,k)
				end
				cmd.args[3].completes = ulxPSitems
			end
			oldArgsList(cmd)
			cmd.args[3].completes = oldCompletes
		end
	end
end
