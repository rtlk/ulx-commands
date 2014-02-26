ulx.pointshop_item_list = {}

for k,v in pairs(PS.Categories) do
	table.insert(ulx.pointshop_item_list, "- "..v.Name.." -")
	for a,b in pairs(PS.Items) do
		if b.Category == v.Name then
			table.insert(ulx.pointshop_item_list, a)
		end
	end
end

function ulx.pointshop_givepoints( calling_ply, target_plys, points )

	if !PS then
	
		ULib.tsayError( calling_ply, "Pointshop is not loaded. Cannot give points.", true )
		return
		
	end
	
	for k,v in pairs( target_plys ) do
	
		if points ~= 0 then
			v:PS_GivePoints(points)
		end
		
	end
	
	ulx.fancyLogAdmin( calling_ply, "#A gave #T #s #s", target_plys, points, PS.Config.PointsName )

end
local pointshop_givepoints = ulx.command( "Pointshop", "ulx givepoints", ulx.pointshop_givepoints, "!givepoints" )
pointshop_givepoints:addParam{ type=ULib.cmds.PlayersArg }
pointshop_givepoints:addParam{ type=ULib.cmds.NumArg, default=1, hint="points", min=1 }
pointshop_givepoints:defaultAccess( ULib.ACCESS_SUPERADMIN )
pointshop_givepoints:help( "Gives the targeted player(s) a number of points to the pointshop." )

function ulx.pointshop_takepoints( calling_ply, target_plys, points )

	if !PS then
	
		ULib.tsayError( calling_ply, "Pointshop is not loaded. Cannot take points.", true )
		return
		
	end
	
	for k,v in pairs( target_plys ) do
		if points ~= 0 then
			if v:PS_GetPoints() >= points then
				v:PS_TakePoints(points)
			else
				v:PS_TakePoints(v:PS_GetPoints())
			end
		end
	end
	
	ulx.fancyLogAdmin( calling_ply, "#A took #s #s from #T", points, PS.Config.PointsName, target_plys )

end
local pointshop_takepoints = ulx.command( "Pointshop", "ulx takepoints", ulx.pointshop_takepoints, "!takepoints" )
pointshop_takepoints:addParam{ type=ULib.cmds.PlayersArg }
pointshop_takepoints:addParam{ type=ULib.cmds.NumArg, default=10, hint="points", min=1 }
pointshop_takepoints:defaultAccess( ULib.ACCESS_SUPERADMIN )
pointshop_takepoints:help( "Takes a number of points from the pointshop of the target player(s)." )

function ulx.pointshop_setpoints( calling_ply, target_plys, points )

	if !PS then
	
		ULib.tsayError( calling_ply, "Pointshop is not loaded. Cannot set points.", true )
		return
		
	end
	
	for k,v in pairs( target_plys ) do
		if v:PS_GetPoints() >= points then
			v:PS_TakePoints(points)
		else
			v:PS_TakePoints(v:PS_GetPoints())
		end
	end
	
	ulx.fancyLogAdmin( calling_ply, "#A set #s #s for #T", points, PS.Config.PointsName, target_plys )

end
local pointshop_setpoints = ulx.command( "Pointshop", "ulx setpoints", ulx.pointshop_setpoints, "!setpoints" )
pointshop_setpoints:addParam{ type=ULib.cmds.PlayersArg }
pointshop_setpoints:addParam{ type=ULib.cmds.NumArg, default=0, hint="points", min=0 }
pointshop_setpoints:defaultAccess( ULib.ACCESS_SUPERADMIN )
pointshop_setpoints:help( "Sets the target player(s) pointshop points to the specified number." )

function ulx.pointshop_giveitem( calling_ply, target_plys, item )

	if !PS then
		ULib.tsayError( calling_ply, "Pointshop is not loaded. Cannot set points.", true )
		return
	end
	
	if !PS.Items[item] then
		ULib.tsayError( calling_ply, "Cannot give item. Item \""..item.."\" invalid.", true )
		return
	end
	
	for k,v in pairs( target_plys ) do
		if v:PS_HasItem(item) then
			table.remove(target_plys,k)
			ULib.tsayError( calling_ply, v:Name().." already has "..item.."!", true )
		else
			v:PS_GiveItem(item)
		end
	end
	
	ulx.fancyLogAdmin( calling_ply, "#A gave a #s to #T", item, target_plys )

end
local pointshop_giveitem = ulx.command( "Pointshop", "ulx giveitem", ulx.pointshop_giveitem, "!giveitem" )
pointshop_giveitem:addParam{ type=ULib.cmds.PlayersArg }
pointshop_giveitem:addParam{ type=ULib.cmds.StringArg, hint="item", completes=ulx.pointshop_item_list }
pointshop_giveitem:defaultAccess( ULib.ACCESS_SUPERADMIN )
pointshop_giveitem:help( "Gives the target player(s) the specified pointshop item." )

