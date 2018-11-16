local function TiiGeRTeaM(msg, mr_roo)
	if tonumber(msg.from.id) == SUDO then
		if mr_roo[1]:lower() == "setsudo" or mr_roo[1] == "تنظیم سودو" then
			AddandRem(msg, mr_roo[2] ,"visudo")
		elseif mr_roo[1]:lower() == "remsudo" or mr_roo[1] == "حذف سودو" then
			AddandRem(msg, mr_roo[2] ,"desudo")
		end
	end
	if is_sudo(msg) then
		if mr_roo[1]:lower() == "setadmin" or mr_roo[1] == "تنظیم ادمین" then
			AddandRem(msg, mr_roo[2] ,"adminprom")
		elseif mr_roo[1]:lower() == "remadmin" or mr_roo[1] == "حذف ادمین" then
			AddandRem(msg, mr_roo[2] ,"admindem")
		elseif mr_roo[1]:lower() == "add" or mr_roo[1] == "نصب گروه" then
			return modadd(msg)
		elseif mr_roo[1]:lower() == "rem" or mr_roo[1] == "حذف گروه" then
			return modrem(msg)
		end
	end
	if is_admin(msg) then
		if mr_roo[1]:lower() == "gbanlist" or mr_roo[1] == "لیست سوپر مسدود" then
			return gbanned_list(msg)
		elseif mr_roo[1]:lower() == "banall" or mr_roo[1] == "سوپر مسدود" then
			AddandRem(msg, mr_roo[2] ,"banall")
		elseif mr_roo[1]:lower() == "unbanall" or mr_roo[1] == "حذف سوپر مسدود" then
			AddandRem(msg, mr_roo[2] ,"unbanall")
		elseif mr_roo[1]:lower() == "setowner" or mr_roo[1] == 'مالک' then
			AddandRem(msg, mr_roo[2] ,"setowner")
		elseif mr_roo[1]:lower() == "remowner" or mr_roo[1] == "حذف مالک" then
			AddandRem(msg, mr_roo[2] ,"remowner")
		end
	end
	if is_JoinChannel(msg) then
		if is_owner(msg) then
			if mr_roo[1]:lower() == "promote" or mr_roo[1] == "مدیر" then
				AddandRem(msg, mr_roo[2] ,"promote")
			elseif mr_roo[1]:lower() == "ownerlist" or mr_roo[1] == "لیست مالکان" then
				return ownerlist(msg)
			elseif mr_roo[1]:lower() == "demote" or mr_roo[1] == "حذف مدیر" then
				AddandRem(msg, mr_roo[2] ,"demote")
			end
		end
		if is_mod(msg) then
			if msg.to.type ~= 'pv' then
				if mr_roo[1]:lower() == "silentlist" or mr_roo[1] == "لیست سکوت" then
					return silent_users_list(msg)
				elseif mr_roo[1]:lower() == "banlist" or mr_roo[1] == "لیست مسدود" then
					return banned_list(msg)
				elseif mr_roo[1]:lower() == "kick" or mr_roo[1] == "اخراج" then
					AddandRem(msg, mr_roo[2] ,"kick")
				elseif mr_roo[1]:lower() == "delall" or mr_roo[1] == "حذف پیام" then
					AddandRem(msg, mr_roo[2] ,"delall")
				elseif mr_roo[1]:lower() == "ban" or mr_roo[1] == "مسدود" then
					AddandRem(msg, mr_roo[2] ,"ban")
				elseif mr_roo[1]:lower() == "unban" or mr_roo[1] == "حذف مسدود" then
					AddandRem(msg, mr_roo[2] ,"unban")
				elseif mr_roo[1]:lower() == "silent" or mr_roo[1] == "سکوت" then
					AddandRem(msg, mr_roo[2] ,"silent")
				elseif mr_roo[1]:lower() == "unsilent" or mr_roo[1] == "حذف سکوت" then
					AddandRem(msg, mr_roo[2] ,"unsilent")
				end
			end
			if (mr_roo[1]:lower() == "whitelist" or mr_roo[1] == "لیست سفید") and mr_roo[2] == "+" then
				AddandRem(msg, mr_roo[3] ,"setwhitelist")
			elseif (mr_roo[1]:lower() == "whitelist" or mr_roo[1] == "لیست سفید") and mr_roo[2] == "-" then
				AddandRem(msg, mr_roo[3] ,"remwhitelist")
			elseif (mr_roo[1]:lower() == "whitelist" or mr_roo[1] == "لیست سفید") and not mr_roo[2] then
				return whitelist(msg)
			elseif mr_roo[1]:lower() == "modlist" or mr_roo[1] == "لیست مدیران" then
				return modlist(msg)
			elseif mr_roo[1]:lower() == 'filter' or mr_roo[1] == "فیلتر" then
				return filter_word(msg, mr_roo[2])
			elseif mr_roo[1]:lower() == 'unfilter' or mr_roo[1] == "حذف فیلتر"  then
				return unfilter_word(msg, mr_roo[2])
			elseif mr_roo[1]:lower() == 'filterlist' or mr_roo[1] == "لیست فیلتر" then
				return filter_list(msg)
			elseif mr_roo[1]:lower() == "settings" or mr_roo[1] == "تنظیمات" then
				return group_settings(msg)
			elseif mr_roo[1]:lower() == "warn" or mr_roo[1] == "اخطار" then
				AddandRem(msg, mr_roo[2] ,"warn")
			elseif mr_roo[1]:lower() == "unwarn" or mr_roo[1] == "حذف اخطار" then
				AddandRem(msg, mr_roo[2] ,"unwarn")
			end
		end
	end
end

return {
patterns = core_patterns, run = TiiGeRTeaM, pre_process = Mr_Mine
}
