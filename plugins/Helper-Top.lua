local function run(msg, matches)
local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
local M_START = StartPm[math.random(#StartPm)]
if msg.query and msg.query:sub(1,6) == "Menu:-" and msg.query:gsub("Menu:-",""):match('%d+') and is_sudo(msg) then
	local url = http.request('http://probot.000webhostapp.com/api/time.php/')
	local jdat = json:decode(url)
	local TiGeR = '*●•۰ به بخش مدیریتی ربات خوشآمدید*\n*'..M_START..'توجه داشته باشید این پنل مدیریتی مخصوص به مدیران و مالک گروه میباشد'..EndPm..'*\n`❃ برای حمایت از ما لطفا در نظر سنجی ربات شرکت کنید`\n\n*ساعت : * `'..jdat.Stime..'`\n*تاریخ :* `'..jdat.FAdate..'`'
	local chatid = "-"..msg.query:match("%d+")
	keyboard = {}
	keyboard.inline_keyboard = {
		{
            {text = "❤️ "..tostring(redis:get(RedisIndex.."TiGeRLikes")), callback_data="/like:"..chatid},
            {text = "💔 "..tostring(redis:get(RedisIndex.."TiGeRDisLikes")), callback_data="/dislike:"..chatid}
        },
		{
			{text = M_START.."تنظیمات", callback_data="/settings:"..chatid}
		},
		{
			{text = M_START..'اطلاعات گروه و مدیریت لیست‌ها', callback_data = '/more:'..chatid}
		},
		{
			{text = M_START..'راهنما ربات', callback_data = '/helplist2:'..chatid}
		},
		{
			{text = M_START..'تلویزیون', callback_data = '/tv:'..chatid}
		},
		{
			{text= M_START..'بستن پنل شیشه‌ای' ,callback_data = '/exit:'..chatid}
		}				
	}
	send_inline(msg.id,'settings','Group Option','Tap Here',TiGeR,'Markdown',keyboard)
end
if msg.query and msg.query:match("Join") and is_sudo(msg) then
	keyboard = {}
	keyboard.inline_keyboard = {
		{
            {text = '🏷 کانال ما', url = 'http://t.me/'..channel_inline..''},
        }			
	}
	send_inline(msg.id,'settings','Group settings','Tap Here','`₪ مدیر گرامی لطفا برای اجرای دستور شما توسط ربات در کانال ما عضو شوید 🌺`','Markdown',keyboard)
end
if msg.query and msg.query:sub(1,6) == "Addl:-" and msg.query:gsub("Addl:-",""):match('%d+') and is_sudo(msg) then
	local chatid = "-"..msg.query:match("%d+")
	local getadd = redis:hget(RedisIndex..'addmemset', chatid) or "1"
	local add = redis:hget(RedisIndex..'addmeminv' ,chatid)
	local sadd = (add == 'on') and "✅" or "✖️" 
	local url = http.request('http://probot.000webhostapp.com/api/time.php/')
	local jdat = json:decode(url)
	local TiGeR = '*●•۰ به بخش اد اجباری ربات خوشآمدید*\n*'..M_START..'توجه داشته باشید این پنل اد اجباری مخصوص به مدیران و مالک گروه میباشد'..EndPm..'*\n`❃ برای حمایت از ما لطفا در نظر سنجی ربات شرکت کنید`\n\n*ساعت : * `'..jdat.Stime..'`\n*تاریخ :* `'..jdat.FAdate..'`'
	if redis:get(RedisIndex..'addpm'..chatid) then
	addpm = "✖️"
	else
	addpm = "✅"
	end
	keyboard = {}
	keyboard.inline_keyboard = {
		{
			{text = M_START..'محدودیت اضافه کردن : '..getadd..'', callback_data = 'TiiGeRTeaM:'..chatid}
		},
		{
			{text = '➕', callback_data = '/addlimup:'..chatid},
			{text = '➖', callback_data = '/addlimdown:'..chatid}
		},
		{
			{text = M_START..'وضعیت محدودیت : '..sadd..'', callback_data = 'TiiGeRTeaM:'..chatid}
		},
		{
			{text = '▪️ فعال', callback_data = '/addlimlock:'..chatid},
			{text = '▪️ غیرفعال', callback_data = '/addlimunlock:'..chatid}
		},
		{
			{text = M_START..'ارسال پیام محدودیت : '..addpm..'', callback_data = 'TiiGeRTeaM:'..chatid}
		},
		{
			{text = '▪️ فعال', callback_data = '/addpmon:'..chatid},
			{text = '▪️ غیرفعال', callback_data = '/addpmoff:'..chatid}
		},
		{
			{text= M_START..'بستن پنل شیشه‌ای' ,callback_data = '/exitadd:'..chatid}
		}
	}
	send_inline(msg.id,'settings','Group Option','Tap Here',TiGeR,'Markdown',keyboard)
end
if msg.query and msg.query:sub(1,6) == "Help:-" and msg.query:gsub("Help:-",""):match('%d+') and is_sudo(msg) then
	local chatid = "-"..msg.query:match("%d+")
	local url = http.request('http://probot.000webhostapp.com/api/time.php/')
	local jdat = json:decode(url)
	local TiGeR = '*●•۰ به بخش راهنمای ربات خوشآمدید*\n*'..M_START..'توجه داشته باشید این پنل راهنما مخصوص به مدیران و مالک گروه میباشد'..EndPm..'*\n`❃ برای حمایت از ما لطفا در نظر سنجی ربات شرکت کنید`\n\n*ساعت : * `'..jdat.Stime..'`\n*تاریخ :* `'..jdat.FAdate..'`'
	keyboard = {}
	keyboard.inline_keyboard = {
		{
            {text = "❤️ "..tostring(redis:get(RedisIndex.."TiGeRLikes")), callback_data="/likehelp:"..chatid},
            {text = "💔 "..tostring(redis:get(RedisIndex.."TiGeRDisLikes")), callback_data="/dislikehelp:"..chatid}
        },
		{
			{text = M_START..'راهنمای مدیریتی', callback_data = '/helpmod:'..chatid}
		},
		{
			{text = M_START..'پاکسازی لیستی', callback_data = '/helpclean:'..chatid},
			{text = M_START..'پاکسازی پیام', callback_data = '/helpclean1:'..chatid}
		},
		{
			{text = M_START..'راهنمای پنل ها', callback_data = '/helppn:'..chatid}
		},
		{
			{text = M_START..'لیستی ربات', callback_data = '/helplisti:'..chatid},
			{text = M_START..'تنظیمی ربات', callback_data = '/helpseti:'..chatid}
		},
		{
			{text = M_START..'راهنمای قفلی', callback_data = '/helplock:'..chatid}
		},
		{
			{text = M_START..'محدودیت و ارتقا', callback_data = '/helpmah:'..chatid},
			{text = M_START..'سرگرمی', callback_data = '/helpfun:'..chatid}
		},
		{
			{text= M_START..'بستن پنل شیشه‌ای' ,callback_data = '/exithelp:'..chatid}
		}				
	}
	send_inline(msg.id,'settings','Group Option','Tap Here',TiGeR,'Markdown',keyboard)
end
if msg.query and msg.query:sub(1,6) == "Sudo:-" and msg.query:gsub("Sudo:-",""):match('%d+') and is_sudo(msg) then
	local chatid = "-"..msg.query:match("%d+")
	local m_read = redis:get(RedisIndex..'markread')
	local url = http.request('http://probot.000webhostapp.com/api/time.php/')
	local jdat = json:decode(url)
	local TiGeR = '*●•۰ به بخش پنل سودو ربات خوشآمدید*\n*'..M_START..'توجه داشته باشید این پنل سودو مخصوص به سودو های ربات میباشد'..EndPm..'*\n\n*ساعت : * `'..jdat.Stime..'`\n*تاریخ :* `'..jdat.FAdate..'`'
	if redis:get(RedisIndex..'auto_leave_bot') then
	Autoleave = "✖️"
	else
	Autoleave = "✅"
	end
	if m_read == 'on' then
	Markread = "✅"
	else
	Markread = "✖️"
	end
	keyboard = {}
	keyboard.inline_keyboard = {
		{
			{text = M_START..'اطلاعات مربوط به سودو', callback_data = '/infosudo1:'..chatid}
		},
		{
			{text = M_START..'راهنمای سودو', callback_data = '/helpsudo1:'..chatid},
			{text = M_START..'لیست سودو ها', callback_data = '/sudolist1:'..chatid}
		},
		{
			{text = M_START..'جوین اجباری', callback_data = '/joinlimset:'..chatid}
		},
		{
			{text = M_START..'تیک دوم : '..Markread..'', callback_data = '/markread:'..chatid}
		},
		{
			{text = M_START..'خروج خودکار : '..Autoleave..'', callback_data = '/autoleave:'..chatid}
		},
		{
			{text= M_START..'بستن پنل شیشه‌ای' ,callback_data = '/exitsudo:'..chatid}
		}
	}
	send_inline(msg.id,'settings','Group Option','Tap Here',TiGeR,'Markdown',keyboard)
end
end

return {
	patterns ={
		"^(Menu:[-]%d+)$",
		"^(Join)$",
		"^(Sudo:[-]%d+)$",
		"^(Help:[-]%d+)$",
		"^(Addl:[-]%d+)$",
		"^###cb:(Addl:%d+)$",
		"^###cb:(Join)$",
		"^###cb:(Menu:%d+)$",
		"^###cb:(Sudo:%d+)$",
		"^###cb:(Help:%d+)$"
	},
	run=run
}		
