if CLIENT then
	local cmdModule
	-- ULX XGUI Autocomplete hack
	for i,m in pairs(xgui.modules.tab) do
		if m.name == "Cmds" then
			print("Loaded cmdModule for RTLK XGUI autocomplete hack")
			cmdModule = xgui.modules.tab[i].panel
		end
	end
	
	local oldArgsList = cmdModule.buildArgsList
	cmdModule.plist.OnRowSelected = function(panel,line)
		cmdModule.selectedPlayer = panel:GetLine(line).ply or false
	end
	cmdModule.buildArgsList = function(cmd)
		if ( cmd.cmd == "ulx takeitem") then
			local ulxPSitems = {}
			for k,v in pairs(cmdModule.selectedPlayer.PS_Items) do
				table.insert(ulxPSitems,k)
			end
			cmd.args[3].completes = ulxPSitems
		end
		oldArgsList(cmd)
	end
end