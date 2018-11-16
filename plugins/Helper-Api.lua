local function run(msg, matches)
local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
local M_START = StartPm[math.random(#StartPm)]
if msg.cb then
	if matches[1] == '/option' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
    elseif not redis:get(RedisIndex.."CheckBot:"..matches[2]) then
		edit_inline(msg.message_id, M_START.."گروه به لیست مدیریتی ربات اضافه نشده")
	else
   options(msg, matches[2])
	end
end
  if matches[1] == '/like' then
      if redis:get(RedisIndex.."IsDisLiked:"..msg.from.id) then
        redis:del(RedisIndex.."IsDisLiked:"..msg.from.id)
        local dislikes = redis:get(RedisIndex.."TiGeRisLikes")
        redis:set(RedisIndex.."TiGeRisLikes",dislikes - 1)
        redis:set(RedisIndex.."IsLiked:"..msg.from.id,true)
        local likes = redis:get(RedisIndex.."TiGeRLikes")
        redis:set(RedisIndex.."TiGeRLikes",likes + 1)
        Canswer(msg.cb_id, M_START.."تشکر فراوان از رای مثبت شما 😄❤️" ,true)
      else
        if redis:get(RedisIndex.."IsLiked:"..msg.from.id) then
          redis:del(RedisIndex.."IsLiked:"..msg.from.id)
          local likes = redis:get(RedisIndex.."TiGeRLikes")
          redis:set(RedisIndex.."TiGeRLikes",likes - 1)
          Canswer(msg.cb_id, M_START.."خیلی بدی مگه چکار کردم رای مثبت رو پس گرفتی 😢💔" ,true)
        else
          redis:set(RedisIndex.."IsLiked:"..msg.from.id,true)
          local likes = redis:get(RedisIndex.."TiGeRLikes")
          redis:set(RedisIndex.."TiGeRLikes",likes + 1)
          Canswer(msg.cb_id, M_START.."تشکر فراوان از رای مثبت شما 😄❤️" ,true)
        end
      end
	  options(msg,matches[2])
  end
  if matches[1] == '/dislike' then
      if redis:get(RedisIndex.."IsLiked:"..msg.from.id) then
        redis:del(RedisIndex.."IsLiked:"..msg.from.id)
        local likes = redis:get(RedisIndex.."TiGeRLikes")
        redis:set(RedisIndex.."TiGeRLikes",likes - 1)
        redis:set(RedisIndex.."IsDisLiked:"..msg.from.id,true)
        local dislikes = redis:get(RedisIndex.."TiGeRDisLikes")
        redis:set(RedisIndex.."TiGeRDisLikes",dislikes + 1)
        Canswer(msg.cb_id, M_START.."خیلی بدی مگه چیکار کردم رای منفی دادی 😢💔" ,true)
      else
        if redis:get(RedisIndex.."IsDisLiked:"..msg.from.id) then
          redis:del(RedisIndex.."IsDisLiked:"..msg.from.id)
          local dislikes = redis:get(RedisIndex.."TiGeRDisLikes")
          redis:set(RedisIndex.."TiGeRDisLikes",dislikes - 1)
          Canswer(msg.cb_id, M_START.."وای مرسی که رای منفیت رو پس گرفتی 😀🌹" ,true)
        else
          redis:set(RedisIndex.."IsDisLiked:"..msg.from.id,true)
          local dislikes = redis:get(RedisIndex.."TiGeRDisLikes")
          redis:set(RedisIndex.."TiGeRDisLikes",dislikes + 1)
          Canswer(msg.cb_id, M_START.."خیلی بدی مگه چیکار کردم رای منفی دادی 😢💔" ,true)
        end
      end
	  options(msg,matches[2])
  end
if matches[1] == '/tv' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
	 elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		 local text = M_START..'تلویزیون 📺'
		 keyboard = {} 
	     keyboard.inline_keyboard = {

			{ 
			{text = 'شبکه 1️⃣', url = 'http://www.aparat.com/live/tv1'},
			{text = 'شبکه 2️⃣', url = 'http://www.aparat.com/live/tv2'},
			{text = 'شبکه 3️⃣', url = 'http://www.aparat.com/live/tv3'}
			},
			{ 
			{text = 'شبکه 4️⃣', url = 'http://www.aparat.com/live/tv4'},
			{text = 'شبکه 5️⃣', url = 'http://www.aparat.com/live/tv5'},
			{text = 'شبکه خبر 📑', url = 'http://www.aparat.com/live/irinn'}
			},
			{ 
			{text = 'شبکه آی فیلم🎥', url = 'http://www.aparat.com/live/ifilm'},
			{text = 'شبکه نمایش🏞', url = 'http://www.aparat.com/live/namayesh'},
			{text = 'شبکه ورزش🤾‍♂️', url = 'http://www.aparat.com/live/varzesh'}
			},
			{ 
			{text = 'شبکه نسیم😛', url = 'http://www.aparat.com/live/nasim'},
			{text = 'شبکه مستند🙊', url = 'http://www.aparat.com/live/mostanad'},
			{text = 'شبکه قرآن🕌', url = 'http://www.aparat.com/live/quran'}
			},
			{ 
			{text = 'شبکه کودک👶🏻', url = 'http://www.aparat.com/live/pouya'},
			{text = 'شبکه تماشا 👀', url = 'http://www.aparat.com/live/hd'},
			{text = 'شبکه press tv🌐', url = 'http://www.aparat.com/live/press'}
			},
			{
			{text = '⇜ بازگشت ', callback_data = '/option:'..matches[2]}
		    }	
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/settings' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/mutelist' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/moresettings' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/locklink' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
end
local st = (lock_link == "warn") and "اخطار" or ((lock_link == "kick") and "اخراج" or ((lock_link == "silent") and "سکوت" or ((lock_link == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل لینک',lock_link,'link','/settings:','لینک',st)
end
if matches[1] == '/linkenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_link:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل لینک',lock_link,'link','/settings:','لینک',st)
	end
end
if matches[1] == '/linkdisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'lock_link:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل لینک',lock_link,'link','/settings:','لینک',st)
	end
end
if matches[1] == '/linkwarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_link:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل لینک',lock_link,'link','/settings:','لینک',st)
	end
end
if matches[1] == '/linkmute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_link:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل لینک',lock_link,'link','/settings:','لینک',st)
	end
end
if matches[1] == '/linkkick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_link:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل لینک',lock_link,'link','/settings:','لینک',st)
	end
end
if matches[1] == '/lockviews' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
end
local st = (lock_views == "warn") and "اخطار" or ((lock_views == "kick") and "اخراج" or ((lock_views == "silent") and "سکوت" or ((lock_views == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل بازدید',lock_views,'views','/settings:','بازدید',st)
end
if matches[1] == '/viewsenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_views:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل بازدید',lock_views,'views','/settings:','بازدید',st)
	end
end
if matches[1] == '/viewsdisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'lock_views:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل بازدید',lock_views,'views','/settings:','بازدید',st)
	end
end
if matches[1] == '/viewswarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_views:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل بازدید',lock_views,'views','/settings:','بازدید',st)
	end
end
if matches[1] == '/viewsmute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_views:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل بازدید',lock_views,'views','/settings:','بازدید',st)
	end
end
if matches[1] == '/viewskick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_views:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل بازدید',lock_views,'views','/settings:','بازدید',st)
	end
end
--####################### By @Arashwm #######################--
if matches[1] == '/lockedit' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (lock_edit == "warn") and "اخطار" or ((lock_edit == "kick") and "اخراج" or ((lock_edit == "silent") and "سکوت" or ((lock_edit == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل ویرایش پیام',lock_edit,'edit','/settings:','ویرایش پیام',st)
end
end
if matches[1] == '/editenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_edit:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل ویرایش پیام',lock_edit,'edit','/settings:','ویرایش پیام',st)
	end
end
if matches[1] == '/editdisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'lock_edit:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل ویرایش پیام',lock_edit,'edit','/settings:','ویرایش پیام',st)
	end
end
if matches[1] == '/editwarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_edit:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل ویرایش پیام',lock_edit,'edit','/settings:','ویرایش پیام',st)
	end
end
if matches[1] == '/editmute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_edit:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل ویرایش پیام',lock_edit,'edit','/settings:','ویرایش پیام',st)
	end
end
if matches[1] == '/editkick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_edit:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل ویرایش پیام',lock_edit,'edit','/settings:','ویرایش پیام',st)
	end
end
if matches[1] == '/locktags' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (lock_tag == "warn") and "اخطار" or ((lock_tag == "kick") and "اخراج" or ((lock_tag == "silent") and "سکوت" or ((lock_tag == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل تگ',lock_tag,'tag','/settings:','تگ',st)
end
end
if matches[1] == '/tagenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_tag:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل تگ',lock_tag,'tag','/settings:','تگ',st)
	end
end
if matches[1] == '/tagdisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'lock_tag:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل تگ',lock_tag,'tag','/settings:','تگ',st)
	end
end
if matches[1] == '/tagwarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_tag:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل تگ',lock_tag,'tag','/settings:','تگ',st)
	end
end
if matches[1] == '/tagmute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_tag:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل تگ',lock_tag,'tag','/settings:','تگ',st)
	end
end
if matches[1] == '/tagkick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_tag:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل تگ',lock_tag,'tag','/settings:','تگ',st)
	end
end
--####################### By @Arashwm #######################--
if matches[1] == '/lockusernames' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (lock_username == "warn") and "اخطار" or ((lock_username == "kick") and "اخراج" or ((lock_username == "silent") and "سکوت" or ((lock_username == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل نام کاربری',lock_username,'usernames','/settings:','نام کاربری',st)
end
end
if matches[1] == '/usernamesenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_username:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل نام کاربری',lock_username,'usernames','/settings:','نام کاربری',st)
	end
end
if matches[1] == '/usernamesdisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'lock_username:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل نام کاربری',lock_username,'usernames','/settings:','نام کاربری',st)
	end
end
if matches[1] == '/usernameswarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_username:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل نام کاربری',lock_username,'usernames','/settings:','نام کاربری',st)
	end
end
if matches[1] == '/usernamesmute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_username:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل نام کاربری',lock_username,'usernames','/settings:','نام کاربری',st)
	end
end
if matches[1] == '/usernameskick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_username:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل نام کاربری',lock_username,'usernames','/settings:','نام کاربری',st)
	end
end
--####################### By @Arashwm #######################--
if matches[1] == '/lockmention' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (lock_mention == "warn") and "اخطار" or ((lock_mention == "kick") and "اخراج" or ((lock_mention == "silent") and "سکوت" or ((lock_mention == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل منشن',lock_mention,'mention','/settings:','منشن',st)
end
end
if matches[1] == '/mentionenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_mention:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل منشن',lock_mention,'mention','/settings:','منشن',st)
	end
end
if matches[1] == '/mentiondisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'lock_mention:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل منشن',lock_mention,'mention','/settings:','منشن',st)
	end
end
if matches[1] == '/mentionwarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_mention:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل منشن',lock_mention,'mention','/settings:','منشن',st)
	end
end
if matches[1] == '/mentionmute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_mention:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل منشن',lock_mention,'mention','/settings:','منشن',st)
	end
end
if matches[1] == '/mentionkick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_mention:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل منشن',lock_mention,'mention','/settings:','منشن',st)
	end
end
if matches[1] == '/lockarabic' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (lock_arabic == "warn") and "اخطار" or ((lock_arabic == "kick") and "اخراج" or ((lock_arabic == "silent") and "سکوت" or ((lock_arabic == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل فارسی',lock_arabic,'farsi','/settings:','فارسی',st)
end
end
if matches[1] == '/farsienable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_arabic:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل فارسی',lock_arabic,'farsi','/settings:','فارسی',st)
	end
end
if matches[1] == '/farsidisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'lock_arabic:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل فارسی',lock_arabic,'farsi','/settings:','فارسی',st)
	end
end
if matches[1] == '/farsiwarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_arabic:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل فارسی',lock_arabic,'farsi','/settings:','فارسی',st)
	end
end
if matches[1] == '/farsimute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_arabic:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل فارسی',lock_arabic,'farsi','/settings:','فارسی',st)
	end
end
if matches[1] == '/farsikick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_arabic:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل فارسی',lock_arabic,'farsi','/settings:','فارسی',st)
	end
end
if matches[1] == '/lockwebpage' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (lock_webpage == "warn") and "اخطار" or ((lock_webpage == "kick") and "اخراج" or ((lock_webpage == "silent") and "سکوت" or ((lock_webpage == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل وبسایت',lock_webpage,'web','/settings:','وبسایت',st)
end
end
if matches[1] == '/webenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_webpage:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل وبسایت',lock_webpage,'web','/settings:','وبسایت',st)
	end
end
if matches[1] == '/webdisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'lock_webpage:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل وبسایت',lock_webpage,'web','/settings:','وبسایت',st)
	end
end
if matches[1] == '/webwarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_webpage:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل وبسایت',lock_webpage,'web','/settings:','وبسایت',st)
	end
end
if matches[1] == '/webmute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_webpage:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل وبسایت',lock_webpage,'web','/settings:','وبسایت',st)
	end
end
if matches[1] == '/webkick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_webpage:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل وبسایت',lock_webpage,'web','/settings:','وبسایت',st)
	end
end
if matches[1] == '/lockmarkdown' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (lock_markdown == "warn") and "اخطار" or ((lock_markdown == "kick") and "اخراج" or ((lock_markdown == "silent") and "سکوت" or ((lock_markdown == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل فونت',lock_markdown,'markdown','/settings:','فونت',st)
end
end
if matches[1] == '/markdownenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_markdown:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل فونت',lock_markdown,'markdown','/settings:','فونت',st)
	end
end
if matches[1] == '/markdowndisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'lock_markdown:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل فونت',lock_markdown,'markdown','/settings:','فونت',st)
	end
end
if matches[1] == '/markdownwarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_markdown:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل فونت',lock_markdown,'markdown','/settings:','فونت',st)
	end
end
if matches[1] == '/markdownmute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_markdown:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل فونت',lock_markdown,'markdown','/settings:','فونت',st)
	end
end
if matches[1] == '/markdownkick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'lock_markdown:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل فونت',lock_markdown,'markdown','/settings:','فونت',st)
	end
end
if matches[1] == '/mutevideonote' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (mute_video_note == "warn") and "اخطار" or ((mute_video_note == "kick") and "اخراج" or ((mute_video_note == "silent") and "سکوت" or ((mute_video_note == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل فیلم سلفی',mute_video_note,'note','/mutelist:','فیلم سلفی',st)
end
end
if matches[1] == '/noteenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_video_note:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل فیلم سلفی',mute_video_note,'note','/mutelist:','فیلم سلفی',st)
	end
end
if matches[1] == '/notedisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'mute_video_note:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل فیلم سلفی',mute_video_note,'note','/mutelist:','فیلم سلفی',st)
	end
end
if matches[1] == '/notewarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_video_note:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل فیلم سلفی',mute_video_note,'note','/mutelist:','فیلم سلفی',st)
	end
end
if matches[1] == '/notemute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_video_note:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل فیلم سلفی',mute_video_note,'note','/mutelist:','فیلم سلفی',st)
	end
end
if matches[1] == '/notekick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_video_note:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل فیلم سلفی',mute_video_note,'note','/mutelist:','فیلم سلفی',st)
	end
end
if matches[1] == '/mutegif' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (mute_gif == "warn") and "اخطار" or ((mute_gif == "kick") and "اخراج" or ((mute_gif == "silent") and "سکوت" or ((mute_gif == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل گیف',mute_gif,'gif','/mutelist:','گیف',st)	
end
end
if matches[1] == '/gifenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_gif:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل گیف',mute_gif,'gif','/mutelist:','گیف',st)	
	end
end
if matches[1] == '/gifdisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'mute_gif:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل گیف',mute_gif,'gif','/mutelist:','گیف',st)	
	end
end
if matches[1] == '/gifwarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_gif:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل گیف',mute_gif,'gif','/mutelist:','گیف',st)	
	end
end
if matches[1] == '/gifmute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_gif:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل گیف',mute_gif,'gif','/mutelist:','گیف',st)	
	end
end
if matches[1] == '/gifkick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_gif:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل گیف',mute_gif,'gif','/mutelist:','گیف',st)	
	end
end
if matches[1] == '/mutetext' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (mute_text == "warn") and "اخطار" or ((mute_text == "kick") and "اخراج" or ((mute_text == "silent") and "سکوت" or ((mute_text == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل متن',mute_text,'text','/mutelist:','متن',st)		
end
end
if matches[1] == '/textenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_text:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل متن',mute_text,'text','/mutelist:','متن',st)
	end
end
if matches[1] == '/textdisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'mute_text:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل متن',mute_text,'text','/mutelist:','متن',st)
	end
end
if matches[1] == '/textwarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_text:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل متن',mute_text,'text','/mutelist:','متن',st)
	end
end
if matches[1] == '/textmute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_text:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل متن',mute_text,'text','/mutelist:','متن',st)
	end
end
if matches[1] == '/textkick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_text:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل متن',mute_text,'text','/mutelist:','متن',st)
	end
end
if matches[1] == '/muteinline' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (mute_inline == "warn") and "اخطار" or ((mute_inline == "kick") and "اخراج" or ((mute_inline == "silent") and "سکوت" or ((mute_inline == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل دکمه شیشه ای',mute_inline,'inline','/mutelist:','دکمه شیشه ای',st)	
end
end
if matches[1] == '/inlineenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_inline:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل دکمه شیشه ای',mute_inline,'inline','/mutelist:','دکمه شیشه ای',st)
	end
end
if matches[1] == '/inlinedisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'mute_inline:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل دکمه شیشه ای',mute_inline,'inline','/mutelist:','دکمه شیشه ای',st)
	end
end
if matches[1] == '/inlinewarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_inline:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل دکمه شیشه ای',mute_inline,'inline','/mutelist:','دکمه شیشه ای',st)
	end
end
if matches[1] == '/inlinemute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_inline:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل دکمه شیشه ای',mute_inline,'inline','/mutelist:','دکمه شیشه ای',st)
	end
end
if matches[1] == '/inlinekick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_inline:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل دکمه شیشه ای',mute_inline,'inline','/mutelist:','دکمه شیشه ای',st)
	end
end
if matches[1] == '/mutegame' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (mute_game == "warn") and "اخطار" or ((mute_game == "kick") and "اخراج" or ((mute_game == "silent") and "سکوت" or ((mute_game == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل بازی',mute_game,'game','/mutelist:','بازی',st)	
end
end
if matches[1] == '/gameenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_game:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل بازی',mute_game,'game','/mutelist:','بازی',st)
	end
end
if matches[1] == '/gamedisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'mute_game:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل بازی',mute_game,'game','/mutelist:','بازی',st)
	end
end
if matches[1] == '/gamewarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_game:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل بازی',mute_game,'game','/mutelist:','بازی',st)
	end
end
if matches[1] == '/gamemute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_game:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل بازی',mute_game,'game','/mutelist:','بازی',st)
	end
end
if matches[1] == '/gamekick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_game:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل بازی',mute_game,'game','/mutelist:','بازی',st)
	end
end
if matches[1] == '/mutephoto' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (mute_photo == "warn") and "اخطار" or ((mute_photo == "kick") and "اخراج" or ((mute_photo == "silent") and "سکوت" or ((mute_photo == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل عکس',mute_photo,'photo','/mutelist:','عکس',st)	
end
end
if matches[1] == '/photoenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_photo:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل عکس',mute_photo,'photo','/mutelist:','عکس',st)
	end
end
if matches[1] == '/photodisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'mute_photo:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل عکس',mute_photo,'photo','/mutelist:','عکس',st)
	end
end
if matches[1] == '/photowarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_photo:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل عکس',mute_photo,'photo','/mutelist:','عکس',st)
	end
end
if matches[1] == '/photomute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_photo:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل عکس',mute_photo,'photo','/mutelist:','عکس',st)
	end
end
if matches[1] == '/photokick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_photo:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل عکس',mute_photo,'photo','/mutelist:','عکس',st)
	end
end
if matches[1] == '/mutevideo' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (mute_video == "warn") and "اخطار" or ((mute_video == "kick") and "اخراج" or ((mute_video == "silent") and "سکوت" or ((mute_video == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل فیلم',mute_video,'video','/mutelist:','فیلم',st)	
end
end
if matches[1] == '/videoenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_video:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل فیلم',mute_video,'video','/mutelist:','فیلم',st)
	end
end
if matches[1] == '/videodisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'mute_video:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل فیلم',mute_video,'video','/mutelist:','فیلم',st)
	end
end
if matches[1] == '/videowarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_video:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل فیلم',mute_video,'video','/mutelist:','فیلم',st)
	end
end
if matches[1] == '/videomute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_video:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل فیلم',mute_video,'video','/mutelist:','فیلم',st)
	end
end
if matches[1] == '/videokick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_video:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل فیلم',mute_video,'video','/mutelist:','فیلم',st)
	end
end
if matches[1] == '/muteaudio' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (mute_audio == "warn") and "اخطار" or ((mute_audio == "kick") and "اخراج" or ((mute_audio == "silent") and "سکوت" or ((mute_audio == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل آهنگ',mute_audio,'audio','/mutelist:','آهنگ',st)	
end
end
if matches[1] == '/audioenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_audio:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل آهنگ',mute_audio,'audio','/mutelist:','آهنگ',st)
	end
end
if matches[1] == '/audiodisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'mute_audio:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل آهنگ',mute_audio,'audio','/mutelist:','آهنگ',st)
	end
end
if matches[1] == '/audiowarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_audio:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل آهنگ',mute_audio,'audio','/mutelist:','آهنگ',st)
	end
end
if matches[1] == '/audiomute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_audio:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل آهنگ',mute_audio,'audio','/mutelist:','آهنگ',st)
	end
end
if matches[1] == '/audiokick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_audio:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل آهنگ',mute_audio,'audio','/mutelist:','آهنگ',st)
	end
end
if matches[1] == '/mutevoice' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (mute_voice == "warn") and "اخطار" or ((mute_voice == "kick") and "اخراج" or ((mute_voice == "silent") and "سکوت" or ((mute_voice == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل ویس',mute_voice,'voice','/mutelist:','ویس',st)
end	
end
if matches[1] == '/voiceenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_voice:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل ویس',mute_voice,'voice','/mutelist:','ویس',st)
	end
end
if matches[1] == '/voicedisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'mute_voice:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل ویس',mute_voice,'voice','/mutelist:','ویس',st)
	end
end
if matches[1] == '/voicewarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_voice:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل ویس',mute_voice,'voice','/mutelist:','ویس',st)
	end
end
if matches[1] == '/voicemute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_voice:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل ویس',mute_voice,'voice','/mutelist:','ویس',st)
	end
end
if matches[1] == '/voicekick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_voice:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل ویس',mute_voice,'voice','/mutelist:','ویس',st)
	end
end
if matches[1] == '/mutesticker' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (mute_sticker == "warn") and "اخطار" or ((mute_sticker == "kick") and "اخراج" or ((mute_sticker == "silent") and "سکوت" or ((mute_sticker == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل استیکر',mute_sticker,'sticker','/mutelist:','استیکر',st)	
end
end
if matches[1] == '/stickerenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_sticker:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل استیکر',mute_sticker,'sticker','/mutelist:','استیکر',st)
	end
end
if matches[1] == '/stickerdisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'mute_sticker:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل استیکر',mute_sticker,'sticker','/mutelist:','استیکر',st)
	end
end
if matches[1] == '/stickerwarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_sticker:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل استیکر',mute_sticker,'sticker','/mutelist:','استیکر',st)
	end
end
if matches[1] == '/stickermute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_sticker:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل استیکر',mute_sticker,'sticker','/mutelist:','استیکر',st)
	end
end
if matches[1] == '/stickerkick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_sticker:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل استیکر',mute_sticker,'sticker','/mutelist:','استیکر',st)
	end
end
if matches[1] == '/mutecontact' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (mute_contact == "warn") and "اخطار" or ((mute_contact == "kick") and "اخراج" or ((mute_contact == "silent") and "سکوت" or ((mute_contact == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],M_START..'قفل مخاطب',mute_contact,'contact','/mutelist:','مخاطب',st)	
end
end
if matches[1] == '/contactenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_contact:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],M_START..'قفل مخاطب',mute_contact,'contact','/mutelist:','مخاطب',st)
	end
end
if matches[1] == '/contactdisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'mute_contact:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],M_START..'قفل مخاطب',mute_contact,'contact','/mutelist:','مخاطب',st)
	end
end
if matches[1] == '/contactwarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_contact:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],M_START..'قفل مخاطب',mute_contact,'contact','/mutelist:','مخاطب',st)
	end
end
if matches[1] == '/contactmute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_contact:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],M_START..'قفل مخاطب',mute_contact,'contact','/mutelist:','مخاطب',st)
	end
end
if matches[1] == '/contactkick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_contact:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],M_START..'قفل مخاطب',mute_contact,'contact','/mutelist:','مخاطب',st)
	end
end
if matches[1] == '/muteforward' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (mute_forward == "warn") and "اخطار" or ((mute_forward == "kick") and "اخراج" or ((mute_forward == "silent") and "سکوت" or ((mute_forward == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],'⇜ قفل فوروارد',mute_forward,'fwd','/mutelist:','فوروارد',st)	
end
end
if matches[1] == '/fwdenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_forward:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],'⇜ قفل فوروارد',mute_forward,'fwd','/mutelist:','فوروارد',st)
	end
end
if matches[1] == '/fwddisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'mute_forward:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],'⇜ قفل فوروارد',mute_forward,'fwd','/mutelist:','فوروارد',st)
	end
end
if matches[1] == '/fwdwarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_forward:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],'⇜ قفل فوروارد',mute_forward,'fwd','/mutelist:','فوروارد',st)
	end
end
if matches[1] == '/fwdmute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_forward:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],'⇜ قفل فوروارد',mute_forward,'fwd','/mutelist:','فوروارد',st)
	end
end
if matches[1] == '/fwdkick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_forward:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],'⇜ قفل فوروارد',mute_forward,'fwd','/mutelist:','فوروارد',st)
	end
end
--####################### By @Arashwm #######################--
if matches[1] == '/mutelocation' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (mute_location == "warn") and "اخطار" or ((mute_location == "kick") and "اخراج" or ((mute_location == "silent") and "سکوت" or ((mute_location == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],'⇜ قفل مکان',mute_location,'location','/mutelist:','مکان',st)
end
end
if matches[1] == '/locationenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_location:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],'⇜ قفل مکان',mute_location,'location','/mutelist:','مکان',st)
	end
end
if matches[1] == '/locationdisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'mute_location:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],'⇜ قفل مکان',mute_location,'location','/mutelist:','مکان',st)
	end
end
if matches[1] == '/locationwarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_location:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],'⇜ قفل مکان',mute_location,'location','/mutelist:','مکان',st)
	end
end
if matches[1] == '/locationmute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_location:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],'⇜ قفل مکان',mute_location,'location','/mutelist:','مکان',st)
	end
end
if matches[1] == '/locationkick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_location:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],'⇜ قفل مکان',mute_location,'location','/mutelist:','مکان',st)
	end
end
--####################### By @Arashwm #######################--
if matches[1] == '/mutedocument' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (mute_document == "warn") and "اخطار" or ((mute_document == "kick") and "اخراج" or ((mute_document == "silent") and "سکوت" or ((mute_document == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],'⇜ قفل فایل',mute_document,'document','/mutelist:','فایل',st)	
end
end
if matches[1] == '/documentenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_document:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],'⇜ قفل فایل',mute_document,'document','/mutelist:','فایل',st)
	end
end
if matches[1] == '/documentdisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'mute_document:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],'⇜ قفل فایل',mute_document,'document','/mutelist:','فایل',st)
	end
end
if matches[1] == '/documentwarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_document:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],'⇜ قفل فایل',mute_document,'document','/mutelist:','فایل',st)
	end
end
if matches[1] == '/documentmute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_document:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],'⇜ قفل فایل',mute_document,'document','/mutelist:','فایل',st)
	end
end
if matches[1] == '/documentkick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_document:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],'⇜ قفل فایل',mute_document,'document','/mutelist:','فایل',st)
	end
end
--####################### By @Arashwm #######################--
if matches[1] == '/mutekeyboard' then
if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
local st = (mute_keyboard == "warn") and "اخطار" or ((mute_keyboard == "kick") and "اخراج" or ((mute_keyboard == "silent") and "سکوت" or ((mute_keyboard == "yes") and "فعال" or "غیرفعال")))
locks(msg,matches[2],'⇜ قفل کیبورد شیشه ای',mute_keyboard,'keyboard','/mutelist:','کیبورد شیشه ای',st)
end
end
if matches[1] == '/keyboardenable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_keyboard:'..matches[2], 'Enable')
local st = "فعال"
locks(msg,matches[2],'⇜ قفل کیبورد شیشه ای',mute_keyboard,'keyboard','/mutelist:','کیبورد شیشه ای',st)
	end
end
if matches[1] == '/keyboarddisable' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:del(RedisIndex..'mute_keyboard:'..matches[2])
local st = "غیرفعال"
locks(msg,matches[2],'⇜ قفل کیبورد شیشه ای',mute_keyboard,'keyboard','/mutelist:','کیبورد شیشه ای',st)
	end
end
if matches[1] == '/keyboardwarn' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_keyboard:'..matches[2], 'Warn')
local st = "اخطار"
locks(msg,matches[2],'⇜ قفل کیبورد شیشه ای',mute_keyboard,'keyboard','/mutelist:','کیبورد شیشه ای',st)
	end
end
if matches[1] == '/keyboardmute' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_keyboard:'..matches[2], 'Mute')
local st = "سکوت"
locks(msg,matches[2],'⇜ قفل کیبورد شیشه ای',mute_keyboard,'keyboard','/mutelist:','کیبورد شیشه ای',st)
	end
end
if matches[1] == '/keyboardkick' then
	if not is_mod1(matches[2], msg.from.id) then
		Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
redis:set(RedisIndex..'mute_keyboard:'..matches[2], 'Kick')
local st = "اخراج"
locks(msg,matches[2],'⇜ قفل کیبورد شیشه ای',mute_keyboard,'keyboard','/mutelist:','کیبورد شیشه ای',st)
	end
end
--####################### By @Arashwm #######################--
if matches[1] == '/lockjoin' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local chklock = redis:get(RedisIndex..'lock_join:'..matches[2])
		if chklock == "no" then
			text = 'قفل ورود فعال شد'
			redis:del(RedisIndex..'lock_join:'..matches[2])
		elseif chklock == "yes" then
			text = 'قفل ورود غیر فعال شد'
			redis:set(RedisIndex..'lock_join:'..matches[2], 'Enable')
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockflood' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local chklock = redis:get(RedisIndex..'lock_flood:'..matches[2])
		if chklock then
			text = 'قفل پیام های مکرر غیر فعال شد'
			redis:del(RedisIndex..'lock_flood:'..matches[2])
		else
			text = 'قفل پیام های مکرر فعال شد'
			redis:set(RedisIndex..'lock_flood:'..matches[2], 'Enable')
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockspam' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local chklock = redis:get(RedisIndex..'lock_spam:'..matches[2])
		if chklock then
			text = 'قفل هرزنامه غیر فعال شد'
			redis:del(RedisIndex..'lock_spam:'..matches[2])
		else
			text = 'قفل هرزنامه فعال شد'
			redis:set(RedisIndex..'lock_spam:'..matches[2], 'Enable')
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockpin' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local chklock = redis:get(RedisIndex..'lock_pin:'..matches[2])
		if chklock then
			text = 'قفل سنجاق کردن فعال شد'
			redis:del(RedisIndex..'lock_pin:'..matches[2])
		else
			text = 'قفل سنجاق کردن غیر فعال شد'
			redis:set(RedisIndex..'lock_pin:'..matches[2], 'Enable')
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/lockbots' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local chklock = redis:get(RedisIndex..'lock_bots:'..matches[2])
		if chklock then
			text = 'قفل ربات ها فعال شد'
			redis:del(RedisIndex..'lock_bots:'..matches[2])
		else
			text = 'قفل ربات ها غیر فعال شد'
			redis:set(RedisIndex..'lock_bots:'..matches[2], 'Enable')
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/welcome' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local chklock = redis:get(RedisIndex..'welcome:'..matches[2])
		if chklock then
			text = 'خوش آمد گویی فعال شد'
			redis:del(RedisIndex..'welcome:'..matches[2])
		else
			text = 'خوش آمد گویی غیر فعال شد'
			redis:set(RedisIndex..'welcome:'..matches[2], 'Enable')
		end
		get_alert(msg.cb_id, text)
		setting(msg, data, matches[2])
	end
end
if matches[1] == '/floodup' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local flood_max = redis:get(RedisIndex..matches[2]..'num_msg_max') or 5
		if tonumber(flood_max) < 30 then
			flood_max = tonumber(flood_max) + 1
			redis:set(RedisIndex..matches[2]..'num_msg_max', flood_max)
			text = "حساسیت پیام های مکرر تنظیم شد به : "..flood_max
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/flooddown' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local flood_max = redis:get(RedisIndex..matches[2]..'num_msg_max') or 5
		if tonumber(flood_max) > 2 then
			flood_max = tonumber(flood_max) - 1
			redis:set(RedisIndex..matches[2]..'num_msg_max', flood_max)
			text = "حساسیت پیام های مکرر تنظیم شد به : "..flood_max
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/charup' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local char_max = redis:get(RedisIndex..matches[2]..'set_char') or 40
		if tonumber(char_max) < 1000 then
			char_max = tonumber(char_max) + 1
			redis:set(RedisIndex..matches[2]..'set_char', char_max)
			text = "تعداد حروف مجاز تنظیم شد به : "..char_max
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/chardown' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local char_max = redis:get(RedisIndex..matches[2]..'set_char') or 40
		if tonumber(char_max) > 2 then
			char_max = tonumber(char_max) - 1
			redis:set(RedisIndex..matches[2]..'set_char', char_max)
			text = "تعداد حروف مجاز تنظیم شد به : "..char_max
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/floodtimeup' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local check_time = redis:get(RedisIndex..matches[2]..'time_check') or 2
		if tonumber(check_time) < 10 then
			check_time = tonumber(check_time) + 1
			redis:set(RedisIndex..matches[2]..'time_check', check_time)
			text = "زمان بررسی پیام های مکرر تنظیم شد به : "..check_time
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end
if matches[1] == '/floodtimedown' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local check_time = 2
		if tonumber(check_time) > 2 then
			check_time = tonumber(check_time) - 1
			redis:set(RedisIndex..matches[2]..'time_check', check_time)
			text = "زمان بررسی پیام های مکرر تنظیم شد به : "..check_time
			get_alert(msg.cb_id, text)
		end 
		moresetting(msg, data, matches[2])
	end
end		
if matches[1] == '/muteall' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local chkmute = redis:get(RedisIndex..'mute_all:'..matches[2])
		if chkmute then
        text = 'بیصدا کردن همه فعال شد'
			redis:del(RedisIndex..'mute_all:'..matches[2])
		else
        text = 'بیصدا کردن همه غیر فعال شد'
			redis:set(RedisIndex..'mute_all:'..matches[2], 'Enable')
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end
if matches[1] == '/mutetgservice' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local chkmute = redis:get(RedisIndex..'mute_tgservice:'..matches[2])
		if chkmute then
        text = 'بیصدا کردن خدمات تلگرام فعال شد'
			redis:del(RedisIndex..'mute_tgservice:'..matches[2])
		else
        text = 'بیصدا کردن خدمات تلگرام غیر فعال شد'
			redis:set(RedisIndex..'mute_tgservice:'..matches[2], 'Enable')
		end
		get_alert(msg.cb_id, text)
		mutelists(msg, data, matches[2])
	end
end	
if matches[1] == '/more' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ لیست مالکین", callback_data="/ownerlist:"..matches[2]},
				{text = "⇜ لیست مدیران", callback_data="/modlist:"..matches[2]}
			},
			{
				{text = "⇜ لیست سایلنت", callback_data="/silentlist:"..matches[2]},
				{text = "⇜ لیست فیلتر", callback_data="/filterlist:"..matches[2]}
			},
			{
				{text = "⇜ لیست بن", callback_data="/bans:"..matches[2]},
				{text = "⇜ لیست سفید", callback_data="/whitelists:"..matches[2]}
			},
			{
				{text = "⇜ لینک گروه", callback_data="/link:"..matches[2]},
				{text = "⇜ قوانین گروه", callback_data="/rules:"..matches[2]}
			},
			{
				{text = "⇜ نمایش پیام خوشامد", callback_data="/showwlc:"..matches[2]},
			},
			{ 
				{text = "⇜ بازگشت به تنظیمات کلی", callback_data="/option:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/ownerlist' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
	local list = redis:smembers(RedisIndex..'Owners:'..matches[2])
	if not redis:get(RedisIndex.."CheckBot:"..matches[2]) then
		text = M_START..'`گروه در` #لیست `گروه ربات  نیست`'..EndPm
	end
	text = M_START..'*لیست مالکین گروه :*\n'
	for k,v in pairs(list) do
	local user_name = redis:get(RedisIndex..'user_name:'..v)
		text = text..k.."- "..v.." [" ..check_markdown(user_name).. "]\n" 
	end
	if #list == 0 then
		text = M_START.."`در حال حاضر هیچ مالکی برای گروه انتخاب نشده است`"..EndPm
	end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ برکناری تمام مالکین", callback_data="/cleanowners:"..matches[2]}
			},
			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleanowners' then
	if not is_admin1(msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Bot Admin")
   elseif lang then
		get_alert(msg.cb_id, "شما ادمین ربات نیستید")
   end
	else
		local list = redis:smembers(RedisIndex..'Owners:'..msg.to.id)
		if #list == 0 then
			text = M_START.."`مالکی برای گروه انتخاب نشده است`"..EndPm
		end
		redis:del(RedisIndex.."Owners:"..msg.to.id)
		text = M_START.."`تمامی مالکان گروه تنزیل مقام شدند`"..EndPm
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ بازگشت", callback_data="/ownerlist:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/filterlist' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local names = redis:hkeys(RedisIndex..'filterlist:'..matches[2])
    text = M_START..'`لیست کلمات فیلتر شده :`\n'
    local b = 1
        for i = 1, #names do
			text = text .. b .. ". " .. names[i] .. "\n"
            b = b + 1
        end
    if #names == 0 then
		text = M_START.."`لیست کلمات فیلتر شده خالی است`"..EndPm
    end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ پاک کردن", callback_data="/cleanfilterlist:"..matches[2]}
			},
			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleanfilterlist' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local names = redis:hkeys(RedisIndex..'filterlist:'..msg.to.id)
						if #names == 0 then
							text = M_START.."`لیست کلمات فیلتر شده خالی است`"..EndPm
						end
						redis:del(RedisIndex..'filterlist:'..msg.to.id)
						text = M_START.."`لیست کلمات فیلتر شده پاک شد`"..EndPm
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ بازگشت", callback_data="/filterlist:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/modlist' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local list = redis:smembers(RedisIndex..'Mods:'..matches[2])
	if not redis:get(RedisIndex.."CheckBot:"..matches[2]) then
		text = M_START..'`گروه در` #لیست `گروه ربات  نیست`'..EndPm
	end
	text = M_START..'*لیست مدیران گروه :*\n'
	for k,v in pairs(list) do
	local user_name = redis:get(RedisIndex..'user_name:'..v)
	text = text..k.."- "..v.." [" ..check_markdown(user_name).. "]\n" 
	end
	if #list == 0 then
	text = M_START.."`در حال حاضر هیچ مدیری برای گروه انتخاب نشده است`"..EndPm
	end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ برکناری تمام مدیران", callback_data="/cleanmods:"..matches[2]}
			},
			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleanmods' then
	if not is_owner1(matches[2], msg.from.id) then
     if not lang then
		get_alert(msg.cb_id, "You Are Not Group Owner")
   elseif lang then
		get_alert(msg.cb_id, "شما صاحب گروه نیستید")
   end
	else
		local list = redis:smembers(RedisIndex..'Mods:'..matches[2])
						if #list == 0 then
							text = M_START.."هیچ مدیری برای گروه انتخاب نشده است"..EndPm
						end
						redis:del(RedisIndex.."Mods:"..matches[2])
						text = M_START.."`تمام مدیران گروه تنزیل مقام شدند`"..EndPm
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ بازگشت", callback_data="/modlist:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/bans' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local list = redis:smembers(RedisIndex.."Banned:"..matches[2])
	if not redis:get(RedisIndex.."CheckBot:"..matches[2]) then
		text = M_START..'`گروه در` #لیست `گروه ربات  نیست`'..EndPm
	end
	text = M_START..'*لیست کاربران محروم شده از گروه :*\n'
	for k,v in pairs(list) do
	local user_name = redis:get(RedisIndex..'user_name:'..v)
	text = text..k.."- "..check_markdown(user_name).." [" ..v.. "]\n" 
	end
	if #list == 0 then
	text = M_START.."*هیچ کاربری از این گروه محروم نشده*"..EndPm
	end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ پاک کردن لیست بن ", callback_data="/cleanbans:"..matches[2]}
			},
			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleanbans' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local list = redis:smembers(RedisIndex..'Banned:'..matches[2])
							if #list == 0 then
								text = M_START.."*هیچ کاربری از این گروه محروم نشده*"..EndPm
							end
							redis:del(RedisIndex.."Banned:"..matches[2])
							text = M_START.."*تمام کاربران محروم شده از گروه از محرومیت خارج شدند*"..EndPm
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ بازگشت", callback_data="/bans:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/link' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local linkgp = redis:get(RedisIndex..matches[2]..'linkgpset')
		if not linkgp then
			text = "↫ ابتدا با دستور setlink/ لینک جدیدی برای گروه تعیین کنید"
		else
			text = "●•۰ [لینک گروه اینجاست]("..linkgp..")\n"
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/rules' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local rules = redis:get(RedisIndex..matches[2]..'rules')
		if not rules then
       text = "↫ قوانین ثبت نشده است"
		elseif rules then
			text = '●•۰ قوانین گروه :\n'..rules
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ پاک کردن", callback_data="/cleanrules:"..matches[2]}
			},
			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
if matches[1] == '/cleanrules' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local rules = redis:get(RedisIndex..matches[2]..'rules')
		if not rules then
			text = "↫ قوانین گروه ثبت نشده"
		else
			text = "ツ قوانین گروه پاک شد"
			redis:del(RedisIndex..matches[2]..'rules')
		end
		keyboard = {} 
		keyboard.inline_keyboard = {
			{
				{text = "⇜ بازگشت", callback_data="/rules:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
	end
end
		if matches[1] == '/whitelists' then
			if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local list = redis:smembers(RedisIndex.."Whitelist:"..matches[2])
	if not redis:get(RedisIndex.."CheckBot:"..matches[2]) then
		text = M_START..'`گروه در` #لیست `گروه ربات  نیست`'..EndPm
	end
	text = M_START..'`کاربران لیست سفید :`\n'
	for k,v in pairs(list) do
	local user_name = redis:get(RedisIndex..'user_name:'..v)
	text = text..k.."- "..check_markdown(user_name).." [" ..v.. "]\n" 
	end
	if #list == 0 then
	text = M_START.."*هیچ کاربری در لیست سفید وجود ندارد*"..EndPm
	end
		local keyboard = {}
		keyboard.inline_keyboard = {
			{
				{text = "⇜ حذف لیست سفید", callback_data="/cleanwhitelists:"..matches[2]}
			},
			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
end
end
if matches[1] == '/cleanwhitelists' then
			if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		if redis:get(RedisIndex.."Whitelist:"..matches[2]) then
				text = "↫ لیست سفید خالی می باشد."
		else
				text = "ツ لیست سفید حذف شد."
			redis:del(RedisIndex.."Whitelist:"..matches[2])
		end
		local keyboard = {} 
				keyboard.inline_keyboard = {

			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
		end
end
if matches[1] == '/showwlc' then
local text = ''
if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		local wlc = redis:get(RedisIndex..'welcome:'..matches[2])
		if not wlc then
				text = "↫ پیام خوشامد تنظیم نشده است."
		else
			text = '●•۰ پیام خوشامد:\n'..wlc
		end
		local keyboard = {} 
		keyboard.inline_keyboard = {
			{ 
				{text = "⇜ حذف پیام خوشامد", callback_data="/cleanwlcmsg:"..matches[2]}
			},
			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
end
end
if matches[1] == '/cleanwlcmsg' then
local text = ''
if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
local wlc = redis:get(RedisIndex..'welcome:'..matches[2])
		if not wlc then
				text = "↫ پیام خوشامد تنظیم نشده است."
		else
			text = 'ツ پیام خوشامد حذف شد.'
		redis:del(RedisIndex..'welcome:'..matches[2])
end
local keyboard = {} 
				keyboard.inline_keyboard = {

			{ 
				{text = "⇜ بازگشت", callback_data="/more:"..matches[2]}
			}
		}
		edit_inline(msg.message_id, text, keyboard)
end
end
if matches[1] == '/exit' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
		 text = 'ツ تنظیمات گروه بسته شده'
		edit_inline(msg.message_id, text)
	end
end
if matches[1] == '/addlimmenu' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		addlimpanel(msg, matches[2])
	end
end
if matches[1] == '/addlimmenu2' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		addlimpanel2(msg, matches[2])
	end
end
if matches[1] == '/addlimup' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
			getadd = redis:hget(RedisIndex..'addmemset', matches[2]) or "0"
			if tonumber(getadd) < 10 then
			redis:hset(RedisIndex..'addmemset', matches[2], getadd + 1)
			text = "تنظیم محدودیت اضافه کردن کاربر به : "..getadd
			get_alert(msg.cb_id, text)
			end
		addlimpanel(msg, matches[2])
	end
end		
if matches[1] == '/addlimdown' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
			getadd = redis:hget(RedisIndex..'addmemset', matches[2]) or "0"
			if tonumber(getadd) > 1 then
			redis:hset(RedisIndex..'addmemset', matches[2], getadd - 1)	
			text = "تنظیم محدودیت اضافه کردن کاربر به : "..getadd
			get_alert(msg.cb_id, text)
			end
		addlimpanel(msg, matches[2])
	end
end	
if matches[1] == '/addlimlock' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		redis:hset(RedisIndex..'addmeminv', matches[2], 'on')
		Canswer(msg.cb_id, "₪ محدودیت اضافه کردن کاربر #فعال شد" ,true)
		addlimpanel(msg, matches[2])
	end
end	
if matches[1] == '/addlimunlock' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		redis:hset(RedisIndex..'addmeminv', matches[2], 'off')
		Canswer(msg.cb_id, "₪ محدودیت اضافه کردن کاربر #غیرفعال شد" ,true)
		addlimpanel(msg, matches[2])
	end
end	
if matches[1] == '/addpmon' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		redis:del(RedisIndex..'addpm'..matches[2])
		Canswer(msg.cb_id, "₪ ارسال پیام محدودیت کاربر #فعال شد" ,true)
		addlimpanel(msg, matches[2])
	end
end	
if matches[1] == '/addpmoff' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true)
   elseif not is_req(matches[2], msg.from.id) then 
    Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true)
	else
		redis:set(RedisIndex..'addpm'..matches[2], true)
		Canswer(msg.cb_id, "₪ ارسال پیام محدودیت کاربر #غیرفعال شد" ,true)
		addlimpanel(msg, matches[2])
	end
end	
if matches[1] == '/exitadd' then
	if not is_mod1(matches[2], msg.from.id) then
     Canswer(msg.cb_id, M_START.."شما مدیر نیستید \nبرای خرید ربات به پیوی :\n "..sudo_username.."\nیا به کانال زیر مراجعه کنید :\n "..channel_username.."" ,true) 
   elseif not is_req(matches[2], msg.from.id) then 
        Canswer(msg.cb_id, M_START.."شما این فهرست را درخواست نکردید" ,true) 
	else
		 text = 'ツ تنظیمات محدودیت کاربر بسته شده'
		edit_inline(msg.message_id, text)
	end
end
if matches[1] == 'TiiGeRTeaM' then
Canswer(msg.cb_id, "داری اشتباه میزنی" ,true) 
end
end
end

return {
	patterns ={
		"^###cb:(TiiGeRTeaM):(.*)$",
		"^###cb:(/addlimmenu):(.*)$",
		"^###cb:(/addlimmenu2):(.*)$",
		"^###cb:(/linkenable):(.*)$",
		"^###cb:(/linkdisable):(.*)$",
		"^###cb:(/linkwarn):(.*)$",
		"^###cb:(/linkmute):(.*)$",
		"^###cb:(/linkkick):(.*)$",
		"^###cb:(/editenable):(.*)$",
		"^###cb:(/lockviews):(.*)$",
		"^###cb:(/viewsenable):(.*)$",
		"^###cb:(/viewsdisable):(.*)$",
		"^###cb:(/viewswarn):(.*)$",
		"^###cb:(/viewsmute):(.*)$",
		"^###cb:(/viewskick):(.*)$",
		"^###cb:(/editdisable):(.*)$",
		"^###cb:(/editwarn):(.*)$",
		"^###cb:(/editmute):(.*)$",
		"^###cb:(/editkick):(.*)$",
		"^###cb:(/tagenable):(.*)$",
		"^###cb:(/tagdisable):(.*)$",
		"^###cb:(/tagwarn):(.*)$",
		"^###cb:(/tagmute):(.*)$",
		"^###cb:(/tagkick):(.*)$",
		"^###cb:(/usernamesenable):(.*)$",
		"^###cb:(/usernamesdisable):(.*)$",
		"^###cb:(/usernameswarn):(.*)$",
		"^###cb:(/usernamesmute):(.*)$",
		"^###cb:(/usernameskick):(.*)$",
		"^###cb:(/mentionenable):(.*)$",
		"^###cb:(/mentiondisable):(.*)$",
		"^###cb:(/mentionwarn):(.*)$",
		"^###cb:(/mentionmute):(.*)$",
		"^###cb:(/mentionkick):(.*)$",
		"^###cb:(/farsienable):(.*)$",
		"^###cb:(/farsidisable):(.*)$",
		"^###cb:(/farsiwarn):(.*)$",
		"^###cb:(/farsimute):(.*)$",
		"^###cb:(/farsikick):(.*)$",
		"^###cb:(/webenable):(.*)$",
		"^###cb:(/webdisable):(.*)$",
		"^###cb:(/webwarn):(.*)$",
		"^###cb:(/webmute):(.*)$",
		"^###cb:(/webkick):(.*)$",
		"^###cb:(/markdownenable):(.*)$",
		"^###cb:(/markdowndisable):(.*)$",
		"^###cb:(/markdownwarn):(.*)$",
		"^###cb:(/markdownmute):(.*)$",
		"^###cb:(/markdownkick):(.*)$",
		"^###cb:(/mutevideonote):(.*)$",
		"^###cb:(/noteenable):(.*)$",
		"^###cb:(/notedisable):(.*)$",
		"^###cb:(/notewarn):(.*)$",
		"^###cb:(/notemute):(.*)$",
		"^###cb:(/notekick):(.*)$",
		"^###cb:(/gifenable):(.*)$",
		"^###cb:(/gifdisable):(.*)$",
		"^###cb:(/gifwarn):(.*)$",
		"^###cb:(/gifmute):(.*)$",
		"^###cb:(/gifkick):(.*)$",
		"^###cb:(/textenable):(.*)$",
		"^###cb:(/textdisable):(.*)$",
		"^###cb:(/textwarn):(.*)$",
		"^###cb:(/textmute):(.*)$",
		"^###cb:(/textkick):(.*)$",
		"^###cb:(/inlineenable):(.*)$",
		"^###cb:(/inlinedisable):(.*)$",
		"^###cb:(/inlinewarn):(.*)$",
		"^###cb:(/inlinemute):(.*)$",
		"^###cb:(/inlinekick):(.*)$",
		"^###cb:(/gameenable):(.*)$",
		"^###cb:(/gamedisable):(.*)$",
		"^###cb:(/gamewarn):(.*)$",
		"^###cb:(/gamemute):(.*)$",
		"^###cb:(/gamekick):(.*)$",
		"^###cb:(/photoenable):(.*)$",
		"^###cb:(/photodisable):(.*)$",
		"^###cb:(/photowarn):(.*)$",
		"^###cb:(/photomute):(.*)$",
		"^###cb:(/photokick):(.*)$",
		"^###cb:(/videoenable):(.*)$",
		"^###cb:(/videodisable):(.*)$",
		"^###cb:(/videowarn):(.*)$",
		"^###cb:(/videomute):(.*)$",
		"^###cb:(/videokick):(.*)$",
		"^###cb:(/audioenable):(.*)$",
		"^###cb:(/audiodisable):(.*)$",
		"^###cb:(/audiowarn):(.*)$",
		"^###cb:(/audiomute):(.*)$",
		"^###cb:(/audiokick):(.*)$",
		"^###cb:(/voiceenable):(.*)$",
		"^###cb:(/voicedisable):(.*)$",
		"^###cb:(/voicewarn):(.*)$",
		"^###cb:(/voicemute):(.*)$",
		"^###cb:(/voicekick):(.*)$",
		"^###cb:(/stickerenable):(.*)$",
		"^###cb:(/stickerdisable):(.*)$",
		"^###cb:(/stickerwarn):(.*)$",
		"^###cb:(/stickermute):(.*)$",
		"^###cb:(/stickerkick):(.*)$",
		"^###cb:(/contactenable):(.*)$",
		"^###cb:(/contactdisable):(.*)$",
		"^###cb:(/contactwarn):(.*)$",
		"^###cb:(/contactmute):(.*)$",
		"^###cb:(/contactkick):(.*)$",
		"^###cb:(/fwdenable):(.*)$",
		"^###cb:(/fwddisable):(.*)$",
		"^###cb:(/fwdwarn):(.*)$",
		"^###cb:(/fwdmute):(.*)$",
		"^###cb:(/fwdkick):(.*)$",
		"^###cb:(/locationenable):(.*)$",
		"^###cb:(/locationdisable):(.*)$",
		"^###cb:(/locationwarn):(.*)$",
		"^###cb:(/locationmute):(.*)$",
		"^###cb:(/locationkick):(.*)$",
		"^###cb:(/documentenable):(.*)$",
		"^###cb:(/documentdisable):(.*)$",
		"^###cb:(/documentwarn):(.*)$",
		"^###cb:(/documentmute):(.*)$",
		"^###cb:(/documentkick):(.*)$",
		"^###cb:(/keyboardenable):(.*)$",
		"^###cb:(/keyboarddisable):(.*)$",
		"^###cb:(/keyboardwarn):(.*)$",
		"^###cb:(/keyboardmute):(.*)$",
		"^###cb:(/keyboardkick):(.*)$",
		"^###cb:(/option):(.*)$",
		"^###cb:(/settings):(.*)$",
		"^###cb:(/mutelist):(.*)$",
		"^###cb:(/locklink):(.*)$",
		"^###cb:(/lockedit):(.*)$",
		"^###cb:(/locktags):(.*)$",
		"^###cb:(/lockusernames):(.*)$",
		"^###cb:(/lockjoin):(.*)$",
		"^###cb:(/lockpin):(.*)$",
		"^###cb:(/lockmarkdown):(.*)$",
		"^###cb:(/lockmention):(.*)$",
		"^###cb:(/lockarabic):(.*)$",
		"^###cb:(/lockwebpage):(.*)$",
		"^###cb:(/lockbots):(.*)$",
		"^###cb:(/lockspam):(.*)$",
		"^###cb:(/lockflood):(.*)$",
		"^###cb:(/welcome):(.*)$",
		"^###cb:(/muteall):(.*)$",
		"^###cb:(/mutegif):(.*)$",
		"^###cb:(/mutegame):(.*)$",
		"^###cb:(/mutevideo):(.*)$",
		"^###cb:(/mutevoice):(.*)$",
		"^###cb:(/muteinline):(.*)$",
		"^###cb:(/mutesticker):(.*)$",
		"^###cb:(/mutelocation):(.*)$",
		"^###cb:(/mutedocument):(.*)$",
		"^###cb:(/muteaudio):(.*)$",
		"^###cb:(/mutephoto):(.*)$",
		"^###cb:(/mutetext):(.*)$",
		"^###cb:(/mutetgservice):(.*)$",
		"^###cb:(/mutekeyboard):(.*)$",
		"^###cb:(/mutecontact):(.*)$",
		"^###cb:(/muteforward):(.*)$",
		"^###cb:(/setflood):(.*)$",
		"^###cb:(/floodup):(.*)$",
		"^###cb:(/flooddown):(.*)$",
		"^###cb:(/charup):(.*)$",
		"^###cb:(/chardown):(.*)$",
		"^###cb:(/floodtimeup):(.*)$",
		"^###cb:(/floodtimedown):(.*)$",
		"^###cb:(/moresettings):(.*)$",
		"^###cb:(/more):(.*)$",
		"^###cb:(/ownerlist):(.*)$",
		"^###cb:(/cleanowners):(.*)$",
		"^###cb:(/modlist):(.*)$",
		"^###cb:(/cleanmods):(.*)$",
		"^###cb:(/bans):(.*)$",
		"^###cb:(/cleanbans):(.*)$",
		"^###cb:(/filterlist):(.*)$",
		"^###cb:(/cleanfilterlist):(.*)$",
		"^###cb:(/whitelist):(.*)$",
		"^###cb:(/cleanwhitelist):(.*)$",
		"^###cb:(/silentlist):(.*)$",
		"^###cb:(/cleansilentlist):(.*)$",
		"^###cb:(/link):(.*)$",
		"^###cb:(/dislike):(.*)$",
		"^###cb:(/like):(.*)$",
		"^###cb:(/rules):(.*)$",
		"^###cb:(/cleanrules):(.*)$",
		"^###cb:(/exit):(.*)$",
		"^###cb:(/whitelists):(.*)$",
		"^###cb:(/cleanwhitelists):(.*)$",
		"^###cb:(/showwlc):(.*)$",
		"^###cb:(/cleanwlcmsg):(.*)$",
		"^###cb:(/tv):(.*)$",
		"^###cb:(/addlimup):(.*)$",
		"^###cb:(/addlimdown):(.*)$",
		"^###cb:(/addlimlock):(.*)$",
		"^###cb:(/addlimunlock):(.*)$",
		"^###cb:(/addpmon):(.*)$",
		"^###cb:(/addpmoff):(.*)$",
		"^###cb:(/exitadd):(.*)$",
	},
	run=run
}
