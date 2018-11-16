local function TiiGeRTeaM(msg, mr_roo)
	local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
	local M_START = StartPm[math.random(#StartPm)]
	if not redis:get(RedisIndex.."CheckBot:"..msg.to.id) then return end
	if mr_roo[1]:lower() == "clean" or mr_roo[1] == "پاک کردن" then
			if is_sudo(msg) then
				if mr_roo[2]:lower() == 'gbans' or mr_roo[2] == 'لیست سوپر مسدود' then
					local list = redis:smembers(RedisIndex..'GBanned')
					if #list == 0 then
						return M_START.."*هیچ کاربری از گروه های ربات محروم نشده*"..EndPm
					end
					redis:del(RedisIndex..'GBanned')
					return M_START.."*تمام کاربرانی که از گروه های ربات محروم بودند از محرومیت خارج شدند*"..EndPm
				end
			end
			if is_admin(msg) then
				if mr_roo[2]:lower() == 'owners' or mr_roo[2] == "مالکان" then
					local list = redis:smembers(RedisIndex..'Owners:'..msg.to.id)
					if #list == 0 then
						return M_START.."`مالکی برای گروه انتخاب نشده است`"..EndPm
					end
					redis:del(RedisIndex.."Owners:"..msg.to.id)
					return M_START.."`تمامی مالکان گروه تنزیل مقام شدند`"..EndPm
				end
			end
			if is_JoinChannel(msg) then
				if is_owner(msg) then
					if msg.to.type == "channel" then
						if mr_roo[2]:lower() == 'blacklist' or mr_roo[2] == 'لیست سیاه' then
							local function GetRestricted(arg, data)
								if data.members then
									for k,v in pairs (data.members) do
										tdbot.changeChaargemberStatus(msg.to.id, v.user_id, 'Restricted', {1,0,1,1,1,1}, dl_cb, nil)
									end
								end
							end
							local function GetBlackList(arg, data)
								if data.members then
									for k,v in pairs (data.members) do
										channel_unblock(msg.to.id, v.user_id)
									end
								end
							end
							for i = 1, 2 do
								tdbot.getChannelMembers(msg.to.id, 0, 100000, 'Restricted', GetRestricted, {msg=msg})
							end
							for i = 1, 2 do
								tdbot.getChannelMembers(msg.to.id, 0, 100000, 'Banned', GetBlackList, {msg=msg})
							end
							return tdbot.sendMessage(msg.to.id, msg.id, 0, M_START.."`لیست سیاه گروه پاک سازی شد`"..EndPm, 0, "md")
						end
						if mr_roo[2]:lower() == 'bots' or mr_roo[2] == 'ربات ها' then
							local function GetBots(arg, data)
								if data.members then
									for k,v in pairs (data.members) do
										if not is_mod1(msg.to.id, v.user_id) then
											kick_user(v.user_id, msg.to.id)
										end
									end
								end
							end
							for i = 1, 5 do
								tdbot.getChannelMembers(msg.to.id, 0, 100000, 'Bots', GetBots, {msg=msg})
							end
							return tdbot.sendMessage(msg.to.id, msg.id, 0, M_START.."`تمام ربات ها از گروه حذف شدند`"..EndPm, 0, "md")
						end
						if mr_roo[2]:lower() == 'deleted' or mr_roo[2] == 'اکانت های دلیت شده' then
							local function GetDeleted(arg, data)
								if data.members then
									for k,v in pairs (data.members) do
										local function GetUser(arg, data)
											if data.type and data.type._ == "userTypeDeleted" then
												kick_user(data.id, msg.to.id)
											end
										end
										tdbot.getUser(v.user_id, GetUser, {msg=arg.msg})
									end
								end
							end
							for i = 1, 2 do
								tdbot.getChannelMembers(msg.to.id, 0, 100000, 'Recent', GetDeleted, {msg=msg})
							end
							for i = 1, 1 do
								tdbot.getChannelMembers(msg.to.id, 0, 100000, 'Search', GetDeleted, {msg=msg})
							end
							return tdbot.sendMessage(msg.to.id, msg.id, 0, M_START.."`تمام اکانت های دلیت ‌شده از گروه حذف شدند`"..EndPm, 0, "md")
						end
					end
					if msg.to.type ~= 'pv' then
						if mr_roo[2]:lower() == 'bans' or mr_roo[2] == 'لیست مسدود' then
							local list = redis:smembers(RedisIndex..'Banned:'..msg.to.id)
							if #list == 0 then
								return M_START.."*هیچ کاربری از این گروه محروم نشده*"..EndPm
							end
							redis:del(RedisIndex.."Banned:"..msg.to.id)
							return M_START.."*تمام کاربران محروم شده از گروه از محرومیت خارج شدند*"..EndPm
						end
						if mr_roo[2]:lower() == 'silentlist' or mr_roo[2] == 'لیست سکوت' then
							local function GetRestricted(arg, data)
								msg=arg.msg
								local i = 1
								local un = ''
								if data.total_count > 0 then
									i = 1
									k = 0
									local function getuser(arg, mdata)
										local ST = data.members[k].status
										if ST.can_add_web_page_previews == false and ST.can_send_media_messages == false and ST.can_send_messages == false and ST.can_send_other_messages == false and ST.is_member == true then
											unsilent_user(msg.to.id, data.members[k].user_id)
											i = i + 1
										end
										k = k + 1
										if k < data.total_count then
											tdbot.getUser(data.members[k].user_id, getuser, nil)
										else
											if i == 1 then
												return tdbot.sendMessage(msg.to.id, msg.id, 0, "*لیست کاربران سایلنت شده خالی است*", 0, "md")
											else
												return tdbot.sendMessage(msg.to.id, msg.id, 0, "*لیست کاربران سایلنت شده پاک شد*", 0, "md")
											end
										end
									end
									tdbot.getUser(data.members[k].user_id, getuser, nil)
								else
									return tdbot.sendMessage(msg.to.id, msg.id, 0, "*لیست کاربران سایلنت شده خالی است*", 0, "md")
								end
							end
							tdbot.getChannelMembers(msg.to.id, 0, 100000, 'Restricted', GetRestricted, {msg=msg})
						end
					end
					if mr_roo[2]:lower() == 'msgs' or mr_roo[2] == 'پیام ها' then
						local function pro(arg,data)
							for k,v in pairs(data.members) do
								tdbot.deleteMessagesFromUser(msg.chat_id, v.user_id, dl_cb, nil)
							end
						end
						local function cb(arg,data)
							for k,v in pairs(data.messages) do
								del_msg(msg.chat_id, v.id)
							end
						end
						for i = 1, 5 do
							tdbot.getChatHistory(msg.to.id, msg.id, 0,  500000000, 0, cb, nil)
						end
						for i = 1, 2 do
							tdbot.getChannelMembers(msg.to.id, 0, 50000, "Search", pro, nil)
						end
						for i = 1, 1 do
							tdbot.getChannelMembers(msg.to.id, 0, 50000, "Recent", pro, nil)
						end
						for i = 1, 5 do
							tdbot.getChannelMembers(msg.to.id, 0, 50000, "Banned", pro, nil)
						end
						return M_START.."*درحال پاکسازی پیام های گروه*"..EndPm
					end
					if mr_roo[2]:lower() == 'mods' or mr_roo[2] == "مدیران" then
						local list = redis:smembers(RedisIndex..'Mods:'..msg.to.id)
						if #list == 0 then
							return M_START.."هیچ مدیری برای گروه انتخاب نشده است"..EndPm
						end
						redis:del(RedisIndex.."Mods:"..msg.to.id)
						return M_START.."`تمام مدیران گروه تنزیل مقام شدند`"..EndPm
					end
					if mr_roo[2]:lower() == 'filterlist' or mr_roo[2] == "لیست فیلتر" then
						local names = redis:hkeys(RedisIndex..'filterlist:'..msg.to.id)
						if #names == 0 then
							return M_START.."`لیست کلمات فیلتر شده خالی است`"..EndPm
						end
						redis:del(RedisIndex..'filterlist:'..msg.to.id)
						return M_START.."`لیست کلمات فیلتر شده پاک شد`"..EndPm
					end
					if mr_roo[2]:lower() == 'rules' or mr_roo[2] == "قوانین" then
						if not redis:get(RedisIndex..msg.to.id..'rules')then
							return M_START.."`قوانین برای گروه ثبت نشده است`"..EndPm
						end
						redis:del(RedisIndex..msg.to.id..'rules')
						return M_START.."`قوانین گروه پاک شد`"
					end
					if mr_roo[2]:lower() == 'welcome' or mr_roo[2] == "خوشامد" then
						if not redis:get(RedisIndex..'setwelcome:'..msg.chat_id) then
							return M_START.."`پیام خوشآمد گویی ثبت نشده است`"..EndPm
						end
						redis:del(RedisIndex..'setwelcome:'..msg.chat_id)
						return M_START.."`پیام خوشآمد گویی پاک شد`"
					end
					if mr_roo[2]:lower() == 'about' or mr_roo[2] == "درباره" then
						if msg.to.type == "chat" then
							if not redis:get(RedisIndex..msg.to.id..'about') then
								return M_START.."`پیامی مبنی بر درباره گروه ثبت نشده است`"..EndPm
							end
						elseif msg.to.type == "channel" then
							tdbot.changeChannelDescription(chat, "", dl_cb, nil)
						end
						return M_START.."`پیام مبنی بر درباره گروه پاک شد`"..EndPm
					end
					if  mr_roo[2] == 'warns' or mr_roo[2] == 'اخطار ها' then
						local hash = msg.to.id..':warn'
						redis:del(RedisIndex..hash)
						return M_START.."`تمام اخطار های کاربران این گروه پاک شد`"..EndPm
					end
				end
			end
		end
	if is_JoinChannel(msg) then
		if is_owner(msg) then
			if mr_roo[1]:lower() == 'setlink' or mr_roo[1] == "تنظیم لینک" then
				redis:setex(RedisIndex..msg.to.id..'linkgp', 60, true)
				return M_START..'`لطفا لینک گروه خود را ارسال کنید`'..EndPm
			end
			if msg.text then
				local is_link = msg.text:match("^([https?://w]*.?telegram.me/joinchat/%S+)$") or msg.text:match("^([https?://w]*.?t.me/joinchat/%S+)$")
				if is_link and redis:get(RedisIndex..msg.to.id..'linkgp') then
					redis:set(RedisIndex..msg.to.id..'linkgpset', msg.text)
					return M_START.."`لینک جدید ذخیره شد`"..EndPm
				end
			end
			if mr_roo[1]:lower() == "setmute" or mr_roo[1] == "تنظیم سکوت" then
				local time = mr_roo[2] * 60
				redis:set(RedisIndex.."TimeMuteset"..msg.to.id, time)
				return M_START.."`زمان سکوت روی` *"..mr_roo[2].."* `دقیقه تنظیم شد`"..EndPm
			end
		end
		if is_mod(msg) then
			if msg.to.type == "channel" then
				if mr_roo[1]:lower() == "gpinfo" or mr_roo[1] == "اطلاعات گروه" then
					local function group_info(arg, data)
						if data.description and data.description ~= "" then
							des = check_markdown(data.description)
						else
							des = ""
						end
						ginfo = M_START.."*اطلاعات گروه :*\n`تعداد مدیران :` *"..data.administrator_count.."*\n`تعداد اعضا :` *"..data.member_count.."*\n`تعداد اعضای حذف شده :` *"..data.banned_count.."*\n`تعداد اعضای محدود شده :` *"..data.restricted_count.."*\n`شناسه گروه :` *"..msg.to.id.."*\n`توضیحات گروه :` "..des
						tdbot.sendMessage(arg.chat_id, arg.msg_id, 1, ginfo, 1, 'md')
					end
					tdbot.getChannelFull(msg.to.id, group_info, {chat_id=msg.to.id,msg_id=msg.id})
				end
				if (mr_roo[1]:lower() == "setabout" or mr_roo[1] == "تنظیم درباره") and mr_roo[2] then
					tdbot.changeChannelDescription(chat, mr_roo[2], dl_cb, nil)
					redis:set(RedisIndex..msg.to.id..'about', mr_roo[2])
					return M_START.."`پیام مبنی بر درباره گروه ثبت شد`"..EndPm
				end
			end
			if mr_roo[2] then
				if mr_roo[1]:lower() == "setwelcome" or mr_roo[1] == "تنظیم خوشامد" then
					redis:set(RedisIndex..'setwelcome:'..msg.chat_id, mr_roo[2])
					return M_START.."`پیام خوشآمد گویی تنظیم شد به :`\n*"..mr_roo[2].."*\n\n*شما میتوانید از*\n_{gpname} نام گروه_\n_{rules} ➣ نمایش قوانین گروه_\n_{time} ➣ ساعت به زبان انگلیسی _\n_{date} ➣ تاریخ به زبان انگلیسی _\n_{timefa} ➣ ساعت به زبان فارسی _\n_{datefa} ➣ تاریخ به زبان فارسی _\n_{name} ➣ نام کاربر جدید_\n_{username} ➣ نام کاربری کاربر جدید_\n`استفاده کنید`"..EndPm
				end
				if mr_roo[1]:lower() == "setname" or mr_roo[1] == "تنظیم نام" then
					local gp_name = mr_roo[2]
					tdbot.changeChatTitle(chat, gp_name, dl_cb, nil)
				end
				if mr_roo[1]:lower() == "res" or mr_roo[1] == "کاربری" then
					tdbot_function ({
					_ = "searchPublicChat",
					username = mr_roo[2]
					}, action_by_username, {chat_id=msg.to.id,username=mr_roo[2],cmd="res"})
				end
				if mr_roo[1]:lower() == "setrules" or mr_roo[1] == "تنظیم قوانین" then
					redis:set(RedisIndex..msg.to.id..'rules', mr_roo[2])
					return M_START.."`قوانین گروه ثبت شد`"..EndPm
				end
				if mr_roo[1]:lower() == "whois" or mr_roo[1] == "شناسه" then
					tdbot_function ({
					_ = "getUser",
					user_id = mr_roo[2],
					}, action_by_id, {chat_id=msg.to.id,user_id=mr_roo[2],cmd="whois"})
				end
			end
if (mr_roo[1]:lower() == 'lockgp' or mr_roo[1]== 'قفل گروه') and mr_roo[4] then
local hour = tonumber(mr_roo[2])
local num1 = (tonumber(hour) * 3600)
local minutes = tonumber(mr_roo[3])
local num2 = (tonumber(minutes) * 60)
local second = tonumber(mr_roo[4])
local num3 = tonumber(second)
local timelock = tonumber(num1 + num2 + num3)
redis:setex(RedisIndex..'lockgp:'..msg.to.id, timelock, true)
return M_START.."`گروه به مدت` *"..mr_roo[2].."* `ساعت` *"..mr_roo[3].."* `دقیقه` *"..mr_roo[4].."* `ثانیه توسط` `"..msg.from.id.."` - @"..check_markdown(msg.from.username or '').." `قفل شد`"..EndPm
end
if mr_roo[1]:lower() == 'lockgp' or mr_roo[1]== 'قفل گروه' then
local time = mr_roo[2]
if mr_roo[3] == "h" or mr_roo[3] == "ساعت" then
local hour = tonumber(time) * 3600
local timelock = tonumber(hour)
redis:setex(RedisIndex..'lockgp:'..msg.to.id, timelock, true)
return M_START.."`گروه به مدت` *"..mr_roo[2].."* `ساعت توسط` `"..msg.from.id.."` - @"..check_markdown(msg.from.username or '').." `قفل شد`"..EndPm
elseif mr_roo[3] == "m" or mr_roo[3] == "دقیقه" then
local minutes = tonumber(time) * 60
local timelock = tonumber(minutes)
redis:setex(RedisIndex..'lockgp:'..msg.to.id, timelock, true)
return M_START.."`گروه به مدت` *"..mr_roo[2].."* `دقیقه توسط` `"..msg.from.id.."` - @"..check_markdown(msg.from.username or '').." `قفل شد`"..EndPm
elseif mr_roo[3] == "s" or mr_roo[3] == "ثانیه" then
local second = tonumber(time)
local timelock = tonumber(second)
redis:setex(RedisIndex..'lockgp:'..msg.to.id, timelock, true)
return M_START.."`گروه به مدت` *"..mr_roo[2].."* `ثانیه توسط` `"..msg.from.id.."` - @"..check_markdown(msg.from.username or '').." `قفل شد`"..EndPm
end
end
			if (mr_roo[1]:lower() == "pin" or mr_roo[1] == "سنجاق") and msg.reply_id then
				local lock_pin = redis:get(RedisIndex..'lock_pin:'..msg.chat_id)
				if lock_pin == 'Enable' then
					if is_owner(msg) then
						tdbot.pinChannelMessage(msg.to.id, msg.reply_id, 1, dl_cb, nil)
						return M_START.."`پیام سجاق شد`"..EndPm
					elseif not is_owner(msg) then
						return
					end
				elseif not lock_pin then
					redis:set(RedisIndex..'pin_msg'..msg.chat_id, msg.reply_id)
					tdbot.pinChannelMessage(msg.to.id, msg.reply_id, 1, dl_cb, nil)
					return M_START.."`پیام سجاق شد`"..EndPm
				end
			end
			if mr_roo[1]:lower() == 'unpin' or mr_roo[1] == "حذف سنجاق" then
				local lock_pin = redis:get(RedisIndex..'lock_pin:'..msg.chat_id)
				if lock_pin == 'Enable' then
					if is_owner(msg) then
						tdbot.unpinChannelMessage(msg.to.id, dl_cb, nil)
						return M_START.."`پیام سنجاق شده پاک شد`"..EndPm
					elseif not is_owner(msg) then
						return
					end
				elseif not lock_pin then
					tdbot.unpinChannelMessage(msg.to.id, dl_cb, nil)
					return M_START.."`پیام سنجاق شده پاک شد`"..EndPm
				end
			end
			if mr_roo[1]:lower() == 'newlink' or mr_roo[1] == "لینک جدید" then
				local function callback_link (arg, data)
					if not data.invite_link then
						return tdbot.sendMessage(msg.to.id, msg.id, 1, M_START.."`ربات ادمین گروه نیست`\n`با دستور` *setlink/* `لینک جدیدی برای گروه ثبت کنید"..EndPm, 1, 'md')
					else
						redis:set(RedisIndex..msg.to.id..'linkgpset', data.invite_link)
						return tdbot.sendMessage(msg.to.id, msg.id, 1, M_START.."`لینک جدید ساخته شد`"..EndPm, 1, 'md')
					end
				end
				tdbot.exportChatInviteLink(msg.to.id, callback_link, nil)
			end
			if mr_roo[1]:lower() == 'link' or mr_roo[1] == "لینک" then
				local linkgp = redis:get(RedisIndex..msg.to.id..'linkgpset')
				if not linkgp then
					return M_START.."`ابتدا با دستور` *newlink/* `لینک جدیدی برای گروه بسازید`\n`و اگر ربات سازنده گروه نیس با دستور` *setlink/* `لینک جدیدی برای گروه ثبت کنید`"..EndPm
				end
				text = M_START.."<b>لینک گروه :</b>\n"..linkgp
				return tdbot.sendMessage(msg.chat_id, msg.id, 1, text, 1, 'html')
			end
			if mr_roo[1]:lower() == 'linkpv' or mr_roo[1] == "لینک خصوصی" then
				if redis:get(RedisIndex..msg.from.id..'chkusermonshi') and not is_admin(msg) then
					tdbot.sendMessage(msg.chat_id, msg.id, 1, "`لطفا پیوی ربات پیام ازسال کنید سپس دستور را وارد نماید.`"..EndPm, 1, 'md')
				else
					local linkgp = redis:get(RedisIndex..msg.to.id..'linkgpset')
					if not linkgp then
						return M_START.."`ابتدا با دستور` *newlink/* `لینک جدیدی برای گروه بسازید`\n`و اگر ربات سازنده گروه نیس با دستور` *setlink/* `لینک جدیدی برای گروه ثبت کنید`"..EndPm
					end
					tdbot.sendMessage(msg.sender_user_id, "", 1, "<b>لینک گروه </b> : <code>"..msg.to.title.."</code> :\n"..linkgp, 1, 'html')
					return M_START.."`لینک گروه به چت خصوصی شما ارسال شد`"..EndPm
				end
			end
			if mr_roo[1]:lower() == 'setchar' or mr_roo[1] == "حداکثر حروف مجاز" then
				if not is_mod(msg) then
					return
				end
				local chars_max = mr_roo[2]
				redis:set(RedisIndex..msg.to.id..'set_char', chars_max)
				return M_START.."`حداکثر حروف مجاز در پیام تنظیم شد به :` *[ "..mr_roo[2].." ]*"..EndPm
			end
			if mr_roo[1]:lower() == 'setflood' or mr_roo[1] == "تنظیم پیام مکرر" then
				if tonumber(mr_roo[2]) < 1 or tonumber(mr_roo[2]) > 50 then
					return M_START.."`باید بین` *[2-50]* `تنظیم شود`"..EndPm
				end
				local flood_max = mr_roo[2]
				redis:set(RedisIndex..msg.to.id..'num_msg_max', flood_max)
				return M_START..'`محدودیت پیام مکرر به` *'..tonumber(mr_roo[2])..'* `تنظیم شد.`'..EndPm
			end
			if mr_roo[1]:lower() == 'setfloodtime'or mr_roo[1] == "تنظیم زمان بررسی" then
				if tonumber(mr_roo[2]) < 2 or tonumber(mr_roo[2]) > 10 then
					return M_START.."`باید بین` *[2-10]* `تنظیم شود`"..EndPm
				end
				local time_max = mr_roo[2]
				redis:set(RedisIndex..msg.to.id..'time_check', time_max)
				return M_START.."`حداکثر زمان بررسی پیام های مکرر تنظیم شد به :` *[ "..mr_roo[2].." ]*"..EndPm
			end
			if mr_roo[1]:lower() == "about" or mr_roo[1] == "درباره" then
				if not redis:get(RedisIndex..msg.to.id..'about') then
					return  M_START.."`پیامی مبنی بر درباره گروه ثبت نشده است`"..EndPm
				else
					return M_START.."*درباره گروه :*\n"..redis:get(RedisIndex..msg.to.id..'about')
				end
			end
			if mr_roo[1]:lower() == "welcome" or mr_roo[1] == "خوشامد" then
				if mr_roo[2] == "enable" or mr_roo[2] == "فعال"  then
					welcome = redis:get(RedisIndex..'welcome:'..msg.chat_id)
					if welcome == 'Enable' then
						return M_START.."`خوشآمد گویی از قبل فعال بود`"..EndPm
					else
						redis:set(RedisIndex..'welcome:'..msg.chat_id, 'Enable')
						return M_START.."`خوشآمد گویی فعال شد`"..EndPm
					end
				end
				if mr_roo[2] == "disable" or mr_roo[2] == "غیرفعال" then
					welcome = redis:get(RedisIndex..'welcome:'..msg.chat_id)
					if welcome == 'Enable' then
						redis:del(RedisIndex..'welcome:'..msg.chat_id)
						return M_START.."`خوشآمد گویی غیرفعال شد`"..EndPm
					else
						return M_START.."`خوشآمد گویی از قبل فعال نبود`"..EndPm
					end
				end
			end
			if mr_roo[1]:lower() == 'setwarn' or mr_roo[1] == "حداکثر اخطار" then
				if tonumber(mr_roo[2]) < 1 or tonumber(mr_roo[2]) > 20 then
					return M_START.."`لطفا عددی بین [1-20] را انتخاب کنید`"..EndPm
				end
				local warn_max = mr_roo[2]
				redis:set(RedisIndex..'max_warn:'..msg.to.id, warn_max)
				return M_START.."`حداکثر اخطار تنظیم شد به :` *[ "..mr_roo[2].." ]*"..EndPm
			end
			if mr_roo[1]:lower() == "warnlist" or mr_roo[1] == "لیست اخطار" then
				local list = M_START..'لیست اخطار :\n'
				local empty = list
				for k,v in pairs (redis:hkeys(RedisIndex..msg.to.id..':warn')) do
					local user_name = redis:get(RedisIndex..'user_name:'..v) or "---"
					local cont = redis:hget(RedisIndex..msg.to.id..':warn', v)
					if user_name then
						list = list..k..'- '..check_markdown(user_name)..' [`'..v..'`] \n*اخطار : '..(cont - 1)..'*\n'
					else
						list = list..k..'- `'..v..'` \n*اخطار : '..(cont - 1)..'*\n'
					end
				end
				if list == empty then
					return M_START..'*لیست اخطار خالی است*'..EndPm
				else
					return list
				end
			end
			if mr_roo[1]:lower() == 'setdow' or mr_roo[1] == 'تنظیم دانلود' then
				if redis:get(RedisIndex..'Num1Time:'..msg.to.id) and not is_admin(msg) then
					tdbot.sendMessage(msg.chat_id, msg.id, 1, M_START.."`اجرای این دستور هر 1 ساعت یک بار ممکن است.`"..EndPm, 1, 'md')
				else
					redis:setex(RedisIndex..'Num1Time:'..msg.to.id, 3600, true)
					redis:setex(RedisIndex..'AutoDownload:'..msg.to.id, 1200, true)
					local text = M_START..'*با موفقیت ثبت شد.*\n`مدیران و صاحب گروه  میتواند به مدت 20 دقیقه از دستوراتی که نیاز به دانلود دارند استفاده کنند`\n*'..M_START..' نکته :* اجرای این دستور هر 1 ساعت یک بار ممکن است.'..EndPm
					tdbot.sendMessage(msg.chat_id, msg.id, 1, text, 1, 'md')
				end
			end
			if mr_roo[1]:lower() == "del" or mr_roo[1] == "حذف" then
				del_msg(msg.to.id, msg.reply_id)
				del_msg(msg.to.id, msg.id)
			end
			if mr_roo[1]:lower() == 'rmsg' or mr_roo[1] == 'پاکسازی' then
				if tonumber(mr_roo[2]) > 100 then
					tdbot.sendMessage(msg.chat_id,  msg.id, 0, M_START.."*عددی بین * [`1-100`] را انتخاب کنید"..EndPm, 0, "md")
				else
					local function cb(arg,data)
						for k,v in pairs(data.messages) do
							del_msg(msg.chat_id, v.id)
						end
					end
					tdbot.getChatHistory(msg.to.id, msg.id, 0,  mr_roo[2], 0, cb, nil)
					tdbot.sendMessage(msg.chat_id,  msg.id, 0, M_START.."`تعداد` *("..mr_roo[2]..")* `پیام پاکسازی شد`"..EndPm, 0, "md")
				end
			end
			if mr_roo[1]:lower() == 'lock auto' or mr_roo[1] == 'قفل خودکار' then
				redis:setex(RedisIndex.."atolc"..msg.to.id..msg.sender_user_id,45,true)
				if redis:get(RedisIndex.."atolct1"..msg.to.id) and redis:get(RedisIndex.."atolct2"..msg.to.id) then
					redis:del(RedisIndex.."atolct1"..msg.to.id)
					redis:del(RedisIndex.."atolct2"..msg.to.id)
					redis:del(RedisIndex.."lc_ato:"..msg.to.id)
					tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'`زمان قبلی از سیستم حذف شد\n\nلطفا زمان شروع قفل خودکار را وارد کنید :\nمثال :\n 00:00`'..EndPm, 1, 'md')
				else
					tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'`لطفا زمان شروع قفل خودکار را وارد کنید :\nمثال :\n 15:24`'..EndPm, 1, 'md')
				end
			elseif mr_roo[1]:lower() == 'unlock auto' or mr_roo[1] == 'باز کردن خودکار' then
				if redis:get(RedisIndex.."atolct1"..msg.to.id) and redis:get(RedisIndex.."atolct2"..msg.to.id) then
					redis:del(RedisIndex.."atolct1"..msg.to.id)
					redis:del(RedisIndex.."atolct2"..msg.to.id)
					redis:del(RedisIndex.."lc_ato:"..msg.to.id)
					tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'`زمانبدی ربات برای قفل کردن خودکار گروه حذف شد`'..EndPm, 1, 'md')
				else
					tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'`قفل خودکار از قبل غیرفعال بود`'..EndPm, 1, 'md')
				end
			elseif (mr_roo[1] == "00" or mr_roo[1] == "01" or mr_roo[1] == "02" or mr_roo[1] == "03" or mr_roo[1] == "04" or mr_roo[1] == "05" or mr_roo[1] == "06" or mr_roo[1] == "07" or mr_roo[1] == "08" or mr_roo[1] == "09" or mr_roo[1] == "10" or mr_roo[1] == "11" or mr_roo[1] == "12" or mr_roo[1] == "13" or mr_roo[1] == "14" or mr_roo[1] == "15" or mr_roo[1] == "16" or mr_roo[1] == "17" or mr_roo[1] == "18" or mr_roo[1] == "19" or mr_roo[1] == "20" or mr_roo[1] == "21" or mr_roo[1] == "22" or mr_roo[1] == "23") and (mr_roo[2] == "00" or mr_roo[2] == "01" or mr_roo[2] == "02" or mr_roo[2] == "03" or mr_roo[2] == "04" or mr_roo[2] == "05" or mr_roo[2] == "06" or mr_roo[2] == "07" or mr_roo[2] == "08" or mr_roo[2] == "09" or mr_roo[2] == "10" or mr_roo[2] == "11" or mr_roo[2] == "12" or mr_roo[2] == "13" or mr_roo[2] == "14" or mr_roo[2] == "15" or mr_roo[2] == "16" or mr_roo[2] == "17" or mr_roo[2] == "18" or mr_roo[2] == "19" or mr_roo[2] == "20" or mr_roo[2] == "21" or mr_roo[2] == "22" or mr_roo[2] == "23" or mr_roo[2] == "24" or mr_roo[2] == "25" or mr_roo[2] == "26" or mr_roo[2] == "27" or mr_roo[2] == "28" or mr_roo[2] == "29" or mr_roo[2] == "30" or mr_roo[2] == "31" or mr_roo[2] == "32" or mr_roo[2] == "33" or mr_roo[2] == "34" or mr_roo[2] == "35" or mr_roo[2] == "36" or mr_roo[2] == "37" or mr_roo[2] == "38" or mr_roo[2] == "39" or mr_roo[2] == "40" or mr_roo[2] == "41" or mr_roo[2] == "42" or mr_roo[2] == "43" or mr_roo[2] == "44" or mr_roo[2] == "45" or mr_roo[2] == "46" or mr_roo[2] == "47" or mr_roo[2] == "48" or mr_roo[2] == "49" or mr_roo[2] == "50" or mr_roo[2] == "51" or mr_roo[2] == "52" or mr_roo[2] == "53" or mr_roo[2] == "54" or mr_roo[2] == "55" or mr_roo[2] == "56" or mr_roo[2] == "57" or mr_roo[2] == "58" or mr_roo[2] == "59") and redis:get(RedisIndex.."atolc"..msg.to.id..msg.sender_user_id) then
				tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'`زمان شروع قفل خودکار در سیستم ثبت شد.\n\nلطفا زمان پایان قفل خودکار را وارد کنید :\nمثال :\n 07:00`'..EndPm, 1, 'md')
				redis:del(RedisIndex.."atolc"..msg.to.id..msg.sender_user_id)
				redis:setex(RedisIndex.."atolct1"..msg.to.id,45,mr_roo[1]..':'..mr_roo[2])
				redis:setex(RedisIndex.."atolc2"..msg.to.id..msg.sender_user_id,45,true)
			elseif (mr_roo[1] == "00" or mr_roo[1] == "01" or mr_roo[1] == "02" or mr_roo[1] == "03" or mr_roo[1] == "04" or mr_roo[1] == "05" or mr_roo[1] == "06" or mr_roo[1] == "07" or mr_roo[1] == "08" or mr_roo[1] == "09" or mr_roo[1] == "10" or mr_roo[1] == "11" or mr_roo[1] == "12" or mr_roo[1] == "13" or mr_roo[1] == "14" or mr_roo[1] == "15" or mr_roo[1] == "16" or mr_roo[1] == "17" or mr_roo[1] == "18" or mr_roo[1] == "19" or mr_roo[1] == "20" or mr_roo[1] == "21" or mr_roo[1] == "22" or mr_roo[1] == "23") and (mr_roo[2] == "00" or mr_roo[2] == "01" or mr_roo[2] == "02" or mr_roo[2] == "03" or mr_roo[2] == "04" or mr_roo[2] == "05" or mr_roo[2] == "06" or mr_roo[2] == "07" or mr_roo[2] == "08" or mr_roo[2] == "09" or mr_roo[2] == "10" or mr_roo[2] == "11" or mr_roo[2] == "12" or mr_roo[2] == "13" or mr_roo[2] == "14" or mr_roo[2] == "15" or mr_roo[2] == "16" or mr_roo[2] == "17" or mr_roo[2] == "18" or mr_roo[2] == "19" or mr_roo[2] == "20" or mr_roo[2] == "21" or mr_roo[2] == "22" or mr_roo[2] == "23" or mr_roo[2] == "24" or mr_roo[2] == "25" or mr_roo[2] == "26" or mr_roo[2] == "27" or mr_roo[2] == "28" or mr_roo[2] == "29" or mr_roo[2] == "30" or mr_roo[2] == "31" or mr_roo[2] == "32" or mr_roo[2] == "33" or mr_roo[2] == "34" or mr_roo[2] == "35" or mr_roo[2] == "36" or mr_roo[2] == "37" or mr_roo[2] == "38" or mr_roo[2] == "39" or mr_roo[2] == "40" or mr_roo[2] == "41" or mr_roo[2] == "42" or mr_roo[2] == "43" or mr_roo[2] == "44" or mr_roo[2] == "45" or mr_roo[2] == "46" or mr_roo[2] == "47" or mr_roo[2] == "48" or mr_roo[2] == "49" or mr_roo[2] == "50" or mr_roo[2] == "51" or mr_roo[2] == "52" or mr_roo[2] == "53" or mr_roo[2] == "54" or mr_roo[2] == "55" or mr_roo[2] == "56" or mr_roo[2] == "57" or mr_roo[2] == "58" or mr_roo[2] == "59") and redis:get(RedisIndex.."atolc2"..msg.to.id..msg.sender_user_id) then
				local time_1 = redis:get(RedisIndex.."atolct1"..msg.to.id)
				if time_1 == mr_roo[1]..':'..mr_roo[2] then
					tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'`آغاز قفل خودکار نمیتوانید با پایان آن یکی باشد`'..EndPm, 1, 'md')
				else
					tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'`عملیات با موقیت انجام شد.\n\nگروه شما در ساعت` *'..time_1..'* `الی` *'..mr_roo[1]..':'..mr_roo[2]..'* `بصورت خودکار تعطیل خواهد شد.`'..EndPm, 1, 'md')
					redis:set(RedisIndex.."atolct1"..msg.to.id,redis:get(RedisIndex.."atolct1"..msg.to.id))
					redis:set(RedisIndex.."atolct2"..msg.to.id,mr_roo[1]..':'..mr_roo[2])
					redis:del(RedisIndex.."atolc2"..msg.to.id..msg.sender_user_id)
				end
			end
			if mr_roo[1]:lower() == "lock" or mr_roo[1] == "قفل" then
				if mr_roo[2] == "link" or mr_roo[2] == "لینک" then
					Lock_Delmsg(msg, 'lock_link', "لینک")
				elseif mr_roo[2]:lower() == "tag" or mr_roo[2] == "تگ" then
					Lock_Delmsg(msg, "lock_tag", "تگ")
				elseif mr_roo[2]:lower() == "views" or mr_roo[2] == "ویو" then
					Lock_Delmsg(msg, "lock_views", "ویو")
				elseif mr_roo[2]:lower() == "username" or mr_roo[2] == "نام کاربری" then
					Lock_Delmsg(msg, "lock_username", "نام کاربری")
				elseif mr_roo[2]:lower() == "mention" or mr_roo[2] == "منشن" then
					Lock_Delmsg(msg, "lock_mention", "منشن")
				elseif mr_roo[2]:lower() == "arabic" or mr_roo[2] == "فارسی" then
					Lock_Delmsg(msg, "lock_arabic", "فارسی")
				elseif mr_roo[2]:lower() == "edit" or mr_roo[2] == "ویرایش" then
					Lock_Delmsg(msg, "lock_edit", "ویرایش")
				elseif mr_roo[2]:lower() == "spam" or mr_roo[2] == "هرزنامه" then
					Lock_Delmsg(msg, "lock_spam", "هرزنامه")
				elseif mr_roo[2]:lower() == "flood" or mr_roo[2] == "پیام مکرر" then
					Lock_Delmsg(msg, "lock_flood", "پیام مکرر")
				elseif mr_roo[2]:lower() == "bots" or mr_roo[2] == "ربات" then
					Lock_Delmsg(msg, "lock_bots", "ربات")
				elseif mr_roo[2]:lower() == "markdown" or mr_roo[2] == "فونت" then
					Lock_Delmsg(msg, "lock_markdown", "فونت")
				elseif mr_roo[2]:lower() == "webpage" or mr_roo[2] == "وب" then
					Lock_Delmsg(msg, "lock_webpage", "وب")
				elseif (mr_roo[2] == "pin" or mr_roo[2] == "سنجاق") and is_owner(msg) then
					Lock_Delmsg(msg, "lock_pin", "سنجاق")
				elseif mr_roo[2]:lower() == "join" or mr_roo[2] == "ورود" then
					Lock_Delmsg(msg, "lock_join", "ورود")
				elseif mr_roo[2]:lower() == "all" or mr_roo[2] == "همه" then
					Lock_Delmsg(msg, "mute_all", "همه")
				elseif mr_roo[2]:lower() == "gif" or mr_roo[2] == "گیف" then
					Lock_Delmsg(msg, "mute_gif", "گیف")
				elseif mr_roo[2]:lower() == "text" or mr_roo[2] == "متن" then
					Lock_Delmsg(msg, "mute_text", "متن")
				elseif mr_roo[2]:lower() == "photo" or mr_roo[2] == "عکس" then
					Lock_Delmsg(msg, "mute_photo", "عکس")
				elseif mr_roo[2]:lower() == "video" or mr_roo[2] == "فیلم" then
					Lock_Delmsg(msg, "mute_video", "فیلم")
				elseif mr_roo[2]:lower() == "video_note" or mr_roo[2] == "فیلم سلفی" then
					Lock_Delmsg(msg, "mute_video_note", "فیلم سلفی")
				elseif mr_roo[2]:lower() == "audio" or mr_roo[2] == "اهنگ" then
					Lock_Delmsg(msg, "mute_audio", "آهنگ")
				elseif mr_roo[2]:lower() == "voice" or mr_roo[2] == "صدا" then
					Lock_Delmsg(msg, "mute_voice", "صدا")
				elseif mr_roo[2]:lower() == "sticker" or mr_roo[2] == "استیکر" then
					Lock_Delmsg(msg, "mute_sticker", "استیکر")
				elseif mr_roo[2]:lower() == "contact" or mr_roo[2] == "مخاطب" then
					Lock_Delmsg(msg, "mute_contact", "مخاطب")
				elseif mr_roo[2]:lower() == "forward" or mr_roo[2] == "فوروارد" then
					Lock_Delmsg(msg, "mute_forward", "فوروارد")
				elseif mr_roo[2]:lower() == "location" or mr_roo[2] == "موقعیت" then
					Lock_Delmsg(msg, "mute_location", "موقعیت")
				elseif mr_roo[2]:lower() == "document" or mr_roo[2] == "فایل" then
					Lock_Delmsg(msg, "mute_document", "فایل")
				elseif mr_roo[2]:lower() == "tgservice" or mr_roo[2] == "سرویس تلگرام" then
					Lock_Delmsg(msg, "mute_tgservice", "سرویس تلگرام")
				elseif mr_roo[2]:lower() == "inline" or mr_roo[2] == "کیبورد شیشه ای" then
					Lock_Delmsg(msg, "mute_inline", "کیبورد شیشهای")
				elseif mr_roo[2]:lower() == "game" or mr_roo[2] == "بازی" then
					Lock_Delmsg(msg, "mute_game", "بازی")
				elseif mr_roo[2]:lower() == "keyboard" or mr_roo[2] == "صفحه کلید" then
					Lock_Delmsg(msg, "mute_keyboard", "صفحه کلید")
				elseif mr_roo[2]:lower() == "cmds" or mr_roo[2] == "دستورات" then
					tdbot.sendMessage(msg.to.id, msg.id, 1, M_START.."`قفل دستورات` *تتوسط* `"..msg.from.id.."` - @"..check_markdown(msg.from.username or '').." `فعال شد.`"..EndPm, 1, 'md')
					redis:set(RedisIndex.."lock_cmd"..msg.chat_id,true)
				end
			end
			if mr_roo[1]:lower() == "warn" or mr_roo[1] == "اخطار" then
				if mr_roo[2] == "link" or mr_roo[2] == "لینک" then
					Lock_Delmsg_warn(msg, 'lock_link', "لینک")
				elseif mr_roo[2]:lower() == "tag" or mr_roo[2] == "تگ" then
					Lock_Delmsg_warn(msg, "lock_tag", "تگ")
				elseif mr_roo[2]:lower() == "views" or mr_roo[2] == "ویو" then
					Lock_Delmsg_warn(msg, "lock_views", "ویو")
				elseif mr_roo[2]:lower() == "username" or mr_roo[2] == "نام کاربری" then
					Lock_Delmsg_warn(msg, "lock_username", "نام کاربری")
				elseif mr_roo[2]:lower() == "mention" or mr_roo[2] == "منشن" then
					Lock_Delmsg_warn(msg, "lock_mention", "منشن")
				elseif mr_roo[2]:lower() == "arabic" or mr_roo[2] == "فارسی" then
					Lock_Delmsg_warn(msg, "lock_arabic", "فارسی")
				elseif mr_roo[2]:lower() == "edit" or mr_roo[2] == "ویرایش" then
					Lock_Delmsg_warn(msg, "lock_edit", "ویرایش")
				elseif mr_roo[2]:lower() == "markdown" or mr_roo[2] == "فونت" then
					Lock_Delmsg_warn(msg, "lock_markdown", "فونت")
				elseif mr_roo[2]:lower() == "webpage" or mr_roo[2] == "وب" then
					Lock_Delmsg_warn(msg, "lock_webpage", "وب")
				elseif mr_roo[2]:lower() == "gif" or mr_roo[2] == "گیف" then
					Lock_Delmsg_warn(msg, "mute_gif", "گیف")
				elseif mr_roo[2]:lower() == "text" or mr_roo[2] == "متن" then
					Lock_Delmsg_warn(msg, "mute_text", "متن")
				elseif mr_roo[2]:lower() == "photo" or mr_roo[2] == "عکس" then
					Lock_Delmsg_warn(msg, "mute_photo", "عکس")
				elseif mr_roo[2]:lower() == "video" or mr_roo[2] == "فیلم" then
					Lock_Delmsg_warn(msg, "mute_video", "فیلم")
				elseif mr_roo[2]:lower() == "video_note" or mr_roo[2] == "فیلم سلفی" then
					Lock_Delmsg_warn(msg, "mute_video_note", "فیلم سلفی")
				elseif mr_roo[2]:lower() == "audio" or mr_roo[2] == "اهنگ" then
					Lock_Delmsg_warn(msg, "mute_audio", "آهنگ")
				elseif mr_roo[2]:lower() == "voice" or mr_roo[2] == "صدا" then
					Lock_Delmsg_warn(msg, "mute_voice", "صدا")
				elseif mr_roo[2]:lower() == "sticker" or mr_roo[2] == "استیکر" then
					Lock_Delmsg_warn(msg, "mute_sticker", "استیکر")
				elseif mr_roo[2]:lower() == "contact" or mr_roo[2] == "مخاطب" then
					Lock_Delmsg_warn(msg, "mute_contact", "مخاطب")
				elseif mr_roo[2]:lower() == "forward" or mr_roo[2] == "فوروارد" then
					Lock_Delmsg_warn(msg, "mute_forward", "فوروارد")
				elseif mr_roo[2]:lower() == "location" or mr_roo[2] == "موقعیت" then
					Lock_Delmsg_warn(msg, "mute_location", "موقعیت")
				elseif mr_roo[2]:lower() == "document" or mr_roo[2] == "فایل" then
					Lock_Delmsg_warn(msg, "mute_document", "فایل")
				elseif mr_roo[2]:lower() == "inline" or mr_roo[2] == "کیبورد شیشه ای" then
					Lock_Delmsg_warn(msg, "mute_inline", "کیبورد شیشه ای")
				elseif mr_roo[2]:lower() == "game" or mr_roo[2] == "بازی" then
					Lock_Delmsg_warn(msg, "mute_game", "بازی")
				elseif mr_roo[2]:lower() == "keyboard" or mr_roo[2] == "صفحه کلید" then
					Lock_Delmsg_warn(msg, "mute_keyboard", "صفحه کلید")
				end
			end
			if mr_roo[1]:lower() == "kick" or mr_roo[1] == "اخراج" then
				if mr_roo[2] == "link" or mr_roo[2] == "لینک" then
					Lock_Delmsg_kick(msg, 'lock_link', "لینک")
				elseif mr_roo[2]:lower() == "tag" or mr_roo[2] == "تگ" then
					Lock_Delmsg_kick(msg, "lock_tag", "تگ")
				elseif mr_roo[2]:lower() == "views" or mr_roo[2] == "ویو" then
					Lock_Delmsg_kick(msg, "lock_views", "ویو")
				elseif mr_roo[2]:lower() == "username" or mr_roo[2] == "نام کاربری" then
					Lock_Delmsg_kick(msg, "lock_username", "نام کاربری")
				elseif mr_roo[2]:lower() == "mention" or mr_roo[2] == "منشن" then
					Lock_Delmsg_kick(msg, "lock_mention", "منشن")
				elseif mr_roo[2]:lower() == "arabic" or mr_roo[2] == "فارسی" then
					Lock_Delmsg_kick(msg, "lock_arabic", "فارسی")
				elseif mr_roo[2]:lower() == "edit" or mr_roo[2] == "ویرایش" then
					Lock_Delmsg_kick(msg, "lock_edit", "ویرایش")
				elseif mr_roo[2]:lower() == "markdown" or mr_roo[2] == "فونت" then
					Lock_Delmsg_kick(msg, "lock_markdown", "فونت")
				elseif mr_roo[2]:lower() == "webpage" or mr_roo[2] == "وب" then
					Lock_Delmsg_kick(msg, "lock_webpage", "وب")
				elseif mr_roo[2]:lower() == "gif" or mr_roo[2] == "گیف" then
					Lock_Delmsg_kick(msg, "mute_gif", "گیف")
				elseif mr_roo[2]:lower() == "text" or mr_roo[2] == "متن" then
					Lock_Delmsg_kick(msg, "mute_text", "متن")
				elseif mr_roo[2]:lower() == "photo" or mr_roo[2] == "عکس" then
					Lock_Delmsg_kick(msg, "mute_photo", "عکس")
				elseif mr_roo[2]:lower() == "video" or mr_roo[2] == "فیلم" then
					Lock_Delmsg_kick(msg, "mute_video", "فیلم")
				elseif mr_roo[2]:lower() == "video_note" or mr_roo[2] == "فیلم سلفی" then
					Lock_Delmsg_kick(msg, "mute_video_note", "فیلم سلفی")
				elseif mr_roo[2]:lower() == "audio" or mr_roo[2] == "اهنگ" then
					Lock_Delmsg_kick(msg, "mute_audio", "آهنگ")
				elseif mr_roo[2]:lower() == "voice" or mr_roo[2] == "صدا" then
					Lock_Delmsg_kick(msg, "mute_voice", "صدا")
				elseif mr_roo[2]:lower() == "sticker" or mr_roo[2] == "استیکر" then
					Lock_Delmsg_kick(msg, "mute_sticker", "استیکر")
				elseif mr_roo[2]:lower() == "contact" or mr_roo[2] == "مخاطب" then
					Lock_Delmsg_kick(msg, "mute_contact", "مخاطب")
				elseif mr_roo[2]:lower() == "forward" or mr_roo[2] == "فوروارد" then
					Lock_Delmsg_kick(msg, "mute_forward", "فوروارد")
				elseif mr_roo[2]:lower() == "location" or mr_roo[2] == "موقعیت" then
					Lock_Delmsg_kick(msg, "mute_location", "موقعیت")
				elseif mr_roo[2]:lower() == "document" or mr_roo[2] == "فایل" then
					Lock_Delmsg_kick(msg, "mute_document", "فایل")
				elseif mr_roo[2]:lower() == "inline" or mr_roo[2] == "کیبورد شیشه ای" then
					Lock_Delmsg_kick(msg, "mute_inline", "کیبورد شیشه ای")
				elseif mr_roo[2]:lower() == "game" or mr_roo[2] == "بازی" then
					Lock_Delmsg_kick(msg, "mute_game", "بازی")
				elseif mr_roo[2]:lower() == "keyboard" or mr_roo[2] == "صفحه کلید" then
					Lock_Delmsg_kick(msg, "mute_keyboard", "صفحه کلید")
				end
			end
			if mr_roo[1]:lower() == "mute" or mr_roo[1] == "سکوت" then
				if mr_roo[2] == "link" or mr_roo[2] == "لینک" then
					Lock_Delmsg_mute(msg, 'lock_link', "لینک")
				elseif mr_roo[2]:lower() == "tag" or mr_roo[2] == "تگ" then
					Lock_Delmsg_mute(msg, "lock_tag", "تگ")
				elseif mr_roo[2]:lower() == "views" or mr_roo[2] == "ویو" then
					Lock_Delmsg_mute(msg, "lock_views", "ویو")
				elseif mr_roo[2]:lower() == "username" or mr_roo[2] == "نام کاربری" then
					Lock_Delmsg_mute(msg, "lock_username", "نام کاربری")
				elseif mr_roo[2]:lower() == "mention" or mr_roo[2] == "منشن" then
					Lock_Delmsg_mute(msg, "lock_mention", "منشن")
				elseif mr_roo[2]:lower() == "arabic" or mr_roo[2] == "فارسی" then
					Lock_Delmsg_mute(msg, "lock_arabic", "فارسی")
				elseif mr_roo[2]:lower() == "edit" or mr_roo[2] == "ویرایش" then
					Lock_Delmsg_mute(msg, "lock_edit", "ویرایش")
				elseif mr_roo[2]:lower() == "markdown" or mr_roo[2] == "فونت" then
					Lock_Delmsg_mute(msg, "lock_markdown", "فونت")
				elseif mr_roo[2]:lower() == "webpage" or mr_roo[2] == "وب" then
					Lock_Delmsg_mute(msg, "lock_webpage", "وب")
				elseif mr_roo[2]:lower() == "gif" or mr_roo[2] == "گیف" then
					Lock_Delmsg_mute(msg, "mute_gif", "گیف")
				elseif mr_roo[2]:lower() == "text" or mr_roo[2] == "متن" then
					Lock_Delmsg_mute(msg, "mute_text", "متن")
				elseif mr_roo[2]:lower() == "photo" or mr_roo[2] == "عکس" then
					Lock_Delmsg_mute(msg, "mute_photo", "عکس")
				elseif mr_roo[2]:lower() == "video" or mr_roo[2] == "فیلم" then
					Lock_Delmsg_mute(msg, "mute_video", "فیلم")
				elseif mr_roo[2]:lower() == "video_note" or mr_roo[2] == "فیلم سلفی" then
					Lock_Delmsg_mute(msg, "mute_video_note", "فیلم سلفی")
				elseif mr_roo[2]:lower() == "audio" or mr_roo[2] == "اهنگ" then
					Lock_Delmsg_mute(msg, "mute_audio", "آهنگ")
				elseif mr_roo[2]:lower() == "voice" or mr_roo[2] == "صدا" then
					Lock_Delmsg_mute(msg, "mute_voice", "صدا")
				elseif mr_roo[2]:lower() == "sticker" or mr_roo[2] == "استیکر" then
					Lock_Delmsg_mute(msg, "mute_sticker", "استیکر")
				elseif mr_roo[2]:lower() == "contact" or mr_roo[2] == "مخاطب" then
					Lock_Delmsg_mute(msg, "mute_contact", "مخاطب")
				elseif mr_roo[2]:lower() == "forward" or mr_roo[2] == "فوروارد" then
					Lock_Delmsg_mute(msg, "mute_forward", "فوروارد")
				elseif mr_roo[2]:lower() == "location" or mr_roo[2] == "موقعیت" then
					Lock_Delmsg_mute(msg, "mute_location", "موقعیت")
				elseif mr_roo[2]:lower() == "document" or mr_roo[2] == "فایل" then
					Lock_Delmsg_mute(msg, "mute_document", "فایل")
				elseif mr_roo[2]:lower() == "inline" or mr_roo[2] == "کیبورد شیشه ای" then
					Lock_Delmsg_mute(msg, "mute_inline", "کیبورد شیشه ای")
				elseif mr_roo[2]:lower() == "game" or mr_roo[2] == "بازی" then
					Lock_Delmsg_mute(msg, "mute_game", "بازی")
				elseif mr_roo[2]:lower() == "keyboard" or mr_roo[2] == "صفحه کلید" then
					Lock_Delmsg_mute(msg, "mute_keyboard", "صفحه کلید")
				end
			end
			if mr_roo[1]:lower() == "unlock" or mr_roo[1] == "باز کردن" or mr_roo[1] == "بازکردن" then
				if mr_roo[2] == "link" or mr_roo[2] == "لینک" then
					Unlock_Delmsg(msg, 'lock_link', "لینک")
				elseif mr_roo[2]:lower() == "tag" or mr_roo[2] == "تگ" then
					Unlock_Delmsg(msg, "lock_tag", "تگ")
				elseif mr_roo[2]:lower() == "views" or mr_roo[2] == "ویو" then
					Unlock_Delmsg(msg, "lock_views", "ویو")
				elseif mr_roo[2]:lower() == "username" or mr_roo[2] == "نام کاربری" then
					Unlock_Delmsg(msg, "lock_username", "نام کاربری")
				elseif mr_roo[2]:lower() == "mention" or mr_roo[2] == "منشن" then
					Unlock_Delmsg(msg, "lock_mention", "منشن")
				elseif mr_roo[2]:lower() == "arabic" or mr_roo[2] == "فارسی" then
					Unlock_Delmsg(msg, "lock_arabic", "فارسی")
				elseif mr_roo[2]:lower() == "edit" or mr_roo[2] == "ویرایش" then
					Unlock_Delmsg(msg, 'lock_edit', "ویرایش")
				elseif mr_roo[2]:lower() == "spam" or mr_roo[2] == "هرزنامه" then
					Unlock_Delmsg(msg, 'lock_spam', "هرزنامه")
				elseif mr_roo[2]:lower() == "flood" or mr_roo[2] == "پیام مکرر" then
					Unlock_Delmsg(msg, 'lock_flood', "پیام مکرر")
				elseif mr_roo[2]:lower() == "bots" or mr_roo[2] == "ربات" then
					Unlock_Delmsg(msg, 'lock_bots', "ربات")
				elseif mr_roo[2]:lower() == "markdown" or mr_roo[2] == "فونت" then
					Unlock_Delmsg(msg, "lock_markdown", "فونت")
				elseif mr_roo[2]:lower() == "webpage" or mr_roo[2] == "وب" then
					Unlock_Delmsg(msg, "lock_webpage", "وب")
				elseif (mr_roo[2] == "pin" or mr_roo[2] == "سنجاق") and is_owner(msg) then
					Unlock_Delmsg(msg, 'lock_pin', "سنجاق")
				elseif mr_roo[2]:lower() == "join" or mr_roo[2] == "ورود" then
					Unlock_Delmsg(msg, 'lock_join', "ورود")
				elseif mr_roo[2]:lower() == "all" or mr_roo[2] == "همه" then
					Unlock_Delmsg(msg, "mute_all", "همه")
				elseif mr_roo[2]:lower() == "gif" or mr_roo[2] == "گیف" then
					Unlock_Delmsg(msg, "mute_gif", "گیف")
				elseif mr_roo[2]:lower() == "text" or mr_roo[2] == "متن" then
					Unlock_Delmsg(msg, "mute_text", "متن")
				elseif mr_roo[2]:lower() == "photo" or mr_roo[2] == "عکس" then
					Unlock_Delmsg(msg, "mute_photo", "عکس")
				elseif mr_roo[2]:lower() == "video" or mr_roo[2] == "فیلم" then
					Unlock_Delmsg(msg, "mute_video", "فیلم")
				elseif mr_roo[2]:lower() == "video_note" or mr_roo[2] == "فیلم سلفی" then
					Unlock_Delmsg(msg, "mute_video_note", "فیلم سلفی")
				elseif mr_roo[2]:lower() == "audio" or mr_roo[2] == "اهنگ" then
					Unlock_Delmsg(msg, "mute_audio", "آهنگ")
				elseif mr_roo[2]:lower() == "voice" or mr_roo[2] == "صدا" then
					Unlock_Delmsg(msg, "mute_voice", "صدا")
				elseif mr_roo[2]:lower() == "sticker" or mr_roo[2] == "استیکر" then
					Unlock_Delmsg(msg, "mute_sticker", "استیکر")
				elseif mr_roo[2]:lower() == "contact" or mr_roo[2] == "مخاطب" then
					Unlock_Delmsg(msg, "mute_contact", "مخاطب")
				elseif mr_roo[2]:lower() == "forward" or mr_roo[2] == "فوروارد" then
					Unlock_Delmsg(msg, "mute_forward", "فوروارد")
				elseif mr_roo[2]:lower() == "location" or mr_roo[2] == "موقعیت" then
					Unlock_Delmsg(msg, "mute_location", "موقعیت")
				elseif mr_roo[2]:lower() == "document" or mr_roo[2] == "فایل" then
					Unlock_Delmsg(msg, "mute_document", "فایل")
				elseif mr_roo[2]:lower() == "tgservice" or mr_roo[2] == "سرویس تلگرام" then
					UnLock_Delmsg(msg, "mute_tgservice", "سرویس-تلگرام")
				elseif mr_roo[2]:lower() == "inline" or mr_roo[2] == "کیبورد شیشه ای" then
					Unlock_Delmsg(msg, "mute_inline", "کیبورد شیشه ای")
				elseif mr_roo[2]:lower() == "game" or mr_roo[2] == "بازی" then
					Unlock_Delmsg(msg, "mute_game", "بازی")
				elseif mr_roo[2]:lower() == "keyboard" or mr_roo[2] == "صفحه کلید" then
					Unlock_Delmsg(msg, "mute_keyboard", "صفحه کلید")
				elseif mr_roo[2]:lower() == "cmds" or mr_roo[2] == "دستورات" then
					tdbot.sendMessage(msg.to.id, msg.id, 1, M_START.."`قفل دستورات` *تتوسط* `"..msg.from.id.."` - @"..check_markdown(msg.from.username or '').." `غیرفعال شد.`"..EndPm, 1, 'md')
					redis:del(RedisIndex.."lock_cmd"..msg.chat_id)
				end
			end
			if mr_roo[1]:lower() == "panel" or mr_roo[1] == "پنل" then
				local function inline_query_cb(arg, data)
					if data.results and data.results[0] then
						redis:setex(RedisIndex.."ReqMenu:" .. msg.to.id .. ":" .. msg.from.id, 260, true) redis:setex(RedisIndex.."ReqMenu:" .. msg.to.id, 10, true) tdbot.sendInlineQueryResultMessage(msg.to.id, msg.id, 0, 1, data.inline_query_id, data.results[0].id, dl_cb, nil)
					else
						text = M_START.."مشکل فنی در ربات هلپر"..EndPm
						return tdbot.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
					end
				end
				tdbot.getInlineQueryResults(BotTiGeR_idapi, msg.to.id, 0, 0, "Menu:"..msg.to.id, 0, inline_query_cb, nil)
			end
			if mr_roo[1]:lower() == "panelpv" or mr_roo[1] == "پنل خصوصی" then
				if not redis:get(RedisIndex..msg.from.id..'chkusermonshi') and not is_admin(msg) then
					tdbot.sendMessage(msg.chat_id, msg.id, 1, M_START.."`شما برای اجرای این دستور ابتدا باید خصوصی ربات پیام دهید.`"..EndPm, 1, 'md')
				else
					local function inline_query_cb(arg, data)
						if data.results and data.results[0] then
							redis:setex(RedisIndex.."ReqMenu:" .. msg.to.id .. ":" .. msg.from.id, 260, true) redis:setex(RedisIndex.."ReqMenu:" .. msg.to.id, 10, true) tdbot.sendInlineQueryResultMessage(msg.from.id, msg.id, 0, 1, data.inline_query_id, data.results[0].id, dl_cb, nil)
						else
							text = M_START.."مشکل فنی در ربات هلپر"..EndPm
							return tdbot.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
						end
					end
					tdbot.getInlineQueryResults(BotTiGeR_idapi, msg.from.id, 0, 0, "Menu:"..msg.to.id, 0, inline_query_cb, nil)
					tdbot.sendMessage(msg.to.id, msg.id, 0, M_START.."`پنل به خصوصی شما ارسال شد.`"..EndPm, 0, "md")
				end
			end
			if mr_roo[1]:lower() == "helppv" or mr_roo[1] == "راهنما خصوصی" then
				if not redis:get(RedisIndex..msg.from.id..'chkusermonshi') and not is_admin(msg) then
					tdbot.sendMessage(msg.chat_id, msg.id, 1, M_START.."`شما برای اجرای این دستور ابتدا باید خصوصی ربات پیام دهید.`"..EndPm, 1, 'md')
				else
					local function inline_query_cb(arg, data)
						if data.results and data.results[0] then
							redis:setex(RedisIndex.."ReqMenu:" .. msg.to.id .. ":" .. msg.from.id, 260, true) redis:setex(RedisIndex.."ReqMenu:" .. msg.to.id, 10, true) tdbot.sendInlineQueryResultMessage(msg.from.id, msg.id, 0, 1, data.inline_query_id, data.results[0].id, dl_cb, nil)
						else
							text = M_START.."مشکل فنی در ربات هلپر"..EndPm
							return tdbot.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
						end
					end
					tdbot.getInlineQueryResults(BotTiGeR_idapi, msg.from.id, 0, 0, "Help:"..msg.to.id, 0, inline_query_cb, nil)
					tdbot.sendMessage(msg.to.id, msg.id, 0, M_START.."`راهنما به خصوصی شما ارسال شد.`"..EndPm, 0, "md")
				end
			end
			if mr_roo[1]:lower() == "help" or mr_roo[1] == "راهنما" then
				local function inline_query_cb(arg, data)
					if data.results and data.results[0] then
						redis:setex(RedisIndex.."ReqMenu:" .. msg.to.id .. ":" .. msg.from.id, 260, true) redis:setex(RedisIndex.."ReqMenu:" .. msg.to.id, 10, true) tdbot.sendInlineQueryResultMessage(msg.to.id, msg.id, 0, 1, data.inline_query_id, data.results[0].id, dl_cb, nil)
					else
						text = "مشکل فنی در ربات هلپر"..EndPm
						return tdbot.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
					end
				end
				tdbot.getInlineQueryResults(BotTiGeR_idapi, msg.to.id, 0, 0, "Help:"..msg.to.id, 0, inline_query_cb, nil)
			end
			if mr_roo[1]:lower() == "paneladd" or mr_roo[1] == "پنل اد اجباری" then
				local function inline_query_cb(arg, data)
					if data.results and data.results[0] then
						redis:setex(RedisIndex.."ReqMenu:" .. msg.to.id .. ":" .. msg.from.id, 260, true) redis:setex(RedisIndex.."ReqMenu:" .. msg.to.id, 10, true) tdbot.sendInlineQueryResultMessage(msg.to.id, msg.id, 0, 1, data.inline_query_id, data.results[0].id, dl_cb, nil)
					else
						text = M_START.."مشکل فنی در ربات هلپر"..EndPm
						return tdbot.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
					end
				end
				tdbot.getInlineQueryResults(BotTiGeR_idapi, msg.to.id, 0, 0, "Addl:"..msg.to.id, 0, inline_query_cb, nil)
			end
			if mr_roo[1]:lower() == "paneladdpv" or mr_roo[1] == "پنل اد اجباری خصوصی" then
				if not redis:get(RedisIndex..msg.from.id..'chkusermonshi') and not is_sudo(msg) then
					tdbot.sendMessage(msg.chat_id, msg.id, 1, M_START.."`شما برای اجرای این دستور ابتدا باید خصوصی ربات پیام دهید.`"..EndPm, 1, 'md')
				else
					local function inline_query_cb(arg, data)
						if data.results and data.results[0] then
							redis:setex(RedisIndex.."ReqMenu:" .. msg.to.id .. ":" .. msg.from.id, 260, true) redis:setex(RedisIndex.."ReqMenu:" .. msg.to.id, 10, true) tdbot.sendInlineQueryResultMessage(msg.from.id, msg.id, 0, 1, data.inline_query_id, data.results[0].id, dl_cb, nil)
						else
							text = M_START.."مشکل فنی در ربات هلپر"..EndPm
							return tdbot.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
						end
					end
					tdbot.getInlineQueryResults(BotTiGeR_idapi, msg.from.id, 0, 0, "Addl:"..msg.to.id, 0, inline_query_cb, nil)
					tdbot.sendMessage(msg.to.id, msg.id, 0, M_START.."`پنل اد اجباری به خصوصی شما ارسال شد.`"..EndPm, 0, "md")
				end
			end
		end
	end
	if redis:get(RedisIndex.."lock_cmd"..msg.chat_id) and not is_mod(msg) then return false end
	if mr_roo[1]:lower() == "id" or mr_roo[1] == "ایدی" or mr_roo[1] == "آیدی" then
		if mr_roo[2] and is_mod(msg) then
			if msg.content.entities[0].type._ == "textEntityTypeMentionName" then
				local function idmen(arg, data)
					if data.id then
						local user_name = "پیدا نشد"
						if data.username and data.username ~= "" then user_name = '@'..check_markdown(data.username) end
						local print_name = data.first_name
						if data.last_name and data.last_name ~= "" then print_name = print_name..' '..data.last_name end
						text = M_START.."*نام :* "..check_markdown(print_name).."\n"..M_START.."*ایدی :* `"..data.id.."`"
						return tdbot.sendMessage(msg.to.id, "", 0, text, 0, "md")
					end
				end
				tdbot.getUser(msg.content.entities[0].type.user_id, idmen)
			else
				tdbot_function ({
				_ = "searchPublicChat",
				username = mr_roo[2]
				}, a_username_p, {chat_id=msg.to.id,username=mr_roo[2],cmd="id"})
			end
		end
	end
	if mr_roo[1]:lower() == 'info' or mr_roo[1] == 'اطلاعات' then
		if not mr_roo[2] and tonumber(msg.reply_to_message_id) ~= 0 then
			assert (tdbot_function ({
			_ = "getMessage",
			chat_id = msg.chat_id,
			message_id = msg.reply_to_message_id
			}, info_by_reply, {chat_id=msg.chat_id}))
		end
		if mr_roo[2] and string.match(mr_roo[2], '^%d+$') and tonumber(msg.reply_to_message_id) == 0 then
			assert (tdbot_function ({
			_ = "getUser",
			user_id = mr_roo[2],
			}, info_by_id, {chat_id=msg.chat_id,user_id=mr_roo[2],msgid=msg.id}))
		end
		if mr_roo[2] and not string.match(mr_roo[2], '^%d+$') and tonumber(msg.reply_to_message_id) == 0 then
			assert (tdbot_function ({
			_ = "searchPublicChat",
			username = mr_roo[2]
			}, info_by_username, {chat_id=msg.chat_id,username=mr_roo[2],msgid=msg.id}))
		end
		if not mr_roo[2] and tonumber(msg.reply_to_message_id) == 0 then
			local function info2_cb(arg, data)
				if tonumber(data.id) then
					if data.username then
						username = "@"..check_markdown(data.username)
					else
						username = ""
					end
					if data.first_name then
						firstname = check_markdown(data.first_name)
					else
						firstname = ""
					end
					if data.last_name then
						lastname = check_markdown(data.last_name)
					else
						lastname = "مقام"
					end
					local hash = 'rank:'..arg.chat_id..':variables'
					local text = M_START.."*نام :* `"..firstname.."`\n"..M_START.."*فامیلی :* `"..lastname.."`\n"..M_START.."*نام کاربری :* "..username.."\n"..M_START.."*آیدی :* `"..data.id.."`\n"
					if data.id == tonumber(Arashwm) then
						text = text..M_START..'*مقام :* `سازنده سورس`\n'
					elseif is_sudo1(data.id) then
						text = text..M_START..'*مقام :* `سودو ربات`\n'
					elseif is_admin1(data.id) then
						text = text..M_START..'*مقام :* `ادمین ربات`\n'
					elseif is_owner1(arg.chat_id, data.id) then
						text = text..M_START..'*مقام :* `سازنده گروه`\n'
					elseif is_mod1(arg.chat_id, data.id) then
						text = text..M_START..'*مقام :* `مدیر گروه`\n'
					else
						text = text..M_START..'*مقام :* `کاربر عادی`\n'
					end
					local user_info = {}
					local uhash = 'user:'..data.id
					local user = redis:hgetall(RedisIndex..uhash)
					local um_hash = 'msgs:'..data.id..':'..arg.chat_id
					user_info_msgs = tonumber(redis:get(RedisIndex..um_hash) or 0)
					text = text..M_START..'*پیام های گروه :* `'..gap_info_msgs..'`\n'
					text = text..M_START..'*پیام های کاربر :* `'..user_info_msgs..'`\n'
					text = text..M_START..'*درصد پیام کاربر :* `('..Percent..'%)`\n'
					text = text..M_START..'*وضعیت کاربر :* `'..UsStatus..'`\n'
					text = text..M_START..'*لقب کاربر :* `'..laghab..'`'
					tdbot.sendMessage(arg.chat_id, arg.msgid, 0, text, 0, "md")
				end
			end
			assert (tdbot_function ({
			_ = "getUser",
			user_id = msg.sender_user_id,
			}, info_by_id, {chat_id=msg.chat_id,user_id=msg.sender_user_id,msgid=msg.id}))
		end
	end
	if mr_roo[1]:lower() == 'nerkh' or mr_roo[1] == 'نرخ' then
		local hash = ('nerkh')
		local nerkh = redis:get(RedisIndex..hash)
		if not nerkh then
			return M_START..'`نرخی برای ربات ثبت نشده است`'..EndPm
		else
			tdbot.sendMessage(msg.chat_id, msg.id, 1, check_markdown(nerkh), 1, 'md')
		end
	end
	if mr_roo[1] == 'شماره کارت' then
		local hash = ('cart')
		local cart = redis:get(RedisIndex..hash)
		if not cart then
			return M_START..'`شماره کارتی برای ربات ثبت نشده است`'..EndPm
		else
			tdbot.sendMessage(msg.chat_id, msg.id, 1, check_markdown(cart), 1, 'md')
		end
	end
	if mr_roo[1]:lower() == 'mydel' or mr_roo[1] == 'پاکسازی پیام های من' then
		tdbot.deleteMessagesFromUser(msg.to.id,  msg.sender_user_id, dl_cb, nil)
		return M_START.."*پیام های کاربر :*\n[@"..check_markdown(msg.from.username or '').."*|*`"..msg.from.id.."`]\n *پاکسازی شد تتوسط خودش*"..EndPm
	end
	if mr_roo[1]:lower() == "rules" or mr_roo[1] == "قوانین"then
		if not redis:get(RedisIndex..msg.to.id..'rules') then
			rules = M_START.."`قوانین ثبت نشده است`"..EndPm
		else
			rules = M_START.."*قوانین گروه :*\n"..redis:get(RedisIndex..msg.to.id..'rules')
		end
		return rules
	end
end

return {
patterns = group_patterns, run = TiiGeRTeaM
}
