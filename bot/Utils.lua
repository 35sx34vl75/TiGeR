local clock = os.clock
function sleep(time)
	local t0 = clock()
while clock() - t0 <= time do end
end
--######################################################################--
local color = {
black = {"\027[30m", "\027[40m"},
red = {"\027[31m", "\027[41m"},
green = {"\027[32m", "\027[42m"},
yellow = {"\027[33m", "\027[43m"},
blue = {"\027[34m", "\027[44m"},
magenta = {"\027[35m", "\027[45m"},
cyan = {"\027[36m", "\027[46m"},
white = {"\027[37m", "\027[47m"},
default = "\027[00m"
}
--######################################################################--
function print_msg(msg)
	text = color.green[1].."[From: "..(msg.from.first_name or msg.to.title).."]\n"..color.yellow[1].."["..os.date("%H:%M:%S").."]"..color.red[1].."[Type :"
	if msg.forwarded then
		text = color.magenta[1].."[Forwarded from:"..(msg.forwarded_from_user or msg.forwarded_from_chat).."]"..text
	end
	if msg.edited then
		text = color.magenta[1].."[Edited]"..text
	end
	if msg.text then
		text = text.."Text]\n"..color.default..msg.text
	else
		if msg.media.caption and msg.media.caption ~= "" then
			if msg.photo then
				text = text.."Photo]\n"..color.cyan[1].."Caption: "..color.default..msg.media.caption
			elseif msg.video then
				text = text.."Video]\n"..color.cyan[1].."Caption: "..color.default..msg.media.caption
			elseif msg.videonote then
				text = text.."Videonote]\n"..color.cyan[1].."Caption: "..color.default..msg.media.caption
			elseif msg.voice then
				text = text.."Voice]\n"..color.cyan[1].."Caption: "..color.default..msg.media.caption
			elseif msg.audio then
				text = text.."Audio]\n"..color.cyan[1].."Caption: "..color.default..msg.media.caption
			elseif msg.animation then
				text = text.."Gif]\n"..color.cyan[1].."Caption: "..color.default..msg.media.caption
			elseif msg.sticker then
				text = text.."Sticker]\n"..color.cyan[1].."Caption: "..color.default..msg.media.caption
			elseif msg.contact then
				text = text.."Contact]\n"..color.cyan[1].."Caption: "..color.default..msg.media.caption
			elseif msg.document then
				text = text.."File]\n"..color.cyan[1].."Caption: "..color.default..msg.media.caption
			elseif msg.location then
				text = text.."Location]\n"..color.cyan[1].."Caption: "..color.default..msg.media.caption
			end
		else
			if msg.photo then
				text = text.."Photo] "..color.default
			elseif msg.video then
				text = text.."Video] "..color.default
			elseif msg.videonote then
				text = text.."Videonote] "..color.default
			elseif msg.voice then
				text = text.."Voice] "..color.default
			elseif msg.audio then
				text = text.."Audio] "..color.default
			elseif msg.animation then
				text = text.."Gif] "..color.default
			elseif msg.sticker then
				text = text.."Sticker] "..color.default
			elseif msg.contact then
				text = text.."Contact] "..color.default
			elseif msg.document then
				text = text.."File] "..color.default
			elseif msg.location then
				text = text.."Location] "..color.default
			end
		end
	end
	if msg.pinned then
		text = color.green[1].."[From: "..(msg.from.first_name or msg.to.title).."]\n"..color.yellow[1].."["..os.date("%H:%M:%S").."]\n"..color.red[1].."Pinned a message in chat: "..color.default..msg.to.title
	end
	if msg.game then
		text = text.."Game] "..color.default
	end
	if msg.adduser then
		text = text.."AddUser]"..color.default
	end
	if msg.deluser then
		text = ""
	end
	if msg.joinuser then
		text = text.."JoinGroup]"..color.default
	end
	print(text)
end
--######################################################################--
function var_cb(msg, data)
	bot = {}
	msg.to = {}
	msg.from = {}
	msg.media = {}
	msg.id = msg.id
	msg.to.type = gp_type(data.chat_id)
	if data.content and data.content.caption then
		msg.media.caption = data.content.caption
	end
	
	if data.reply_to_message_id ~= 0 then
		msg.reply_id = data.reply_to_message_id
	else
		msg.reply_id = false
	end
	function get_gp(arg, data)
		if gp_type(msg.chat_id) == "channel" or gp_type(msg.chat_id) == "chat" then
			msg.to.id = msg.chat_id or 0
			msg.to.title = data.title
		else
			msg.to.id = msg.chat_id or 0
			msg.to.title = false
		end
	end
	assert (tdbot_function ({ _ = "getChat", chat_id = data.chat_id }, get_gp, nil))
	function botifo_cb(arg, data)
		bot.id = data.id
		our_id = data.id
		if data.username then
			bot.username = data.username
		else
			bot.username = false
		end
		if data.first_name then
			bot.first_name = data.first_name
		end
		if data.last_name then
			bot.last_name = data.last_name
		else
			bot.last_name = false
		end
		if data.first_name and data.last_name then
			bot.print_name = data.first_name..' '..data.last_name
		else
			bot.print_name = data.first_name
		end
		if data.phone_number then
			bot.phone = data.phone_number
		else
			bot.phone = false
		end
	end
	assert (tdbot_function({ _ = 'getMe'}, botifo_cb, {chat_id=msg.chat_id}))
	function get_user(arg, data)
		if data.id then
			msg.from.id = data.id
		else
			msg.from.id = 0
		end
		if data.username then
			msg.from.username = data.username
		else
			msg.from.username = false
		end
		if data.first_name then
			msg.from.first_name = data.first_name
		end
		if data.last_name then
			msg.from.last_name = data.last_name
		else
			msg.from.last_name = false
		end
		if data.first_name and data.last_name then
			msg.from.print_name = data.first_name..' '..data.last_name
		else
			msg.from.print_name = data.first_name
		end
		if data.phone_number then
			msg.from.phone = data.phone_number
		else
			msg.from.phone = false
		end
		print_msg(msg)
		match_plugins(msg)
		
	end
	assert (tdbot_function ({ _ = "getUser", user_id = (data.sender_user_id or 0)}, get_user, nil))
end
--######################################################################--
local function Scharbytes(s, i)
	local byte    = string.byte
	i = i or 1
	if type(s) ~= "string" then
	end
	if type(i) ~= "number" then
	end
	local c = byte(s, i)
	if c > 0 and c <= 127 then
		return 1
	elseif c >= 194 and c <= 223 then
		local c2 = byte(s, i + 1)
		if not c2 then
		end
		if c2 < 128 or c2 > 191 then
		end
		return 2
	elseif c >= 224 and c <= 239 then
		local c2 = byte(s, i + 1)
		local c3 = byte(s, i + 2)
		if not c2 or not c3 then
		end
		if c == 224 and (c2 < 160 or c2 > 191) then
		elseif c == 237 and (c2 < 128 or c2 > 159) then
		elseif c2 < 128 or c2 > 191 then
		end
		if c3 < 128 or c3 > 191 then
		end
		return 3
	elseif c >= 240 and c <= 244 then
		local c2 = byte(s, i + 1)
		local c3 = byte(s, i + 2)
		local c4 = byte(s, i + 3)
		if not c2 or not c3 or not c4 then
		end
		if c == 240 and (c2 < 144 or c2 > 191) then
		elseif c == 244 and (c2 < 128 or c2 > 143) then
		elseif c2 < 128 or c2 > 191 then
		end
		if c3 < 128 or c3 > 191 then
		end
		if c4 < 128 or c4 > 191 then
		end
		return 4
	else
	end
end
--######################################################################--
function Slen(s)
	if type(s) ~= "string" then
		for k,v in pairs(s) do print('"',tostring(k),'"',tostring(v),'"') end
	end
	local pos = 1
	local bytes = string.len(s)
	local length = 0
	while pos <= bytes do
		length = length + 1
		pos = pos + Scharbytes(s, pos)
	end
	return length
end
--######################################################################--
function set_config(msg)
	local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
	local M_START = StartPm[math.random(#StartPm)]
	local function config_cb(arg, data)
		for k,v in pairs(data.members) do
			local function config_mods(arg, data)
				redis:sadd(RedisIndex..'Mods:'..msg.chat_id,data.id)
			end
			assert (tdbot_function ({
			_ = "getUser",
			user_id = v.user_id
			}, config_mods, {user_id=v.user_id}))
			
			if data.members[k].status._ == "chatMemberStatusCreator" then
				owner_id = v.user_id
				local function config_owner(arg, data)
						redis:sadd(RedisIndex..'Owners:'..msg.chat_id, data.id)
					tdbot.sendMention(msg.chat_id,data.id, msg.id,M_START..'با موفقیت انجام شد تمام ادمین های گروه به مدیر ربات منتصب شدند و سازنده گروه به مقام مالک گروه منتصب شد.'..EndPm,67, tonumber(Slen("سازنده گروه")))
				end
				assert (tdbot_function ({
				_ = "getUser",
				user_id = owner_id
				}, config_owner, {user_id=owner_id}))
			end
		end
	end
	tdbot.getChannelMembers(msg.to.id, 0, 200, 'Administrators', config_cb, {chat_id=msg.to.id})
end
--######################################################################--
function serialize_to_file(data, file, uglify)
	file = io.open(file, 'w+')
	local serialized
	if not uglify then
		serialized = serpent.block(data, {
		comment = false,
		name = '_'
		})
	else
		serialized = serpent.dump(data)
	end
	file:write(serialized)
	file:close()
end
--######################################################################--
function string.random(length)
	local str = "";
	for i = 1, length do
		math.random(97, 122)
		str = str..string.char(math.random(97, 122));
	end
	return str;
end
--######################################################################--
function string:split(sep)
	local sep, fields = sep or ":", {}
	local pattern = string.format("([^%s]+)", sep)
	self:gsub(pattern, function(c) fields[#fields+1] = c end)
	return fields
end
--######################################################################--
function string.trim(s)
	print("string.trim(s) is DEPRECATED use string:trim() instead")
	return s:gsub("^%s*(.-)%s*$", "%1")
end
--######################################################################--
function string:trim()
	return self:gsub("^%s*(.-)%s*$", "%1")
end
--######################################################################--
function get_http_file_name(url, headers)
	local file_name = url:match("[^%w]+([%.%w]+)$")
	file_name = file_name or url:match("[^%w]+(%w+)[^%w]+$")
	file_name = file_name or str:random(5)
	
	local content_type = headers["content-type"]
	
	local extension = nil
	if content_type then
		extension = mimetype.get_mime_extension(content_type)
	end
	if extension then
		file_name = file_name.."."..extension
	end
	
	local disposition = headers["content-disposition"]
	if disposition then
		file_name = disposition:match('filename=([^;]+)') or file_name
	end
	return file_name
end
--######################################################################--
function download_to_file(url, file_name)
	local respbody = {}
	local options = {
	url = url,
	sink = ltn12.sink.table(respbody),
	redirect = true
	}
	local response = nil
	
	if url:starts('https') then
		options.redirect = false
		response = {https.request(options)}
	else
		response = {http.request(options)}
	end
	
	local code = response[2]
	local headers = response[3]
	local status = response[4]
	
	if code ~= 200 then return nil end
	
	file_name = file_name or get_http_file_name(url, headers)
	
	local file_path = "data/photos/"..file_name
	file = io.open(file_path, "w+")
	file:write(table.concat(respbody))
	file:close()
	
	return file_path
end
--######################################################################--
function run_command(str)
	local cmd = io.popen(str)
	local result = cmd:read('*all')
	cmd:close()
	return result
end
--######################################################################--
function string:isempty()
	return self == nil or self == ''
end
--######################################################################--
function string:isblank()
	self = self:trim()
	return self:isempty()
end
--######################################################################--
function string.starts(String, Start)
	return Start == string.sub(String,1,string.len(Start))
end
--######################################################################--
function string:starts(text)
	return text == string.sub(self,1,string.len(text))
end
--######################################################################--
function unescape_html(str)
	local map = {
	["lt"]  = "<",
	["gt"]  = ">",
	["amp"] = "&",
	["quot"] = '"',
	["apos"] = "'"
	}
	new = string.gsub(str, '(&(#?x?)([%d%a]+);)', function(orig, n, s)
		var = map[s] or n == "#" and string.char(s)
		var = var or n == "#x" and string.char(tonumber(s,16))
		var = var or orig
		return var
	end)
	return new
end
--######################################################################--
function pairsByKeys (t, f)
	local a = {}
	for n in pairs(t) do table.insert(a, n) end
	table.sort(a, f)
	local i = 0      -- iterator variable
	local iter = function ()   -- iterator function
		i = i + 1
		if a[i] == nil then return nil
		else return a[i], t[a[i]]
		end
	end
	return iter
end
--######################################################################--
function run_bash(str)
	local cmd = io.popen(str)
	local result = cmd:read('*all')
	return result
end
--######################################################################--
function scandir(directory)
	local i, t, popen = 0, {}, io.popen
	for filename in popen('ls -a "'..directory..'"'):lines() do
		i = i + 1
		t[i] = filename
	end
	return t
end
--######################################################################--
function plugins_names( )
	local files = {}
	for k, v in pairs(scandir("plugins")) do
		if (v:match(".lua$")) then
			table.insert(files, v)
		end
	end
	return files
end
--######################################################################--
function file_exists(name)
	local f = io.open(name,"r")
	if f ~= nil then
		io.close(f)
		return true
	else
		return false
	end
end
--######################################################################--
function gp_type(chat_id)
	local gp_type = "pv"
	local id = tostring(chat_id)
	if id:match("^-100") then
		gp_type = "channel"
	elseif id:match("-") then
		gp_type = "chat"
	end
	return gp_type
end
--######################################################################--
function is_reply(msg)
	local var = false
	if msg.reply_to_message_id ~= 0 then
		var = true
	end
	return var
end
--######################################################################--
function is_supergroup(msg)
	chat_id = tostring(msg.chat_id)
	if chat_id:match('^-100') then
		if not msg.is_post then
			return true
		end
	else
		return false
	end
end
--######################################################################--
function is_channel(msg)
	chat_id = tostring(msg.chat_id)
	if chat_id:match('^-100') then
		if msg.is_post then
			return true
		else
			return false
		end
	end
end
--######################################################################--
function is_group(msg)
	chat_id = tostring(msg.chat_id)
	if chat_id:match('^-100') then
		return false
	elseif chat_id:match('^-') then
		return true
	else
		return false
	end
end
--######################################################################--
function is_private(msg)
	chat_id = tostring(msg.chat_id)
	if chat_id:match('^-') then
		return false
	else
		return true
	end
end
--######################################################################--
function check_markdown(text)
	str = text
	if str ~= nil then
		if str:match('_') then
			output = str:gsub('_',[[\_]])
		elseif str:match('*') then
			output = str:gsub('*','\\*')
		elseif str:match('`') then
			output = str:gsub('`','\\`')
		else
			output = str
		end
		return output
	end
end
--######################################################################--
Arashwm = 205549111
function is_sudo(msg)
	local var = false
	if is_sudo1(tonumber(msg.sender_user_id)) then var = true end
return var
end
function is_admin(msg)
	local var = false
	if is_admin1(tonumber(msg.sender_user_id)) then var = true end
	return var
end
function is_owner(msg)
	local var = false
	if is_owner1(tostring(msg.chat_id),tonumber(msg.sender_user_id)) then var = true end
	return var
end
function is_mod(msg)
	local var = false
	if is_mod1(tostring(msg.chat_id),tonumber(msg.sender_user_id)) then var = true end
	return var
end
function is_whitelist(chat_id, user_id)
	local var = false
	if is_mod1(chat_id, user_id) then var = true end
	if redis:sismember(RedisIndex.."Whitelist:"..chat_id,user_id) then var = true end
	return var
end
function is_sudo1(user_id)
	local var = false
	for v,user in pairs(_config.sudo_users) do
		if user == user_id then
			var = true
		end
	end
	return var
end
function is_admin1(user_id)
	local var = false
	local user = user_id
	for v,user in pairs(_config.admins) do
		if user[1] == user_id then
			var = true
		end
	end
	
	for v,user in pairs(_config.sudo_users) do
		if user == user_id then
			var = true
		end
	end
	return var
end
function is_owner1(chat_id, user_id)
	local var = false
	if is_admin1(user_id) then var = true end
	if redis:sismember(RedisIndex.."Owners:"..chat_id,user_id) then var = true end
	return var
end
function is_mod1(chat_id, user_id)
	local var = false
	if is_owner1(chat_id, user_id) then var = true end
	if redis:sismember(RedisIndex.."Mods:"..chat_id,user_id) then var = true end
	return var
end
--######################################################################--
function warns_user_not_allowed(plugin, msg)
	if not user_allowed(plugin, msg) then
		return true
	else
		return false
	end
end
--######################################################################--
function user_allowed(plugin, msg)
	if plugin.privileged and not is_sudo(msg) then
		return false
	end
	return true
end
--######################################################################--
function is_banned(chat_id, user_id)
	local var = false
	if redis:sismember(RedisIndex.."Banned:"..chat_id,user_id) then var = true end
	return var
end
--######################################################################--
function is_silent_user(userid, chatid, msg, func)
	function check_silent(arg, data)
		local var = false
		if data.members then
			for k,v in pairs(data.members) do
				if(v.user_id == userid)then var = true end
			end
		end
		if func then
			func(msg, var)
		end
	end
	tdbot.getChannelMembers(chatid, 0, 100000, 'Restricted', check_silent)
end
--######################################################################--
function is_gbanned(user_id)
	local var = false
	if redis:sismember(RedisIndex.."GBanned",user_id) then var = true end
	return var
end
--######################################################################--
function is_filter(msg, text)
	local var = false
	local filter = redis:hkeys(RedisIndex..'filterlist:'..msg.to.id)
		if filter then
			for i = 1, #filter do
				if string.match(text, filter[i]) then
				var = true
				end
			end
		end
	return var
end
--######################################################################--
function kick_user(user_id, chat_id)
	if not tonumber(user_id) then
		return false
	end
	tdbot.changeChatMemberStatus(chat_id, user_id, 'Banned', {0}, dl_cb, nil)
end
--######################################################################--
function del_msg(chat_id, message_ids)
	local msgid = {[0] = message_ids}
	tdbot.deleteMessages(chat_id, msgid, true, dl_cb, nil)
end
--######################################################################--
function channel_unblock(chat_id, user_id)
	tdbot.changeChatMemberStatus(chat_id, user_id, 'Left', dl_cb, nil)
end
--######################################################################--
function channel_set_admin(chat_id, user_id)
	tdbot.changeChatMemberStatus(chat_id, user_id, 'Administrators', {1, 1, 1, 1, 1, 1, 1, 1, 0}, dl_cb, nil)
end
--######################################################################--
function channel_demote(chat_id, user_id)
	tdbot.changeChatMemberStatus(chat_id, user_id, 'Restriced', {1, 0, 1, 1, 1, 1}, dl_cb, nil)
end
--######################################################################--
function silent_user(chat_id, user_id)
   tdbot.changeChatMemberStatus(chat_id, user_id, 'Restricted', {1, 0, 0, 0, 0, 0}, dl_cb, nil)
end
--######################################################################--
function unsilent_user(chat_id, user_id)
   tdbot.changeChatMemberStatus(chat_id, user_id, 'Restricted', {1, 0, 1, 1, 1, 1}, dl_cb, nil)
end
--######################################################################--
function file_dl(file_id)
	tdbot.downloadFile(file_id, 32, dl_cb, nil)
end
--######################################################################--
function banned_list(msg)
	local list = redis:smembers(RedisIndex.."Banned:"..msg.to.id)
	local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
	local M_START = StartPm[math.random(#StartPm)]
	if not redis:get(RedisIndex.."CheckBot:"..msg.to.id) then
		message = M_START..'`گروه در` #لیست `گروه ربات  نیست`'..EndPm
	end
	message = M_START..'*لیست کاربران محروم شده از گروه :*\n'
	for k,v in pairs(list) do
	local user_name = redis:get(RedisIndex..'user_name:'..v) or "---"
	message = message..k.."- "..check_markdown(user_name).." [" ..v.. "]\n" 
	end
	if #list == 0 then
	message = M_START.."*هیچ کاربری از این گروه محروم نشده*"..EndPm
	end
	return message
end
--######################################################################--
function silent_users_list(msg)
	local function GetRestricted(arg, data)
		msg=arg.msg
		local i = 1
		message = '_لیست کاربران سایلنت شده :_\n'
		local un = ''
		if data.total_count > 0 then
			i = 1
			k = 0
			local function getuser(arg, mdata)
				local ST = data.members[k].status
				if ST.can_add_web_page_previews == false and ST.can_send_media_messages == false and ST.can_send_messages == false and ST.can_send_other_messages == false and ST.is_member == true then
					if mdata.username then
						un = '@'..mdata.username
					else
						un = mdata.first_name
					end
					message = message ..i.. '-'..' '..check_markdown(un)..' [' ..data.members[k].user_id.. '] \n'
					i = i + 1
				end
				k = k + 1
				if k < data.total_count then
					tdbot.getUser(data.members[k].user_id, getuser, nil)
				else
					if i == 1 then
							return tdbot.sendMessage(msg.to.id, msg.id, 0, "*لیست کاربران سایلنت شده خالی است*", 0, "md")
					else
						return tdbot.sendMessage(msg.to.id, msg.id, 0, message, 0, "md")
					end
				end
			end
			tdbot.getUser(data.members[k].user_id, getuser, nil)
		else
				return tdbot.sendMessage(msg.to.id, msg.id, 0, "*لیست کاربران سایلنت شده خالی است*", 0, "md")
		end
	end
	tdbot.getChannelMembers(msg.chat_id, 0, 100000, 'Restricted', GetRestricted, {msg=msg})
end
--######################################################################--
function whitelist(msg)
	local list = redis:smembers(RedisIndex.."Whitelist:"..msg.to.id)
	local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
	local M_START = StartPm[math.random(#StartPm)]
	if not redis:get(RedisIndex.."CheckBot:"..msg.to.id) then
		message = M_START..'`گروه در` #لیست `گروه ربات  نیست`'..EndPm
	end
	message = M_START..'`کاربران لیست سفید :`\n'
	for k,v in pairs(list) do
	local user_name = redis:get(RedisIndex..'user_name:'..v) or "---"
	message = message..k.."- "..check_markdown(user_name).." [" ..v.. "]\n" 
	end
	if #list == 0 then
	message = M_START.."*هیچ کاربری در لیست سفید وجود ندارد*"..EndPm
	end
	return message
end
--######################################################################--
function gbanned_list(msg)
	local list = redis:smembers(RedisIndex.."GBanned:"..msg.to.id)
	local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
	local M_START = StartPm[math.random(#StartPm)]
	message = M_START..'`لیست کاربران محروم شده از گروه های ربات :`\n'
	for k,v in pairs(list) do
	local user_name = redis:get(RedisIndex..'user_name:'..v) or "---"
	message = message..k.."- "..check_markdown(user_name).." [" ..v.. "]\n" 
	end
	if #list == 0 then
	message = M_START.."*هیچ کاربری از گروه های ربات محروم نشده*"..EndPm
	end
	return message
end
