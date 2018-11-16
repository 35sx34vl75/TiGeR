local function TiiGeRTeaM(msg, mr_roo)
local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
local M_START = StartPm[math.random(#StartPm)]
if tonumber(msg.from.id) == Arashwm then
if ((mr_roo[1]:lower() == 'save') or (mr_roo[1] == "ذخیره پلاگین")) and mr_roo[2] then
	if not redis:get(RedisIndex..'AutoDownload:'..msg.to.id) then
		return M_START..'*دانلود خودکار در گروه شما فعال نمیباشد*'..EndPm..'\n*برای فعال سازی از دستور زیر استفاده کنید :*\n `"Setdow"` *&&* `"تنظیم دانلود"`'
	end
	if tonumber(msg.reply_to_message_id) ~= 0  then
		function get_filemsg(arg, data)
			function get_fileinfo(arg,data)
				if data.content._ == 'messageDocument' then
					fileid = data.content.document.document.id
					filename = data.content.document.file_name
					file_dl(document_id)
					sleep(1)
					if (filename:lower():match('.lua$')) then
						local pathf = tcpath..'/files/documents/'..filename
						if pl_exi(filename) then
							local pfile = 'plugins/'..mr_roo[2]..'.lua'
							os.rename(pathf, pfile)
							tdbot.sendMessage(msg.to.id, msg.id,1, M_START..'*پلاگین*\n`'..mr_roo[2]..'`\n*در ربات ذخیره شد.*'..EndPm, 1, 'md')
						else
							tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'*فایل مورد نظر را دوباره ارسال کنید*'..EndPm, 1, 'md')
						end
					else
						tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'*فایل پلاگین نمیباشد*'..EndPm, 1, 'md')
					end
				else
					return
				end
			end
			tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = data.id }, get_fileinfo, nil)
		end
		tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = msg.reply_to_message_id }, get_filemsg, nil)
	end
end
if ((mr_roo[1]:lower() == "sendfile") or (mr_roo[1] == "ارسال فایل")) and mr_roo[2] and mr_roo[3] then
	local send_file = "./"..mr_roo[2].."/"..mr_roo[3]
	tdbot.sendDocument(msg.to.id, send_file, M_START..""..channel_username..""..EndPm, nil, msg.id, 0, 1, nil, dl_cb, nil)
end
if ((mr_roo[1]:lower() == "sendplug") or (mr_roo[1] == "ارسال پلاگین")) and mr_roo[2] then
	local plug = "./plugins/"..mr_roo[2]..".lua"
	tdbot.sendDocument(msg.to.id, plug, M_START..""..channel_username..""..EndPm, nil, msg.id, 0, 1, nil, dl_cb, nil)
end
end
if is_sudo(msg)then
if msg.to.type == 'channel' or msg.to.type == 'chat' then
if ((mr_roo[1]:lower() == 'charge') or (mr_roo[1] == "شارژ")) and mr_roo[2] and not mr_roo[3] then
	local linkgp = redis:get(RedisIndex..msg.to.id..'linkgpset')
	if not linkgp then
		return M_START..'`لطفا قبل از شارژ گروه لینک گروه را تنظیم کنید`'..EndPm..'\n*"تنظیم لینک"\n"setlink"*'
	end
	local mods = redis:smembers(RedisIndex..'Mods:'..msg.to.id)
	local owners = redis:smembers(RedisIndex..'Owners:'..msg.to.id)
	if #owners == 0 then
		return M_START..'`لطفا قبل از شارژ گروه مالک گروه را تنظیم کنید`\n_یا میتوانید از دستور زیر استفاده کنید_'..EndPm..'\n*"Config"*\n*"پیکربندی"*'
	end
	message = '\n'
	for k,v in pairs(owners) do
	local user_name = redis:get(RedisIndex..'user_name:'..v) or "---"
		message = message ..k.. '- '..check_markdown(user_name)..' [' ..v.. '] \n'
	end
	if #mods == 0 then
		return M_START..'`لطفا قبل از شارژ گروه مدیر گروه را تنظیم کنید`\n_یا میتوانید از دستور زیر استفاده کنید_'..EndPm..'\n*"Config"*\n*"پیکربندی"*'
	end
	message2 = '\n'
	for k,v in pairs(mods) do
	local user_name = redis:get(RedisIndex..'user_name:'..v) or "---"
		message2 = message2 ..k.. '- '..check_markdown(user_name)..' [' ..v.. '] \n'
	end
	if tonumber(mr_roo[2]) > 0 and tonumber(mr_roo[2]) < 1001 then
		local extime = (tonumber(mr_roo[2]) * 86400)
		redis:setex(RedisIndex..'ExpireDate:'..msg.to.id, extime, true)
		print(''..extime..'')
		if not redis:get(RedisIndex..'CheckExpire::'..msg.to.id) then
			redis:set(RedisIndex..'CheckExpire::'..msg.to.id)
		end
		tdbot.sendMessage(gp_sudo, msg.id, 1, "*♨️ گزارش \nگروهی به لیست گروه ای مدیریتی ربات اضافه شد ➕*\n\n🔺 *مشخصات شخص اضافه کننده :*\n\n_>نام ؛_ "..check_markdown(msg.from.first_name or "").."\n_>نام کاربری ؛_ @"..check_markdown(msg.from.username or "").."\n_>شناسه کاربری ؛_ `"..msg.from.id.."`\n\n🔺 *مشخصات گروه اضافه شده :*\n\n_>نام گروه ؛_ "..check_markdown(msg.to.title).."\n_>شناسه گروه ؛_ `"..msg.to.id.."`\n>_مقدار شارژ انجام داده ؛_ `"..mr_roo[2].."`\n_>لینک گروه ؛_\n"..check_markdown(linkgp).."\n_>لیست مالک گروه ؛_ "..message.."\n_>لیست مدیران گروه؛_ "..message2.."\n\n🔺* دستور های پیشفرض برای گروه :*\n\n_برای وارد شدن به گروه ؛_\n/join `"..msg.to.id.."`\n_حذف گروه از گروه های ربات ؛_\n/rem `"..msg.to.id.."`\n_خارج شدن ربات از گروه ؛_\n/leave `"..msg.to.id.."`", 1, 'md')
		tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'`گروه به مدت` *'..mr_roo[2]..'* `روز شارژ شد.`'..EndPm, 1, 'md')
	else
		tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'*تعداد روزها باید عددی از 1 تا 1000 باشد.*'..EndPm, 1, 'md')
	end
end
end
if mr_roo[1]:lower() == 'time sv' or mr_roo[1] == 'ساعت سرور' then
tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'`ساعت سرور :`\n'..os.date("%H:%M:%S")..''..EndPm, 1, 'md')
end
if mr_roo[1]:lower() == 'setnerkh' or mr_roo[1] == 'تنظیم نرخ' then
	redis:set(RedisIndex..'nerkh',mr_roo[2])
	return M_START..'`متن شما با موفقیت تنظیم شد :`\n\n '..check_markdown(mr_roo[2])..''
end
if mr_roo[1] == 'تنظیم کارت'  then
	redis:set(RedisIndex..'cart',mr_roo[2])
	return M_START..'`شماره کارت شما با موفقیت تنظیم شد :`\n\n '..check_markdown(mr_roo[2])..''
end
if mr_roo[1] == 'حذف شماره کارت' then
	local hash = ('cart')
	redis:del(RedisIndex..hash)
	return M_START..'`نرخ ربات پاک شد`'..EndPm
end
if mr_roo[1]:lower() == "setmonshi" or mr_roo[1] == "تنظیم منشی" then
	local pm = mr_roo[2]
	redis:set(RedisIndex..'bot:pm',pm)
	return M_START..'`متن منشی با موفقیت ثبت شد.`\n\n>>>  '..check_markdown(pm)..''
end
if (mr_roo[1]:lower() == "monshi" or mr_roo[1] == "منشی") and not mr_roo[2]  then
	local hash = ('bot:pm')
	local pm = redis:get(RedisIndex..hash)
	if not pm then
		return M_START..'`متن منشی ثبت نشده است.`'..EndPm
	else
		return tdbot.sendMessage(msg.chat_id, 0, 1, "*پیغام کنونی منشی :*\n\n"..check_markdown(pm), 0, 'md')
	end
end
if mr_roo[1]:lower() == "monshi" or mr_roo[1] == "منشی" then
	if mr_roo[2]=="on" or mr_roo[2]=="فعال" then
		redis:set(RedisIndex.."bot:pm", M_START.."`سلام من یک اکانت هوشمند هستم.`"..EndPm )
		return M_START.."`منشی فعال شد لطفا دوباره پیغام را تنظیم کنید`" ..EndPm
	end
	if mr_roo[2]=="off" or mr_roo[2]=="غیرفعال" then
		redis:del(RedisIndex.."bot:pm")
		return M_START.."`منشی غیرفعال شد`" ..EndPm
	end
end
if mr_roo[1]:lower() == "joinch" or mr_roo[1] == "عضویت اجباری" then
if mr_roo[2] == "on" or mr_roo[2] == "فعال" then
redis:del(RedisIndex.."JoinEnabel"..msg.chat_id)
return M_START.."`جوین اجباری در این گروه` #فعال `شد.`"..EndPm
elseif mr_roo[2] == "off" or mr_roo[2] == "غیرفعال" then
redis:set(RedisIndex.."JoinEnabel"..msg.chat_id, true)
return M_START.."`جوین اجباری در این گروه` #غیرفعال `شد.`"..EndPm
end
end
if (mr_roo[1]:lower() == 'add' or mr_roo[1] == "نصب گروه") and not redis:get(RedisIndex..'ExpireDate:'..msg.to.id) then
	redis:set(RedisIndex..'ExpireDate:'..msg.to.id,true)
	redis:setex(RedisIndex..'ExpireDate:'..msg.to.id, 180, true)
	if not redis:get(RedisIndex..'CheckExpire::'..msg.to.id) then
		redis:set(RedisIndex..'CheckExpire::'..msg.to.id,true)
	end
end
if matches[1]:lower() == "testspeed" or matches[1] == "سرعت سرور" then
	local io = io.popen("speedtest --share"):read("*all")
	link = io:match("http://www.speedtest.net/result/%d+.png")
	local file = download_to_file(link,'speed.png')
	tdbot.sendPhoto(msg.to.id, msg.id, file, 0, {}, 0, 0, M_START..""..channel_username..""..EndPm, 0, 0, 1, nil, dl_cb, nil)
end
if mr_roo[1]:lower() == 'rem' or mr_roo[1] == "حذف گروه" then
	if redis:get(RedisIndex..'CheckExpire::'..msg.to.id) then
		redis:del(RedisIndex..'CheckExpire::'..msg.to.id)
	end
	redis:del(RedisIndex..'ExpireDate:'..msg.to.id)
end
if mr_roo[1]:lower() == 'gid' or mr_roo[1] == "آیدی گروه"  then
	tdbot.sendMessage(msg.to.id, msg.id, 1, '`'..msg.to.id..'`', 1,'md')
end
if mr_roo[1]:lower() == "panelsudo" or mr_roo[1] == "پنل سودو"  then
	local function inline_query_cb(arg, data)
		if data.results and data.results[0] then
			redis:setex(RedisIndex.."ReqMenu:" .. msg.to.id .. ":" .. msg.from.id, 260, true) redis:setex(RedisIndex.."ReqMenu:" .. msg.to.id, 10, true) tdbot.sendInlineQueryResultMessage(msg.to.id, msg.id, 0, 1, data.inline_query_id, data.results[0].id, dl_cb, nil)
		else
			text = M_START.."مشکل فنی در ربات هلپر"..EndPm
			return tdbot.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
		end
	end
	tdbot.getInlineQueryResults(BotTiGeR_idapi, msg.to.id, 0, 0, "Sudo:"..msg.to.id, 0, inline_query_cb, nil)
end
if (mr_roo[1]:lower() == 'leave' or mr_roo[1] == "خروج") and mr_roo[2]  then
	tdbot.sendMessage(mr_roo[2], 0, 1, M_START..'ربات با دستور سودو از گروه خارج شد.\nبرای اطلاعات بیشتر با سودو تماس بگیرید.'..EndPm..'\n`سودو ربات :` '..check_markdown(sudo_username), 1, 'md')
	tdbot.changeChatMemberStatus(mr_roo[2], our_id, 'Left', dl_cb, nil)
	tdbot.sendMessage(gp_sudo, msg.id, 1, M_START..'ربات با موفقیت از گروه '..mr_roo[2]..' خارج شد.'..EndPm..'\nتوسط : @'..check_markdown(msg.from.username or '')..' | `'..msg.from.id..'`', 1,'md')
end
if (mr_roo[1]:lower() == 'charge' or mr_roo[1] == "شارژ") and mr_roo[2] and mr_roo[3] then
	if string.match(mr_roo[2], '^-%d+$') then
		if tonumber(mr_roo[3]) > 0 and tonumber(mr_roo[3]) < 1001 then
			local extime = (tonumber(mr_roo[3]) * 86400)
			redis:setex(RedisIndex..'ExpireDate:'..mr_roo[2], extime, true)
			if not redis:get(RedisIndex..'CheckExpire::'..msg.to.id) then
				redis:set(RedisIndex..'CheckExpire::'..msg.to.id,true)
			end
			tdbot.sendMessage(gp_sudo, 0, 1, "*♨️ گزارش \nگروهی به لیست گروه ای مدیریتی ربات اضافه شد ➕*\n\n🔺 *مشخصات شخص اضافه کننده :*\n\n_>نام ؛_ "..check_markdown(msg.from.first_name or "").."\n_>نام کاربری ؛_ @"..check_markdown(msg.from.username or "").."\n_>شناسه کاربری ؛_ `"..msg.from.id.."`\n\n🔺 *مشخصات گروه اضافه شده :*\n\n_>نام گروه ؛_ "..check_markdown(msg.to.title).."\n_>شناسه گروه ؛_ `"..mr_roo[2].."`\n>_مقدار شارژ انجام داده ؛_ `"..mr_roo[3].."`\n🔺* دستور های پیشفرض برای گروه :*\n\n_برای وارد شدن به گروه ؛_\n/join `"..mr_roo[2].."`\n_حذف گروه از گروه های ربات ؛_\n/rem `"..mr_roo[2].."`\n_خارج شدن ربات از گروه ؛_\n/leave `"..mr_roo[2].."`", 1, 'md')
			tdbot.sendMessage(mr_roo[2], 0, 1, M_START..'ربات توسط ادمین به مدت `'..mr_roo[3]..'` روز شارژ شد\nبرای مشاهده زمان شارژ گروه دستور /expire استفاده کنید...'..EndPm,1 , 'md')
		else
			tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'*تعداد روزها باید عددی از 1 تا 1000 باشد.*'..EndPm, 1, 'md')
		end
	end
end
if mr_roo[1]:lower() == 'full' or mr_roo[1] == 'نامحدود' then
	local linkgp = redis:get(RedisIndex..msg.to.id..'linkgpset')
	if not linkgp then
		return M_START..'`لطفا قبل از شارژ گروه لینک گروه را تنظیم کنید`'..EndPm..'\n*"تنظیم لینک"\n"setlink"*'
	end
	local mods = redis:smembers(RedisIndex..'Mods:'..msg.to.id)
	local owners = redis:smembers(RedisIndex..'Owners:'..msg.to.id)
	if #owners == 0 then
		return M_START..'`لطفا قبل از شارژ گروه مالک گروه را تنظیم کنید`\n_یا میتوانید از دستور زیر استفاده کنید_'..EndPm..'\n*"Config"*\n*"پیکربندی"*'
	end
	message = '\n'
	for k,v in pairs(owners) do
	local user_name = redis:get(RedisIndex..'user_name:'..v) or "---"
		message = message ..k.. '- '..check_markdown(user_name)..' [' ..v.. '] \n'
	end
	if #mods == 0 then
		return M_START..'`لطفا قبل از شارژ گروه مدیر گروه را تنظیم کنید`\n_یا میتوانید از دستور زیر استفاده کنید_'..EndPm..'\n*"Config"*\n*"پیکربندی"*'
	end
	message2 = '\n'
	for k,v in pairs(mods) do
	local user_name = redis:get(RedisIndex..'user_name:'..v) or "---"
		message2 = message2 ..k.. '- '..check_markdown(user_name)..' [' ..v.. '] \n'
	end
	redis:set(RedisIndex..'ExpireDate:'..msg.to.id,true)
	if not redis:get(RedisIndex..'CheckExpire::'..msg.to.id) then
		redis:set(RedisIndex..'CheckExpire::'..msg.to.id,true)
	end
	tdbot.sendMessage(gp_sudo, msg.id, 1, "*♨️ گزارش \nگروهی به لیست گروه ای مدیریتی ربات اضافه شد ➕*\n\n🔺 *مشخصات شخص اضافه کننده :*\n\n_>نام ؛_ "..check_markdown(msg.from.first_name or "").."\n_>نام کاربری ؛_ @"..check_markdown(msg.from.username or "").."\n_>شناسه کاربری ؛_ `"..msg.from.id.."`\n\n🔺 *مشخصات گروه اضافه شده :*\n\n_>نام گروه ؛_ "..check_markdown(msg.to.title).."\n_>شناسه گروه ؛_ `"..msg.to.id.."`\n>_مقدار شارژ انجام داده ؛_ `نامحدود !`\n_>لینک گروه ؛_\n"..check_markdown(linkgp).."\n_>لیست مالک گروه ؛_ "..message.."\n_>لیست مدیران گروه؛_ "..message2.."\n\n🔺* دستور های پیشفرض برای گروه :*\n\n_برای وارد شدن به گروه ؛_\n/join `"..msg.to.id.."`\n_حذف گروه از گروه های ربات ؛_\n/rem `"..msg.to.id.."`\n_خارج شدن ربات از گروه ؛_\n/leave `"..msg.to.id.."`", 1, 'md')
	tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'`ربات بدون محدودیت فعال شد !` *( نامحدود )*'..EndPm, 1, 'md')
end
if (mr_roo[1]:lower() == 'jointo' or mr_roo[1] == "ورود به") and mr_roo[2] then
	if string.match(mr_roo[2], '^-%d+$') then
		tdbot.sendMessage(SUDO, msg.id, 1, M_START..'با موفقیت تورو به گروه '..mr_roo[2]..' اضافه کردم.'..EndPm, 1, 'md')
		tdbot.addChatMember(mr_roo[2], SUDO, 0, dl_cb, nil)
		tdbot.sendMessage(mr_roo[2], 0, 1, M_START..'*سودو به گروه اضافه شد.*'..EndPm..'\n`سودو ربات :` '..check_markdown(sudo_username), 1, 'md')
	end
end
if mr_roo[1]:lower() == 'setbotname' or mr_roo[1] == "تغییر نام ربات" then
	tdbot.changeName(mr_roo[2], dl_cb, nil)
	return M_START..'`اسم ربات تغییر کرد به :`\n*'..mr_roo[2]..'*'..EndPm
end
if mr_roo[1]:lower() == 'setbotusername' or mr_roo[1] == "تغییر یوزرنیم ربات" then
	tdbot.changeUsername(mr_roo[2], dl_cb, nil)
	return M_START..'`یوزرنیم ربات تغییر کرد به :` \n@'..check_markdown(mr_roo[2])..''..EndPm
end
if mr_roo[1]:lower() == 'delbotusername' or mr_roo[1] == "حذف یوزرنیم ربات" then
	tdbot.changeUsername('', dl_cb, nil)
	return M_START..'*انجام شد*'..EndPm
end
if mr_roo[1]:lower() == 'markread' or mr_roo[1] == "تیک دوم" then
if mr_roo[2]:lower() == 'on' or mr_roo[2] == "فعال" then
	redis:set(RedisIndex..'markread','on')
	return M_START..'`تیک دوم` *روشن*'..EndPm
end
if mr_roo[2]:lower() == 'off' or mr_roo[2] == "غیرفعال" then
	redis:del(RedisIndex..'markread')
	return M_START..'`تیک دوم` *خاموش*'..EndPm
end
end
if mr_roo[1]:lower() == 'broadcast' or mr_roo[1] == "ارسال به همه" then
	local data = load_data(_config.moderation.data)
	local bc = mr_roo[2]
	for k,v in pairs(data) do
		tdbot.sendMessage(k, "", 0, bc, 0,  "html")
	end
end
if mr_roo[1]:lower() == 'sudolist' or mr_roo[1] == "لیست سودو" then
	return sudolist(msg)
end
if mr_roo[1]:lower() == 'codegift' or mr_roo[1] == 'کدهدیه' then
	local code = {'1','2','3','4','5','6','7','8','9','a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'}
	local charge = {2,5,8,10,11,14,16,18,20}
	local a = code[math.random(#code)]
	local b = code[math.random(#code)]
	local c = code[math.random(#code)]
	local d = code[math.random(#code)]
	local e = code[math.random(#code)]
	local f = code[math.random(#code)]
	local chargetext = charge[math.random(#charge)]
	local codetext = "TiiGeR-"..a..b..c..d..e..f.."-TeaM"
	redis:sadd(RedisIndex.."CodeGift:", codetext)
	redis:hset(RedisIndex.."CodeGiftt:", codetext , chargetext)
	redis:setex(RedisIndex.."CodeGiftCharge:"..codetext,chargetext * 86400,true)
	local text = M_START.."`کد با موفقیت ساخته شد.\nکد :`\n*"..codetext.."*\n`دارای` *"..chargetext.."* `روز شارژ میباشد .`"..EndPm
	local text2 = M_START.."`کدهدیه جدید ساخته شد.`\n`¤ این کدهدیه دارای` *"..chargetext.."* `روز شارژ میباشد !`\n`¤ طرز استفاده :`\n`¤ ابتدا دستور 'gift' راوارد نماید سپس کدهدیه را وارد کنید :`\n*"..codetext.."*\n`رو در گروه خود ارسال کند ,` *"..chargetext.."* `روز شارژ به گروه آن اضافه میشود !`\n`¤¤¤ توجه فقط یک نفر میتواند از این کد استفاده کند !`"..EndPm
	tdbot.sendMessage(msg.chat_id, msg.id, 1, text, 1, 'md')
	tdbot.sendMessage(gp_sudo, msg.id, 1, text2, 1, 'md')
end
if mr_roo[1]:lower() == 'giftlist' or mr_roo[1] == 'لیست کدهدیه' then
	local list = redis:smembers(RedisIndex.."CodeGift:")
	local text = '*💢 لیست کد هدیه های ساخته شده :*\n'
	for k,v in pairs(list) do
		local expire = redis:ttl(RedisIndex.."CodeGiftCharge:"..v)
		if expire == -1 then
			EXPIRE = "نامحدود"
		else
			local d = math.floor(expire / 86400 ) + 1
			EXPIRE = d..""
		end
		text = text..k.."- `• کدهدیه :`\n[ *"..v.."* ]\n`• شارژ :`\n*"..EXPIRE.."*\n\n❦❧❦❧❦❧❦❧❦❧\n"
	end
	if #list == 0 then
	text = M_START..'`هیچ کد هدیه , ساخته نشده است`'..EndPm
	end
	tdbot.sendMessage(msg.chat_id, msg.id, 1, text, 1, 'md')
end
end
if is_admin(msg) then
if mr_roo[1]:lower() == "setrank" then
	if msg.reply_id then
		assert (tdbot_function ({
		_ = "getMessage",
		chat_id = msg.to.id,
		message_id = msg.reply_id
		}, rank_reply, {chat_id=msg.to.id,cmd="setrank",rank=string.sub(msg.text,9)}))
	elseif mr_roo[3] and string.match(mr_roo[3], '^%d+$') then
		assert (tdbot_function ({
		_ = "getUser",
		user_id = mr_roo[3],
		}, rank_id, {chat_id=msg.to.id,user_id=mr_roo[3],cmd="setrank",rank=mr_roo[2]}))
	elseif mr_roo[3] and not string.match(mr_roo[3], '^%d+$') then
		assert (tdbot_function ({
		_ = "searchPublicChat",
		username = mr_roo[3]
		}, rank_username, {chat_id=msg.to.id,username=mr_roo[3],cmd="setrank",rank=mr_roo[2]}))
	end
end
if mr_roo[1] == "تنظیم مقام" then
	if msg.reply_id then
		assert (tdbot_function ({
		_ = "getMessage",
		chat_id = msg.to.id,
		message_id = msg.reply_id
		}, rank_reply, {chat_id=msg.to.id,cmd="setrank",rank=string.sub(msg.text,21)}))
	elseif mr_roo[3] and string.match(mr_roo[3], '^%d+$') then
		assert (tdbot_function ({
		_ = "getUser",
		user_id = mr_roo[3],
		}, rank_id, {chat_id=msg.to.id,user_id=mr_roo[3],cmd="setrank",rank=mr_roo[2]}))
	elseif mr_roo[3] and not string.match(mr_roo[3], '^%d+$') then
		assert (tdbot_function ({
		_ = "searchPublicChat",
		username = mr_roo[3]
		}, rank_username, {chat_id=msg.to.id,username=mr_roo[3],cmd="setrank",rank=mr_roo[2]}))
	end
end
if mr_roo[1] == "حذف مقام" or mr_roo[1]:lower() == "remrank" then
	if msg.reply_id then
		assert (tdbot_function ({
		_ = "getMessage",
		chat_id = msg.to.id,
		message_id = msg.reply_id
		}, rank_reply, {chat_id=msg.to.id,cmd="delrank"}))
	elseif mr_roo[2] and string.match(mr_roo[2], '^%d+$') then
		assert (tdbot_function ({
		_ = "getUser",
		user_id = mr_roo[2],
		}, rank_id, {chat_id=msg.to.id,user_id=mr_roo[2],cmd="delrank"}))
	elseif mr_roo[2] and not string.match(mr_roo[2], '^%d+$') then
		assert (tdbot_function ({
		_ = "searchPublicChat",
		username = mr_roo[2]
		}, rank_username, {chat_id=msg.to.id,username=mr_roo[2],cmd="delrank"}))
	end
end
if mr_roo[1]:lower() == "config" or mr_roo[1] == "پیکربندی" then
	return set_config(msg)
end
if mr_roo[1]:lower() == 'creategroup' or mr_roo[1] == "ساخت گروه" then
	local text = mr_roo[2]
	tdbot.createNewGroupChat({[0] = msg.from.id}, text, dl_cb, nil)
	return M_START..'`گروه ساخته شد`'..EndPm
end
if mr_roo[1]:lower() == 'createsuper' or mr_roo[1] == "ساخت سوپرگروه" then
local text = mr_roo[2]
tdbot.createNewChannelChat(text, 1, '@TiiGeRTeaM', (function(b, d) tdbot.addChatMember(d.id, msg.from.id, 0, dl_cb, nil) end), nil)
	return M_START..'*سوپرگروه ساخته شد و* [`'..msg.from.id..'`] *به گروه اضافه شد.*'..EndPm
end
if mr_roo[1]:lower() == 'tosuper' or mr_roo[1] == "تبدیل به سوپرگروه" then
	local id = msg.to.id
	tdbot.migrateGroupChatToChannelChat(id, dl_cb, nil)
	return M_START..'`گروه به سوپر گروه تبدیل شد`'..EndPm
end
if mr_roo[1]:lower() == 'import' or mr_roo[1] == "ورود لینک" then
	if mr_roo[2]:match("^([https?://w]*.?telegram.me/joinchat/.*)$") or mr_roo[2]:match("^([https?://w]*.?t.me/joinchat/.*)$") then
		local link = mr_roo[2]
		if link:match('t.me') then
			link = string.gsub(link, 't.me', 'telegram.me')
		end
		tdbot.importChatInviteLink(link, dl_cb, nil)
		return M_START..'*انجام شد*'..EndPm
	end
end
if mr_roo[1]:lower() == 'bc' or mr_roo[1] == "ارسال" then
	local text = mr_roo[2]
	tdbot.sendMessage(mr_roo[3], "", 0, text, 0,  "html")
end
if mr_roo[1]:lower() == 'chats' or mr_roo[1] == "لیست گروه ها" then
	return chat_list(msg)
end
if (mr_roo[1]:lower() == 'join' or mr_roo[1] == "ورود") and mr_roo[2] then
	tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'*شما وارد گروه * '..mr_roo[2]..' *شدید*'..EndPm, 1, 'md')
	tdbot.sendMessage(mr_roo[2], 0, 1, M_START.."*سودو ربات وارد گروه شد*"..EndPm, 1, 'md')
	tdbot.addChatMember(mr_roo[2], msg.from.id, 0, dl_cb, nil)
end
if (mr_roo[1]:lower() == 'rem' or mr_roo[1] == "حذف گروه") and mr_roo[2] then
	redis:srem(RedisIndex.."Group" ,mr_roo[2])
	redis:del(RedisIndex.."Gpnameset"..mr_roo[2])
	redis:del(RedisIndex.."CheckBot:"..mr_roo[2])
	redis:del(RedisIndex.."Whitelist:"..mr_roo[2])
	redis:del(RedisIndex.."Banned:"..mr_roo[2])
	redis:del(RedisIndex.."Owners:"..mr_roo[2])
	redis:del(RedisIndex.."Mods:"..mr_roo[2])
	redis:del(RedisIndex..'filterlist:'..mr_roo[2])
	redis:del(RedisIndex..mr_roo[2]..'rules')
	redis:del(RedisIndex..'setwelcome:'..mr_roo[2])
	redis:del(RedisIndex..'lock_link:'..mr_roo[2])
	redis:del(RedisIndex..'lock_join:'..mr_roo[2])
	redis:del(RedisIndex..'lock_tag:'..mr_roo[2])
	redis:del(RedisIndex..'lock_username:'..mr_roo[2])
	redis:del(RedisIndex..'lock_pin:'..mr_roo[2])
	redis:del(RedisIndex..'lock_arabic:'..mr_roo[2])
	redis:del(RedisIndex..'lock_mention:'..mr_roo[2])
	redis:del(RedisIndex..'lock_edit:'..mr_roo[2])
	redis:del(RedisIndex..'lock_spam:'..mr_roo[2])
	redis:del(RedisIndex..'lock_flood:'..mr_roo[2])
	redis:del(RedisIndex..'lock_markdown:'..mr_roo[2])
	redis:del(RedisIndex..'lock_webpage:'..mr_roo[2])
	redis:del(RedisIndex..'welcome:'..mr_roo[2])
	redis:del(RedisIndex..'views:'..mr_roo[2])
	redis:del(RedisIndex..'lock_bots:'..mr_roo[2])
	redis:del(RedisIndex..'mute_all:'..mr_roo[2])
	redis:del(RedisIndex..'mute_gif:'..mr_roo[2])
	redis:del(RedisIndex..'mute_photo:'..mr_roo[2])
	redis:del(RedisIndex..'mute_sticker:'..mr_roo[2])
	redis:del(RedisIndex..'mute_contact:'..mr_roo[2])
	redis:del(RedisIndex..'mute_inline:'..mr_roo[2])
	redis:del(RedisIndex..'mute_game:'..mr_roo[2])
	redis:del(RedisIndex..'mute_text:'..mr_roo[2])
	redis:del(RedisIndex..'mute_keyboard:'..mr_roo[2])
	redis:del(RedisIndex..'mute_forward:'..mr_roo[2])
	redis:del(RedisIndex..'mute_location:'..mr_roo[2])
	redis:del(RedisIndex..'mute_document:'..mr_roo[2])
	redis:del(RedisIndex..'mute_voice:'..mr_roo[2])
	redis:del(RedisIndex..'mute_audio:'..mr_roo[2])
	redis:del(RedisIndex..'mute_video:'..mr_roo[2])
	redis:del(RedisIndex..'mute_video_note:'..mr_roo[2])
	redis:del(RedisIndex..'mute_tgservice:'..mr_roo[2])
	return M_START..'*گروه* `'..mr_roo[2]..'` *از گروه های مدیریتی ربات حذف شد.*'..EndPm
end
if mr_roo[1]:lower() == 'adminlist' or mr_roo[1] == "لیست ادمین" then
	return adminlist(msg)
end
if (mr_roo[1]:lower() == 'leave' or mr_roo[1] == "خروج") and not mr_roo[2] then
	tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'`ربات با موفقیت از گروه خارج شد.`'..EndPm, 1,'md')
	tdbot.changeChatMemberStatus(msg.to.id, our_id, 'Left', dl_cb, nil)
end
if mr_roo[1]:lower() == 'autoleave' or mr_roo[1] == "خروج خودکار" then
	local hash = 'auto_leave_bot'
	if mr_roo[2]:lower() == 'enable' or mr_roo[2] == "فعال" then
		redis:del(RedisIndex..hash)
		return M_START..'*خروج خودکار فعال شد*'..EndPm
	elseif mr_roo[2]:lower() == 'disable' or mr_roo[2] == "غیرفعال" then
		redis:set(RedisIndex..hash, true)
		return M_START..'*خروج خودکار غیرفعال شد*'..EndPm
	end
end
if mr_roo[1]:lower() == 'panelgp' or mr_roo[1] == 'پنل گروه' then
	local function inline_query_cb(arg, data)
		if data.results and data.results[0] then
			redis:setex(RedisIndex.."ReqMenu:" .. msg.to.id .. ":" .. msg.from.id, 260, true) redis:setex(RedisIndex.."ReqMenu:" .. msg.to.id, 10, true) tdbot.sendInlineQueryResultMessage(msg.to.id, msg.id, 0, 1, data.inline_query_id, data.results[0].id, dl_cb, nil)
		else
			text = M_START.."مشکل فنی در ربات هلپر"..EndPm
			return tdbot.sendMessage(msg.to.id, msg.id, 0, text, 0, "md")
		end
	end
	tdbot.getInlineQueryResults(BotTiGeR_idapi, msg.to.id, 0, 0, "Menu:"..mr_roo[2], 0, inline_query_cb, nil)
end
end
if is_JoinChannel(msg) then
if is_mod(msg) then
if msg.to.type == 'channel' or msg.to.type == 'chat' then
if (mr_roo[1]:lower() == 'expire' or mr_roo[1] == "اعتبار") and not mr_roo[2] then
	local check_time = redis:ttl(RedisIndex..'ExpireDate:'..msg.to.id)
	year = math.floor(check_time / 31536000)
	byear = check_time % 31536000
	month = math.floor(byear / 2592000)
	bmonth = byear % 2592000
	day = math.floor(bmonth / 86400)
	bday = bmonth % 86400
	hours = math.floor( bday / 3600)
	bhours = bday % 3600
	min = math.floor(bhours / 60)
	sec = math.floor(bhours % 60)
	if check_time == -1 then
		remained_expire = M_START..'`گروه به صورت نامحدود شارژ میباشد!`'..EndPm
	elseif tonumber(check_time) > 1 and check_time < 60 then
		remained_expire = M_START..'`گروه به مدت` *'..sec..'* `ثانیه شارژ میباشد`'..EndPm
	elseif tonumber(check_time) > 60 and check_time < 3600 then
		remained_expire = M_START..'`گروه به مدت` *'..min..'* `دقیقه و` *'..sec..'* _ثانیه شارژ میباشد`'..EndPm
	elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
		remained_expire = M_START..'`گروه به مدت` *'..hours..'* `ساعت و` *'..min..'* `دقیقه و` *'..sec..'* `ثانیه شارژ میباشد`'..EndPm
	elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
		remained_expire = M_START..'`گروه به مدت` *'..day..'* `روز و` *'..hours..'* `ساعت و` *'..min..'* `دقیقه و` *'..sec..'* `ثانیه شارژ میباشد`'..EndPm
	elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
		remained_expire = M_START..'`گروه به مدت` *'..month..'* `ماه` *'..day..'* `روز و` *'..hours..'* `ساعت و` *'..min..'* `دقیقه و` *'..sec..'* `ثانیه شارژ میباشد`'..EndPm
	elseif tonumber(check_time) > 31536000 then
		remained_expire = M_START..'`گروه به مدت` *'..year..'* `سال` *'..month..'* `ماه` *'..day..'* `روز و` *'..hours..'* `ساعت و` *'..min..'* `دقیقه و` *'..sec..'* `ثانیه شارژ میباشد`'..EndPm
	end
	tdbot.sendMessage(msg.to.id, msg.id, 1, remained_expire, 1, 'md')
end
end
if (mr_roo[1]:lower() == 'expire' or mr_roo[1] == "اعتبار") and mr_roo[2]  then
	if string.match(mr_roo[2], '^-%d+$') then
		local check_time = redis:ttl(RedisIndex..'ExpireDate:'..mr_roo[2])
		year = math.floor(check_time / 31536000)
		byear = check_time % 31536000
		month = math.floor(byear / 2592000)
		bmonth = byear % 2592000
		day = math.floor(bmonth / 86400)
		bday = bmonth % 86400
		hours = math.floor( bday / 3600)
		bhours = bday % 3600
		min = math.floor(bhours / 60)
		sec = math.floor(bhours % 60)
		if check_time == -1 then
			remained_expire = M_START..'`گروه به صورت نامحدود شارژ میباشد!`'..EndPm
		elseif tonumber(check_time) > 1 and check_time < 60 then
			remained_expire = M_START..'`گروه به مدت` *'..sec..'* `ثانیه شارژ میباشد`'..EndPm
		elseif tonumber(check_time) > 60 and check_time < 3600 then
			remained_expire = M_START..'`گروه به مدت` *'..min..'* `دقیقه و` *'..sec..'* _ثانیه شارژ میباشد`'..EndPm
		elseif tonumber(check_time) > 3600 and tonumber(check_time) < 86400 then
			remained_expire = M_START..'`گروه به مدت` *'..hours..'* `ساعت و` *'..min..'* `دقیقه و` *'..sec..'* `ثانیه شارژ میباشد`'..EndPm
		elseif tonumber(check_time) > 86400 and tonumber(check_time) < 2592000 then
			remained_expire = M_START..'`گروه به مدت` *'..day..'* `روز و` *'..hours..'* `ساعت و` *'..min..'* `دقیقه و` *'..sec..'* `ثانیه شارژ میباشد`'..EndPm
		elseif tonumber(check_time) > 2592000 and tonumber(check_time) < 31536000 then
			remained_expire = M_START..'`گروه به مدت` *'..month..'* `ماه` *'..day..'* `روز و` *'..hours..'* `ساعت و` *'..min..'* `دقیقه و` *'..sec..'* `ثانیه شارژ میباشد`'..EndPm
		elseif tonumber(check_time) > 31536000 then
			remained_expire = M_START..'`گروه به مدت` *'..year..'* `سال` *'..month..'* `ماه` *'..day..'* `روز و` *'..hours..'* `ساعت و` *'..min..'* `دقیقه و` *'..sec..'* `ثانیه شارژ میباشد`'..EndPm
		end
		tdbot.sendMessage(msg.to.id, msg.id, 1, remained_expire, 1, 'md')
	end
end
if mr_roo[1]:lower() == 'gift' or mr_roo[1] == 'استفاده هدیه' then 
	redis:setex(RedisIndex.."Codegift:" .. msg.to.id , 260, true)
	tdbot.sendMessage(msg.chat_id, msg.id, 1, M_START.."`شما دو دقیقه برای استفاده از کدهدیه زمان دارید.`"..EndPm, 1, 'md')
end
end
end
end

return {
patterns = admin_patterns, run = TiiGeRTeaM
}
