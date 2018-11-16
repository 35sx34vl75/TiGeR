local clock = os.clock
function sleep(time) 
  local t0 = clock()
  while clock() - t0 <= time do end
end
function scandir(directory)
  local i, t, popen = 0, {}, io.popen
  for filename in popen('ls -a "'..directory..'"'):lines() do
    i = i + 1
    t[i] = filename
  end
  return t
end
function plugins_names( )
  local files = {}
  for k, v in pairs(scandir("plugins")) do
    if (v:match(".lua$")) then
      table.insert(files, v)
    end
  end
  return files
end
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
Arashwm = 205549111
function is_sudo(msg)
	local var = false
	if is_sudo1(tonumber(msg.from.id)) then var = true end
return var
end
function is_admin(msg)
	local var = false
	if is_admin1(tonumber(msg.from.id)) then var = true end
	return var
end
function is_owner(msg)
	local var = false
	if is_owner1(tostring(msg.chat.id),tonumber(msg.from.id)) then var = true end
	return var
end
function is_mod(msg)
	local var = false
	if is_mod1(tostring(msg.chat.id),tonumber(msg.from.id)) then var = true end
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
function is_req(chat_id, user_id)
  local var = false
  if redis:get(RedisIndex.."ReqMenu:" .. chat_id .. ":" .. user_id) then
  redis:setex(RedisIndex.."ReqMenu:" .. chat_id .. ":" .. user_id, 260, true)
  redis:setex(RedisIndex.."ReqMenu:" .. chat_id, 10, true)
  var = true
  end
  return var
end
function is_filter(msg, text)
local var = false
local data = load_data(_config.moderation.data)
  if data[tostring(msg.chat.id)]['filterlist'] then
for k,v in pairs(data[tostring(msg.chat.id)]['filterlist']) do 
    if string.find(string.lower(text), string.lower(k)) then
       var = true
        end
     end
  end
 return var
end
function is_banned(chat_id, user_id)
	local var = false
	if redis:sismember(RedisIndex.."Banned:"..chat_id,user_id) then var = true end
	return var
end
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
function locks(msg, GP_id, name, temp, cb, back, v, st)
local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
local M_START = StartPm[math.random(#StartPm)]
	text = M_START..'تنظیمات پیشرفته قفل '..v..''
	keyboard = {}
	keyboard.inline_keyboard = {
		{
			{text = ''..name..' : '..st, callback_data = "/"..cb.."enable:"..GP_id},

		},
		{
			{text = M_START..'فعال', callback_data = "/"..cb.."enable:"..GP_id},
			{text = M_START..'غیر فعال', callback_data = "/"..cb.."disable:"..GP_id}
		},
		{
			{text = M_START..'اخطار', callback_data = "/"..cb.."warn:"..GP_id}
		},
		{
			{text = M_START..'سکوت', callback_data = "/"..cb.."mute:"..GP_id},
			{text = M_START..'اخراج', callback_data = "/"..cb.."kick:"..GP_id}
		},
		{
			{text = M_START..'بازگشت', callback_data = back..GP_id}
		}
	}
	edit_inline(msg.message_id, text, keyboard)
end
function options(msg, GP_id)
	local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
	local M_START = StartPm[math.random(#StartPm)]
	local url = http.request('http://probot.000webhostapp.com/api/time.php/')
	local jdat = json:decode(url)
	local TiGeR = '*●•۰ به بخش مدیریتی ربات خوشآمدید*\n*'..M_START..'توجه داشته باشید این پنل مدیریتی مخصوص به مدیران و مالک گروه میباشد'..EndPm..'*\n`❃ برای حمایت از ما لطفا در نظر سنجی ربات شرکت کنید`\n\n*ساعت : * `'..jdat.Stime..'`\n*تاریخ :* `'..jdat.FAdate..'`'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
            {text = "❤️ "..tostring(redis:get(RedisIndex.."TiGeRLikes")), callback_data="/like:"..GP_id},
            {text = "💔 "..tostring(redis:get(RedisIndex.."TiGeRDisLikes")), callback_data="/dislike:"..GP_id}
        },
		{
			{text = M_START.."تنظیمات", callback_data="/settings:"..GP_id}
		},
		{
			{text = M_START..'اطلاعات گروه و مدیریت لیست‌ها', callback_data = '/more:'..GP_id}
		},
		{
			{text = M_START..'راهنما ربات', callback_data = '/helplist2:'..GP_id},
			{text = M_START..'اد اجباری', callback_data = '/addlimmenu2:'..GP_id},
		},
		{
			{text = M_START..'تلویزیون', callback_data = '/tv:'..GP_id}
		},
		{
			{text= M_START..'بستن پنل شیشه‌ای' ,callback_data = '/exit:'..GP_id}
		}				
	}
    edit_inline(msg.message_id, TiGeR, keyboard)
end
function moresetting(msg, data, GP_id)
local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
local M_START = StartPm[math.random(#StartPm)]
		if redis:get(RedisIndex..GP_id..'num_msg_max') then
			NUM_MSG_MAX = redis:get(RedisIndex..GP_id..'num_msg_max')
		else
			NUM_MSG_MAX = 5
		end
		if redis:get(RedisIndex..GP_id..'set_char') then
			SETCHAR = redis:get(RedisIndex..GP_id..'set_char')
		else
			SETCHAR = 40
		end
		if redis:get(RedisIndex..GP_id..'time_check') then
			TIME_CHECK = redis:get(RedisIndex..GP_id..'time_check')
		else
			TIME_CHECK = 2
		end
    text = '●• به تنظیمات بیشتر گروه خوش آمدید'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = M_START..'حداکثر پیام های مکرر ', callback_data = 'TiiGeRTeaM:'}
		},
		{
			{text = "➕", callback_data='/floodup:'..GP_id}, 
			{text = tostring(NUM_MSG_MAX), callback_data = 'TiiGeRTeaM:' },
			{text = "➖", callback_data='/flooddown:'..GP_id}
		},
		{
			{text = M_START..'حداکثر حروف مجاز ', callback_data = 'TiiGeRTeaM:'}
		},
		{
			{text = "➕", callback_data='/charup:'..GP_id}, 
			{text = tostring(SETCHAR), callback_data = 'TiiGeRTeaM:'},
			{text = "➖", callback_data='/chardown:'..GP_id}
		},
		{
			{text = M_START..'زمان بررسی پیام های مکرر ', callback_data = 'TiiGeRTeaM:'}
		},
		{
			{text = "➕", callback_data='/floodtimeup:'..GP_id}, 
			{text = tostring(TIME_CHECK), callback_data = 'TiiGeRTeaM:'},
			{text = "➖", callback_data='/floodtimedown:'..GP_id}
		},
		{
			{text = M_START..'بازگشت ', callback_data = '/mutelist:'..GP_id}
		}				
	}
    edit_inline(msg.message_id, text, keyboard)
end
function setting(msg, data, GP_id)
	local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
	local M_START = StartPm[math.random(#StartPm)]
	lock_link = redis:get(RedisIndex..'lock_link:'..GP_id)
	lock_join = redis:get(RedisIndex..'lock_join:'..GP_id)
	lock_tag = redis:get(RedisIndex..'lock_tag:'..GP_id)
	lock_username = redis:get(RedisIndex..'lock_username:'..GP_id)
	lock_pin = redis:get(RedisIndex..'lock_pin:'..GP_id)
	lock_arabic = redis:get(RedisIndex..'lock_arabic:'..GP_id)
	lock_mention = redis:get(RedisIndex..'lock_mention:'..GP_id)
	lock_edit = redis:get(RedisIndex..'lock_edit:'..GP_id)
	lock_spam = redis:get(RedisIndex..'lock_spam:'..GP_id)
	lock_flood = redis:get(RedisIndex..'lock_flood:'..GP_id)
	lock_markdown = redis:get(RedisIndex..'lock_markdown:'..GP_id)
	lock_webpage = redis:get(RedisIndex..'lock_webpage:'..GP_id)
	lock_welcome = redis:get(RedisIndex..'welcome:'..GP_id)
	lock_views = redis:get(RedisIndex..'lock_views:'..GP_id)
	lock_bots = redis:get(RedisIndex..'lock_bots:'..GP_id)
	local Link = (lock_link == "Warn") and "🔖" or ((lock_link == "Kick") and "🚫" or ((lock_link == "Mute") and "💤" or ((lock_link == "Enable") and "✅" or "❌")))
	local Tags = (lock_tag == "Warn") and "🔖" or ((lock_tag == "Kick") and "🚫" or ((lock_tag == "Mute") and "💤" or ((lock_tag == "Enable") and "✅" or "❌")))
	local User = (lock_username == "Warn") and "🔖" or ((lock_username == "Kick") and "🚫" or ((lock_username == "Mute") and "💤" or ((lock_username == "Enable") and "✅" or "❌")))
	local Fa = (lock_arabic == "Warn") and "🔖" or ((lock_arabic == "Kick") and "🚫" or ((lock_arabic == "Mute") and "💤" or ((lock_arabic == "Enable") and "✅" or "❌")))
	local Mention = (lock_mention == "Warn") and "🔖" or ((lock_mention == "Kick") and "🚫" or ((lock_mention == "Mute") and "💤" or ((lock_mention == "Enable") and "✅" or "❌")))
	local Edit = (lock_edit == "Warn") and "🔖" or ((lock_edit == "Kick") and "🚫" or ((lock_edit == "Mute") and "💤" or ((lock_edit == "Enable") and "✅" or "❌")))
	local Mar = (lock_markdown == "Warn") and "🔖" or ((lock_markdown == "Kick") and "🚫" or ((lock_markdown == "Mute") and "💤" or ((lock_markdown == "Enable") and "✅" or "❌")))
	local Web = (lock_webpage == "Warn") and "🔖" or ((lock_webpage == "Kick") and "🚫" or ((lock_webpage == "Mute") and "💤" or ((lock_webpage == "Enable") and "✅" or "❌")))
	local Views = (lock_views == "Warn") and "🔖" or ((lock_views == "Kick") and "🚫" or ((lock_views == "Mute") and "💤" or ((lock_views == "Enable") and "✅" or "❌")))
	local Bot =  (lock_bots == "Enable" and "✅" or "❌")
	local Join =  (lock_join == "Enable" and "✅" or "❌")
	local Pin =  (lock_pin == "Enable" and "✅" or "❌")
	local Spam =  (lock_spam == "Enable" and "✅" or "❌")
	local Flood =  (lock_flood == "Enable" and "✅" or "❌")
	local Wel = (lock_welcome == "Enable" and "✅" or "❌")
    text = M_START..'به تنظیمات گروه خوش آمدید'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = M_START.."ویرایش : "..Edit, callback_data="/lockedit:"..GP_id},
			{text = M_START.."لینک : "..Link, callback_data="/locklink:"..GP_id}
		},
		{
			{text = M_START.."تگ : "..Tags, callback_data="/locktags:"..GP_id},
			{text = M_START.."نام کاربری : "..User, callback_data="/lockusernames:"..GP_id}
		},
		{
			{text = M_START.."بازدید : "..Views, callback_data="/lockviews:"..GP_id},
			{text = M_START.."ورود : "..Join, callback_data="/lockjoin:"..GP_id}
		},
		{
			{text = M_START.."پیام های مکرر : "..Flood, callback_data="/lockflood:"..GP_id},
			{text = M_START.."هرزنامه : "..Spam, callback_data="/lockspam:"..GP_id}
		},
		{
			{text = M_START.."فراخوانی : "..Mention, callback_data="/lockmention:"..GP_id},
			{text = M_START.."عربی : "..Fa, callback_data="/lockarabic:"..GP_id}
		},
		{
			{text = M_START.."صفحات وب : "..Web, callback_data="/lockwebpage:"..GP_id},
			{text = M_START.."فونت : "..Mar, callback_data="/lockmarkdown:"..GP_id}
		},
		{
			{text = M_START.."سنجاق کردن : "..Pin, callback_data="/lockpin:"..GP_id},
			{text = M_START.."ربات ها : "..Bot, callback_data="/lockbots:"..GP_id}
		},
		{
			{text = M_START.."خوشآمد گویی : "..Wel, callback_data="/welcome:"..GP_id}
		},
		{
			{text = M_START..'ادامه تنظیمات ', callback_data = '/mutelist:'..GP_id}
		},
		{
			{text = M_START..'بازگشت ', callback_data = '/option:'..GP_id}
		}				
	}
    edit_inline(msg.message_id, text, keyboard)
end
function mutelists(msg, data, GP_id)
	local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
	local M_START = StartPm[math.random(#StartPm)]
	mute_all = redis:get(RedisIndex..'mute_all:'..GP_id)
	mute_gif = redis:get(RedisIndex..'mute_gif:'..GP_id)
	mute_photo = redis:get(RedisIndex..'mute_photo:'..GP_id)
	mute_sticker = redis:get(RedisIndex..'mute_sticker:'..GP_id)
	mute_contact = redis:get(RedisIndex..'mute_contact:'..GP_id)
	mute_inline = redis:get(RedisIndex..'mute_inline:'..GP_id)
	mute_game = redis:get(RedisIndex..'mute_game:'..GP_id)
	mute_text = redis:get(RedisIndex..'mute_text:'..GP_id)
	mute_keyboard = redis:get(RedisIndex..'mute_keyboard:'..GP_id)
	mute_forward = redis:get(RedisIndex..'mute_forward:'..GP_id)
	mute_location = redis:get(RedisIndex..'mute_location:'..GP_id)
	mute_document = redis:get(RedisIndex..'mute_document:'..GP_id)
	mute_voice = redis:get(RedisIndex..'mute_voice:'..GP_id)
	mute_audio = redis:get(RedisIndex..'mute_audio:'..GP_id)
	mute_video = redis:get(RedisIndex..'mute_video:'..GP_id)
	mute_video_note = redis:get(RedisIndex..'mute_video_note:'..GP_id)
	mute_tgservice = redis:get(RedisIndex..'mute_tgservice:'..GP_id)
	local Gif = (mute_gif == "Warn") and "🔖" or ((mute_gif == "Kick") and "🚫" or ((mute_gif == "Mute") and "💤" or ((mute_gif == "Enable") and "✅" or "❌")))
	local Photo = (mute_photo == "Warn") and "🔖" or ((mute_photo == "Kick") and "🚫" or ((mute_photo == "Mute") and "💤" or ((mute_photo == "Enable") and "✅" or "❌")))
	local Sticker = (mute_sticker == "Warn") and "🔖" or ((mute_sticker == "Kick") and "🚫" or ((mute_sticker == "Mute") and "💤" or ((mute_sticker == "Enable") and "✅" or "❌")))
	local Contact = (mute_contact == "Warn") and "🔖" or ((mute_contact == "Kick") and "🚫" or ((mute_contact == "Mute") and "💤" or ((mute_contact == "Enable") and "✅" or "❌")))
	local Inline = (mute_inline == "Warn") and "🔖" or ((mute_inline == "Kick") and "🚫" or ((mute_inline == "Mute") and "💤" or ((mute_inline == "Enable") and "✅" or "❌")))
	local Game = (mute_game == "Warn") and "🔖" or ((mute_game == "Kick") and "🚫" or ((mute_game == "Mute") and "💤" or ((mute_game == "Enable") and "✅" or "❌")))
	local Text = (mute_text == "Warn") and "🔖" or ((mute_text == "Kick") and "🚫" or ((mute_text == "Mute") and "💤" or ((mute_text == "Enable") and "✅" or "❌")))
	local Key = (mute_keyboard == "Warn") and "🔖" or ((mute_keyboard == "Kick") and "🚫" or ((mute_keyboard == "Mute") and "💤" or ((mute_keyboard == "Enable") and "✅" or "❌")))
	local Fwd = (mute_forward == "Warn") and "🔖" or ((mute_forward == "Kick") and "🚫" or ((mute_forward == "Mute") and "💤" or ((mute_forward == "Enable") and "✅" or "❌")))
	local Loc = (mute_location == "Warn") and "🔖" or ((mute_location == "Kick") and "🚫" or ((mute_location == "Mute") and "💤" or ((mute_location == "Enable") and "✅" or "❌")))
	local Doc = (mute_document == "Warn") and "🔖" or ((mute_document == "Kick") and "🚫" or ((mute_document == "Mute") and "💤" or ((mute_document == "Enable") and "✅" or "❌")))
	local Voice = (mute_voice == "Warn") and "🔖" or ((mute_voice == "Kick") and "🚫" or ((mute_voice == "Mute") and "💤" or ((mute_voice == "Enable") and "✅" or "❌")))
	local Audio = (mute_audio == "Warn") and "🔖" or ((mute_audio == "Kick") and "🚫" or ((mute_audio == "Mute") and "💤" or ((mute_audio == "Enable") and "✅" or "❌")))
	local Video = (mute_video == "Warn") and "🔖" or ((mute_video == "Kick") and "🚫" or ((mute_video == "Mute") and "💤" or ((mute_video == "Enable") and "✅" or "❌")))
	local VSelf = (mute_video_note == "Warn") and "🔖" or ((mute_video_note == "Kick") and "🚫" or ((mute_video_note == "Mute") and "💤" or ((mute_video_note == "Enable") and "✅" or "❌")))
	local Tgser =  (mute_tgservice == "Enable" and "✅" or "❌")
	local All =  (mute_all == "Enable" and "✅" or "❌")
	text = M_START..'به لیست بیصدای گروه خوش آمدید'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = M_START.."همه : "..All, callback_data="/muteall:"..GP_id},
			{text = M_START.."گیف : "..Gif, callback_data="/mutegif:"..GP_id}
		},
		{ 
			{text = M_START.."متن : "..Text, callback_data="/mutetext:"..GP_id},
			{text = M_START.."اینلاین : "..Inline, callback_data="/muteinline:"..GP_id}
		},
		{
			{text = M_START.."بازی : "..Game, callback_data="/mutegame:"..GP_id},
			{text = M_START.."عکس : "..Photo, callback_data="/mutephoto:"..GP_id}
		},
		{
			{text = M_START.."فیلم : "..Video, callback_data="/mutevideo:"..GP_id},
			{text = M_START.."آهنگ : "..Audio, callback_data="/muteaudio:"..GP_id}
		},
		{
			{text = M_START.."صدا : "..Voice, callback_data="/mutevoice:"..GP_id},
			{text = M_START.."استیکر : "..Sticker, callback_data="/mutesticker:"..GP_id}
		},
		{
			{text = M_START.."مخاطب : "..Contact, callback_data="/mutecontact:"..GP_id},
			{text = M_START.."فوروارد :" ..Fwd, callback_data="/muteforward:"..GP_id}
		},
		{ 
			{text = M_START.."موقعیت : "..Loc, callback_data="/mutelocation:"..GP_id},
			{text = M_START.."فایل : "..Doc, callback_data="/mutedocument:"..GP_id}
		},
		{
			{text = M_START.."خدمات تلگرام : "..Tgser, callback_data="/mutetgservice:"..GP_id},
			{text = M_START.."کیبورد : "..Key, callback_data="/mutekeyboard:"..GP_id}
		},
		{
			{text = M_START.."فیلم سلفی : "..VSelf, callback_data="/mutevideonote:"..GP_id}
        },
		{
			{text = M_START..'تنظیمات بیشتر ', callback_data = '/moresettings:'..GP_id}
		},
        {
			{text = M_START..'بازگشت ', callback_data = '/settings:'..GP_id}
		}	
	}
    edit_inline(msg.message_id, text, keyboard)
end
function lockhelp(msg, GP_id)
	local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
	local M_START = StartPm[math.random(#StartPm)]
	text = M_START..'به راهنمای قفلی خوشآمدید'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = M_START.."قفل خودکار گروه", callback_data="/lockh31:"..GP_id},
		},
		{
			{text = M_START.."همه", callback_data="/lockh1:"..GP_id},
			{text = M_START.."لینک", callback_data="/lockh2:"..GP_id},
			{text = M_START.."فوروارد", callback_data="/lockh3:"..GP_id}
		},
		{
			{text = M_START.."تگ", callback_data="/lockh4:"..GP_id},
			{text = M_START.."منشن", callback_data="/lockh5:"..GP_id},
			{text = M_START.."فارسی", callback_data="/lockh6:"..GP_id}
		},
		{
			{text = M_START.."ویرایش", callback_data="/lockh7:"..GP_id},
			{text = M_START.."هرزنامه", callback_data="/lockh8:"..GP_id},
			{text = M_START.."پیام مکرر", callback_data="/lockh9:"..GP_id}
		},
		{
			{text = M_START.."ربات", callback_data="/lockh10:"..GP_id},
			{text = M_START.."فونت", callback_data="/lockh11:"..GP_id},
			{text = M_START.."وبسایت", callback_data="/lockh12:"..GP_id}
		},
		{
			{text = M_START.."سنجاق", callback_data="/lockh13:"..GP_id},
			{text = M_START.."ورود", callback_data="/lockh14:"..GP_id},
			{text = M_START.."گیف", callback_data="/lockh15:"..GP_id}
		},
		{
			{text = M_START.."متن", callback_data="/lockh16:"..GP_id},
			{text = M_START.."عکس", callback_data="/lockh17:"..GP_id},
			{text = M_START.."فیلم", callback_data="/lockh18:"..GP_id}
		},
		{
			{text = M_START.."فیلم سلفی", callback_data="/lockh19:"..GP_id},
			{text = M_START.."آهنگ", callback_data="/lockh20:"..GP_id},
			{text = M_START.."ویس", callback_data="/lockh21:"..GP_id}
		},
		{
			{text = M_START.."استیکر", callback_data="/lockh22:"..GP_id},
			{text = M_START.."مخاطب", callback_data="/lockh23:"..GP_id},
			{text = M_START.."مکان", callback_data="/lockh24:"..GP_id}
		},
		{
			{text = M_START.."فایل", callback_data="/lockh25:"..GP_id},
			{text = M_START.."سرویس تلگرام", callback_data="/lockh26:"..GP_id},
			{text = M_START.."دکمه شیشه ای", callback_data="/lockh27:"..GP_id}
		},
		{
			{text = M_START.."بازی", callback_data="/lockh28:"..GP_id},
			{text = M_START.."کیبورد شیشه ای", callback_data="/lockh29:"..GP_id},
			{text = M_START.."بازدید", callback_data="/lockh30:"..GP_id}
		},
		{
			{text= M_START..'بازگشت' ,callback_data = '/helplist:'..GP_id}
		}				
	}
    edit_inline(msg.message_id, text, keyboard)
end
function helplist(msg, GP_id)
	local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
	local M_START = StartPm[math.random(#StartPm)]
	local url = http.request('http://probot.000webhostapp.com/api/time.php/')
	local jdat = json:decode(url)
	text = '*●•۰ به بخش راهنمای ربات خوشآمدید*\n*'..M_START..'توجه داشته باشید این پنل راهنما مخصوص به مدیران و مالک گروه میباشد'..EndPm..'*\n`❃ برای حمایت از ما لطفا در نظر سنجی ربات شرکت کنید`\n\n*ساعت : * `'..jdat.Stime..'`\n*تاریخ :* `'..jdat.FAdate..'`'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
            {text = "❤️ "..tostring(redis:get(RedisIndex.."TiGeRLikes")), callback_data="/likehelp:"..GP_id},
            {text = "💔 "..tostring(redis:get(RedisIndex.."TiGeRDisLikes")), callback_data="/dislikehelp:"..GP_id}
        },
		{
			{text = M_START..'راهنمای مدیریتی', callback_data = '/helpmod:'..GP_id}
		},
		{
			{text = M_START..'پاکسازی لیستی', callback_data = '/helpclean:'..GP_id},
			{text = M_START..'پاکسازی پیام', callback_data = '/helpclean1:'..GP_id}
		},
		{
			{text = M_START..'راهنمای پنل ها', callback_data = '/helppn:'..GP_id}
		},
		{
			{text = M_START..'لیستی ربات', callback_data = '/helplisti:'..GP_id},
			{text = M_START..'تنظیمی ربات', callback_data = '/helpseti:'..GP_id}
		},
		{
			{text = M_START..'راهنمای قفلی', callback_data = '/helplock:'..GP_id}
		},
		{
			{text = M_START..'محدودیت و ارتقا', callback_data = '/helpmah:'..GP_id},
			{text = M_START..'سرگرمی', callback_data = '/helpfun:'..GP_id}
		},
		{
			{text= M_START..'بستن پنل شیشه‌ای' ,callback_data = '/exithelp:'..GP_id}
		}				
	}
    edit_inline(msg.message_id, text, keyboard)
end
function helplist2(msg, GP_id)
	local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
	local M_START = StartPm[math.random(#StartPm)]
	local url = http.request('http://probot.000webhostapp.com/api/time.php/')
	local jdat = json:decode(url)
	text = '*●•۰ به بخش راهنمای ربات خوشآمدید*\n*'..M_START..'توجه داشته باشید این پنل راهنما مخصوص به مدیران و مالک گروه میباشد'..EndPm..'*\n`❃ برای حمایت از ما لطفا در نظر سنجی ربات شرکت کنید`\n\n*ساعت : * `'..jdat.Stime..'`\n*تاریخ :* `'..jdat.FAdate..'`'
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
            {text = "❤️ "..tostring(redis:get(RedisIndex.."TiGeRLikes")), callback_data="/likehelp:"..GP_id},
            {text = "💔 "..tostring(redis:get(RedisIndex.."TiGeRDisLikes")), callback_data="/dislikehelp:"..GP_id}
        },
		{
			{text = M_START..'راهنمای مدیریتی', callback_data = '/helpmod:'..GP_id}
		},
		{
			{text = M_START..'پاکسازی لیستی', callback_data = '/helpclean:'..GP_id},
			{text = M_START..'پاکسازی پیام', callback_data = '/helpclean1:'..GP_id}
		},
		{
			{text = M_START..'راهنمای پنل ها', callback_data = '/helppn:'..GP_id}
		},
		{
			{text = M_START..'لیستی ربات', callback_data = '/helplisti:'..GP_id},
			{text = M_START..'تنظیمی ربات', callback_data = '/helpseti:'..GP_id}
		},
		{
			{text = M_START..'راهنمای قفلی', callback_data = '/helplock:'..GP_id}
		},
		{
			{text = M_START..'محدودیت و ارتقا', callback_data = '/helpmah:'..GP_id},
			{text = M_START..'سرگرمی', callback_data = '/helpfun:'..GP_id}
		},
		{
			{text= M_START..'بازگشت' ,callback_data = '/option:'..GP_id}
		}				
	}
    edit_inline(msg.message_id, text, keyboard)
end
function sudopanel(msg, GP_id)
	local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
	local M_START = StartPm[math.random(#StartPm)]
	local url = http.request('http://probot.000webhostapp.com/api/time.php/')
	local jdat = json:decode(url)
	local TiGeR = '*●•۰ به بخش پنل سودو ربات خوشآمدید*\n*'..M_START..'توجه داشته باشید این پنل سودو مخصوص به سودو های ربات میباشد'..EndPm..'*\n\n*ساعت : * `'..jdat.Stime..'`\n*تاریخ :* `'..jdat.FAdate..'`'
	local m_read = redis:get(RedisIndex..'markread')
	if redis:get(RedisIndex..'auto_leave_bot') then
	Autoleave = "❈️"
	else
	Autoleave = "❀"
	end
	if m_read == 'on' then
	Markread = "❀"
	else
	Markread = "❈️"
	end
	keyboard = {} 
	keyboard.inline_keyboard = {
		{
			{text = M_START..'اطلاعات مربوط به سودو', callback_data = '/infosudo1:'..GP_id}
		},
		{
			{text = M_START..'راهنمای سودو', callback_data = '/helpsudo1:'..GP_id},
			{text = M_START..'لیست سودو ها', callback_data = '/sudolist1:'..GP_id}
		},
		{
			{text = M_START..'جوین اجباری', callback_data = '/joinlimset:'..GP_id}
		},
		{
			{text = M_START..'تیک دوم : '..Markread..'', callback_data = '/markread:'..GP_id}
		},
		{
			{text = M_START..'خروج خودکار : '..Autoleave..'', callback_data = '/autoleave:'..GP_id}
		},
		{
			{text= M_START..'بستن پنل شیشه‌ای' ,callback_data = '/exitsudo:'..GP_id}
		}
	}
    edit_inline(msg.message_id, TiGeR, keyboard)
end
function addlimpanel(msg, GP_id)
	local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
	local M_START = StartPm[math.random(#StartPm)]
	local url = http.request('http://probot.000webhostapp.com/api/time.php/')
	local jdat = json:decode(url)
	local TiGeR = '*●•۰ به بخش اد اجباری ربات خوشآمدید*\n*'..M_START..'توجه داشته باشید این پنل اد اجباری مخصوص به مدیران و مالک گروه میباشد'..EndPm..'*\n`❃ برای حمایت از ما لطفا در نظر سنجی ربات شرکت کنید`\n\n*ساعت : * `'..jdat.Stime..'`\n*تاریخ :* `'..jdat.FAdate..'`'
	local getadd = redis:hget(RedisIndex..'addmemset', GP_id) or "0"
	local add = redis:hget(RedisIndex..'addmeminv' ,GP_id)
	local sadd = (add == 'on') and "❀" or "❈️" 
	if redis:get(RedisIndex..'addpm'..GP_id) then
	addpm = "❈"
	else
	addpm = "❀"
	end
	keyboard = {}
	keyboard.inline_keyboard = {
		{
			{text = M_START..'محدودیت اضافه کردن : '..getadd..'', callback_data = 'TiiGeRTeaM:'..GP_id}
		},
		{
			{text = '➕', callback_data = '/addlimup:'..GP_id},
			{text = '➖', callback_data = '/addlimdown:'..GP_id}
		},
		{
			{text = M_START..'وضعیت محدودیت : '..sadd..'', callback_data = 'TiiGeRTeaM:'..GP_id}
		},
		{
			{text = '▪️ فعال', callback_data = '/addlimlock:'..GP_id},
			{text = '▪️ غیرفعال', callback_data = '/addlimunlock:'..GP_id}
		},
		{
			{text = M_START..'ارسال پیام محدودیت : '..addpm..'', callback_data = 'TiiGeRTeaM:'..GP_id}
		},
		{
			{text = '▪️ فعال', callback_data = '/addpmon:'..GP_id},
			{text = '▪️ غیرفعال', callback_data = '/addpmoff:'..GP_id}
		},
		{
			{text= M_START..'بستن پنل شیشه‌ای' ,callback_data = '/exitadd:'..GP_id}
		}
	}
    edit_inline(msg.message_id, TiGeR, keyboard)
end
function addlimpanel2(msg, GP_id)
	local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
	local M_START = StartPm[math.random(#StartPm)]
	local url = http.request('http://probot.000webhostapp.com/api/time.php/')
	local jdat = json:decode(url)
	local TiGeR = '*●•۰ به بخش اد اجباری ربات خوشآمدید*\n*'..M_START..'توجه داشته باشید این پنل اد اجباری مخصوص به مدیران و مالک گروه میباشد'..EndPm..'*\n`❃ برای حمایت از ما لطفا در نظر سنجی ربات شرکت کنید`\n\n*ساعت : * `'..jdat.Stime..'`\n*تاریخ :* `'..jdat.FAdate..'`'
	local getadd = redis:hget(RedisIndex..'addmemset', GP_id) or "0"
	local add = redis:hget(RedisIndex..'addmeminv' ,GP_id)
	local sadd = (add == 'on') and "❀" or "❈" 
	if redis:get(RedisIndex..'addpm'..GP_id) then
	addpm = "❈️"
	else
	addpm = "❀"
	end
	keyboard = {}
	keyboard.inline_keyboard = {
		{
			{text = M_START..'محدودیت اضافه کردن : '..getadd..'', callback_data = 'TiiGeRTeaM:'..GP_id}
		},
		{
			{text = '➕', callback_data = '/addlimup:'..GP_id},
			{text = '➖', callback_data = '/addlimdown:'..GP_id}
		},
		{
			{text = M_START..'وضعیت محدودیت : '..sadd..'', callback_data = 'TiiGeRTeaM:'..GP_id}
		},
		{
			{text = '▪️ فعال', callback_data = '/addlimlock:'..GP_id},
			{text = '▪️ غیرفعال', callback_data = '/addlimunlock:'..GP_id}
		},
		{
			{text = M_START..'ارسال پیام محدودیت : '..addpm..'', callback_data = 'TiiGeRTeaM:'..GP_id}
		},
		{
			{text = '▪️ فعال', callback_data = '/addpmon:'..GP_id},
			{text = '▪️ غیرفعال', callback_data = '/addpmoff:'..GP_id}
		},
		{
			{text= M_START..'بازگشت' ,callback_data = '/option:'..GP_id}
		}
	}
    edit_inline(msg.message_id, TiGeR, keyboard)
end
function get_var_inline(msg)
if msg.query then
if msg.query:match("-%d+") then
msg.chat = {}
msg.chat.id = "-"..msg.query:match("%d+")
    end
elseif not msg.query then
msg.chat.id = msg.chat.id
end
match_plugins(msg)
end
function get_var(msg)
msg.reply = {}
msg.fwd_from = {}
 msg.data = {}
msg.id = msg.message_id
if msg.reply_to_message then
msg.reply_id = msg.reply_to_message.message_id
msg.reply.id = msg.reply_to_message.from.id
if msg.reply_to_message.from.last_name then
msg.reply.print_name = msg.reply_to_message.from.first_name..' '..msg.reply_to_message.from.last_name
else
msg.reply.print_name = msg.reply_to_message.from.first_name
end
msg.reply.first_name = msg.reply_to_message.from.first_name
msg.reply.last_name = msg.reply_to_message.from.last_name
msg.reply.username = msg.reply_to_message.from.username
end
if msg.from.last_name then
msg.from.print_name = msg.from.first_name..' '..msg.from.last_name
else
msg.from.print_name = msg.from.first_name
end
if msg.forward_from then
msg.fwd_from.id = msg.forward_from.id
msg.fwd_from.first_name = msg.forward_from.first_name
msg.fwd_from.last_name = msg.forward_from.last_name
if msg.forward_from.last_name then
msg.fwd_from.print_name = msg.forward_from.first_name..' '..msg.forward_from.last_name
else
msg.fwd_from.print_name = msg.forward_from.first_name
end
msg.fwd_from.username = msg.forward_from.username
end
match_plugins(msg)
end
