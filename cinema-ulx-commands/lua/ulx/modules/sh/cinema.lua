ulx.theater_list = {}
timer.Simple(0,function()
for k,v in pairs(Location.Maps) do
	if v.Name == game.GetMap() then
		for a,b in pairs(v.Locations) do
			table.insert(ulx.theater_list,a)
		end
	end
end
end)
function getTheaterIndex(thea)
	for k,v in pairs(Location.Maps) do
		if v.Name == game.GetMap() then
			for a,b in pairs(v.Locations) do
				if a == thea then
					return theater:GetTheaters()[b.Index]
				end
			end
		end
	end
	return false
end

function ulx.cinema_skip( calling_ply, target )
	
	if (!target or target == "theater") and !calling_ply:InTheater() then
		ULib.tsayError( calling_ply, "You are not in a theater or did not select a valid theater.", true )
		return
	end
	
	if target and !calling_ply:InTheater() and (!table.HasValue(ulx.theater_list, target)) then
		ULib.tsayError( calling_ply, "You did not select a valid theater.", true )
		return
	end

	local theater = calling_ply:GetTheater()
	
	if target then
		theater = getTheaterIndex(target) or calling_ply:GetTheater()
	end
	
	if !theater then
		ULib.tsayError( calling_ply, "There was an error! Are you in a theater?", true )
		return
	end
	
	if !theater:IsPlaying() then
		ULib.tsayError( calling_ply, "There is no video playing.", true )
		return
	end
	
	local video = theater:VideoTitle()
	
	theater:SkipVideo()
	
	ulx.fancyLogAdmin( calling_ply, "#A skipped the video (#s) in #s", video, theater:Name() )

end
local cinema_skip = ulx.command( "Cinema", "ulx skipvideo", ulx.cinema_skip, {"!skipvideo", "!skip"}, true )
cinema_skip:defaultAccess( ULib.ACCESS_SUPERADMIN )
cinema_skip:addParam{ type=ULib.cmds.StringArg, hint="theater", completes=ulx.theater_list, ULib.cmds.optional }
cinema_skip:help( "Skips the current video." )

function ulx.cinema_seek( calling_ply, time, target )
	
	if (!target or target == "theater") and !calling_ply:InTheater() then
		ULib.tsayError( calling_ply, "You are not in a theater or did not select a valid theater.", true )
		return
	end
	
	if target and !calling_ply:InTheater() and (!table.HasValue(ulx.theater_list, target)) then
		ULib.tsayError( calling_ply, "You did not select a valid theater.", true )
		return
	end

	local theater = calling_ply:GetTheater()
	
	if target then
		theater = getTheaterIndex(target) or calling_ply:GetTheater()
	end
	
	if !theater then
		ULib.tsayError( calling_ply, "There was an error! Are you in a theater?", true )
		return
	end
	
	if !theater:IsPlaying() then
		ULib.tsayError( calling_ply, "There is no video playing.", true )
		return
	end
	
	local video = theater:VideoTitle()
	
	theater:Seek(time)
	
	ulx.fancyLogAdmin( calling_ply, "#A set the video (#s) in #s to #s seconds", video, theater:Name(), time )

end
local cinema_seek = ulx.command( "Cinema", "ulx seekvideo", ulx.cinema_seek, {"!seekvideo", "!seek"}, true )
cinema_seek:defaultAccess( ULib.ACCESS_SUPERADMIN )
cinema_seek:addParam{ type=ULib.cmds.NumArg, default=10, hint="time", min=0 }
cinema_seek:addParam{ type=ULib.cmds.StringArg, hint="theater", completes=ulx.theater_list, ULib.cmds.optional }
cinema_seek:help( "Seeks to a certain point in the current video." )

function ulx.cinema_reset( calling_ply, target )
	
	if (!target or target == "theater") and !calling_ply:InTheater() then
		ULib.tsayError( calling_ply, "You are not in a theater or did not select a valid theater.", true )
		return
	end
	
	if target and !calling_ply:InTheater() and (!table.HasValue(ulx.theater_list, target)) then
		ULib.tsayError( calling_ply, "You did not select a valid theater.", true )
		return
	end

	local theater = calling_ply:GetTheater()
	
	if target then
		theater = getTheaterIndex(target) or calling_ply:GetTheater()
	end
	
	if !theater then
		ULib.tsayError( calling_ply, "There was an error! Are you in a theater?", true )
		return
	end
	
	theater:Reset()
	
	ulx.fancyLogAdmin( calling_ply, "#A reset #s", theater:Name() )

end
local cinema_reset = ulx.command( "Cinema", "ulx resettheater", ulx.cinema_reset, {"!resettheater", "!reset"}, true )
cinema_reset:defaultAccess( ULib.ACCESS_SUPERADMIN )
cinema_reset:addParam{ type=ULib.cmds.StringArg, hint="theater", completes=ulx.theater_list, ULib.cmds.optional }
cinema_reset:help( "Resets the theater." )
