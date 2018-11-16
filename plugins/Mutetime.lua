local function TiiGeRTeaM(msg, mr_roo)
local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
local M_START = StartPm[math.random(#StartPm)]
if mr_roo[1]:lower() == "silent" or mr_roo[1] == "سکوت" then
local time = mr_roo[2]
if mr_roo[3]:lower() == "time" or mr_roo[3] == "ساعت" then
local hour = tonumber(time) * 3600
local timemute = tonumber(hour)
local function Restricted(arg, data)
if data.sender_user_id == our_id then
	return tdbot.sendMessage(msg.chat_id, "", 0, M_START.."*من نمیتوانم توانایی چت کردن رو از خودم بگیرم*"..EndPm, 0, "md")
end
if is_mod1(msg.chat_id, data.sender_user_id) then
	return tdbot.sendMessage(msg.chat_id, "", 0, M_START.."*شما نمیتوانید توانایی چت کردن رو از مدیران،صاحبان گروه، و ادمین های ربات بگیرید*"..EndPm, 0, "md")
end
tdbot.Restricted(msg.chat_id,data.sender_user_id,'Restricted',   {1,msg.date+timemute, 0, 0, 0,0})
tdbot.sendMention(msg.chat_id,data.sender_user_id, data.id,M_START.."کاربر [ "..data.sender_user_id.." ]  به مدت "..time.." ساعت سکوت شد"..EndPm,10,string.len(data.sender_user_id))
end
tdbot.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id), Restricted, nil)
elseif mr_roo[3]:lower() == "m" or mr_roo[3] == "دقیقه" then
local minutes = tonumber(time) * 60
local timemute = tonumber(minutes)
local function Restricted(arg,data)
if data.sender_user_id == our_id then
	return tdbot.sendMessage(msg.chat_id, "", 0, M_START.."*من نمیتوانم توانایی چت کردن رو از خودم بگیرم*"..EndPm, 0, "md")
end
if is_mod1(msg.chat_id, data.sender_user_id) then
	return tdbot.sendMessage(msg.chat_id, "", 0, M_START.."*شما نمیتوانید توانایی چت کردن رو از مدیران،صاحبان گروه، و ادمین های ربات بگیرید*"..EndPm, 0, "md")
end
tdbot.Restricted(msg.chat_id,data.sender_user_id,'Restricted',   {1,msg.date+timemute, 0, 0, 0,0})
tdbot.sendMention(msg.chat_id,data.sender_user_id, data.id,M_START.."کاربر [ "..data.sender_user_id.." ]  به مدت "..time.." دقیقه سکوت شد"..EndPm,10,string.len(data.sender_user_id))
end
tdbot.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id), Restricted, nil)
elseif mr_roo[3]:lower() == "s" or mr_roo[3] == "ثانیه" then
local second = tonumber(time)
local timemute = tonumber(second)
local function Restricted(arg,data)
if data.sender_user_id == our_id then
	return tdbot.sendMessage(arg.chat_id, "", 0, M_START.."*من نمیتوانم توانایی چت کردن رو از خودم بگیرم*"..EndPm, 0, "md")
end
if is_mod1(msg.chat_id, data.sender_user_id) then
	return tdbot.sendMessage(msg.chat_id, "", 0, M_START.."*شما نمیتوانید توانایی چت کردن رو از مدیران،صاحبان گروه، و ادمین های ربات بگیرید*"..EndPm, 0, "md")
end
tdbot.Restricted(msg.chat_id,data.sender_user_id,'Restricted',   {1,msg.date+timemute, 0, 0, 0,0})
tdbot.sendMention(msg.chat_id,data.sender_user_id, data.id,M_START.."کاربر [ "..data.sender_user_id.." ]  به مدت "..time.." ثانیه سکوت شد"..EndPm,10,string.len(data.sender_user_id))
end
tdbot.getMessage(msg.chat_id, tonumber(msg.reply_to_message_id), Restricted, nil)
end
end
if mr_roo[1]:lower() == "delbot" or mr_roo[1] == "پاکسازی ربات" then
if mr_roo[2]:lower() == "on" or mr_roo[2] == "فعال" then
redis:set(RedisIndex.."delbot"..msg.to.id, true)
redis:set(RedisIndex.."deltimebot"..msg.chat_id , 60)
return M_START.."`پاکسازی خودکار پیام های ربات توسط` `"..msg.from.id.."` - @"..check_markdown(msg.from.username or '').." `فعال شد`"..EndPm
elseif mr_roo[2]:lower() == "off" or mr_roo[2] == "غیرفعال" then
redis:del(RedisIndex.."delbot"..msg.to.id)
redis:del(RedisIndex.."deltimebot"..msg.chat_id)
return M_START.."`پاکسازی خودکار پیام های ربات توسط` `"..msg.from.id.."` - @"..check_markdown(msg.from.username or '').." `غیرفعال شد`"..EndPm
end
end
if mr_roo[1]:lower() == "deltimebot" or mr_roo[1] == "زمان پاکسازی ربات" then
if tonumber(mr_roo[2]) < 60 or tonumber(mr_roo[2]) > 300 then
return M_START.."`باید بین` *[60 - 300]* `تنظیم شود`"..EndPm
end
redis:set(RedisIndex.."deltimebot"..msg.chat_id , mr_roo[2])
return M_START.."`زمان پاکسازی پیام ربات تنظیم شد به هر` *[ "..mr_roo[2].." ]* `ثانیه`"..EndPm
end
end
local function pre_process(msg)
if msg.text then
if msg.text:match("(.*)") then
if redis:get(RedisIndex.."delbot"..msg.to.id) and not redis:get(RedisIndex.."deltimebot2"..msg.to.id) and not is_mod(msg) then
local time = redis:get(RedisIndex.."deltimebot"..msg.chat_id)
redis:setex(RedisIndex.."deltimebot2"..msg.to.id, time, true)
tdbot.deleteMessagesFromUser(msg.to.id,  our_id, dl_cb, nil)
end
end
end
end

return {
patterns = {
"^[!/#]([Dd][Ee][Ll][Bb][Oo][Tt]) (.*)$",
"^[!/#]([Dd][Ee][Ll][Tt][Ii][Mm][Ee][Bb][Oo][Tt]) (%d+)$",
"^[!/#]([Ss][Ii][Ll][Ee][Nn][Tt]) (%d+) (.*)$",
"^([Dd][Ee][Ll][Bb][Oo][Tt]) (.*)$",
"^([Dd][Ee][Ll][Tt][Ii][Mm][Ee][Bb][Oo][Tt]) (%d+)$",
"^([Ss][Ii][Ll][Ee][Nn][Tt]) (%d+) (.*)$",
"^(سکوت) (%d+) (.*)$",
"^(پاکسازی ربات) (.*)$",
"^(زمان پاکسازی ربات) (%d+)$",
},
run = TiiGeRTeaM, pre_process = pre_process
}


