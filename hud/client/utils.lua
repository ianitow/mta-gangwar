function RGBToHex(red, green, blue, alpha)
	if((red < 0 or red > 255 or green < 0 or green > 255 or blue < 0 or blue > 255) or (alpha and (alpha < 0 or alpha > 255))) then
		return nil
	end
	if(alpha) then
		return string.format("#%.2X%.2X%.2X%.2X", red,green,blue,alpha)
	else
		return string.format("#%.2X%.2X%.2X", red,green,blue)
	end
end

function getTeamHex(team)
	if (team) then
		r, g, b = team:getColor()
		hex = RGBToHex(r, g, b)
		return hex
	end
end
function hexOwner(team)
	local ownerTeam = Team.getFromName(team)
	if ownerTeam then
		return getTeamHex(ownerTeam)
	end
	return "#FFFFFF"
end

function formatMilliExtens(milli)
	local minute = math.floor(milli / 60000)
	local seconds =   math.floor(milli / 1000)
	if(minute < 1) then
		return (seconds < 10 and "0"..seconds or seconds) .." segundos."
	else
		seconds = math.floor(milli/1000) - (minute * 60) 
		return minute .." minutos e ".. (seconds < 10 and "0"..seconds or seconds).." segundos."
	end
end

function getRealHour(phone)
	local final = ""
	local time = getRealTime()
	if(time.hour <10) then
		final = final .. "0:"
	else
		final = final .. time.hour..":"
	end
	if(time.minute < 10 ) then
		final = final .."0"..time.minute
	else
		final = final .. time.minute
	end
	if phone then
		return final
	end
	if(time.second < 10) then
		final = ":"..final .."0"..time.second
	else
		final = ":"..final.. time.second
	end
	return final
end

function formatMilliseconds(milli)
	local minute = math.floor(milli / 60000)
	local seconds =   math.floor(milli / 1000)
	if(minute < 1) then
		return (seconds < 10 and "0"..seconds or seconds)
	else
		seconds = math.floor(milli/1000) - (minute * 60) 
		return minute ..":".. (seconds < 10 and "0"..seconds or seconds)
	end
end

function table.find(tab,ele)
	for index,value in pairs (tab) do
		if value == el then
			return index
		end
	end
end