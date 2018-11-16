function MaTaDoRTeaM(msg, mr_roo)
local StartPm = {"↫ ","⇜ ","⌯ ","℘ ","↜ ","⇋ "}
local M_START = StartPm[math.random(#StartPm)]
if is_JoinChannel(msg) then
if is_mod(msg) then
if msg.reply_id then
if mr_roo[1]:lower() == 'tophoto' or mr_roo[1] == 'تبدیل به عکس' then
	if not redis:get(RedisIndex..'AutoDownload:'..msg.to.id) then
		return M_START..'*دانلود خودکار در گروه شما فعال نمیباشد*'..EndPm..'\n*برای فعال سازی از دستور زیر استفاده کنید :*\n `"Setdow"` *&&* `"تنظیم دانلود"`'
	end
	function tophoto(arg, data)
		function tophoto_cb(arg,data)
			if data.content.sticker then
				local file = data.content.sticker.sticker.path
				local secp = tostring(tcpath)..'/data/stickers/'
				local ffile = string.gsub(file, '-', '')
				local fsecp = string.gsub(secp, '-', '')
				local name = string.gsub(ffile, fsecp, '')
				local sname = string.gsub(name, 'webp', 'jpg')
				local pfile = 'data/photos/'..sname
				local pasvand = 'webp'
				local apath = tostring(tcpath)..'/data/stickers'
				if file_exif(tostring(name), tostring(apath), '') then
					os.rename(file, pfile)
					tdbot.sendPhoto(msg.to.id, msg.id, pfile, 0, {}, 0, 0, "₪ "..channel_username.."", 0, 0, 1, nil, dl_cb, nil)
				else
					tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'*لطفا دوباره استیکر مورد نظر خود را ارسال کنید*'..EndPm, 1, 'md')
				end
			else
				tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'*استیکر نمیباشد.*'..EndPm, 1, 'md')
			end
		end
		tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = data.id }, tophoto_cb, nil)
	end
	tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = msg.reply_id }, tophoto, nil)
end
if mr_roo[1]:lower() == 'tosticker' or mr_roo[1] == 'تبدیل به استیکر' then
	if not redis:get(RedisIndex..'AutoDownload:'..msg.to.id) then
		return M_START..'*دانلود خودکار در گروه شما فعال نمیباشد*'..EndPm..'\n*برای فعال سازی از دستور زیر استفاده کنید :*\n `"Setdow"` *&&* `"تنظیم دانلود"`'
	end
	function tosticker(arg, data)
		function tosticker_cb(arg,data)
			if data.content._ == 'messagePhoto' then
				file = data.content.photo.id
				local pathf = tcpath..'/files/photos/'..file..'.jpg'
				if file_exif(file..'_(0).jpg', tcpath..'/files/photos', 'jpg') then
					pathf = tcpath..'/files/photos/'..file..'_(0).jpg'
				end
				local pfile = 'data/photos/'..file..'.webp'
				if file_exif(file..'.jpg', tcpath..'/files/photos', 'jpg') then
					os.rename(pathf, pfile)
					tdbot.sendSticker(msg.to.id, msg.id, pfile, 512, 512, 1, nil, nil, dl_cb, nil)
				else
					tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'*لطفا دوباره عکس مورد نظر خود را ارسال کنید*'..EndPm, 1, 'md')
				end
			else
				tdbot.sendMessage(msg.to.id, msg.id, 1, M_START..'*عکس نمیباشد.*'..EndPm, 1, 'md')
			end
		end
		tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = data.id }, tosticker_cb, nil)
	end
	tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = msg.reply_id }, tosticker, nil)
end
end
if (mr_roo[1]:lower() == 'calc' or mr_roo[1] == 'ماشین حساب') and mr_roo[2] then
	if msg.to.type == "pv" then
		return
	end
	return calc(mr_roo[2])
end
if mr_roo[1]:lower() == 'settag' or mr_roo[1] == 'تنظیم تگ' then
	local title = mr_roo[2]
	local title2 = mr_roo[3]
	redis:set(RedisIndex..msg.to.id..'setmusictag', title)
	redis:set(RedisIndex..msg.to.id..'setmusictag2', title2)
	local text = M_START..'`تگ آهنگ تنظیم شد :`\n'..check_markdown(title)..'/'..check_markdown(title2)..''..EndPm
	return tdbot.sendMessage(msg.chat_id, 0, 1, text, 1, 'md')
end
if mr_roo[1]:lower() == 'praytime' or mr_roo[1] == 'ساعت شرعی' then
	if mr_roo[2] then
		city = mr_roo[2]
	elseif not mr_roo[2] then
		city = 'Tehran'
	end
	local lat,lng,url	= get_staticmap(city)
	local dumptime = run_bash('date +%s')
	local code = http.request('http://api.aladhan.com/timings/'..dumptime..'?latitude='..lat..'&longitude='..lng..'&timezonestring=Asia/Tehran&method=7')
	local jdat = json:decode(code)
	local data = jdat.data.timings
	local text = 'شهر: '..city
	text = text..'\nاذان صبح: '..data.Fajr
	text = text..'\nطلوع آفتاب: '..data.Sunrise
	text = text..'\nاذان ظهر: '..data.Dhuhr
	text = text..'\nغروب آفتاب: '..data.Sunset
	text = text..'\nاذان مغرب: '..data.Maghrib
	text = text..'\nعشاء : '..data.Isha
	text = text..'\n'..M_START..''..channel_username
	return tdbot.sendMessage(msg.chat_id, 0, 1, text, 1, 'html')
end
if mr_roo[1]:lower() == 'aparat' or mr_roo[1] == 'آپارات' then
url , res = http.request("http://www.aparat.com/etc/api/videoBySearch/text/"..URL.escape(mr_roo[2]))
if res ~= 200 then return end
if json:decode(url) then
	j = json:decode(url)
	if j.videobysearch then
		Items = j.videobysearch
		text = "🔍 نتایج جستجو در وبسایت آپارات :"
		.."\n"
		.."\n"
		for i=1, #Items do
			text = text..i.."- "..Items[i].title.."\n👁 تعداد بازدید : "..Items[i].visit_cnt.."\nلینک نمایش در وبسایت آپارات ( "..opizoLink("http://aparat.com/v/"..Items[i].uid).." )\n"
		end
		return tdbot.sendMessage(msg.chat_id, 0, 1,text, 1, 'html')
	end
end
end
if mr_roo[1]:lower() == 'sexy' or mr_roo[1] == 'سکسی' then
	urls = getRandomButts()
	urls1 = getRandomBoobs()
	local file = download_to_file(urls,'sex.webp')
	local file1 = download_to_file(urls1,'sex2.webp')
	tdbot.sendDocument(msg.to.id, file, M_START..""..channel_username..""..EndPm, nil, msg.id, 0, 1, nil, dl_cb, nil)
	tdbot.sendDocument(msg.to.id, file1, M_START..""..channel_username..""..EndPm, nil, msg.id, 0, 1, nil, dl_cb, nil)
end
if mr_roo[1]:lower() == 'song' or mr_roo[1] == 'آهنگ' then
	local art = mr_roo[2]
	local url , res = http.request('http://api.mostafa-am.ir/radio-javan/'..URL.escape(art))
	if res ~= 200 then
		return "No Connection"
	end
	local jdat = json:decode(url)
	if not jdat.OK then
		return M_START..'`آهنگ مورد نظر یافت نشد.`'..EndPm
	end
	local song, video = '', ''
	for i=1, 10 do
		if jdat.Videos ~= '' then
			if jdat.Musics[i] then
				song = song..i..'- '..jdat.Musics[i].Title..'\nLink: '..jdat.Musics[i].Url:gsub('_', '\\_')..'\n'
			end
			if jdat.Videos[i] then
				video = video..i..'- '..jdat.Videos[i].Title..'\nLink: '..jdat.Videos[i].Url:gsub('_', '\\_')..'\n'
			end
		else
			if jdat.Musics[i] then
				song = song..i..'- '..jdat.Musics[i].Song..'\nLink: '..jdat.Musics[i].Url:gsub('_', '\\_')..'\n'
			end
			video = M_START..'وجود ندارد'..EndPm
		end
	end
	local result = 'موزیک :\n'..song..'\nموزیک ویدیو :\n'..video
	return tdbot.sendMessage(msg.chat_id, 0, 1,result, 1, 'md')
end
if mr_roo[1]:lower() == 'dlmusic' or mr_roo[1] == 'دانلود آهنگ' then
	tdbot.sendMessage(msg.chat_id, msg.id, 1,M_START.."در حال دانلود ..."..EndPm, 1, 'md')
	local file = download_to_file(mr_roo[2],'Mp3-MR.mp3')
	tdbot.sendDocument(msg.to.id, file, M_START..""..channel_username..""..EndPm, nil, msg.id, 0, 1, nil, dl_cb, nil)
end
if mr_roo[1]:lower() == 'time' or mr_roo[1] == 'ساعت' then
	local url , res = https.request('https://enigma-dev.ir/api/time/')
	if res ~= 200 then
		return M_START.."*در نمایش زمان خطایی رخ داد*"..EndPm
	end
	local jdat = json:decode(url)
	if jdat then
		text = "🗓 امروز : "..jdat.FaDate.WordTwo.."\n⏰ ساعت : "..jdat.FaTime.Number.."\n".."\n🗓*Today* : *"..jdat.EnDate.WordOne.."*".."\n⏰ *Time* : *"..jdat.EnTime.Number.."*\n\n₪ "..channel_username..""
		tdbot.sendMessage(msg.chat_id, 0, 1, text, 1, 'md')
	end
end
if mr_roo[1]:lower() == 'emoji' or mr_roo[1] == 'شکلک' then
	local url ='http://2wap.org/usf/text_sm_gen/sm_gen.php?text='..mr_roo[2]
	local file = download_to_file(url,'Emoji.webp')
	tdbot.sendDocument(msg.to.id, file, M_START..""..channel_username..""..EndPm, nil, msg.id, 0, 1, nil, dl_cb, nil)
end
if mr_roo[1]:lower() == 'like' or mr_roo[1] == 'نظرسنجی' then
	local function TiiGeR(arg, data)
		tdbot.sendInlineQueryResultMessage(msg.chat_id, msg.id, 0, 1, data.inline_query_id, data.results[0].id)
	end
	tdbot.getInlineQueryResults(190601014, msg.chat_id, 0, 0, mr_roo[2], 0, TiiGeR, nil)
end
if mr_roo[1]:lower() == 'ahang' or mr_roo[1] == 'تیکه آهنگ' then
	local function TiiGeR(arg, data)
		tdbot.sendInlineQueryResultMessage(msg.chat_id, msg.id, 0, 1, data.inline_query_id, data.results[0].id)
	end
	tdbot.getInlineQueryResults(117678843, msg.chat_id, 0, 0, mr_roo[2], 0, TiiGeR, nil)
end
if mr_roo[1]:lower() == 'weather' or mr_roo[1] == 'اب و هوا' then
	city = mr_roo[2]
	local url = "http://prs1378.ir/api/weather/?city="..city..""
	local file = download_to_file(url,'weather.jpg')
	tdbot.sendDocument(msg.to.id, file, M_START..""..channel_username..""..EndPm, nil, msg.id, 0, 1, nil, dl_cb, nil)
	local wtext = get_weather(city)
	if not wtext then
		wtext = M_START..'`مکان وارد شده صحیح نیست`'..EndPm
	end
	return wtext
end
if mr_roo[1]:lower() == 'gif' or mr_roo[1] == 'گیف' then
	local modes = {'memories-anim-logo','alien-glow-anim-logo','flash-anim-logo','flaming-logo','whirl-anim-logo','highlight-anim-logo','burn-in-anim-logo','shake-anim-logo','inner-fire-anim-logo','jump-anim-logo'}
	local text = URL.escape(mr_roo[2])
	local url = 'http://www.flamingtext.com/net-fu/image_output.cgi?_comBuyRedirect=false&script='..modes[math.random(#modes)]..'&text='..text..'&symbol_tagname=popular&fontsize=70&fontname=futura_poster&fontname_tagname=cool&textBorder=15&growSize=0&antialias=on&hinting=on&justify=2&letterSpacing=0&lineSpacing=0&textSlant=0&textVerticalSlant=0&textAngle=0&textOutline=off&textOutline=false&textOutlineSize=2&textColor=%230000CC&angle=0&blueFlame=on&blueFlame=false&framerate=75&frames=5&pframes=5&oframes=4&distance=2&transparent=off&transparent=false&extAnim=gif&animLoop=on&animLoop=false&defaultFrameRate=75&doScale=off&scaleWidth=240&scaleHeight=120&&_=1469943010141'
	local title , res = http.request(url)
	local mod = {'Blinking+Text','No+Button','Dazzle+Text','Walk+of+Fame+Animated','Wag+Finger','Glitter+Text','Bliss','Flasher','Roman+Temple+Animated',}
	local set = mod[math.random(#mod)]
	local colors = {'00FF00','6699FF','CC99CC','CC66FF','0066FF','000000','CC0066','FF33CC','FF0000','FFCCCC','FF66CC','33FF00','FFFFFF','00FF00'}
	local bc = colors[math.random(#colors)]
	local colorss = {'00FF00','6699FF','CC99CC','CC66FF','0066FF','000000','CC0066','FF33CC','FFF200','FF0000','FFCCCC','FF66CC','33FF00','FFFFFF','00FF00'}
	local tc = colorss[math.random(#colorss)]
	local url2 = 'http://www.imagechef.com/ic/maker.jsp?filter=&jitter=0&tid='..set..'&color0='..bc..'&color1='..tc..'&color2=000000&customimg=&0='..mr_roo[2]
	local title1 , res = http.request(url2)
	if res ~= 200 then return end
	if title then
		if json:decode(title) then
			local jdat = json:decode(title)
			local gif = jdat.src
			local file = download_to_file(gif,'Gif.gif')
			tdbot.sendDocument(msg.to.id, file, M_START..""..channel_username..""..EndPm, nil, msg.id, 0, 1, nil, dl_cb, nil)
		end
	end
	if title1 then
		if json:decode(title1) then
			local jdat = json:decode(title1)
			local gif = jdat.resImage
			local file = download_to_file(gif,'Gif-Random.gif')
			tdbot.sendDocument(msg.to.id, file, M_START..""..channel_username..""..EndPm, nil, msg.id, 0, 1, nil, dl_cb, nil)
		end
	end
end
if mr_roo[1]:lower() == 'sticker' or mr_roo[1] == 'استیکر' then
	local eq = URL.escape(mr_roo[2])
	local w = "500"
	local h = "500"
	local txtsize = "100"
	local txtclr = {'00FF00','6699FF','CC99CC','CC66FF','0066FF','000000','CC0066','FF33CC','FFF200','FF0000','FFCCCC','FF66CC','33FF00','FFFFFF','00FF00'}
	local tc = txtclr[math.random(#txtclr)]
	if mr_roo[3] then
		tc = mr_roo[3]
	end
	if mr_roo[4] then
		txtsize = mr_roo[4]
	end
	if mr_roo[5] and mr_roo[6] then
		w = mr_roo[5]
		h = mr_roo[6]
	end
	local url = "https://assets.imgix.net/examples/clouds.jpg?blur=150&w="..w.."&h="..h.."&fit=crop&txt="..eq.."&txtsize="..txtsize.."&txtclr="..tc.."&txtalign=middle,center&txtfont=Futura%20Condensed%20Medium&mono="..tc..""
	local receiver = msg.to.id
	local  file = download_to_file(url,'text.webp')
	tdbot.sendDocument(msg.to.id, file, M_START..""..channel_username..""..EndPm, nil, msg.id, 0, 1, nil, dl_cb, nil)
end
if mr_roo[1]:lower() == 'photo' or mr_roo[1] == 'عکس' then
	local eq = URL.escape(mr_roo[2])
	local w = "500"
	local h = "500"
	local txtsize = "100"
	local tc = {'00FF00','6699FF','CC99CC','CC66FF','0066FF','000000','CC0066','FF33CC','FFF200','FF0000','FFCCCC','FF66CC','33FF00','FFFFFF','00FF00'}
	local txtclr = tc[math.random(#tc)]
	if mr_roo[3] then 
		txtclr = mr_roo[3]
	end
	if mr_roo[4] then 
		txtsize = mr_roo[4]
	end
	if mr_roo[5] and mr_roo[6] then 
		w = mr_roo[5]
		h = mr_roo[6]
	end
	local url = "https://assets.imgix.net/examples/clouds.jpg?blur=150&w="..w.."&h="..h.."&fit=crop&txt="..eq.."&txtsize="..txtsize.."&txtclr="..txtclr.."&txtalign=middle,center&txtfont=Futura%20Condensed%20Medium&mono=ff6598cc"
	local  file = download_to_file(url,'text.jpg')
	tdbot.sendPhoto(msg.to.id, msg.id, file, 0, {}, 0, 0, "", 0, 0, 1, nil, dl_cb, nil)
end
if mr_roo[1]:lower() == 'voice' or mr_roo[1] == 'تبدیل به صدا' then
	local text = mr_roo[2]
	textc = text:gsub(' ','.')
	
	if msg.to.type == 'pv' then
		return nil
	else
		local url = "http://tts.baidu.com/text2audio?lan=en&ie=UTF-8&text="..textc
		local file = download_to_file(url,'Voice-MR.mp3')
		tdbot.sendDocument(msg.to.id, file, M_START..""..channel_username.."..EndPm", nil, msg.id, 0, 1, nil, dl_cb, nil)
	end
end
if mr_roo[1]:lower() == 'short' or mr_roo[1] == 'لینک کوتاه' then
	if mr_roo[2]:match("[Hh][Tt][Tt][Pp][Ss]://") then
		shortlink = mr_roo[2]
	elseif not mr_roo[2]:match("[Hh][Tt][Tt][Pp][Ss]://") then
		shortlink = "https://"..mr_roo[2]
	end
	local yon = http.request('http://api.yon.ir/?url='..URL.escape(shortlink))
	local jdat = json:decode(yon)
	local bitly = https.request('https://api-ssl.bitly.com/v3/shorten?access_token=f2d0b4eabb524aaaf22fbc51ca620ae0fa16753d&longUrl='..URL.escape(shortlink))
	local data = json:decode(bitly)
	local u2s = http.request('http://u2s.ir/?api=1&return_text=1&url='..URL.escape(shortlink))
	local llink = http.request('http://llink.ir/yourls-api.php?signature=a13360d6d8&action=shorturl&url='..URL.escape(shortlink)..'&format=simple')
	local text = ' 🌐لینک اصلی :\n'..check_markdown(data.data.long_url)..'\n\nلینکهای کوتاه شده با 6 سایت کوتاه ساز لینک : \n》کوتاه شده با bitly :\n___________________________\n'..(check_markdown(data.data.url) or '---')..'\n___________________________\n》کوتاه شده با u2s :\n'..(check_markdown(u2s) or '---')..'\n___________________________\n》کوتاه شده با llink : \n'..(check_markdown(llink) or '---')..'\n___________________________\n》لینک کوتاه شده با yon : \nyon.ir/'..(check_markdown(jdat.output) or '---')..'\n____________________'..M_START..check_markdown(channel_username)..EndPm
	return tdbot.sendMessage(msg.chat_id, 0, 1, text, 1, 'md')
end
if mr_roo[1]:lower() == 'set' or mr_roo[1] == 'تنظیم' then
	if not redis:get(RedisIndex..'AutoDownload:'..msg.to.id) then
		return M_START..'*دانلود خودکار در گروه شما فعال نمیباشد*'..EndPm..'\n*برای فعال سازی از دستور زیر استفاده کنید :*\n `"Setdow"` *&&* `"تنظیم دانلود"`'
	end
	local title = redis:get(RedisIndex..msg.to.id..'setmusictag')
	local title2 = redis:get(RedisIndex..msg.to.id..'setmusictag2')
	if not title and title2 then
		return tdbot.sendMessage(msg.chat_id, 0, 1, M_START..'`لطفا ابتدا تگ آهنگ را تنظیم کنید.`'..EndPm, 1, 'md')
	end
	if msg.reply_id  then
		function get_filemsg(arg, data)
			function get_fileinfo(arg,data)
				if data.content._ == 'messageAudio' then
					local audio_id = data.content.audio.audio.id
					local audio_name = data.content.audio.file_name
					local pathf = tcpath..'/files/music/'..audio_name
					local cpath = tcpath..'/files/music'
					if file_exi(audio_name, cpath) then
						local folder = 'data/photos/'..title..'.mp3'
						local pfile = folder
						os.rename(pathf, pfile)
						file_dl(audio_id)
					else
						tdbot.sendMessage(msg.chat_id, 0, 1, M_START..'`فایل را دوباره ارسال کنید`'..EndPm, 1, 'md')
					end
					local file = './data/photos/'..title..'.mp3'
					tdbot.sendAudio(msg.to.id, file, 0, title2, title , 1, M_START.."فایل ویرایش شده با تگ\n"..M_START..""..channel_username..""..EndPm)
				end
			end
			tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = data.id }, get_fileinfo, nil)
		end
		tdbot_function ({ _ = 'getMessage', chat_id = msg.chat_id, message_id = msg.reply_to_message_id }, get_filemsg, nil)
	end
end
if mr_roo[1]:lower() == "font" then
	if string.len(mr_roo[2]) > 20 then
		tdbot.sendMessage(msg.chat_id, 0, 1, M_START.."`حداکثر حروف مجاز 20 کاراکتر انگلیسی و عدد است`"..EndPm, 1, 'md')
	end
	local font_base = "A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,9,8,7,6,5,4,3,2,1,.,_"
	local font_hash = "z,y,x,w,v,u,t,s,r,q,p,o,n,m,l,k,j,i,h,g,f,e,d,c,b,a,Z,Y,X,W,V,U,T,S,R,Q,P,O,N,M,L,K,J,I,H,G,F,E,D,C,B,A,0,1,2,3,4,5,6,7,8,9,.,_"
	local fonts = {
	"ⓐ,ⓑ,ⓒ,ⓓ,ⓔ,ⓕ,ⓖ,ⓗ,ⓘ,ⓙ,ⓚ,ⓛ,ⓜ,ⓝ,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,ⓣ,ⓤ,ⓥ,ⓦ,ⓧ,ⓨ,ⓩ,ⓐ,ⓑ,ⓒ,ⓓ,ⓔ,ⓕ,ⓖ,ⓗ,ⓘ,ⓙ,ⓚ,ⓛ,ⓜ,ⓝ,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,ⓣ,ⓤ,ⓥ,ⓦ,ⓧ,ⓨ,ⓩ,⓪,➈,➇,➆,➅,➄,➃,➂,➁,➀,●,_",
	"⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⓪,⑼,⑻,⑺,⑹,⑸,⑷,⑶,⑵,⑴,.,_",
	"α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,⊘,९,𝟠,7,Ϭ,Ƽ,५,Ӡ,ϩ,𝟙,.,_",		"ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,0,9,8,7,6,5,4,3,2,1,.,_",
	"α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,Q,尺,ㄎ,ｲ,Ц,Џ,Щ,ﾒ,ﾘ,乙,ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,q,尺,ㄎ,ｲ,Ц,Џ,Щ,ﾒ,ﾘ,乙,ᅙ,9,8,ᆨ,6,5,4,3,ᆯ,1,.,_",
	"α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,0,9,8,7,6,5,4,3,2,1,.,_",
	"Λ,ɓ,¢,Ɗ,£,ƒ,ɢ,ɦ,ĩ,ʝ,Қ,Ł,ɱ,ה,ø,Ṗ,Ҩ,Ŕ,Ş,Ŧ,Ū,Ɣ,ω,Ж,¥,Ẑ,Λ,ɓ,¢,Ɗ,£,ƒ,ɢ,ɦ,ĩ,ʝ,Қ,Ł,ɱ,ה,ø,Ṗ,Ҩ,Ŕ,Ş,Ŧ,Ū,Ɣ,ω,Ж,¥,Ẑ,0,9,8,7,6,5,4,3,2,1,.,_",
	"Λ,Б,Ͼ,Ð,Ξ,Ŧ,G,H,ł,J,К,Ł,M,Л,Ф,P,Ǫ,Я,S,T,U,V,Ш,Ж,Џ,Z,Λ,Б,Ͼ,Ð,Ξ,Ŧ,g,h,ł,j,К,Ł,m,Л,Ф,p,Ǫ,Я,s,t,u,v,Ш,Ж,Џ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"A̴,̴B̴,̴C̴,̴D̴,̴E̴,̴F̴,̴G̴,̴H̴,̴I̴,̴J̴,̴K̴,̴L̴,̴M̴,̴N̴,̴O̴,̴P̴,̴Q̴,̴R̴,̴S̴,̴T̴,̴U̴,̴V̴,̴W̴,̴X̴,̴Y̴,̴Z̴,̴a̴,̴b̴,̴c̴,̴d̴,̴e̴,̴f̴,̴g̴,̴h̴,̴i̴,̴j̴,̴k̴,̴l̴,̴m̴,̴n̴,̴o̴,̴p̴,̴q̴,̴r̴,̴s̴,̴t̴,̴u̴,̴v̴,̴w̴,̴x̴,̴y̴,̴z̴,̴0̴,̴9̴,̴8̴,̴7̴,̴6̴,̴5̴,̴4̴,̴3̴,̴2̴,̴1̴,̴.̴,̴_̴",
	"ⓐ,ⓑ,ⓒ,ⓓ,ⓔ,ⓕ,ⓖ,ⓗ,ⓘ,ⓙ,ⓚ,ⓛ,ⓜ,ⓝ,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,ⓣ,ⓤ,ⓥ,ⓦ,ⓧ,ⓨ,ⓩ,ⓐ,ⓑ,ⓒ,ⓓ,ⓔ,ⓕ,ⓖ,ⓗ,ⓘ,ⓙ,ⓚ,ⓛ,ⓜ,ⓝ,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,ⓣ,ⓤ,ⓥ,ⓦ,ⓧ,ⓨ,ⓩ,⓪,➈,➇,➆,➅,➄,➃,➂,➁,➀,●,_",
	"⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⓪,⑼,⑻,⑺,⑹,⑸,⑷,⑶,⑵,⑴,.,_",
	"α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,α,в,c,∂,є,ƒ,g,н,ι,נ,к,ℓ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,χ,у,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"α,в,c,ɗ,є,f,g,н,ι,נ,к,Ɩ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,x,у,z,α,в,c,ɗ,є,f,g,н,ι,נ,к,Ɩ,м,η,σ,ρ,q,я,ѕ,т,υ,ν,ω,x,у,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,α,в,c,d,e,ғ,ɢ,н,ι,j,ĸ,l,м,ɴ,o,p,q,r,ѕ,т,υ,v,w,х,y,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"α,Ⴆ,ƈ,ԃ,ҽ,ϝ,ɠ,ԋ,ι,ʝ,ƙ,ʅ,ɱ,ɳ,σ,ρ,ϙ,ɾ,ʂ,ƚ,υ,ʋ,ɯ,x,ყ,ȥ,α,Ⴆ,ƈ,ԃ,ҽ,ϝ,ɠ,ԋ,ι,ʝ,ƙ,ʅ,ɱ,ɳ,σ,ρ,ϙ,ɾ,ʂ,ƚ,υ,ʋ,ɯ,x,ყ,ȥ,0,9,8,7,6,5,4,3,2,1,.,_",
	"α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"ą,ɓ,ƈ,đ,ε,∱,ɠ,ɧ,ï,ʆ,ҡ,ℓ,ɱ,ŋ,σ,þ,ҩ,ŗ,ş,ŧ,ų,√,щ,х,γ,ẕ,ą,ɓ,ƈ,đ,ε,∱,ɠ,ɧ,ï,ʆ,ҡ,ℓ,ɱ,ŋ,σ,þ,ҩ,ŗ,ş,ŧ,ų,√,щ,х,γ,ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
	"ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,ą,ҍ,ç,ժ,ҽ,ƒ,ց,հ,ì,ʝ,ҟ,Ӏ,ʍ,ղ,օ,ք,զ,ɾ,ʂ,է,մ,ѵ,ա,×,վ,Հ,⊘,९,𝟠,7,Ϭ,Ƽ,५,Ӡ,ϩ,𝟙,.,_",
	"მ,ჩ,ƈ,ძ,ε,բ,ց,հ,ἶ,ʝ,ƙ,l,ო,ղ,օ,ր,գ,ɾ,ʂ,է,մ,ν,ω,ჯ,ყ,z,მ,ჩ,ƈ,ძ,ε,բ,ց,հ,ἶ,ʝ,ƙ,l,ო,ղ,օ,ր,գ,ɾ,ʂ,է,մ,ν,ω,ჯ,ყ,z,0,Գ,Ց,Դ,6,5,Վ,Յ,Զ,1,.,_",
	"ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,0,9,8,7,6,5,4,3,2,1,.,_",
	"α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,α,ß,ς,d,ε,ƒ,g,h,ï,յ,κ,ﾚ,m,η,⊕,p,Ω,r,š,†,u,∀,ω,x,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"ª,b,¢,Þ,È,F,૬,ɧ,Î,j,Κ,Ļ,м,η,◊,Ƿ,ƍ,r,S,⊥,µ,√,w,×,ý,z,ª,b,¢,Þ,È,F,૬,ɧ,Î,j,Κ,Ļ,м,η,◊,Ƿ,ƍ,r,S,⊥,µ,√,w,×,ý,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"Δ,Ɓ,C,D,Σ,F,G,H,I,J,Ƙ,L,Μ,∏,Θ,Ƥ,Ⴓ,Γ,Ѕ,Ƭ,Ʊ,Ʋ,Ш,Ж,Ψ,Z,λ,ϐ,ς,d,ε,ғ,ɢ,н,ι,ϳ,κ,l,ϻ,π,σ,ρ,φ,г,s,τ,υ,v,ш,ϰ,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"Λ,ß,Ƈ,D,Ɛ,F,Ɠ,Ĥ,Ī,Ĵ,Ҡ,Ŀ,M,И,♡,Ṗ,Ҩ,Ŕ,S,Ƭ,Ʊ,Ѵ,Ѡ,Ӿ,Y,Z,Λ,ß,Ƈ,D,Ɛ,F,Ɠ,Ĥ,Ī,Ĵ,Ҡ,Ŀ,M,И,♡,Ṗ,Ҩ,Ŕ,S,Ƭ,Ʊ,Ѵ,Ѡ,Ӿ,Y,Z,0,9,8,7,6,5,4,3,2,1,.,_",
	"ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,Q,尺,ㄎ,ｲ,Ц,Џ,Щ,ﾒ,ﾘ,乙,ﾑ,乃,ζ,Ð,乇,ｷ,Ǥ,ん,ﾉ,ﾌ,ズ,ﾚ,ᄊ,刀,Ծ,ｱ,q,尺,ㄎ,ｲ,Ц,Џ,Щ,ﾒ,ﾘ,乙,ᅙ,9,8,ᆨ,6,5,4,3,ᆯ,1,.,_",
	"α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,α,β,c,δ,ε,Ŧ,ĝ,h,ι,j,κ,l,ʍ,π,ø,ρ,φ,Ʀ,$,†,u,υ,ω,χ,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"ค,๖,¢,໓,ē,f,ງ,h,i,ว,k,l,๓,ຖ,໐,p,๑,r,Ş,t,น,ง,ຟ,x,ฯ,ຊ,ค,๖,¢,໓,ē,f,ງ,h,i,ว,k,l,๓,ຖ,໐,p,๑,r,Ş,t,น,ง,ຟ,x,ฯ,ຊ,0,9,8,7,6,5,4,3,2,1,.,_",
	"ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,ձ,ъ,ƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,0,9,8,7,6,5,4,3,2,1,.,_",
	"Â,ß,Ĉ,Ð,Є,Ŧ,Ǥ,Ħ,Ī,ʖ,Қ,Ŀ,♏,И,Ø,P,Ҩ,R,$,ƚ,Ц,V,Щ,X,￥,Ẕ,Â,ß,Ĉ,Ð,Є,Ŧ,Ǥ,Ħ,Ī,ʖ,Қ,Ŀ,♏,И,Ø,P,Ҩ,R,$,ƚ,Ц,V,Щ,X,￥,Ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
	"Λ,ɓ,¢,Ɗ,£,ƒ,ɢ,ɦ,ĩ,ʝ,Қ,Ł,ɱ,ה,ø,Ṗ,Ҩ,Ŕ,Ş,Ŧ,Ū,Ɣ,ω,Ж,¥,Ẑ,Λ,ɓ,¢,Ɗ,£,ƒ,ɢ,ɦ,ĩ,ʝ,Қ,Ł,ɱ,ה,ø,Ṗ,Ҩ,Ŕ,Ş,Ŧ,Ū,Ɣ,ω,Ж,¥,Ẑ,0,9,8,7,6,5,4,3,2,1,.,_",
	"Λ,Б,Ͼ,Ð,Ξ,Ŧ,G,H,ł,J,К,Ł,M,Л,Ф,P,Ǫ,Я,S,T,U,V,Ш,Ж,Џ,Z,Λ,Б,Ͼ,Ð,Ξ,Ŧ,g,h,ł,j,К,Ł,m,Л,Ф,p,Ǫ,Я,s,t,u,v,Ш,Ж,Џ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"Թ,Յ,Շ,Ժ,ȝ,Բ,Գ,ɧ,ɿ,ʝ,ƙ,ʅ,ʍ,Ռ,Ծ,ρ,φ,Ր,Տ,Ե,Մ,ע,ա,Ճ,Վ,Հ,Թ,Յ,Շ,Ժ,ȝ,Բ,Գ,ɧ,ɿ,ʝ,ƙ,ʅ,ʍ,Ռ,Ծ,ρ,φ,Ր,Տ,Ե,Մ,ע,ա,Ճ,Վ,Հ,0,9,8,7,6,5,4,3,2,1,.,_",
	"Æ,þ,©,Ð,E,F,ζ,Ħ,Ї,¿,ズ,ᄂ,M,Ñ,Θ,Ƿ,Ø,Ґ,Š,τ,υ,¥,w,χ,y,շ,Æ,þ,©,Ð,E,F,ζ,Ħ,Ї,¿,ズ,ᄂ,M,Ñ,Θ,Ƿ,Ø,Ґ,Š,τ,υ,¥,w,χ,y,շ,0,9,8,7,6,5,4,3,2,1,.,_",
	"ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"4,8,C,D,3,F,9,H,!,J,K,1,M,N,0,P,Q,R,5,7,U,V,W,X,Y,2,4,8,C,D,3,F,9,H,!,J,K,1,M,N,0,P,Q,R,5,7,U,V,W,X,Y,2,0,9,8,7,6,5,4,3,2,1,.,_",
	"Λ,M,X,ʎ,Z,ɐ,q,ɔ,p,ǝ,ɟ,ƃ,ɥ,ı,ɾ,ʞ,l,ա,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,Λ,M,X,ʎ,Z,ɐ,q,ɔ,p,ǝ,ɟ,ƃ,ɥ,ı,ɾ,ʞ,l,ա,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,0,9,8,7,6,5,4,3,2,1,.,‾",
	"A̴,̴B̴,̴C̴,̴D̴,̴E̴,̴F̴,̴G̴,̴H̴,̴I̴,̴J̴,̴K̴,̴L̴,̴M̴,̴N̴,̴O̴,̴P̴,̴Q̴,̴R̴,̴S̴,̴T̴,̴U̴,̴V̴,̴W̴,̴X̴,̴Y̴,̴Z̴,̴a̴,̴b̴,̴c̴,̴d̴,̴e̴,̴f̴,̴g̴,̴h̴,̴i̴,̴j̴,̴k̴,̴l̴,̴m̴,̴n̴,̴o̴,̴p̴,̴q̴,̴r̴,̴s̴,̴t̴,̴u̴,̴v̴,̴w̴,̴x̴,̴y̴,̴z̴,̴0̴,̴9̴,̴8̴,̴7̴,̴6̴,̴5̴,̴4̴,̴3̴,̴2̴,̴1̴,̴.̴,̴_̴",
	"A̱,̱Ḇ,̱C̱,̱Ḏ,̱E̱,̱F̱,̱G̱,̱H̱,̱I̱,̱J̱,̱Ḵ,̱Ḻ,̱M̱,̱Ṉ,̱O̱,̱P̱,̱Q̱,̱Ṟ,̱S̱,̱Ṯ,̱U̱,̱V̱,̱W̱,̱X̱,̱Y̱,̱Ẕ,̱a̱,̱ḇ,̱c̱,̱ḏ,̱e̱,̱f̱,̱g̱,̱ẖ,̱i̱,̱j̱,̱ḵ,̱ḻ,̱m̱,̱ṉ,̱o̱,̱p̱,̱q̱,̱ṟ,̱s̱,̱ṯ,̱u̱,̱v̱,̱w̱,̱x̱,̱y̱,̱ẕ,̱0̱,̱9̱,̱8̱,̱7̱,̱6̱,̱5̱,̱4̱,̱3̱,̱2̱,̱1̱,̱.̱,̱_̱",
	"A̲,̲B̲,̲C̲,̲D̲,̲E̲,̲F̲,̲G̲,̲H̲,̲I̲,̲J̲,̲K̲,̲L̲,̲M̲,̲N̲,̲O̲,̲P̲,̲Q̲,̲R̲,̲S̲,̲T̲,̲U̲,̲V̲,̲W̲,̲X̲,̲Y̲,̲Z̲,̲a̲,̲b̲,̲c̲,̲d̲,̲e̲,̲f̲,̲g̲,̲h̲,̲i̲,̲j̲,̲k̲,̲l̲,̲m̲,̲n̲,̲o̲,̲p̲,̲q̲,̲r̲,̲s̲,̲t̲,̲u̲,̲v̲,̲w̲,̲x̲,̲y̲,̲z̲,̲0̲,̲9̲,̲8̲,̲7̲,̲6̲,̲5̲,̲4̲,̲3̲,̲2̲,̲1̲,̲.̲,̲_̲",
	"Ā,̄B̄,̄C̄,̄D̄,̄Ē,̄F̄,̄Ḡ,̄H̄,̄Ī,̄J̄,̄K̄,̄L̄,̄M̄,̄N̄,̄Ō,̄P̄,̄Q̄,̄R̄,̄S̄,̄T̄,̄Ū,̄V̄,̄W̄,̄X̄,̄Ȳ,̄Z̄,̄ā,̄b̄,̄c̄,̄d̄,̄ē,̄f̄,̄ḡ,̄h̄,̄ī,̄j̄,̄k̄,̄l̄,̄m̄,̄n̄,̄ō,̄p̄,̄q̄,̄r̄,̄s̄,̄t̄,̄ū,̄v̄,̄w̄,̄x̄,̄ȳ,̄z̄,̄0̄,̄9̄,̄8̄,̄7̄,̄6̄,̄5̄,̄4̄,̄3̄,̄2̄,̄1̄,̄.̄,̄_̄",
	"A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,0,9,8,7,6,5,4,3,2,1,.,_",
	"a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"@,♭,ḉ,ⓓ,℮,ƒ,ℊ,ⓗ,ⓘ,נ,ⓚ,ℓ,ⓜ,η,ø,₪,ⓠ,ⓡ,﹩,т,ⓤ,√,ω,ж,૪,ℨ,@,♭,ḉ,ⓓ,℮,ƒ,ℊ,ⓗ,ⓘ,נ,ⓚ,ℓ,ⓜ,η,ø,₪,ⓠ,ⓡ,﹩,т,ⓤ,√,ω,ж,૪,ℨ,0,➈,➑,➐,➅,➄,➃,➌,➁,➊,.,_",
	"@,♭,¢,ⅾ,ε,ƒ,ℊ,ℌ,ї,נ,к,ℓ,м,п,ø,ρ,ⓠ,ґ,﹩,⊥,ü,√,ω,ϰ,૪,ℨ,@,♭,¢,ⅾ,ε,ƒ,ℊ,ℌ,ї,נ,к,ℓ,м,п,ø,ρ,ⓠ,ґ,﹩,⊥,ü,√,ω,ϰ,૪,ℨ,0,9,8,7,6,5,4,3,2,1,.,_",
	"α,♭,ḉ,∂,ℯ,ƒ,ℊ,ℌ,ї,ʝ,ḱ,ℓ,м,η,ø,₪,ⓠ,я,﹩,⊥,ц,ṽ,ω,ჯ,૪,ẕ,α,♭,ḉ,∂,ℯ,ƒ,ℊ,ℌ,ї,ʝ,ḱ,ℓ,м,η,ø,₪,ⓠ,я,﹩,⊥,ц,ṽ,ω,ჯ,૪,ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
	"@,ß,¢,ḓ,℮,ƒ,ℊ,ℌ,ї,נ,ḱ,ʟ,м,п,◎,₪,ⓠ,я,﹩,т,ʊ,♥️,ẘ,✄,૪,ℨ,@,ß,¢,ḓ,℮,ƒ,ℊ,ℌ,ї,נ,ḱ,ʟ,м,п,◎,₪,ⓠ,я,﹩,т,ʊ,♥️,ẘ,✄,૪,ℨ,0,9,8,7,6,5,4,3,2,1,.,_",
	"@,ß,¢,ḓ,℮,ƒ,ℊ,н,ḯ,נ,к,ℓμ,п,☺️,₪,ⓠ,я,﹩,⊥,υ,ṽ,ω,✄,૪,ℨ,@,ß,¢,ḓ,℮,ƒ,ℊ,н,ḯ,נ,к,ℓμ,п,☺️,₪,ⓠ,я,﹩,⊥,υ,ṽ,ω,✄,૪,ℨ,0,9,8,7,6,5,4,3,2,1,.,_",
	"@,ß,ḉ,ḓ,є,ƒ,ℊ,ℌ,ї,נ,ḱ,ʟ,ღ,η,◎,₪,ⓠ,я,﹩,⊥,ʊ,♥️,ω,ϰ,૪,ẕ,@,ß,ḉ,ḓ,є,ƒ,ℊ,ℌ,ї,נ,ḱ,ʟ,ღ,η,◎,₪,ⓠ,я,﹩,⊥,ʊ,♥️,ω,ϰ,૪,ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
	"@,ß,ḉ,∂,ε,ƒ,ℊ,ℌ,ї,נ,ḱ,ł,ღ,и,ø,₪,ⓠ,я,﹩,т,υ,√,ω,ჯ,૪,ẕ,@,ß,ḉ,∂,ε,ƒ,ℊ,ℌ,ї,נ,ḱ,ł,ღ,и,ø,₪,ⓠ,я,﹩,т,υ,√,ω,ჯ,૪,ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
	"α,♭,¢,∂,ε,ƒ,❡,н,ḯ,ʝ,ḱ,ʟ,μ,п,ø,ρ,ⓠ,ґ,﹩,т,υ,ṽ,ω,ж,૪,ẕ,α,♭,¢,∂,ε,ƒ,❡,н,ḯ,ʝ,ḱ,ʟ,μ,п,ø,ρ,ⓠ,ґ,﹩,т,υ,ṽ,ω,ж,૪,ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
	"α,♭,ḉ,∂,℮,ⓕ,ⓖ,н,ḯ,ʝ,ḱ,ℓ,м,п,ø,ⓟ,ⓠ,я,ⓢ,ⓣ,ⓤ,♥️,ⓦ,✄,ⓨ,ⓩ,α,♭,ḉ,∂,℮,ⓕ,ⓖ,н,ḯ,ʝ,ḱ,ℓ,м,п,ø,ⓟ,ⓠ,я,ⓢ,ⓣ,ⓤ,♥️,ⓦ,✄,ⓨ,ⓩ,0,➒,➑,➐,➏,➄,➍,➂,➁,➀,.,_",
	"@,♭,ḉ,ḓ,є,ƒ,ⓖ,ℌ,ⓘ,נ,к,ⓛ,м,ⓝ,ø,₪,ⓠ,я,﹩,ⓣ,ʊ,√,ω,ჯ,૪,ⓩ,@,♭,ḉ,ḓ,є,ƒ,ⓖ,ℌ,ⓘ,נ,к,ⓛ,м,ⓝ,ø,₪,ⓠ,я,﹩,ⓣ,ʊ,√,ω,ჯ,૪,ⓩ,0,➒,➇,➆,➅,➄,➍,➌,➋,➀,.,_",
	"α,♭,ⓒ,∂,є,ⓕ,ⓖ,ℌ,ḯ,ⓙ,ḱ,ł,ⓜ,и,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,⊥,ʊ,ⓥ,ⓦ,ж,ⓨ,ⓩ,α,♭,ⓒ,∂,є,ⓕ,ⓖ,ℌ,ḯ,ⓙ,ḱ,ł,ⓜ,и,ⓞ,ⓟ,ⓠ,ⓡ,ⓢ,⊥,ʊ,ⓥ,ⓦ,ж,ⓨ,ⓩ,0,➒,➑,➆,➅,➎,➍,➌,➁,➀,.,_",
	"ⓐ,ß,ḉ,∂,℮,ⓕ,❡,ⓗ,ї,נ,ḱ,ł,μ,η,ø,ρ,ⓠ,я,﹩,ⓣ,ц,√,ⓦ,✖️,૪,ℨ,ⓐ,ß,ḉ,∂,℮,ⓕ,❡,ⓗ,ї,נ,ḱ,ł,μ,η,ø,ρ,ⓠ,я,﹩,ⓣ,ц,√,ⓦ,✖️,૪,ℨ,0,➒,➑,➐,➅,➄,➍,➂,➁,➊,.,_",
	"α,ß,ⓒ,ⅾ,ℯ,ƒ,ℊ,ⓗ,ї,ʝ,к,ʟ,ⓜ,η,ⓞ,₪,ⓠ,ґ,﹩,т,υ,ⓥ,ⓦ,ж,ⓨ,ẕ,α,ß,ⓒ,ⅾ,ℯ,ƒ,ℊ,ⓗ,ї,ʝ,к,ʟ,ⓜ,η,ⓞ,₪,ⓠ,ґ,﹩,т,υ,ⓥ,ⓦ,ж,ⓨ,ẕ,0,➈,➇,➐,➅,➎,➍,➌,➁,➊,.,_",
	"@,♭,ḉ,ⅾ,є,ⓕ,❡,н,ḯ,נ,ⓚ,ⓛ,м,ⓝ,☺️,ⓟ,ⓠ,я,ⓢ,⊥,υ,♥️,ẘ,ϰ,૪,ⓩ,@,♭,ḉ,ⅾ,є,ⓕ,❡,н,ḯ,נ,ⓚ,ⓛ,м,ⓝ,☺️,ⓟ,ⓠ,я,ⓢ,⊥,υ,♥️,ẘ,ϰ,૪,ⓩ,0,➒,➑,➆,➅,➄,➃,➂,➁,➀,.,_",
	"ⓐ,♭,ḉ,ⅾ,є,ƒ,ℊ,ℌ,ḯ,ʝ,ḱ,ł,μ,η,ø,ⓟ,ⓠ,ґ,ⓢ,т,ⓤ,√,ⓦ,✖️,ⓨ,ẕ,ⓐ,♭,ḉ,ⅾ,є,ƒ,ℊ,ℌ,ḯ,ʝ,ḱ,ł,μ,η,ø,ⓟ,ⓠ,ґ,ⓢ,т,ⓤ,√,ⓦ,✖️,ⓨ,ẕ,0,➈,➇,➐,➅,➄,➃,➂,➁,➀,.,_",
	"ձ,ъƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,ձ,ъƈ,ժ,ε,բ,ց,հ,ﻨ,յ,ĸ,l,ო,ռ,օ,թ,զ,г,ร,է,ս,ν,ա,×,ყ,২,0,9,8,7,6,5,4,3,2,1,.,_",
	"λ,ϐ,ς,d,ε,ғ,ϑ,ɢ,н,ι,ϳ,κ,l,ϻ,π,σ,ρ,φ,г,s,τ,υ,v,ш,ϰ,ψ,z,λ,ϐ,ς,d,ε,ғ,ϑ,ɢ,н,ι,ϳ,κ,l,ϻ,π,σ,ρ,φ,г,s,τ,υ,v,ш,ϰ,ψ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,ค,๒,ς,๔,є,Ŧ,ɠ,ђ,เ,ן,к,l,๓,ภ,๏,թ,ợ,г,ร,t,ย,v,ฬ,x,ץ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"მ,ჩ,ƈძ,ε,բ,ց,հ,ἶ,ʝ,ƙ,l,ო,ղ,օ,ր,գ,ɾ,ʂ,է,մ,ν,ω,ჯ,ყ,z,მ,ჩ,ƈძ,ε,բ,ց,հ,ἶ,ʝ,ƙ,l,ო,ղ,օ,ր,գ,ɾ,ʂ,է,մ,ν,ω,ჯ,ყ,z,0,Գ,Ց,Դ,6,5,Վ,Յ,Զ,1,.,_",
	"ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,ค,ც,८,ძ,૯,Բ,૭,Һ,ɿ,ʆ,қ,Ն,ɱ,Ո,૦,ƿ,ҩ,Ր,ς,੮,υ,౮,ω,૪,ע,ઽ,0,9,8,7,6,5,4,3,2,1,.,_",
	"Λ,Б,Ͼ,Ð,Ξ,Ŧ,g,h,ł,j,К,Ł,m,Л,Ф,p,Ǫ,Я,s,t,u,v,Ш,Ж,Џ,z,Λ,Б,Ͼ,Ð,Ξ,Ŧ,g,h,ł,j,К,Ł,m,Л,Ф,p,Ǫ,Я,s,t,u,v,Ш,Ж,Џ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"λ,ß,Ȼ,ɖ,ε,ʃ,Ģ,ħ,ί,ĵ,κ,ι,ɱ,ɴ,Θ,ρ,ƣ,ર,Ș,τ,Ʋ,ν,ώ,Χ,ϓ,Հ,λ,ß,Ȼ,ɖ,ε,ʃ,Ģ,ħ,ί,ĵ,κ,ι,ɱ,ɴ,Θ,ρ,ƣ,ર,Ș,τ,Ʋ,ν,ώ,Χ,ϓ,Հ,0,9,8,7,6,5,4,3,2,1,.,_",
	"ª,b,¢,Þ,È,F,૬,ɧ,Î,j,Κ,Ļ,м,η,◊,Ƿ,ƍ,r,S,⊥,µ,√,w,×,ý,z,ª,b,¢,Þ,È,F,૬,ɧ,Î,j,Κ,Ļ,м,η,◊,Ƿ,ƍ,r,S,⊥,µ,√,w,×,ý,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"Թ,Յ,Շ,Ժ,ȝ,Բ,Գ,ɧ,ɿ,ʝ,ƙ,ʅ,ʍ,Ռ,Ծ,ρ,φ,Ր,Տ,Ե,Մ,ע,ա,Ճ,Վ,Հ,Թ,Յ,Շ,Ժ,ȝ,Բ,Գ,ɧ,ɿ,ʝ,ƙ,ʅ,ʍ,Ռ,Ծ,ρ,φ,Ր,Տ,Ե,Մ,ע,ա,Ճ,Վ,Հ,0,9,8,7,6,5,4,3,2,1,.,_",
	"Λ,Ϧ,ㄈ,Ð,Ɛ,F,Ɠ,н,ɪ,ﾌ,Қ,Ł,௱,Л,Ø,þ,Ҩ,尺,ら,Ť,Ц,Ɣ,Ɯ,χ,Ϥ,Ẕ,Λ,Ϧ,ㄈ,Ð,Ɛ,F,Ɠ,н,ɪ,ﾌ,Қ,Ł,௱,Л,Ø,þ,Ҩ,尺,ら,Ť,Ц,Ɣ,Ɯ,χ,Ϥ,Ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
	"Ǟ,в,ट,D,ę,բ,g,৸,i,j,κ,l,ɱ,П,Φ,Р,q,Я,s,Ʈ,Ц,v,Щ,ж,ყ,ւ,Ǟ,в,ट,D,ę,բ,g,৸,i,j,κ,l,ɱ,П,Φ,Р,q,Я,s,Ʈ,Ц,v,Щ,ж,ყ,ւ,0,9,8,7,6,5,4,3,2,1,.,_",
	"ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,ɒ,d,ɔ,b,ɘ,ʇ,ϱ,н,i,į,ʞ,l,м,и,o,q,p,я,ƨ,т,υ,v,w,x,γ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"Æ,þ,©,Ð,E,F,ζ,Ħ,Ї,¿,ズ,ᄂ,M,Ñ,Θ,Ƿ,Ø,Ґ,Š,τ,υ,¥,w,χ,y,շ,Æ,þ,©,Ð,E,F,ζ,Ħ,Ї,¿,ズ,ᄂ,M,Ñ,Θ,Ƿ,Ø,Ґ,Š,τ,υ,¥,w,χ,y,շ,0,9,8,7,6,5,4,3,2,1,.,_",
	"ª,ß,¢,ð,€,f,g,h,¡,j,k,|,m,ñ,¤,Þ,q,®,$,t,µ,v,w,×,ÿ,z,ª,ß,¢,ð,€,f,g,h,¡,j,k,|,m,ñ,¤,Þ,q,®,$,t,µ,v,w,×,ÿ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,ɐ,q,ɔ,p,ǝ,ɟ,ɓ,ɥ,ı,ſ,ʞ,ๅ,ɯ,u,o,d,b,ɹ,s,ʇ,n,ʌ,ʍ,x,ʎ,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⒜,⒝,⒞,⒟,⒠,⒡,⒢,⒣,⒤,⒥,⒦,⒧,⒨,⒩,⒪,⒫,⒬,⒭,⒮,⒯,⒰,⒱,⒲,⒳,⒴,⒵,⒪,⑼,⑻,⑺,⑹,⑸,⑷,⑶,⑵,⑴,.,_",
	"ɑ,ʙ,c,ᴅ,є,ɻ,მ,ʜ,ι,ɿ,ĸ,г,w,и,o,ƅϭ,ʁ,ƨ,⊥,n,ʌ,ʍ,x,⑃,z,ɑ,ʙ,c,ᴅ,є,ɻ,მ,ʜ,ι,ɿ,ĸ,г,w,и,o,ƅϭ,ʁ,ƨ,⊥,n,ʌ,ʍ,x,⑃,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"4,8,C,D,3,F,9,H,!,J,K,1,M,N,0,P,Q,R,5,7,U,V,W,X,Y,2,4,8,C,D,3,F,9,H,!,J,K,1,M,N,0,P,Q,R,5,7,U,V,W,X,Y,2,0,9,8,7,6,5,4,3,2,1,.,_",
	"Λ,ßƇ,D,Ɛ,F,Ɠ,Ĥ,Ī,Ĵ,Ҡ,Ŀ,M,И,♡,Ṗ,Ҩ,Ŕ,S,Ƭ,Ʊ,Ѵ,Ѡ,Ӿ,Y,Z,Λ,ßƇ,D,Ɛ,F,Ɠ,Ĥ,Ī,Ĵ,Ҡ,Ŀ,M,И,♡,Ṗ,Ҩ,Ŕ,S,Ƭ,Ʊ,Ѵ,Ѡ,Ӿ,Y,Z,0,9,8,7,6,5,4,3,2,1,.,_",
	"α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,α,в,¢,đ,e,f,g,ħ,ı,נ,κ,ł,м,и,ø,ρ,q,я,š,т,υ,ν,ω,χ,ч,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"α,в,c,ɔ,ε,ғ,ɢ,н,ı,נ,κ,ʟ,м,п,σ,ρ,ǫ,я,ƨ,т,υ,ν,ш,х,ч,z,α,в,c,ɔ,ε,ғ,ɢ,н,ı,נ,κ,ʟ,м,п,σ,ρ,ǫ,я,ƨ,т,υ,ν,ш,х,ч,z,0,9,8,7,6,5,4,3,2,1,.,_",
	"【a】,【b】,【c】,【d】,【e】,【f】,【g】,【h】,【i】,【j】,【k】,【l】,【m】,【n】,【o】,【p】,【q】,【r】,【s】,【t】,【u】,【v】,【w】,【x】,【y】,【z】,【a】,【b】,【c】,【d】,【e】,【f】,【g】,【h】,【i】,【j】,【k】,【l】,【m】,【n】,【o】,【p】,【q】,【r】,【s】,【t】,【u】,【v】,【w】,【x】,【y】,【z】,【0】,【9】,【8】,【7】,【6】,【5】,【4】,【3】,【2】,【1】,.,_",
	"[̲̲̅̅a̲̅,̲̅b̲̲̅,̅c̲̅,̲̅d̲̲̅,̅e̲̲̅,̅f̲̲̅,̅g̲̅,̲̅h̲̲̅,̅i̲̲̅,̅j̲̲̅,̅k̲̅,̲̅l̲̲̅,̅m̲̅,̲̅n̲̅,̲̅o̲̲̅,̅p̲̅,̲̅q̲̅,̲̅r̲̲̅,̅s̲̅,̲̅t̲̲̅,̅u̲̅,̲̅v̲̅,̲̅w̲̅,̲̅x̲̅,̲̅y̲̅,̲̅z̲̅,[̲̲̅̅a̲̅,̲̅b̲̲̅,̅c̲̅,̲̅d̲̲̅,̅e̲̲̅,̅f̲̲̅,̅g̲̅,̲̅h̲̲̅,̅i̲̲̅,̅j̲̲̅,̅k̲̅,̲̅l̲̲̅,̅m̲̅,̲̅n̲̅,̲̅o̲̲̅,̅p̲̅,̲̅q̲̅,̲̅r̲̲̅,̅s̲̅,̲̅t̲̲̅,̅u̲̅,̲̅v̲̅,̲̅w̲̅,̲̅x̲̅,̲̅y̲̅,̲̅z̲̅,̲̅0̲̅,̲̅9̲̲̅,̅8̲̅,̲̅7̲̅,̲̅6̲̅,̲̅5̲̅,̲̅4̲̅,̲̅3̲̲̅,̅2̲̲̅,̅1̲̲̅̅],.,_",
	"[̺͆a̺͆͆,̺b̺͆͆,̺c̺͆,̺͆d̺͆,̺͆e̺͆,̺͆f̺͆͆,̺g̺͆,̺͆h̺͆,̺͆i̺͆,̺͆j̺͆,̺͆k̺͆,̺l̺͆͆,̺m̺͆͆,̺n̺͆͆,̺o̺͆,̺͆p̺͆͆,̺q̺͆͆,̺r̺͆͆,̺s̺͆͆,̺t̺͆͆,̺u̺͆͆,̺v̺͆͆,̺w̺͆,̺͆x̺͆,̺͆y̺͆,̺͆z̺,[̺͆a̺͆͆,̺b̺͆͆,̺c̺͆,̺͆d̺͆,̺͆e̺͆,̺͆f̺͆͆,̺g̺͆,̺͆h̺͆,̺͆i̺͆,̺͆j̺͆,̺͆k̺͆,̺l̺͆͆,̺m̺͆͆,̺n̺͆͆,̺o̺͆,̺͆p̺͆͆,̺q̺͆͆,̺r̺͆͆,̺s̺͆͆,̺t̺͆͆,̺u̺͆͆,̺v̺͆͆,̺w̺͆,̺͆x̺͆,̺͆y̺͆,̺͆z̺,̺͆͆0̺͆,̺͆9̺͆,̺͆8̺̺͆͆7̺͆,̺͆6̺͆,̺͆5̺͆,̺͆4̺͆,̺͆3̺͆,̺͆2̺͆,̺͆1̺͆],.,_",
	"̛̭̰̃ã̛̰̭,̛̭̰̃b̛̰̭̃̃,̛̭̰c̛̛̰̭̃̃,̭̰d̛̰̭̃,̛̭̰̃ḛ̛̭̃̃,̛̭̰f̛̰̭̃̃,̛̭̰g̛̰̭̃̃,̛̭̰h̛̰̭̃,̛̭̰̃ḭ̛̛̭̃̃,̭̰j̛̰̭̃̃,̛̭̰k̛̰̭̃̃,̛̭̰l̛̰̭,̛̭̰̃m̛̰̭̃̃,̛̭̰ñ̛̛̰̭̃,̭̰ỡ̰̭̃,̛̭̰p̛̰̭̃,̛̭̰̃q̛̰̭̃̃,̛̭̰r̛̛̰̭̃̃,̭̰s̛̰̭,̛̭̰̃̃t̛̰̭̃,̛̭̰̃ữ̰̭̃,̛̭̰ṽ̛̰̭̃,̛̭̰w̛̛̰̭̃̃,̭̰x̛̰̭̃,̛̭̰̃ỹ̛̰̭̃,̛̭̰z̛̰̭̃̃,̛̛̭̰ã̛̰̭,̛̭̰̃b̛̰̭̃̃,̛̭̰c̛̛̰̭̃̃,̭̰d̛̰̭̃,̛̭̰̃ḛ̛̭̃̃,̛̭̰f̛̰̭̃̃,̛̭̰g̛̰̭̃̃,̛̭̰h̛̰̭̃,̛̭̰̃ḭ̛̛̭̃̃,̭̰j̛̰̭̃̃,̛̭̰k̛̰̭̃̃,̛̭̰l̛̰̭,̛̭̰̃m̛̰̭̃̃,̛̭̰ñ̛̛̰̭̃,̭̰ỡ̰̭̃,̛̭̰p̛̰̭̃,̛̭̰̃q̛̰̭̃̃,̛̭̰r̛̛̰̭̃̃,̭̰s̛̰̭,̛̭̰̃̃t̛̰̭̃,̛̭̰̃ữ̰̭̃,̛̭̰ṽ̛̰̭̃,̛̭̰w̛̛̰̭̃̃,̭̰x̛̰̭̃,̛̭̰̃ỹ̛̰̭̃,̛̭̰z̛̰̭̃̃,̛̭̰0̛̛̰̭̃̃,̭̰9̛̰̭̃̃,̛̭̰8̛̛̰̭̃̃,̭̰7̛̰̭̃̃,̛̭̰6̛̰̭̃̃,̛̭̰5̛̰̭̃,̛̭̰̃4̛̰̭̃,̛̭̰̃3̛̰̭̃̃,̛̭̰2̛̰̭̃̃,̛̭̰1̛̰̭̃,.,_",
	"a,ะb,ะc,ะd,ะe,ะf,ะg,ะh,ะi,ะj,ะk,ะl,ะm,ะn,ะo,ะp,ะq,ะr,ะs,ะt,ะu,ะv,ะw,ะx,ะy,ะz,a,ะb,ะc,ะd,ะe,ะf,ะg,ะh,ะi,ะj,ะk,ะl,ะm,ะn,ะo,ะp,ะq,ะr,ะs,ะt,ะu,ะv,ะw,ะx,ะy,ะz,ะ0,ะ9,ะ8,ะ7,ะ6,ะ5,ะ4,ะ3,ะ2,ะ1ะ,.,_",
	"̑ȃ,̑b̑,̑c̑,̑d̑,̑ȇ,̑f̑,̑g̑,̑h̑,̑ȋ,̑j̑,̑k̑,̑l̑,̑m̑,̑n̑,̑ȏ,̑p̑,̑q̑,̑ȓ,̑s̑,̑t̑,̑ȗ,̑v̑,̑w̑,̑x̑,̑y̑,̑z̑,̑ȃ,̑b̑,̑c̑,̑d̑,̑ȇ,̑f̑,̑g̑,̑h̑,̑ȋ,̑j̑,̑k̑,̑l̑,̑m̑,̑n̑,̑ȏ,̑p̑,̑q̑,̑ȓ,̑s̑,̑t̑,̑ȗ,̑v̑,̑w̑,̑x̑,̑y̑,̑z̑,̑0̑,̑9̑,̑8̑,̑7̑,̑6̑,̑5̑,̑4̑,̑3̑,̑2̑,̑1̑,.,_",
	"~a,͜͝b,͜͝c,͜͝d,͜͝e,͜͝f,͜͝g,͜͝h,͜͝i,͜͝j,͜͝k,͜͝l,͜͝m,͜͝n,͜͝o,͜͝p,͜͝q,͜͝r,͜͝s,͜͝t,͜͝u,͜͝v,͜͝w,͜͝x,͜͝y,͜͝z,~a,͜͝b,͜͝c,͜͝d,͜͝e,͜͝f,͜͝g,͜͝h,͜͝i,͜͝j,͜͝k,͜͝l,͜͝m,͜͝n,͜͝o,͜͝p,͜͝q,͜͝r,͜͝s,͜͝t,͜͝u,͜͝v,͜͝w,͜͝x,͜͝y,͜͝z,͜͝0,͜͝9,͜͝8,͜͝7,͜͝6,͜͝5,͜͝4,͜͝3,͜͝2͜,͝1͜͝~,.,_",
	"̤̈ä̤,̤̈b̤̈,̤̈c̤̈̈,̤d̤̈,̤̈ë̤,̤̈f̤̈,̤̈g̤̈̈,̤ḧ̤̈,̤ï̤̈,̤j̤̈,̤̈k̤̈̈,̤l̤̈,̤̈m̤̈,̤̈n̤̈,̤̈ö̤,̤̈p̤̈,̤̈q̤̈,̤̈r̤̈,̤̈s̤̈̈,̤ẗ̤̈,̤ṳ̈,̤̈v̤̈,̤̈ẅ̤,̤̈ẍ̤,̤̈ÿ̤,̤̈z̤̈,̤̈ä̤,̤̈b̤̈,̤̈c̤̈̈,̤d̤̈,̤̈ë̤,̤̈f̤̈,̤̈g̤̈̈,̤ḧ̤̈,̤ï̤̈,̤j̤̈,̤̈k̤̈̈,̤l̤̈,̤̈m̤̈,̤̈n̤̈,̤̈ö̤,̤̈p̤̈,̤̈q̤̈,̤̈r̤̈,̤̈s̤̈̈,̤ẗ̤̈,̤ṳ̈,̤̈v̤̈,̤̈ẅ̤,̤̈ẍ̤,̤̈ÿ̤,̤̈z̤̈,̤̈0̤̈,̤̈9̤̈,̤̈8̤̈,̤̈7̤̈,̤̈6̤̈,̤̈5̤̈,̤̈4̤̈,̤̈3̤̈,̤̈2̤̈̈,̤1̤̈,.,_",
	"≋̮̑ȃ̮,̮̑b̮̑,̮̑c̮̑,̮̑d̮̑,̮̑ȇ̮,̮̑f̮̑,̮̑g̮̑,̮̑ḫ̑,̮̑ȋ̮,̮̑j̮̑,̮̑k̮̑,̮̑l̮̑,̮̑m̮̑,̮̑n̮̑,̮̑ȏ̮,̮̑p̮̑,̮̑q̮̑,̮̑r̮,̮̑̑s̮,̮̑̑t̮,̮̑̑u̮,̮̑̑v̮̑,̮̑w̮̑,̮̑x̮̑,̮̑y̮̑,̮̑z̮̑,≋̮̑ȃ̮,̮̑b̮̑,̮̑c̮̑,̮̑d̮̑,̮̑ȇ̮,̮̑f̮̑,̮̑g̮̑,̮̑ḫ̑,̮̑ȋ̮,̮̑j̮̑,̮̑k̮̑,̮̑l̮̑,̮̑m̮̑,̮̑n̮̑,̮̑ȏ̮,̮̑p̮̑,̮̑q̮̑,̮̑r̮,̮̑̑s̮,̮̑̑t̮,̮̑̑u̮,̮̑̑v̮̑,̮̑w̮̑,̮̑x̮̑,̮̑y̮̑,̮̑z̮̑,̮̑0̮̑,̮̑9̮̑,̮̑8̮̑,̮̑7̮̑,̮̑6̮̑,̮̑5̮̑,̮̑4̮̑,̮̑3̮̑,̮̑2̮̑,̮̑1̮̑≋,.,_",
	"a̮,̮b̮̮,c̮̮,d̮̮,e̮̮,f̮̮,g̮̮,ḫ̮,i̮,j̮̮,k̮̮,l̮,̮m̮,̮n̮̮,o̮,̮p̮̮,q̮̮,r̮̮,s̮,̮t̮̮,u̮̮,v̮̮,w̮̮,x̮̮,y̮̮,z̮̮,a̮,̮b̮̮,c̮̮,d̮̮,e̮̮,f̮̮,g̮̮,ḫ̮i,̮̮,j̮̮,k̮̮,l̮,̮m̮,̮n̮̮,o̮,̮p̮̮,q̮̮,r̮̮,s̮,̮t̮̮,u̮̮,v̮̮,w̮̮,x̮̮,y̮̮,z̮̮,0̮̮,9̮̮,8̮̮,7̮̮,6̮̮,5̮̮,4̮̮,3̮̮,2̮̮,1̮,.,_",
	"A̲,̲B̲,̲C̲,̲D̲,̲E̲,̲F̲,̲G̲,̲H̲,̲I̲,̲J̲,̲K̲,̲L̲,̲M̲,̲N̲,̲O̲,̲P̲,̲Q̲,̲R̲,̲S̲,̲T̲,̲U̲,̲V̲,̲W̲,̲X̲,̲Y̲,̲Z̲,̲a̲,̲b̲,̲c̲,̲d̲,̲e̲,̲f̲,̲g̲,̲h̲,̲i̲,̲j̲,̲k̲,̲l̲,̲m̲,̲n̲,̲o̲,̲p̲,̲q̲,̲r̲,̲s̲,̲t̲,̲u̲,̲v̲,̲w̲,̲x̲,̲y̲,̲z̲,̲0̲,̲9̲,̲8̲,̲7̲,̲6̲,̲5̲,̲4̲,̲3̲,̲2̲,̲1̲,̲.̲,̲_̲",
	"Â,ß,Ĉ,Ð,Є,Ŧ,Ǥ,Ħ,Ī,ʖ,Қ,Ŀ,♏,И,Ø,P,Ҩ,R,$,ƚ,Ц,V,Щ,X,￥,Ẕ,Â,ß,Ĉ,Ð,Є,Ŧ,Ǥ,Ħ,Ī,ʖ,Қ,Ŀ,♏,И,Ø,P,Ҩ,R,$,ƚ,Ц,V,Щ,X,￥,Ẕ,0,9,8,7,6,5,4,3,2,1,.,_",
	}
	local result = {}
	i=0
	for k=1,#fonts do
		i=i+1
		local tar_font = fonts[i]:split(",")
		local text = mr_roo[2]
		local text = text:gsub("A",tar_font[1])
		local text = text:gsub("B",tar_font[2])
		local text = text:gsub("C",tar_font[3])
		local text = text:gsub("D",tar_font[4])
		local text = text:gsub("E",tar_font[5])
		local text = text:gsub("F",tar_font[6])
		local text = text:gsub("G",tar_font[7])
		local text = text:gsub("H",tar_font[8])
		local text = text:gsub("I",tar_font[9])
		local text = text:gsub("J",tar_font[10])
		local text = text:gsub("K",tar_font[11])
		local text = text:gsub("L",tar_font[12])
		local text = text:gsub("M",tar_font[13])
		local text = text:gsub("N",tar_font[14])
		local text = text:gsub("O",tar_font[15])
		local text = text:gsub("P",tar_font[16])
		local text = text:gsub("Q",tar_font[17])
		local text = text:gsub("R",tar_font[18])
		local text = text:gsub("S",tar_font[19])
		local text = text:gsub("T",tar_font[20])
		local text = text:gsub("U",tar_font[21])
		local text = text:gsub("V",tar_font[22])
		local text = text:gsub("W",tar_font[23])
		local text = text:gsub("X",tar_font[24])
		local text = text:gsub("Y",tar_font[25])
		local text = text:gsub("Z",tar_font[26])
		local text = text:gsub("a",tar_font[27])
		local text = text:gsub("b",tar_font[28])
		local text = text:gsub("c",tar_font[29])
		local text = text:gsub("d",tar_font[30])
		local text = text:gsub("e",tar_font[31])
		local text = text:gsub("f",tar_font[32])
		local text = text:gsub("g",tar_font[33])
		local text = text:gsub("h",tar_font[34])
		local text = text:gsub("i",tar_font[35])
		local text = text:gsub("j",tar_font[36])
		local text = text:gsub("k",tar_font[37])
		local text = text:gsub("l",tar_font[38])
		local text = text:gsub("m",tar_font[39])
		local text = text:gsub("n",tar_font[40])
		local text = text:gsub("o",tar_font[41])
		local text = text:gsub("p",tar_font[42])
		local text = text:gsub("q",tar_font[43])
		local text = text:gsub("r",tar_font[44])
		local text = text:gsub("s",tar_font[45])
		local text = text:gsub("t",tar_font[46])
		local text = text:gsub("u",tar_font[47])
		local text = text:gsub("v",tar_font[48])
		local text = text:gsub("w",tar_font[49])
		local text = text:gsub("x",tar_font[50])
		local text = text:gsub("y",tar_font[51])
		local text = text:gsub("z",tar_font[52])
		local text = text:gsub("0",tar_font[53])
		local text = text:gsub("9",tar_font[54])
		local text = text:gsub("8",tar_font[55])
		local text = text:gsub("7",tar_font[56])
		local text = text:gsub("6",tar_font[57])
		local text = text:gsub("5",tar_font[58])
		local text = text:gsub("4",tar_font[59])
		local text = text:gsub("3",tar_font[60])
		local text = text:gsub("2",tar_font[61])
		local text = text:gsub("1",tar_font[62])
		
		table.insert(result, text)
	end
	local result_text = "کلمه ی اولیه : "..mr_roo[2].."\nطراحی با "..tostring(#fonts).." فونت :\n ________________________\n\n "
	a=0
	for v=1,#result do
		a=a+1
		result_text = result_text..a.."- "..result[a].."\n\n"
	end
	tdbot.sendMessage(msg.chat_id, 0, 1, result_text.."💢💢💢💢💢💢💢💢💢💢\n"..M_START..""..channel_username..""..EndPm, 1, 'html')
end
if mr_roo[1] == "زیبانویس" then
	if string.len(mr_roo[2]) > 20 then
		tdbot.sendMessage(msg.chat_id, 0, 1, M_START.."`حداکثر حروف مجاز 20 کاراکتر فارسی و عدد است`"..EndPm, 1, 'md')
	end
	local font_base = "ض,ص,ق,ف,غ,ع,ه,خ,ح,ج,ش,س,ی,ب,ل,ا,ن,ت,م,چ,ظ,ط,ز,ر,د,پ,و,ک,گ,ث,ژ,ذ,آ,ئ,.,_"
	local font_hash = "ض,ص,ق,ف,غ,ع,ه,خ,ح,ج,ش,س,ی,ب,ل,ا,ن,ت,م,چ,ظ,ط,ز,ر,د,پ,و,ک,گ,ث,ژ,ذ,آ,ئ,.,_"
	local fontsfa = {
	"ضَِ,صَِ,قَِ,فَِ,غَِ,عَِ,هَِ,خَِ,حَِـَِ,جَِ,شَِـَِ,سَِــَِ,یَِ,بَِ,لَِ,اَِ,نَِ,تَِـ,مَِــَِ,چَِ,ظَِ,طَِ,زَِ,رَِ,دَِ,پَِـَِـ,وَِ,ڪَِــ,گَِــ,ثَِ,ژَِ,ذَِ,آ,ئَِ,.,_",
	"ۘۘضــ, ۘۘصـ, ۘۘقـ, ۘۘفـ, ۘۘغـ, ۘۘعـ, ۘۘهـ, ۘۘخـ, ۘۘحـ, ۘۘجـ, ۘۘشـ,ۘۘسـ, ۘۘیـ, ۘۘبـ, ۘۘلـ, ۘۘا, ۘۘنـ, ۘۘتـ, ۘۘمـ, ۘۘچـ, ۘۘظـ, ۘۘطـ,ۘۘز, ۘۘر, ۘۘد, ۘۘپـ, ۘۘو, ۘۘڪـ, ۘۘگـ, ۘۘثـ, ۘۘژ, ۘۘذ, ۘۘآ, ۘۘئـ,.___",	
	"ضَِـٖٖـۘۘـُِ,صَِـُّ℘ـʘ͜͡,قـٖٖـۘۘـ,فـٖٖـۘۘـُِ,غَِـُّ℘ـʘ͜͡,عـٖٖـۘۘـ,هَِـٖٖـۘۘـُِ,خَِـَّ℘ـʘ͜͡,حـٖٖـۘۘـ,جـٖٖـۘۘـُِ,شَِـُّ℘ـʘ͜͡,سَـٖٖـۘۘـ,یـٖٖـۘۘـُِ,بَـَّ℘ـʘ͜͡,لـٖٖـۘۘـ,اۘۘ,نِّـُّ℘ـʘ͜͡,تَـٖٖـۘۘـ,مُِـٖٖـۘۘـُِ,چٍّـََ℘ـʘ͜͡,ظُّـٖٖـۘۘـ,طِّـٖٖـۘۘـُِ,‌زُِ,رُِ,دَّ,پـٖٖـۘۘـ,وّ,کُّـٖٖـۘۘـُِ,گـ℘ـʘ͜͡,ثَـٖٖـۘۘـ,ژ,ذُّ,℘آ,ئـٖٖـۘۘـ,.,_",
	"ضــ,صــ,قــ,فــ,غــ,عــ,هــ,خــ,حــ,جــ,شــ,ســ,یـــ,بـــ,لــ,ا',نـــ,تـــ,مـــ,چــ,ظــ,طــ,زّ,رّ,دّ,پــ,,وّ,کــ,گــ,ثــ,ژّ,ذّ,آ,ئــ,.,_",
	"ضـَِـٖٖـ,صۘۘـُِـ℘ـʘ͜͡,قٖٖ ,فۘۘـُِـٖٖـۘۘـُِـ,غِِ  ,عِّـِّـۘۘـُِـ,هََ,❢خــًٍـْْـ,حْْـــْْـ,جًٍــْْـ❢,شََـََـََـََـََ,سََـََـََـََـََ,یََ,بََـــْْــََ❅,لََــََـََــ,ا',ݩ,تـެـެِэٖٖ‍ٖٖ‍ٖٖ‍ٖٖ‍ٖٖـ,مٖٖــٍ͜ـۘۘــ,چۘۘـِ؁,ظٖٖــۘۘـ,طۘۘـُِـۘۘ,ز',়ر',دۘۘـ, پـِّ؁,وَِ,ڪـًّ,ِ؁,گٖٖــٍ͜ـۘۘــ,ثۘۘـِ؁,'ژ',ذ'ً,ًّ,়়آ,়়ئّّ'',.,_",
	"ضَِـٖٖـۘۘـُِ,صَِـُّ℘ـʘ͜͡,قـٖٖـۘۘـ,فـٖٖـۘۘـُِ,غَِـُّ℘ـʘ͜͡,عـٖٖـۘۘـ,هَِـٖٖـۘۘـُِ,خَِـَّ℘ـʘ͜͡,حـٖٖـۘۘـ,جـٖٖـۘۘـُِ,شَِـُّ℘ـʘ͜͡,سَـٖٖـۘۘـ,یـٖٖـۘۘـُِ,بَـَّ℘ـʘ͜͡,لـٖٖـۘۘـ,اۘۘ,نِّـُّ℘ـʘ͜͡,تَـٖٖـۘۘـ,مُِـٖٖـۘۘـُِ,چٍّـََ℘ـʘ͜͡,ظُّـٖٖـۘۘـ,طِّـٖٖـۘۘـُِ,‌زُِ,رُِ,دَّ,پـٖٖـۘۘـ,وّ,کُّـٖٖـۘۘـُِ,گـ℘ـʘ͜͡,ثَـٖٖـۘۘـ,ژ,ذُّ,℘آ,ئـٖٖـۘۘـ,.,_",
	"ض̈́ـ̈́ـ̈́ـ̈́ـ,ص̈́ـ̈́ـ̈́ـ̈́ـ,قـ̈́ـ̈́ـ̈́ـ,فـ̈́ـ̈́ـ̈́ـ̈́ـ,غ̈́ـ̈́ـ̈́ـ̈́ـ,ع̈́ـ̈́ـ̈́ـ̈́ـ,ه̈́ـ̈́ـ̈́ـ̈́ـ,خـ̈́ـ̈́ـ̈́ـ,ح̈́ـ̈́ـ̈́ـ̈́ـ,ج̈́ـ̈́ـ̈́ـ̈́ـ,شـ̈́ـ̈́ـ̈́ـ,سـ̈́ـ̈́ـ̈́ـ,ی̈́ـ̈́ـ̈́ـ̈́ـ,ب̈́ـ̈́ـ̈́ـ̈́ـ,ل̈́ـ̈́ـ̈́ـ̈́ـ,̈́ا,ن̈́ـ̈́ـ̈́ـ̈́ـ,ت̈́ـ̈́ـ̈́ـ̈́ـ,م̈́ـ̈́ـ̈́ـ̈́ـ,چـ̈́ـ̈́ـ̈́ـ,ظـ̈́ـ̈́ـ̈́ـ̈́ـ,ط̈́ـ̈́ـ̈́ـ̈́ـ,ز',ر',د',پ̈́ـ̈́ـ̈́ـ̈́ـ,̈́̈́و,کـ̈́ـ̈́ـ̈́ـ,گـ̈́ـ̈́ـ̈́ـ̈́ـ,ث̈́ـ̈́ـ̈́ـ̈́ـ,̈́ژ',ذ',آ',ئ̈́ـ̈́ـ̈́ـ,.,__",
	"ضـٜٜـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜـٜ٘ـٍٍʘ͜͡ʘ͜͡ـٍٜ,ص۪۪ـؔٛـؒؔـ۪۪,ـقـ۪۪ـؒؔـ۪۪ـৃَـ,ـ؋ـ,غ,عـْْـْْـْْ✮ْْ,ه,ـפֿـ,ـפـ,جـٜ۪✶ًً◌,ش,ـωـ,ےٖٖ•,ب, لـؒؔـؒؔ℘,↭ٖٓا,نـ۪ٞ,تـ۪۪ـؒؔـ۪۪ـِْ,مـٰٰـٰٰ,چ,ظ,ط,ز✶ًً◌,ر√,ــدٍٕ,پـٜٜـٍٍـٜٜ℘͡ـٜٜ✮,ـפּـ,ڪ,❆گـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,ث,ژ^°√,ذ,آ,ئ,.,___",
	"ِ↲ضـூ͜͡,صـۡۙـُُـ़,قـ്͜ــ,◌فــ͜͡ـ☆͜͡➬,غـٖٖـ,✞ٜ۪ـٜ۪ع,ـެِэٖٖ‍ٖٖ‍ٖٖ‍ٖٖ‍ٖٖهٖٖ,خـံີـؒؔ,حــٌ۝ؔؑـެِэٖٖ‍ٖٖ‍ٖ,جـَ͜❁,ــ͜͡ـشـ☆͜͡,سـٖٖـــ,يٰٰـٰٰـٰٰـ, ٰٰبـًٍ,لٜ۪ـٜ۪,ံີا,ެِэٖٖ‍ٖٖ‍ٖٖ‍ٖٖ‍ٖٖـݩ,تـََـََـََـ,مـؒؔ◌͜͡ࢪ,ـچـٌ۝ؔؑ,ظًّـެِэٖٖ‍ٖٖ‍ٖٖ‍ٖٖ‍ٖٖ,طٌِـٌ۝ؔؑ,ٖٖزံີ,ࢪ,ـَ͜د,پـٜٜـٜٓـٜٜـٜٓـٜٜـٜٜـٜٜـ,ۋ℘,ڪـٰٖـٰٰـٜٜـٜٓـٜٓـٜٓـٜٜ,گـٖٖـٖٖ,ثـؒؔ◌,ٌ۝ؔؑژِэٖٖ‍ٖٖ‍ٖٖ,ـْٜـذ,❀آ,ئٰٰـٰٰـًٍ,.,__",
	"ضـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,صـٜ٘ـٍٜـٜۘـٜۘـٍٍـٜٜ,قـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,فـٜ٘ـٍٜـٜۘـٜۘـٍٍـٜٜ,غٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ, ٍٍ‍ٍٍعٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,ٍٍ‍ٍٍهٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,خـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,حـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,جـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,شـٜ٘ـٍٜـٜۘـٜۘـٍٍـٜٜ,سـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ, ًًیَِـََـََـََـَِ, بـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ, ًًلٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,ا', ًنََـٍٍـٜٜـٜۘـٜٓـٍٜ,تـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,مـٜ٘ـٍٜـٜۘـٜۘـٍٍـٜٜ,چـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,ظـٜ٘ـٍٜـٜۘـٜۘـٍٍـٜٜ,طـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,''ز,ر',  ًًد'', پـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,وٍٍ‍ٍ‍‍‍ ,ڪـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,گـٜ٘ـٍٜـٜۘـٜۘـٍٍـٜٜ,ثـٜ٘ـٍٜـٜۘـٜۘـٍٍـٜٜ,ًژ,ََذ,❢آ''',ئـٜٜـٍٍـٜٜـٜۘـٜٓـ,.,__",		
	"ضـ﹏ـ,صـ﹏ــ,قـ﹏ـ,فـ﹏ـ,غـ﹏ـ,عـ﹏ـ,هـ﹏ـ,خـ﹏ـ,حـ﹏ـ,جـ﹏ــ,شـ﹏ـ,سـ﹏ـ,یـ﹏ـ,بـ﹏ـ,لـ﹏ــ,ا',نـ﹏ـ,تـ﹏ـ,مـ﹏ـ,چـ﹏ـ,ظـ﹏ــ,طـ﹏ـ,ز,ر,د,پـ﹏ـ,و,کـ﹏ـ,گـ﹏ـ,ثـ﹏ــ,ژ,ذ,آ,ئـ﹏ــ,.,_",
	"ضـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,صـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,قـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ‌,فـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,غـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,عـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ‌,هـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,خـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,حـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ‌,جـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,شـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,سـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ‌,یـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,بـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,لـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ‌,ا',نـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,تـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,مـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ‌,چـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,ظـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,طـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ‌,ز۪ٜ‌,ر۪ٜ,د۪ٜ,پـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,و',کـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,گـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ‌,ثـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,ژ۪ٜ,ذ۪ٜ,آ,ئـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,.,_",
	"়়ضًَـ়ৃ,صَৃـ,়ۘـقٍٰـۘۘ,فََـۘۘ✾ُُ:,◌͜͡غ, عَؔـٍٍʘ͜͡ʘ,هـَ͜❁ٜ۪,خـِِ✿ٰٰ‌,حـٖٖ℘ـ,جـؒؔـؔؔـٖٖـؔـ,شـٜٜـٜٓـٜٜـٜٓـٜٜـٜٜـٜٜـ,سـٰٖـٰٰـٜٜـٜٓـٜٓـٜٓـٜٜـ,ـےٍٕ,بـــ✄ــ,ل҉ ـ,ٰံاًّ,۪۪نـ↭ٰٰـ۪۪,تـَ͜❁ٜ۪ـ,مــؒؔ✫ؒؔـ ҉๏̯̃๏ًٍ,چۘۘـ ۪۪ـٰٰـ,ظـؒؔـؔؔـٖٖـؔـ ــ,طُّـۘۘ↭,✵͜͡ز,رؒؔ◌͜͡◌,َؔد,پّـꯩ้ี,ٰۘوٰٖ,کـ͜͝ـ͜͝ـ,گـ͜͝ـ͜͝ـ,ث͜͝ـ❁۠۠ـ͜͝ـ۪ٜـ۪ٜ❀͜͡ـ,ژؒؔ❁,ـٜٜـٜٓـٜٜـٜٓـٜٜـٜٜـٜٜذ,✺آٍጀ,ٍጀئ,.__",
	"ض✿ٰٰ‌✰ض۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,صـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,قـٍٍ℘͡ـٜٜ,فـَ͜ـ,غـَ͜✾ٖٖ,عुؔـ,℘͡ـهٜुـ,خـَ͜✾ٖٖ,ح͡ـٜٜ,ـجٍٍ℘,شـٖٖ,سـۘۘـُِ℘ـʘ͜,یـٖٖـۘۘـٖٖ,✺ًّ‏َؔب,,لۣۗـًٍـٍَـ,ٍٓ‍ؒؔا,ـنـؔؔ‌ؒؔ,ؒؔ✺تًّ‏َؔ«ۣۗ,مـٍَـٍٓ‍ؒؔـ۪۪ـؔؔ‌ؒؔـؒؔـؒؔـؒؔ,چـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜـ۪ٜ,ظ۪ٜ,ـ۪ٜط۪ٜـ۪ٜـ۪ٜ,ز۪ٜ,ر௸,ـدؒؔ,پِـَِـَِـَِـَِـَِـَِـَِـَ,◌͜͡و◌,ڪـَ͜✾ٖٖ,گٍٖـْْ❥ٍٍـٍٍ,ثْْـٍٍ,ژُُ,ـَ͜ذ,﷽آ,ئ҉ــ҉ۘۘ,ٓٓ,,ـَ͜,,.,__",
	"ضـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,صـٜ٘ـٍٜـٜۘـٜۘـٍٍـٜٜ,قـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,فـٜ٘ـٍٜـٜۘـٜۘـٍٍـٜٜ,غٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ, ٍٍ‍ٍٍعٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,ٍٍ‍ٍٍهٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,خـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,حـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,جـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,شـٜ٘ـٍٜـٜۘـٜۘـٍٍـٜٜ,سـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ, ًًیَِـََـََـََـَِ, بـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ, ًًلٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,ا', ًنََـٍٍـٜٜـٜۘـٜٓـٍٜ,تـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,مـٜ٘ـٍٜـٜۘـٜۘـٍٍـٜٜ,چـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,ظـٜ٘ـٍٜـٜۘـٜۘـٍٍـٜٜ,طـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,''ز,ر',  ًًد'', پـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,وٍٍ‍ٍ‍‍‍ ,ڪـٜٜـٍٍـٜٜـٜۘـٜٓـٍٜ,گـٜ٘ـٍٜـٜۘـٜۘـٍٍـٜٜ,ثـٜ٘ـٍٜـٜۘـٜۘـٍٍـٜٜ,ًژ,ََذ,❢آ''',ئـٜٜـٍٍـٜٜـٜۘـٜٓـ,.,__",
	"ضٖٖـۘۘ℘ـʘ͜͡,صـٖٖـۘۘ℘ـʘ͜͡,قـٖٖـۘۘ℘ـʘ͜͡,فـٖٖـۘۘ℘ـʘ͜͡,غـٖٖـۘۘ℘ـʘ͜͡,عـٖٖـۘۘ℘ـʘ͜͡,هـٖٖـۘۘ℘ـʘ͜͡,خـٖٖـۘۘ℘ـʘ͜͡,حـٖٖـۘۘ℘ـʘ͜͡,جـٖٖـۘۘ℘ـʘ͜͡,شـٖٖـۘۘ℘ـʘ͜͡,سـٖٖـۘۘ℘ـʘ͜͡,یـٖٖـۘۘ℘ـʘ͜͡,بـٖٖـۘۘ℘ـʘ͜͡,لـٖٖـۘۘ℘ـʘ͜͡,ا',نـٖٖـۘۘ℘ـʘ͜͡,تـٖٖـۘۘ℘ـʘ͜͡,مـٖٖـۘۘ℘ـʘ͜͡,چـٖٖـۘۘ℘ـʘ͜͡,ظـٖٖـۘۘ℘ـʘ͜͡,طـٖٖـۘۘ℘ـʘ͜͡,ز,ر,د,پـٖٖـۘۘ℘ـʘ͜͡,و,ڪـٖٖـۘۘ℘ـʘ͜͡,گـٖٖـۘۘ℘ـʘ͜͡,ۘثـٖٖـۘۘ℘ـʘ͜͡,ژ,ذ,آ,ئـٖٖـۘۘ℘ـʘ͜͡,.,_",
	"ضـ෴ِْ,صـ෴ِْ,قـ෴ِْ,فـ෴ِْ,غـ෴ِْ,عـ෴ِْ,هـ෴ِْ,خـ෴ِْ,حـ෴ِْ,جـ෴ِْ,شـ෴ِْ,سـ෴ِْ,یـ෴ِْ,بـ෴ِْ,لـ෴ِْ,ا',نـ෴ِْ,تـ෴ِْ,مـ෴ِْ,چـ෴ِْ,ظـ෴ِْ,طـ෴ِْ,ز,ر,د,پـ෴ِْ,و,کـ෴ِْ,گـ෴ِْ,ثـ෴ِْ,ژ,ذ,آ',ئـ෴ِْ,.,__",
	"ضـًٍʘًٍʘـ,صـًٍʘًٍʘـ,قـًٍʘًٍʘـ,فـًٍʘًٍʘـ,غـًٍʘًٍʘـ,عـًٍʘًٍʘـ,هـًٍʘًٍʘـ,خـًٍʘًٍʘـ,حـًٍʘًٍʘـ,جـًٍʘًٍʘـ,شـًٍʘًٍʘـ,سـًٍʘًٍʘـ,یـًٍʘًٍʘـ,بـًٍʘًٍʘـ,لـًٍʘًٍʘـ,أ,نـًٍʘًٍʘـ,تـًٍʘًٍʘـ,مـًٍʘًٍʘـ,چـًٍʘًٍʘـ,ظـًٍʘًٍʘـ,طـًٍʘًٍʘـ,زََ,رََ,دََ,پـًٍʘًٍʘـ,ٌۉ,,کـًٍʘًٍʘـ,گـًٍʘًٍʘـ,ثـًٍʘًٍʘـ,ژَِ,ذِِ,آ,ئـًٍʘًٍʘـ,.,__",
	"ضـؒؔـٓٓـؒؔ◌͜͡◌,صـؒؔـٓٓـؒؔ◌͜͡◌,قـؒؔـٓٓـؒؔ◌͜͡◌,فـؒؔـٓٓـؒؔ◌͜͡◌,غـؒؔـٓٓـؒؔ◌͜͡◌,عـٓٓـؒؔ◌͜͡◌,هـؒؔـٓٓـؒؔ◌͜͡◌,خـؒؔـٓٓـؒؔ◌͜͡◌,حـؒؔـٓٓـؒؔ◌͜͡◌,جـؒؔـٓٓـؒؔ◌͜͡◌,شـؒؔـٓٓـؒؔ◌͜͡◌,سـؒؔـٓٓـؒؔ◌͜͡◌,یـؒؔـٓٓـؒؔ◌͜͡◌,بـؒؔـٓٓـؒؔ◌͜͡◌,لـؒؔـٓٓـؒؔ◌͜͡◌,ا',نـؒؔـٓٓـؒؔ◌͜͡◌,تـؒؔـٓٓـؒؔ◌͜͡◌,مـؒؔـٓٓـؒؔ◌͜͡◌,چـؒؔـٓٓـؒؔ◌͜͡◌,ظـؒؔـٓٓـؒؔ◌͜͡◌,طـؒؔـٓٓـؒؔ◌͜͡◌,ز,ر,د,پـؒؔـٓٓـؒؔ◌͜͡◌,و,کـؒؔـٓٓـؒؔ◌͜͡◌,گـؒؔـٓٓـؒؔ◌͜͡◌,ثـؒؔـٓٓـؒؔ◌͜͡◌,ژ,ذ,آ,ئـؒؔـٓٓـؒؔ◌͜͡◌,.,_",
	"ضـًٍʘًٍʘـ,صـًٍʘًٍʘـ,قـًٍʘًٍʘـ,فـًٍʘًٍʘـ,غـًٍʘًٍʘـ,عـًٍʘًٍʘـ,هـًٍʘًٍʘـ,خـًٍʘًٍʘـ,حـًٍʘًٍʘـ,جـًٍʘًٍʘـ,شـًٍʘًٍʘـ,سـًٍʘًٍʘـ,یـًٍʘًٍʘـ,بـًٍʘًٍʘـ,لـًٍʘًٍʘـ,أ,نـًٍʘًٍʘـ,تـًٍʘًٍʘـ,مـًٍʘًٍʘـ,چـًٍʘًٍʘـ,ظـًٍʘًٍʘـ,طـًٍʘًٍʘـ,زََ,رََ,دََ,پـًٍʘًٍʘـ,ٌۉ,کـًٍʘًٍʘـ,گـًٍʘًٍʘـ,ثـًٍʘًٍʘـ,ژَِ,ذِِ,آ,ئـًٍʘًٍʘـ,.,_",
	"ضـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,صـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,قـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,فـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,غـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,عـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,هـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,خـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,حـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,جـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,شـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,سـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,یـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,بـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,لـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,اٍٍ,نـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,تـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,مـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,چـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,ظـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,طـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,ؒزٜٜ,↯رٜٜ,دٜٜঊٌٍ,پـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,وٍঊٌٍ,کـؒؔـٜٜঊٌٍـ↯ــٜٜـٍٍ,گـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,ثـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍـ,ژٍঊٌٍ,آ,ئـؒؔـٜٜঊٌٍـ↯ـٜٜـٍٍঊ,.,_",
	"ضـؒؔـؒؔـَؔ௸,صـؒؔـؒؔـَؔ௸,قـؒؔـؒؔـَؔ௸,فـؒؔـؒؔـَؔ௸,غـؒؔـؒؔـَؔ௸,عـؒؔـؒؔـَؔ௸,ھـؒؔـؒؔـَؔ௸,خـؒؔـؒؔـَؔ௸,حـؒؔـؒؔـَؔ௸,جـؒؔـؒؔـَؔ௸,شـؒؔـؒؔـَؔ௸,سـؒؔـؒؔـَؔ௸,یـؒؔـؒؔـَؔ௸,بـؒؔـؒؔـَؔ௸,لـؒؔـؒؔـَؔ௸,ا,نـؒؔـؒؔـَؔ௸,تـؒؔـؒؔـَؔ௸,مـؒؔـؒؔـَؔ௸,چـؒؔـؒؔـَؔ௸,ظـؒؔـؒؔـَؔ௸,طـؒؔـؒؔـَؔ௸,ز,ر,د,پـؒؔـؒؔـَؔ௸,و,کـؒؔـؒؔـَؔ௸,گـؒؔـؒؔـَؔ௸,ثـؒؔـؒؔـَؔ௸,ژ,آ,ئـؒؔـؒؔـَؔ௸,.,_",
	"ضــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,صــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,قــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,فــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,غــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,عــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,هــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,خــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,حــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,جــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,شــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,ســًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,یــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,بــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,لــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,,اٍؓ℘ًً,نــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,تــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,مــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,چــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,ظــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,طــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,زًٍ,ر۪ؔ℘ًً,د۪ؔ,پــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,وٍؓ℘ًً,کــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,گــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,ثــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,ژٍؓ℘ًً,ٍذّ℘ًً,℘ًًآ,ئــًٍـٍؓـٍ۪ـ۪ؔـٍ℘ًً,.,_",
	"ضٜٜــؕؕـٜٜـٜٜ✿,صٜٜــؕؕـٜٜـٜٜ✿,قٜٜــؕؕـٜٜـٜٜ✿,فٜٜــؕؕـٜٜـٜٜ✿,غــؕؕـٜٜـٜٜ✿,عٜٜــؕؕـٜٜـٜٜ✿,هٜٜــؕؕـٜٜـٜٜ✿,خــؕؕـٜٜـٜٜ✿,حٜٜــؕؕـٜٜـٜٜ✿,جــؕؕـٜٜـٜٜ✿,شٜٜــؕؕـٜٜـٜٜ✿,سٜٜــؕؕـٜٜـٜٜ✿,یٜٜــؕؕـٜٜـٜٜ✿,بــؕؕـٜٜـٜٜ✿,لــؕؕـٜٜـٜٜ✿,ٜٜا,نٜٜــؕؕـٜٜـٜٜ✿,تٜٜــؕؕـٜٜـٜٜ✿,مــؕؕـٜٜـٜٜ✿,چٜٜــؕؕـٜٜـٜٜ✿,ظٜٜــؕؕـٜٜـٜٜ✿,طــؕؕـٜٜـٜٜ✿,ٜٜزٜٜ✿,ٜٜرؕ✿,دٜٜ,پـٜٜــؕؕـٜٜـٜٜ✿,وٜٜ,کٜٜــؕؕـٜٜـٜٜ✿,گٜٜــؕؕـٜٜـٜٜ✿,ثٜٜــؕؕـٜٜـٜٜ✿,ژٜٜ✿,ذٜٜ,✿آ,ئٜٜــؕؕـٜٜـٜٜ✿,.,_",
	"ضَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,َصَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,قـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَ,فَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,َغَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,عَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَ,هَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,َخَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,حَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَ,جَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,َشَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,سَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَ,یَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,َبَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,لَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَ,اَِ,نَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,َتَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,مَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَ,چَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,َظَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,طَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَ,زَِ,رَِ,دَِ,پَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,َوًَ,کَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,گـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَ,ثَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,َژَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـ,ذَِ,آ,ئـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَِـَ,.,_",
	"ضٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,صٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,قٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,فٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,غــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,عٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,هٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,خــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,حٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,جــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,شــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,سٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,یٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,بــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,لــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,ٜٜا,نٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,تٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,مــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,چٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,ظٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,طــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,زٜٜ✿,ٜٜرؕ✿,دٜٜ,پـٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,وٜٜ,کٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,گٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,ثٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,ژٜٜ✿,ذٜٜ,✿آ,ئٜٜــؕؕـٜٜـٜٜ✿ٜٜـٜٜـٜٜـ,.,_",
	"ضـٰٖـۘۘـــٍٰـ,صـٰٖـۘۘـــٍٰـ,قـٰٖـۘۘـــٍٰـ,فـٰٖـۘۘـــٍٰـ,غـٰٖـۘۘـــٍٰـ,عـٰٖـۘۘـــٍٰـ,هـٰٖـۘۘـــٍٰـ,خـٰٖـۘۘـــٍٰـ,حـٰٖـۘۘـــٍٰـ,جـٰٖـۘۘـــٍٰـ,شـٰٖـۘۘـــٍٰـ,سـٰٖـۘۘـــٍٰـ,یـٰٖـۘۘـــٍٰـ,بـٰٖـۘۘـــٍٰـ,لـٰٖـۘۘـــٍٰـ,ا,نـٰٖـۘۘـــٍٰـ,تـٰٖـۘۘـــٍٰـ,مـٰٖـۘۘـــٍٰـ,چـٰٖـۘۘـــٍٰـ,ظـٰٖـۘۘـــٍٰـ,طـٰٖـۘۘـــٍٰـ,زٰٖ,رٰٖ,دٰٖ,پـٰٖـۘۘـــٍٰـ,و়়,لـٰٖـۘۘـــٍٰـ,گـٰٖـۘۘـــٍٰـ,ثـٰٖـۘۘـــٍٰ,ژٰٖ,ذۘۘ,آ়,ئـٰٖـۘۘـــٍٰـ,.,_",
	"ضـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,صـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,قـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,فـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,,غـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,عـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,هـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,خـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,حـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,جـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,شـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,سـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,یـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,بـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,لـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,ا͜͝,نـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,تـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,مـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,چـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,ظـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,طـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,͜͝ز❁۠۠,❁ر۠۠,❁د۠۠,پـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,❁۠۠و,کـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,گـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,ثـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,❁ژ۠۠,❁ذ۠۠,❁۠۠آ,ئـ͜͝ـ͜͝ـ͜͝ـ❁۠۠,.,_",
	"ضـ͜͝ـ۪ٜـ۪ٜ❀,صـ͜͝ـ۪ٜـ۪ٜ❀,قـ͜͝ـ۪ٜـ۪ٜ❀,فـ͜͝ـ۪ٜـ۪ٜ❀,غـ͜͝ـ۪ٜـ۪ٜ,عـ͜͝ـ۪ٜـ۪ٜ❀,هـ͜͝ـ۪ٜـ۪ٜ❀,خـ͜͝ـ۪ٜـ۪ٜ❀,حـ͜͝ـ۪ٜـ۪ٜ❀,جـ͜͝ـ۪ٜـ۪ٜ,شـ͜͝ـ۪ٜـ۪ٜ❀,سـ͜͝ـ۪ٜـ۪ٜ❀,یـ͜͝ـ۪ٜـ۪ٜ❀,بـ͜͝ـ۪ٜـ۪ٜ❀,لـ͜͝ـ۪ٜـ۪ٜ❀,❀ا❀,نـ͜͝ـ۪ٜـ۪ٜ❀,تـ͜͝ـ۪ٜـ۪ٜ❀,مـ͜͝ـ۪ٜـ۪ٜ❀,چـ͜͝ـ۪ٜـ۪ٜ❀,ظـ͜͝ـ۪ٜـ۪ٜ❀,طـ͜͝ـ۪ٜـ۪ٜ❀,۪ٜز❀,۪ٜر❀,۪ٜ❀د,پـ͜͝ـ۪ٜـ۪ٜ❀,و❀,کـ͜͝ـ۪ٜـ۪ٜ❀,گـ͜͝ـ۪ٜـ۪ٜ❀,ثـ͜͝ـ۪ٜـ۪ٜ❀,ژ❀,ذ۪ٜ❀,͜͝ـ۪ٜ❀آ,ئـ͜͝ـ۪ٜـ۪ٜ❀,.,_",
	"ضـ℘ू,صـٰٰـۘۘ↭ٖٓ,قــٜ۪◌͜͡✾ـ,فــ℘ू,غـٜ۪◌͜͡✾,عـ℘ू,هـ℘ू,خـٰٰـۘۘ↭ٖٓ,حـٜ۪◌͜͡✾ـ,جـ℘ू,شـٰٰـۘۘ↭ٖٓ,سـٜ۪◌͜͡✾,یــ℘ू,بــ℘ू,لـٜ۪◌͜͡✾,ا℘ू,نـٰٰـۘۘ↭ٖٓ,تـٜ۪◌͜͡✾,مـ℘ू,چـ℘ू,ظـٰٰـۘۘ↭ٖٓ,طـٜ۪◌͜͡✾ـ,زُّ'℘ू,رٰٰ℘ू,ٜ۪◌د͜͡✾,پـ℘ू,ـٰٰوُّ,ڪـٜ۪◌͜͡✾,گـ℘ू,ثـٰٰـۘۘ↭ٖٓ,ژٜ۪◌͜͡✾,ذًَ℘ू,℘ूآ,ئـٰٰـۘۘ↭ٖٓ,.,_",
	"ضـ͜͝ـ۪ٜـ۪ٜ❀,صـ͜͝ـ۪ٜـ۪ٜ❀,قـ͜͝ـ۪ٜـ۪ٜ❀,فـ͜͝ـ۪ٜـ۪ٜ❀,غـ͜͝ـ۪ٜـ۪ٜ,عـ͜͝ـ۪ٜـ۪ٜ❀,هـ͜͝ـ۪ٜـ۪ٜ❀,خـ͜͝ـ۪ٜـ۪ٜ❀,حـ͜͝ـ۪ٜـ۪ٜ❀,جـ͜͝ـ۪ٜـ۪ٜ,شـ͜͝ـ۪ٜـ۪ٜ❀,سـ͜͝ـ۪ٜـ۪ٜ❀,یـ͜͝ـ۪ٜـ۪ٜ❀,بـ͜͝ـ۪ٜـ۪ٜ❀,لـ͜͝ـ۪ٜـ۪ٜ❀,❀ا❀,نـ͜͝ـ۪ٜـ۪ٜ❀,تـ͜͝ـ۪ٜـ۪ٜ❀,مـ͜͝ـ۪ٜـ۪ٜ❀,چـ͜͝ـ۪ٜـ۪ٜ❀,ظـ͜͝ـ۪ٜـ۪ٜ❀,طـ͜͝ـ۪ٜـ۪ٜ❀,۪ٜز❀,۪ٜر❀,۪ٜ❀د,پـ͜͝ـ۪ٜـ۪ٜ❀,و❀,کـ͜͝ـ۪ٜـ۪ٜ❀,گـ͜͝ـ۪ٜـ۪ٜ❀,ثـ͜͝ـ۪ٜـ۪ٜ❀,ژ❀,ذ۪ٜ❀,͜͝ـ۪ٜ❀آ,ئـ͜͝ـ۪ٜـ۪ٜ❀,.,_",
	"ضـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,صـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,قـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,فـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,غـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,عـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,هـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,خـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــ,ؒؔحैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,جـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,شـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,سـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,یـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,بـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,لـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,ैا'َّ,نـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,تـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,مـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,چـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,ظैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,طैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,ز۪ٜ❀,رؒؔ,❀'͜͡دَّ',پـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,'وَّ'ै,ڪैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,گـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,ثـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,۪ٜ❀ژै,ذै,۪ٜ❀آ',ئـैـ۪ٜـ۪ٜـ۪ٜ❀͜͡ــؒؔ,.,_",
	"ضـ͜͡ــؒؔـ͜͝ـ,صـ͜͡ــؒؔـ͜͝ـ,قـ͜͡ــؒؔـ͜͝ـ,فـ͜͡ــؒؔـ͜͝ـ,غـ͜͡ــؒؔـ͜͝ـ,عـ͜͡ــؒؔـ͜͝ـ,هـ͜͡ــؒؔـ͜͝ـ,خـ͜͡ــؒؔـ͜͝ـ,حـ͜͡ــؒؔـ͜͝ـ,جـ͜͡ــؒؔـ͜͝ـ,شـ͜͡ــؒؔـ͜͝ـ,سـ͜͡ــؒؔـ͜͝ـ,یـ͜͡ــؒؔـ͜͝ـ,بـ͜͡ــؒؔـ͜͝ـ,لـ͜͡ــؒؔـ͜͝ـ,اؒؔ,نـ͜͡ــؒؔـ͜͝ـ,تـ͜͡ــؒؔـ͜͝ـ,مـ͜͡ــؒؔـ͜͝ـ,چـ͜͡ــؒؔـ͜͝ـ,ظـ͜͡ــؒؔـ͜͝ـ,طـ͜͡ــؒؔـ͜͝ـ,❁'ز'۠۠,ر҉   ,❁'د۠۠,پـ͜͡ــؒؔـ͜͝ـ,'وۘۘ',کـ͜͡ــؒؔـ͜͝ـ,گـ͜͡ــؒؔـ͜͝ـ,ثـ͜͡ــؒؔـ͜͝ـ,❁'ژ۠۠,❁'د'۠۠,❁۠۠,آ,ئـ͜͡ــؒؔـ͜͝ـ,.,_",
	"ضٰٖـٰٖ℘ـَ͜✾ـ,صٰٖـٰٖ℘ـَ͜✾ـ,قٰٖـٰٖ℘ـَ͜✾ـ,فٰٖـٰٖ℘ـَ͜✾ـ,غٰٖـٰٖ℘ـَ͜✾ـ,عٰٖـٰٖ℘ـَ͜✾ـ,هٰٖـٰٖ℘ـَ͜✾ـ,خٰٖـٰٖ℘ـَ͜✾ـ,حٰٖـٰٖ℘ـَ͜✾ـ,جٰٖـٰٖ℘ـَ͜✾ـ,شٰٖـٰٖ℘ـَ͜✾ـ,سٰٖـٰٖ℘ـَ͜✾ـ,یٰٖـٰٖ℘ـَ͜✾ـ,بٰٖـٰٖ℘ـَ͜✾ـ,لٰٖـٰٖ℘ـَ͜✾ـ,اٰٖـٰٖ℘ـَ͜✾ـ,نٰٖـٰٖ℘ـَ͜✾ـ,تٰٖـٰٖ℘ـَ͜✾ـ,مٰٖـٰٖ℘ـَ͜✾ـ,چٰٖـٰٖ℘ـَ͜✾ـ,ظٰٖـٰٖ℘ـَ͜✾ـ,طٰٖـٰٖ℘ـَ͜✾ـ,زٰٖـٰٖ℘ـَ͜✾ـ,رٰٖـٰٖ℘ـَ͜✾ـ,دٰٖـٰٖ℘ـَ͜✾ـ,پٰٖـٰٖ℘ـَ͜✾ـ,وٰٖـٰٖ℘ـَ͜✾ـ,کٰٖـٰٖ℘ـَ͜✾ـ,گٰٖـٰٖ℘ـَ͜✾ـ,ثٰٖـٰٖ℘ـَ͜✾ـ,ژٰٖـٰٖ℘ـَ͜✾ـ,ذٰٖـٰٖ℘ـَ͜✾ـ,آٰٖـٰٖ℘ـَ͜✾ـ,ئٰٖـٰٖ℘ـَ͜✾ـ,.ٰٖـٰٖ℘ـَ͜✾ـ,_",
	"ض❈ۣۣـ🍁ـ,ص❈ۣۣـ🍁ـ,ق❈ۣۣـ🍁ـ,ف❈ۣۣـ🍁ـ,غ❈ۣۣـ🍁ـ,ع❈ۣۣـ🍁ـ,ه❈ۣۣـ🍁ـ,خ❈ۣۣـ🍁ـ,ح❈ۣۣـ🍁ـ,ج❈ۣۣـ🍁ـ,ش❈ۣۣـ🍁ـ,س❈ۣۣـ🍁ـ,ی❈ۣۣـ🍁ـ,ب❈ۣۣـ🍁ـ,ل❈ۣۣـ🍁ـ,ا❈ۣۣـ🍁ـ,ن❈ۣۣـ🍁ـ,ت❈ۣۣـ🍁ـ,م❈ۣۣـ🍁ـ,چ❈ۣۣـ🍁ـ,ظ❈ۣۣـ🍁ـ,ط❈ۣۣـ🍁ـ,ز❈ۣۣـ🍁ـ,ر❈ۣۣـ🍁ـ,د❈ۣۣـ🍁ـ,پ❈ۣۣـ🍁ـ,و❈ۣۣـ🍁ـ,ک❈ۣۣـ🍁ـ,گ❈ۣۣـ🍁ـ,ث❈ۣۣـ🍁ـ,ژ❈ۣۣـ🍁ـ,ذ❈ۣۣـ🍁ـ,آ❈ۣۣـ🍁ـ,ئ❈ۣۣـ🍁ـ,.❈ۣۣـ🍁ـ,_",
	"ضْஓ͜ঠৡ,صْஓ͜ঠৡ,قْஓ͜ঠৡ,فْஓ͜ঠৡ,غْஓ͜ঠৡ,عْஓ͜ঠৡ,هْஓ͜ঠৡ,خْஓ͜ঠৡ,حْஓ͜ঠৡ,جْஓ͜ঠৡ,شْஓ͜ঠৡ,سْஓ͜ঠৡ,یْஓ͜ঠৡ,بْஓ͜ঠৡ,لْஓ͜ঠৡ,اْஓ͜ঠৡ,نْஓ͜ঠৡ,تْஓ͜ঠৡ,مْஓ͜ঠৡ,چْஓ͜ঠৡ,ظْஓ͜ঠৡ,طْஓ͜ঠৡ,زْஓ͜ঠৡ,رْஓ͜ঠৡ,دْஓ͜ঠৡ,پْஓ͜ঠৡ,وْஓ͜ঠৡ,کْஓ͜ঠৡ,گْஓ͜ঠৡ,ثْஓ͜ঠৡ,ژْஓ͜ঠৡ,ذْஓ͜ঠৡ,آْஓ͜ঠৡ,ئْஓ͜ঠৡ,.ْஓ͜ঠৡ,_",
	"ضـೄ,صـ۪۪ـؒؔـؒؔ◌͜͡◌,قـ۪۪ـؒؔـ۪۪,فـ͜͡ــؒؔـ͜͝ـ,غـೄ,عـ۪۪ـؒؔـ۪۪,هٍٖ❦,خـٜٓـٍٜـٜ٘ـ,حـٜ٘ـَٖ,جٍٍـٍٜــٍٍـٜ٘,͜͡∅شٍٜ۩,↜͜͡∅سٍٜ۩,یٜ٘,↭ِِبَٖ↜͜͡,لـٍٍـٍٜــٍٍـٜ٘∅,↜͜͡'اَُ'ِ,❦نٍٓ,تـــ۪۪ـؒؔــؒؔ◌͜͡◌,مـೄ,چــ۪۪ـؒؔـ۪۪,❀ظـؒؔ❀,طــَ͜✿ٰ,✧زٰٰ‌〆۪۪,✵ٍٓ ٍٖر,دٍٖ❦,پـٖٖـٖٖــَ͜✧,℘و'َ͜✿,کـٖٖـٖٖ‍℘,گـؒؔـٰٰ‌℘,❀ثـٜـؒؔ〆۪۪,ژٍٖ❦,✿ٰٰ‌ذ❀✵آٍٓ✵ٓ,ئـೄ,.,_",
	"✮ًٍضـًٍـَؔ✯ًٍ,✮صًٍـًٍـَؔ✯ًٍ,✮قًٍـًٍـَؔ✯ًٍ,✮ًٍفـًٍـَؔ✯ًٍ,✮غًٍـًٍـَؔ✯,ًٍ✮عًٍـًٍـَؔ✯ًٍ,✮هًٍـًٍـَؔ✯ًٍ,✮خًٍـًٍـَؔ✯ًٍ,✮ًٍحـٜـًٍـَؔ✯ًٍ,✮جًٍـًٍـَؔ✯ًٍ,✮شًٍـًٍـَؔ✯ًٍ,✮سًٍـًٍـَؔ✯ًٍ,✮ًٍیــًٍـَؔ✯ًٍ,✮بـًٍـًٍـَؔ✯ًٍ,✮لـًٍـًٍـَؔ✯ًٍ,✮ًٍا✯ًٍ,✮نًٍـًٍـَؔ✯ًٍ,✮تًٍـًٍـَؔ✯ًٍ,✮مًٍـًٍـَؔ✯ًٍ,✮چًٍـًٍـَؔ✯ًٍ,✮ظًٍـًٍـَؔ✯ًٍ,✮ًٍطـًٍـَؔ✯ًٍ,زَؔ✯ًٍ,ًٍرَؔ✯ًٍ,✮ًٍد,َؔ✮پًٍـًٍـَؔ✯ًٍ,✯ًٍو,✮ًٍکـًٍـَؔ✯ًٍ,✮ًٍگـًٍـَؔ✯ًٍ,✮ًٍثــًٍـَؔ✯ًٍ,✮ژًٍ,✯ًٍذ,✮آًٍ✯ًٍ,✮ئـًٍـًٍـَؔ✯ًٍ,.,_",
	"ضـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,صـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,قـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,فـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,غـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,عـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,هـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,خـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,حـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,جـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,شـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,سـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,یـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,بـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,لـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,✯اّّ✯,نـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,تـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,مـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,چـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,ظـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,طـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,✯زَّ'✯,✯ر✯,✯د✯,پـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,‌ົ້◌ฺฺ'‌ົ້و◌ฺฺ,ڪـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,گـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,ثـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,‌ົ້◌ฺฺژ,✯ذ✯,ಹ۪۪'آ'‌ົ້◌ฺฺಹ۪۪,ئـؒؔـؒؔـ۪۪ـؒؔـؒؔـ‌ົ້◌ฺฺಹ۪۪,.,_",
	"ضـٰٖـۘۘـــٍٰـ,صـٰٖـۘۘـــٍٰـ,قـٰٖـۘۘـــٍٰـ,فـٰٖـۘۘـــٍٰـ,غـٰٖـۘۘـــٍٰـ,عـٰٖـۘۘـــٍٰـ,ه',خـٰٖـۘۘـــٍٰـ,حـٰٖـۘۘـــٍٰـ,جـٰٖـۘۘـــٍٰـ,شـٰٖـۘۘـــٍٰـ,سـٰٖـۘۘـــٍٰـ,یـٰٖـۘۘـــٍٰـ,بـٰٖـۘۘـــٍٰـ,لـٰٖـۘۘـــٍٰـ,ا,نـٰٖـۘۘـــٍٰـ,تـٰٖـۘۘـــٍٰـ,مـٰٖـۘۘـــٍٰـ,چـٰٖـۘۘـــٍٰـ,ظـٰٖـۘۘـــٍٰـ,طـٰٖـۘۘـــٍٰـ,ز,ر,د,پـٰٖـۘۘـــٍٰـ,و,ڪـٰٖـۘۘـــٍٰـ,گـٰٖـۘۘـــٍٰـ,ثـٰٖـۘۘـــٍٰـ,ژ,ذ,آ,ئـٰٖـۘۘـــٍٰـ,.,_",
	"ضٰٓـؒؔـ۪۪ঊ۝,صٰٓـؒؔـ۪۪ঊ۝,قٰٓـؒؔـ۪۪ঊ۝,قٰٓـؒؔـ۪۪ঊ۝,غٰٓـؒؔـ۪۪ঊ۝,عٰٓـؒؔـ۪۪ঊ۝,هٰٓـؒؔـ۪۪ঊ۝,خٰٓـؒؔـ۪۪ঊ۝,ٰحٰٓـؒؔـ۪۪ঊ۝ٰٓ,جٰٓـؒؔـ۪۪ঊ۝,شٰٓـؒؔـ۪۪ঊ۝,سٰٓـؒؔـ۪۪ঊ۝,یٰٓـؒؔـ۪۪ঊ۝,بٰٓـؒؔـ۪۪ঊ۝,لٰٓـؒؔـ۪۪ঊ۝,اٰ۪,نٰٓـؒؔـ۪۪ঊ۝,تٰٓـؒؔـ۪۪ঊ۝,مٰٓـؒؔـ۪۪ঊ۝,چٰٓـؒؔـ۪۪ঊ۝,ظٰٓـؒؔـ۪۪ঊ۝,طٰٓـؒؔـ۪۪ঊ۝ٰٓ,زؓঊ,رٰٓ,۪۪دؓ,پٰٓـؒؔـ۪۪ঊ۝,وٰٓ,۪۪کٰٓـؒؔـ۪۪ঊ۝,گٰٓـؒؔـ۪۪ঊ۝,ثٰٓـؒؔـ۪۪ঊ۝,ؒؔژؓঊ,ذ۪۪ঊ,آٰٓ۝,ئٰٓـؒؔـ۪۪ঊ۝,.,_",
	"ض۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,ص۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,ق۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,ف۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,غ۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,ع۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,ه۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,خ۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,ح۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,ج۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,ش۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,س۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,ی۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,ب۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,ل۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,ٗؔ✰͜͡ا℘ِِ,ن۪۟ــ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,ت۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,م۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,چ۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,ظ۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,ط۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,✰͜͡ز℘ِِ,ٗؔ✰ر͜͡℘ِِ,✰͜͡د℘ِِ,پ۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,۪ٜ✰و͜͡℘ِِ,ڪ۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,گ۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,ث۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,✰͜͡ژ℘ِِ,ٗؔ✰ذ͜͡℘ِِ,✰͜͡آ'℘ِِ,ئ۪۟ـ۟۟✶ًٍـ۟ـًٍـ۪۟ـ۟ـًٍــ۪۟ـ۟۟ـً۟ــٗؔـٗؔ✰͜͡℘ِِ,.,_",
	"ضـ۪۪ইٌ,صـ۪۪ইٌ,قـ۪۪ইٌ,فّــٍ͜ـ়়,غــٍ͜ـ়়,ع়ۘـٖٖــ,,ۘۘهُِـۘۘ,,خـ়ـۘۘـٍٰ,حـْ₰ْۜ,جـْ₰ْۜ,شـْ ـْ₰,سّـ ـٍ͜ـ়়,یْۜـْ✤ْ,بـ̴̬℘̴̬ـ̴̬مـ̴̬℘,لـ̴̬ـ̴̬مـ,ا,نـ̴̬℘̴̬ـ̴, تـ̴̬℘̴̬ـ̴̬م̴̬,℘مـ̴̬ـ̴̬مـ℘,چــَؔ۝,ظــَؔ۝,ط়ـۘۘـٍٰ℘,زٌّ,رٌّ,دٌّ,پــٍ͜ـ়়و,ڪ়ۘ,گـٖٖـۘۘـۘۘـُِـۘۘ,ثــَ͜✿ٰٰ‌ᬼ✵,ژ,ذ,آ,ئــٜ۪✦ــٜ۪✦,.,_",
	"ضؔؑـَؔـَؔ ـَؔ สฺฺŗــَؔ๛ٖؔ,صؔؑــَؔـَؔ ـَؔ สฺฺŗــَؔ๛ٖؔ,قؔؑــَؔـَؔ ـَؔ สฺฺŗــَؔ๛ٖؔ,❂ؔؑفــَؔـَؔ ـَؔ สฺฺŗــَؔ๛ٖؔ,غؔؑــَؔـَؔ ـَؔ สฺฺŗــَؔ๛ٖؔ,عـَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,هؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,خؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,حؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,جــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,شؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,سـَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,یؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,بؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,لؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,اสฺฺ,ؔؑنــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,ؔؑتــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,مؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,چؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,ظؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,طؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,❂زؔؑ ـَؔ ,رสฺฺŗ,❂ؔؑـَؔد۪๛ٖؔ,ؔؑپــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,❂وؔؑ ـَؔ,ڪؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,گؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,ثؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,สฺฺŗـذَؔ๛ٖؔ,❂آ,ئؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,.,_",
	"ضــ ོꯨ҉ــؒؔ҉:ـــ,صــ ོꯨ҉ــؒؔ҉:ــــ,قــ ོꯨ҉ــؒؔ҉:ــــ,فــ ོꯨ҉ــؒؔ҉:ــــ,غــ ོꯨ҉ــؒؔ҉:ــــ,عــ ོꯨ҉ــؒؔ҉:ــــ,هــ ོꯨ҉ــؒؔ҉:ــــ,خــ ོꯨ҉ــؒؔ҉:ــــ,حــ ོꯨ҉ــؒؔ҉:ــــ,ج۪ٜــ ོꯨ҉ــؒؔ҉:ــــ,شــ ོꯨ҉ــؒؔ҉:ــــ,ســ ོꯨ҉ــؒؔ҉:ــــ,یــ ོꯨ҉ــؒؔ҉:ــــ,بــ ོꯨ҉ــؒؔ҉:ــــ,لــ ོꯨ҉ــؒؔ҉:ــــ,اــ ོꯨ҉ــؒؔ҉:ــــ,نــ ོꯨ҉ــؒؔ҉:ــــ,تــ ོꯨ҉ــؒؔ҉:ــــ,مــ ོꯨ҉ــؒؔ҉:ــــ,چــ ོꯨ҉ــؒؔ҉:ــــ,ظــ ོꯨ҉ــؒؔ҉:ــــ,طــ ོꯨ҉ــؒؔ҉:ــــ,زــ ོꯨ҉ــؒؔ҉:ــــ,رــ ོꯨ҉ــؒؔ҉:ــــ,دــ ོꯨ҉ــؒؔ҉:ــــ,پــ ོꯨ҉ــؒؔ҉:ــــ,وــ ོꯨ҉ــؒؔ҉:ــــ,کــ ོꯨ҉ــؒؔ҉:ــــ,گــ ོꯨ҉ــؒؔ҉:ــــ,ثــ ོꯨ҉ــؒؔ҉:ــــ,ژــ ོꯨ҉ــؒؔ҉:ــــ,ذــ ོꯨ҉ــؒؔ҉:ــــ,آ,ئ,.,_",
	"ضؔؑـَؔـَؔ ـَؔ สฺฺŗــَؔ๛ٖؔ,صؔؑــَؔـَؔ ـَؔ สฺฺŗــَؔ๛ٖؔ,قؔؑــَؔـَؔ ـَؔ สฺฺŗــَؔ๛ٖؔ,❂ؔؑفــَؔـَؔ ـَؔ สฺฺŗــَؔ๛ٖؔ,غؔؑــَؔـَؔ ـَؔ สฺฺŗــَؔ๛ٖؔ,عـَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,هؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,خؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,حؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,جــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,شؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,سـَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,یؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,بؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,لؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,اสฺฺ,ؔؑنــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,ؔؑتــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,مؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,چؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,ظؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,طؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,❂زؔؑ ـَؔ ,رสฺฺŗ,❂ؔؑـَؔد۪๛ٖؔ,ؔؑپــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,❂وؔؑ ـَؔ,ڪؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,گؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,ثؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,สฺฺŗـذَؔ๛ٖؔ,❂آ,ئؔؑــَؔـَؔ ـَؔ สฺฺŗـَؔ๛ٖؔ,.,_",
	"ضؔؑـَؔ ـؔؑـَؔ๛ٖؔ,ؔؑصـَؔ ـؔؑـَؔ๛ٖؔ,ؔؑقـَؔ ـؔؑـَؔ๛ٖؔ,فؔؑـَؔ ـؔؑـَؔ๛ٖؔ,ؔؑغـَؔ ـؔؑـَؔ๛ٖؔ,ؔؑعـَؔ ـؔؑـَؔ๛ٖؔ,ؔؑه۪๛ٖؔ,ؔؑخـَؔ ـؔؑـَؔ๛ٖؔ,حؔؑـَؔ ـؔؑـَؔ๛ٖؔ,جؔؑـَؔ ـؔؑـَؔ๛ٖؔ,ؔؑشـَؔ ـؔؑـَؔ๛ٖؔ,ؔؑسـَؔ ـؔؑـَؔ๛ٖؔ,ؔؑیـَؔ ـؔؑـَؔ๛ٖؔ,ؔؑبـَؔ ـؔؑـَؔ๛ٖؔ,ؔؑلـَؔ ـؔؑـَؔ๛ٖؔ,ا,ؔؑنـَؔ ـؔؑـَؔ๛ٖؔ,ؔؑتـَؔ ـؔؑـَؔ๛ٖؔ,مؔؑـَؔ ـؔؑـَؔ๛ٖؔ,ؔؑچـَؔ ـؔؑـَؔ๛ٖؔ,طؔؑـَؔ ـؔؑـَؔ๛ٖؔ,ؔؑظـَؔ ـؔؑـَؔ๛ٖؔ,ؔؑزَؔ,ر,د,پؔؑـَؔ ـؔؑـَؔ๛ٖؔ,و,کؔؑـَؔ ـؔؑـَؔ๛ٖؔ,گؔؑـَؔ ـؔؑـَؔ๛ٖؔ,ؔؑثـَؔ ـؔؑـَؔ๛ٖؔ,ژ,ذ,آ,ؔؑئـَؔ ـؔؑـَؔ๛ٖؔ,.,_",
	"ضـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,صـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,قـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,فـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,غـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,عـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,ه➤,خـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,حـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,جـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,شـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,سـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,یـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,بـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,لـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,ا✺۠۠➤,نـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,تـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,مـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,چـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,ظـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,طـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,ز✺۠۠➤,ر✺۠۠➤,د✺۠۠➤,پـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,و✺۠۠➤,کـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,گـ͜͝ـ͜͝ـ͜͝ـ✺۠۠➤,ث✺۠۠➤,ژ✺۠۠➤,ذ✺۠۠➤,آ✺۠۠➤,ئ✺۠۠➤,.,_",
	"ضٖـٖٗ⸭ـٖٖٗـٖٗ⸭ٖٗ,صٖـٖٗ⸭ـٖٗـٖٖٗـٖٗ⸭,قـٖٗ⸭ـٖٗـٖٖٗـٖٗ⸭,فٖـٖٗ⸭ـٖٗـٖٖٗـٖٗ⸭,غٖـٖٗ⸭ــٖٖٗـٖٗ⸭,عٖـٖٗ⸭ــٖٖٗـٖٗ⸭,هٖٗ⸭,خٖـٖٗ⸭ـٖٗـٖٖٗـٖٗ⸭,حـٖٗ⸭ــٖٖٗـٖٗ⸭,جـٖٗ⸭ــٖٖٗـٖٗ⸭,شٖـٖٗ⸭ـٖٗـٖٖٗـٖٗ⸭,سٖـٖٗ⸭ــٖٖٗـٖٗ⸭,یـٖٗ⸭ـٖٗـٖٖٗـٖٗ⸭,ٖبـٖٗ⸭ــٖٖٗـٖٗ⸭,ٖلـٖٗ⸭,ـٖٖٗـٖٗا⸭,ٖنـٖٗ⸭ٖٗـٖٖٗـٖٗ⸭,تٖـٖٗ⸭ـٖٖٗـٖٗ⸭,مٖـٖٗ⸭ـٖٗـٖٗ⸭,چـٖٗ⸭ـٖٖٗـٖٗ⸭,ظـٖٗ⸭ـٖٖٗـٖٗ⸭,طـٖٗ⸭ـٖٖٗـٖٗ⸭,ز⸭,ٖرٖٗ⸭,ٖٗ⸭ـٖٖٗـٖٗد⸭,پـٖٗ⸭ـٖٖٗـٖٗ⸭,⸭ـوٖٖٗـٖٗ⸭,ڪـٖٗ⸭ـٖٖٗـٖٗ⸭,گـٖٗ⸭ـٖٖٗـٖٗ⸭,ثـٖٗ⸭ـٖٖٗـٖٗ⸭,ٖٗژ⸭,ٖٗ⸭ـذٖٗ⸭,⸭آ⸭,ئـٖٖٗـٖٗ⸭ـٖٖٗـٖٗ⸭,.,_",
	"ِِِِِِْْٰٰٰٰٰٰٖٖٖٖٖٖٖٖٖٖضـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,ص۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,۪ٜقـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,ف۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,۪ٜغـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,عـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,هٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,خ۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,خ۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,جـ۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,ش۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,سـ۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,یـ۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,بـ۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,لـ۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,۪ٜاٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,نـ۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,تـ۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,م۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,چ۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,ظ۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,طـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,ٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡ز✦,رٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,ٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡د✦,پ۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡و✦,ڪـ۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,گ۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,ث۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,ٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡ژ✦,ذٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,آٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,ئـ۪ٜـ۪ٜـ۪ٜـٰٰٰٰٰٰٰٰٰٰٰٰٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪ٜ۪۪۪۪۪۪ٜٜٜٜٖٜٜٜٖٜٖٖٖٖٖٖٖ͜͡✦,.,_",
	"ضـٍ͜ـ❉,صـٍ͜ــٍ͜❉,قـٍ͜ــٍ͜ــٍ͜❉,فـٍ͜ـ❉,غـٍ͜ــٍ͜ـ❉,عـٍ͜ــٍ͜ــٍ͜ـ❉,هـٍ͜ـ❉,خـٍ͜ــٍ͜❉,حـٍ͜ــٍ͜ــٍ͜❉,جـٍ͜ـ❉,شـٍ͜ــٍ͜❉,سـٍ͜ــٍ͜ــٍ͜❉,یـٍ͜ـ❉,بـٍ͜ــٍ͜❉,لـٍ͜ــٍ͜❉,ـٍ͜ــٍ͜ــٍ͜ا❉,نـٍ͜ـ❉,تـٍ͜ــٍ͜❉,مـٍ͜ــٍ͜ــٍ͜❉,چـٍ͜ـ❉,ظـٍ͜ــٍ͜❉,طـٍ͜ــٍ͜❉,زٍ͜❉,رٍ͜❉,دٍ͜❉,پـٍ͜ـ❉,وۘ❉,ڪـٍ͜ــٍ͜ــٍ͜❉,گـٍ͜ـ❉,ثـٍ͜ــٍ͜❉,ژً❉,ذٌ❉,آ❉,ئـٍ͜ـ❉,.,_",
	"ضـْْـْْـْْ/ْْ,صـْْـْْـ,قْْـْْـْْـْْ/ْْ,فـْْـْْـ,ْْغـْْـْْـْْ/,عْْـْْـْْـْْ,هـْْـْْـْْ/,خْْـْْـْْـ,حْْـْْـْْـْْ/ْْ,جـْْـْْـْْ,شـْْـْْـْْ/ْْ,سـْْـْْـْْ,یـْْـْْـْْ/,بْْـْْـْْـ,لْْـْْـْْـْْ/ْْ,ـْْـْْـْْا,نـْْـْْـْْ/ْْ,تـْْـْْـْْ,مـْْـْْـْْ/ْْ,چْـْْـْْـ,ظْْـْْـْْـْْ/,طْْـْْـْْـْْ,زٌ/,ـْْر,ـْْـْْـدْْ/,پْْـْْـْْـ,ـْْـْْـْْو/ْْ,ڪْـْْـْْـْْ,گـْْـْْـْْ/,ثْْـْْـْْـْْ,ـْْـْْـژْْ/,ْْـْْـْْـذ,آْْ/ْْ,ئـْْـْْـْْـْْـْْ/ْْ,.,_",
	"↜ضٍٍـُِ➲ِِனُِ,صـِْـَِ➲َِனِِ,↜ٍٍقـُِ➲ِِனُِ,فـِْـَِ➲َِனِِ↝,↜ٍٍغـُِ➲ِِனُِ,عـِْـَِ➲َِனِِ↝,↜ٍٍهـُِ➲ِِனُِ,خـِْـَِ➲َِனِِ↝,↜ٍٍحـُِ➲ِِனُِ,جـِْـَِ➲َِனِِ↝,↜ٍٍشـُِ➲ِِனُِ,سـِْـَِ➲َِனِِ↝,↜یٍٍـُِ➲ِِனُِ,بـِْـَِ➲َِனِِ↝,↜ٍٍلـُِ➲ِِனُِ,ِْاَِ➲َِனِِ↝,↜نٍٍـُِ➲ِِனُِ,تـِْـَِ➲َِனِِ↝,↜مٍٍـُِ➲ِِனُِ,چـِْـَِ➲َِனِِ↝,↜ظٍٍـُِ➲ِِனُِ,طـِْـَِ➲َِனِِ↝,↜ٍٍـزُِ➲ِِனُِ,ـِْـَِرِ➲َِனِِ↝,↜ٍٍـُِد➲ِِனُِ,پـِْـَِ➲َِனِِ↝,↜ٍٍـُِو➲ِِனُِ,ـِْـَِ➲َِனِِ↝,↜ٍٍڪـُِ➲ِِனُِ,گـِْـَِ➲َِனِِ↝,↜ثٍٍـُِ➲ِِனُِ,ـِْـژَِ➲َِனِِ↝,↜ٍٍـُِذ➲ِِனُِ,آَِ➲َِனِِ↝,↜ٍٍئـُِ➲ِِனُِ↝,.,_",
	"ضـ̚͠ــ̵͠ـ̵͠◕̟͠₰̵͕◚̶̶₰͕͔ ,صـ̚͠ــ̵͠◕̟͠₰̵͕◚̶̶₰͕͔,قـ̚͠ــ̵͠ـ̵͠◕̟͠₰̵͕◚̶̶₰͕͔ ,فـ̚͠ــ̵͠◕̟͠₰̵͕◚̶̶₰͕͔,غـ̚͠ــ̵͠ـ̵͠◕̟͠₰̵͕◚̶̶₰͕͔ ,عـ̚͠ــ̵͠◕̟͠₰̵͕◚̶̶₰͕͔,هـ̚͠ــ̵͠ـ̵͠◕̟͠₰̵͕◚̶̶₰͕͔ ,خـ̚͠ــ̵͠◕̟͠₰̵͕◚̶̶₰͕͔,حـ̚͠ــ̵͠ـ̵͠◕̟͠₰̵͕◚̶̶₰͕͔ ,جـ̚͠ــ̵͠◕̟͠₰̵͕◚̶̶₰͕͔,شـ̚͠ــ̵͠ـ̵͠◕̟͠₰̵͕◚̶̶₰͕͔ ,سـ̚͠ــ̵͠◕̟͠₰̵͕◚̶̶₰͕͔,یـ̚͠ــ̵͠ـ̵͠◕̟͠₰̵͕◚̶̶₰͕͔ ,بـ̚͠ــ̵͠◕̟͠₰̵͕◚̶̶₰͕͔,لـ̚͠ــ̵͠ـ̵͠◕̟͠₰̵͕◚̶̶₰͕͔ ,ا✓,ن̚͠ــ̵͠◕̟͠₰̵͕◚̶̶₰͕͔,تـ̚͠ــ̵͠ـ̵͠◕̟͠₰̵͕◚̶̶₰͕͔ ,مـ̚͠ــ̵͠◕̟͠₰̵͕◚̶̶₰͕͔,چـ̚͠ــ̵͠ـ̵͠◕̟͠₰̵͕◚̶̶₰͕͔ ,ظـ̚͠ــ̵͠◕̟͠₰̵͕◚̶̶₰͕͔,طـ̚͠ــ̵͠ـ̵͠◕̟͠₰̵͕◚̶̶₰͕͔ ,̺ز◕̟͠₰̵͕◚̶̶₰͕͔,̚͠رـ̵͠ـ̵͠◕̟͠₰̵͕◚̶̶₰͕͔ ,د̵͠◕̟͠₰ ,پـ̚͠ــ̵͠ـ̵͠◕̟͠₰̵͕◚̶̶₰͕͔ ,ـ̚͠ــ̵͠و̺◕̟͠₰̵͕◚̶̶₰͕͔,ڪـ̚͠ــ̵͠ـ̵͠◕̟͠₰̵͕◚̶̶₰͕͔ ,گـ̚͠ــ̵͠◕̟͠₰̵͕◚̶̶₰͕͔,ثـ̚͠ــ̵͠ـ̵͠◕̟͠₰̵͕◚̶̶₰͕͔ ,ژ◕̟͠₰̵͕◚̶̶₰͕͔,ـ̚͠ـذـ̵͠ـ̵͠◕̟͠₰̵͕◚̶̶₰͕͔ ,آ✓,ئـ̚͠ــ̵͠◕̟͠₰̵͕◚̶̶₰͕͔,.,_",
	"ضـٰٓـًً◑ِّ◑ًً, صـུـٜٜ◑ِّ◑ًً,قـٰٓـًً◑ِّ◑ًً, فـུـٜٜ◑ِّ◑ًً,غـٰٓـًً◑ِّ◑ًً, عـུـٜٜ◑ِّ◑ًً,هـٰٓـًً◑ِّ◑ًً, خـུـٜٜ◑ِّ◑ًً,حـٰٓـًً◑ِّ◑ًً, جـུـٜٜ◑ِّ◑ًً,شـٰٓـًً◑ِّ◑ًً, سـུـٜٜ◑ِّ◑ًً,یـٰٓـًً◑ِّ◑ًً, بـུـٜٜ◑ِّ◑ًً,لـٰٓـًً◑ِّ◑ًً, ا◑ِّ◑ًً,نـٰٓـًً◑ِّ◑ًً, تـུـٜٜ◑ِّ◑ًً,مـٰٓـًً◑ِّ◑ًً, چـུـٜٜ◑ِّ◑ًً,ظـٰٓـًً◑ِّ◑ًً, طـུـٜٜ◑ِّ◑ًً,ز◑ِّ◑ًً,رٜٜ◑ِّ◑ًً,د◑ِّ◑ًً, پـུـٜٜ◑ِّ◑ًً,وًً◑ِّ◑ًً, ڪـུـٜٜ◑ِّ◑ًً,گـٰٓـًً◑ِّ◑ًً, ثـུـٜٜ◑ِّ◑ًً,ژ◑ِّ◑ًً,ذٜٜ◑ِّ◑ًً,ا◑ِّ◑ًً, ئـུـٜٜ◑ِّ◑ًً,.,_",
	"ضـ͜͡ـ͜͡✭,صـ͜͡ـ͜͡✭,قـ͜͡ـ͜͡ـ͜͡✭,فــ͜͡ـ͜͡✭,غـ͜͡ـ͜͡✭,عـ͜͡ـ͜͡✭,هـ͜͡ـ͜͡ـ͜͡✭,خــ͜͡ـ͜͡✭,حـ͜͡ـ͜͡✭,جـ͜͡ـ͜͡✭,شـ͜͡ـ͜͡ـ͜͡✭,ســ͜͡ـ͜͡✭,یـ͜͡ـ͜͡✭,بـ͜͡ـ͜͡✭,لـ͜͡ـ͜͡ـ͜͡✭,͜͡ا✭,نـ͜͡ـ͜͡✭,تـ͜͡ـ͜͡✭,مـ͜͡ـ͜͡ـ͜͡✭,چــ͜͡ـ͜͡✭,ظـ͜͡ـ͜͡✭,طـ͜͡ـ͜͡✭,ز͜͡✭,͜͡ر✭,͜͡د✭,پـ͜͡ـ͜͡✭,ـ͜͡و͜͡ـ͜͡✭,ڪــ͜͡ـ͜͡✭,گـ͜͡ـ͜͡✭,ـ͜͡ـ͜͡✭,ثـ͜͡ـ͜͡ـ͜͡✭,ـ͜͡ژ͜͡✭,ذ✭,آ✭,ئـ͜͡ـ͜͡ـ͜͡✭,.,_",
	"ضـًٍـؒؔـؒؔ⸙ؒৡ✪,صـًٍـؒؔـؒؔ⸙ؒৡ✪,قـًٍـؒؔـؒؔ⸙ؒৡ✪,فـًٍـؒؔـؒؔ⸙ؒৡ✪,غـًٍـؒؔـؒؔ⸙ؒৡ✪,عـًٍـؒؔـؒؔ⸙ؒৡ✪,هـًٍـؒؔـؒؔ⸙ؒৡ✪,خـًٍـؒؔـؒؔ⸙ؒৡ✪,حـًٍـؒؔـؒؔ⸙ؒৡ✪,جـًٍـؒؔـؒؔ⸙ؒৡ✪,شـًٍـؒؔـؒؔ⸙ؒৡ✪,سـًٍـؒؔـؒؔ⸙ؒৡ✪,یـًٍـؒؔـؒؔ⸙ؒৡ✪,بـًٍـؒؔـؒؔ⸙ؒৡ✪,لـًٍـؒؔـؒؔ⸙ؒৡ✪,ا✪,نـًٍـؒؔـؒؔ⸙ؒৡ✪,تـًٍـؒؔـؒؔ⸙ؒৡ✪,مـًٍـؒؔـؒؔ⸙ؒৡ✪,چـًٍـؒؔـؒؔ⸙ؒৡ✪,ظـًٍـؒؔـؒؔ⸙ؒৡ✪,طـًٍـؒؔـؒؔ⸙ؒৡ✪,ز✪,ر✪,د✪,پـًٍـؒؔـؒؔ⸙ؒৡ✪,و✪,ڪـًٍـؒؔـؒؔ⸙ؒৡ✪,گـًٍـؒؔـؒؔ⸙ؒৡ✪,ثـًٍـؒؔـؒؔ⸙ؒৡ✪,ژ✪,ذ✪,آ✪,ئـًٍـؒؔـؒؔ⸙ؒৡ✪,.,_",
	"ضـ◎۪۪❖ुؔ,صـ◎۪۪❖ुؔ,قـ◎۪۪❖ुؔ,فـ◎۪۪❖ुؔ,غـ◎۪۪❖ुؔ,عـ◎۪۪❖ुؔ,هـ◎۪۪❖ुؔ,خـ◎۪۪❖ुؔ,حـ◎۪۪❖ुؔ,جـ◎۪۪❖ु,شـ◎۪۪❖ु,سـ◎۪۪❖ु,یـ◎۪۪❖ु,بـ◎۪۪❖ु,لـ◎۪۪❖ु,ا◎۪۪❖ु,نـ◎۪۪❖ु,تـ◎۪۪❖ु,مـ◎۪۪❖ु,چـ◎۪۪❖ु,ظـ◎۪۪❖ु,طـ◎۪۪❖ु,ز◎۪۪❖ु,ر◎۪۪❖ु,د◎۪۪❖ु,پـ◎۪۪❖ु,و◎۪۪❖ु,ڪـ◎۪۪❖ु,گـ◎۪۪❖ु,ثـ◎۪۪❖ु,ژ◎۪۪❖ु,ذ◎۪۪❖ु,آ◎۪۪❖ु,ئـ◎۪۪❖ु,.,_",
	"ض۪ٓـٌْ‌ٍٖـ۪ٓـٌْ‌ٍٖ,صــ۪ٓـٌْ‌ٍٖ,‌ قـ۪ٓـٌْ‌ٍٖـ۪ٓ,فـٌْ‌ٍٖـ۪ٓ,غـٌْ‌ٍٖـ۪ٓ,عـٌْ‌ٍٖـ۪ٓ,هـٌْ‌ٍٖـ۪ٓ,خـٌْ‌ٍٖـ۪ٓ,حـٌْ‌ٍٖـ۪ٓ,جـٌْ‌ٍٖـ۪ٓ,شـٌْ‌ٍٖـ۪ٓ,سـٌْ‌ٍٖـ۪ٓ,یـٌْ‌ٍٖـ۪ٓ,بـٌْ‌ٍٖـ۪ٓ,لـٌْ‌ٍٖـ۪ٓ,اٌْ‌ٍٖـ۪ٓ,نـٌْ‌ٍٖـ۪ٓ,تـٌْ‌ٍٖـ۪ٓ,مـٌْ‌ٍٖـ۪ٓ,چـٌْ‌ٍٖـ۪ٓ,ظـٌْ‌ٍٖـ۪ٓ,طـٌْ‌ٍٖـ۪ٓ,زुـ۪ٓ,رٌْ‌ٍٖـ۪ٓ,دुـ۪ٓ,پـٌْ‌ٍٖـ۪ٓ,وुـ۪ٓ,ڪـٌْ‌ٍٖـ۪ٓ,گـٌْ‌ٍٖـ۪ٓ,ثـٌْ‌ٍٖـ۪ٓ,ژुـ۪ٓ,ذـٌْ‌ٍٖـ۪ٓ,آुـ۪ٓ,ئـٌْ‌ٍٖـ۪ٓ,.,_",
	"ضِْـِْ❉,ِْصـِْ❉,قِْـِْ❉,ِْفـِْ❉,غِْـِْ❉,ِْعـِْ❉,ِْهـِْ❉,ِْخـِْ❉,ِْحـِْ❉,ِْجـِْ❉,ِْشـِْ❉,ِْسـِْ❉,یِْـِْ❉,بِْـِْ❉,لِْـِْ❉,ِْاـِْ❉,نِْـِْ❉,ِْتـِْ❉,ِْمـِْ❉,ِْچـِْ❉,ِْظـِْ❉,طِْـِْ❉,زِْـِْ❉,رِْـِْ❉,ِْدـِْ❉,پِْـِْ❉,وِْـِْ❉,ِْکـِْ❉,ِْگـِْ❉,ِْثـِْ❉,ِْژـِْ❉,ِْذـِْ❉,ِْآـِْ❉,ِْئـِْ❉,.,_",
	"[ِْـِْضـِْ❉ِْـِْ,[ِْـِْصـِْ❉ِْـِْ,[ِْـِْقـِْ❉ِْـِْ,[ِْـِْفـِْ❉ِْـِْ,[ِْـغِْـِْ❉ِْـِْ,[ِْـعِْـِْ❉ِْـِْ,[ِْـهِْـِْ❉ِْـِْ,[ِْـِْخـِْ❉ِْـِْ,[ِْـِْحـِْ❉ِْـِْ,[ِْـِْجـِْ❉ِْـِْ,[ِْـِْشـِْ❉ِْـِْ,[ِْـِْسـِْ❉ِْـِْ,[ِْـِْیـِْ❉ِْـِْ,[ِْـِْبـِْ❉ِْـِْ,[ِْـلِْـِْ❉ِْـِْ,[ِْـاِْـِْ❉ِْـِْ,[ِْـِْنـِْ❉ِْـِْ,[ِْـِْتـِْ❉ِْـِْ,[ِْـمِْـِْ❉ِْـِْ,[ِْـچِْـِْ❉ِْـِْ,[ِْـِْظـِْ❉ِْـِْ,[ِْـِْطـِْ❉ِْـِْ,[ِْـِْزـِْ❉ِْـِْ,[ِْـرِْـِْ❉ِْـِْ,[ِْـِْدـِْ❉ِْـِْ,[ِْـپِْـِْ❉ِْـِْ,[ِْـِْوـِِْْ❉ِْـِْ,[ِْـڪِْـِْ❉ِْـِْ,[ِْـگِْـِْ❉ِْـِْ,[ِْـِْثـِْ❉ِْـِْ,[ِْـِْژـِْ❉ِْـِْ,[ِْـذِْـِْ❉ِْـِْ,[ِْـآِْـِْ❉ِْـِْ,[ِْـِْئـِْ❉ِْـِْ,.,_",
	"❅ضـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅صـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅قـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅فـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅غـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅عـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅هـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅خـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅حـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅جـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅شـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅سـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅یـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅بـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅لـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅اؒؔ❢,❅نـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅تـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅مـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅چـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅ظـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅طـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅ـ۪۪ـؒؔـزؒؔـ۪۪ـؒؔـؒؔ❢,❅ـ۪۪ـؒؔـؒؔرـ۪۪ـؒؔـؒؔ❢,❅ـ۪۪ـؒؔـدؒؔـ۪۪ـؒؔـؒؔ❢,❅پـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅ـ۪۪ـؒؔـؒؔوـ۪۪ـؒؔـؒؔ❢,❅ڪـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅گـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅ثـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,❅ـ۪۪ـؒؔـژؒؔـ۪۪ـؒؔـؒؔ❢,❅ـ۪۪ـؒؔـذؒؔـ۪۪ـؒؔـؒؔ❢,❅۪۪آؒؔ❢,❅ئـ۪۪ـؒؔـؒؔـ۪۪ـؒؔـؒؔ❢,.,_",
	"ضٖؒـؒؔـٰٰـٖٖ,صٖؒـؒؔـٰٰـٖٖ,قٖؒـؒؔـٰٰـٖٖ,فٖؒـؒؔـٰٰـٖٖ,غٖؒـؒؔـٰٰـٖٖ,عٖؒـؒؔـٰٰـٖٖ,هٖؒـؒؔـٰٰـٖٖ,خٖؒـؒؔـٰٰـٖٖ,حٖؒـؒؔـٰٰـٖٖ,جٖؒـؒؔـٰٰـٖٖ,شٖؒـؒؔـٰٰـٖٖ,سٖؒـؒؔـٰٰـٖٖ,یٖؒـؒؔـٰٰـٖٖ,بٖؒـؒؔـٰٰـٖٖ,لٖؒـؒؔـٰٰـٖٖ,اٖؒـؒؔـٰٰـٖٖ,نٖؒـؒؔـٰٰـٖٖ,تٖؒـؒؔـٰٰـٖٖ,مٖؒـؒؔـٰٰـٖٖ,چٖؒـؒؔـٰٰـٖٖ,ظٖؒـؒؔـٰٰـٖٖ,طٖؒـؒؔـٰٰـٖٖ,زٖؒـؒؔـٰٰـٖٖ,رٖؒـؒؔـٰٰـٖٖ,دٖؒـؒؔـٰٰـٖٖ,پٖؒـؒؔـٰٰـٖٖ,وٖؒـؒؔـٰٰـٖٖ,کٖؒـؒؔـٰٰـٖٖ,گٖؒـؒؔـٰٰـٖٖ,ثٖؒـؒؔـٰٰـٖٖ,ژٖؒـؒؔـٰٰـٖٖ,ذٖؒـؒؔـٰٰـٖٖ,آٖؒـؒؔـٰٰـٖٖ,ئٖؒـؒؔـٰٰـٖٖ,.ٖؒـؒؔـٰٰـٖٖ,_"
	}
	local resultfa = {}
	i=0
	for k=1,#fontsfa do
		i=i+1
		local tar_font = fontsfa[i]:split(",")
		local text = mr_roo[2]
		local text = text:gsub("ض",tar_font[1])
		local text = text:gsub("ص",tar_font[2])
		local text = text:gsub("ق",tar_font[3])
		local text = text:gsub("ف",tar_font[4])
		local text = text:gsub("غ",tar_font[5])
		local text = text:gsub("ع",tar_font[6])
		local text = text:gsub("ه",tar_font[7])
		local text = text:gsub("خ",tar_font[8])
		local text = text:gsub("ح",tar_font[9])
		local text = text:gsub("ج",tar_font[10])
		local text = text:gsub("ش",tar_font[11])
		local text = text:gsub("س",tar_font[12])
		local text = text:gsub("ی",tar_font[13])
		local text = text:gsub("ب",tar_font[14])
		local text = text:gsub("ل",tar_font[15])
		local text = text:gsub("ا",tar_font[16])
		local text = text:gsub("ن",tar_font[17])
		local text = text:gsub("ت",tar_font[18])
		local text = text:gsub("م",tar_font[19])
		local text = text:gsub("چ",tar_font[20])
		local text = text:gsub("ظ",tar_font[21])
		local text = text:gsub("ط",tar_font[22])
		local text = text:gsub("ز",tar_font[23])
		local text = text:gsub("ر",tar_font[24])
		local text = text:gsub("د",tar_font[25])
		local text = text:gsub("پ",tar_font[26])
		local text = text:gsub("و",tar_font[27])
		local text = text:gsub("ک",tar_font[28])
		local text = text:gsub("گ",tar_font[29])
		local text = text:gsub("ث",tar_font[30])
		local text = text:gsub("ژ",tar_font[31])
		local text = text:gsub("ذ",tar_font[32])
		local text = text:gsub("ئ",tar_font[33])
		local text = text:gsub("آ",tar_font[34])
		table.insert(resultfa, text)
	end
	
	local result_textfa = "کلمه ی اولیه : "..mr_roo[2].."\nطراحی با "..tostring(#fontsfa).." فونت :\n______________________________\n"
	a=0
	for v=1,#resultfa do
		a=a+1
		result_textfa = result_textfa..a.."- "..resultfa[a].."\n\n"
	end
	tdbot.sendMessage(msg.chat_id, 0, 1, result_textfa.."💢💢💢💢💢💢💢💢💢💢\n"..M_START..""..channel_username..""..EndPm, 1, 'html')
end
end
end
end

return {
patterns = fun_patterns, run = MaTaDoRTeaM
}
