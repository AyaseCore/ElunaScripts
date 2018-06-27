local dt = {}
dt.time = 5 --5 min
dt.data = {}
dt.option = {"a","b","c","d"}
dt.id = 0
dt.reward = {id = 47241,count = 2}

function dt.load()
	local q = WorldDBQuery("SELECT * FROM ayasecore_questionsystem")
	if (q) then
		repeat
			local temp = {["qu"]=q:GetString(0),["xx"] = {q:GetString(1),q:GetString(2),q:GetString(3),q:GetString(4)},
			["ok"]=q:GetString(5)}
			table.insert(dt.data,temp)
		until not q:NextRow()
	end
end

function dt.re() 
	dt.id = math.random(1,#dt.data) 
	local d = dt.data[dt.id]
	SendWorldMessage(string.format("|cffff0000[答题系统]|r%s\n    [choice]  |CFFFF0080a|r：|CFF00FFFF%s|r  |CFFFF0080b|r：|CFF00FFFF%s|r  |CFFFF0080c|r：|CFF00FFFF%s|r  |CFFFF0080d|r：|CFF00FFFF%s|r\n|cFFF08000★★★下一轮答题将在|r|cffff0000(%s分钟)|r|cFFF08000后开始.请留意★★★|r",d.qu,d.xx[1],d.xx[2],d.xx[3],d.xx[4],dt.time))
end

function dt.comm(_,p,c)
	if (c == "dt") then
		if dt.id == 0 then 
			p:SendBroadcastMessage("本轮答题结束.下一轮请关注聊天窗口.再接再厉！")
		else
			dt.show(p)
		end
	return false
	end
end

function dt.show(p) 
	local d = dt.data[dt.id]
	p:GossipClearMenu()
	p:GossipMenuAddItem(0,"本轮答题题目：\n"..d.qu.."",1,0)
	for i= 1,4 do
		p:GossipMenuAddItem(5,"选项\n|CFFFF0080["..dt.option[i].."]|r|cff0000ff"..d.xx[i].."|r",1,i)	
	end
	p:GossipSendMenu(1,p,60001)
end

function dt.sele(_,p,_,_,i)
	if (i == 0) then
		return dt.show(p)
	else
		local d = dt.data[dt.id]
		if d.ok == dt.option[i] then
			SendWorldMessage(string.format("|cffff0000[答题]|r：|cffFFFFFF本轮题目正确答案为 |CFFFF0080%s|r |cffFFFFFF恭喜玩家|cffff0000[%s]|r|cffFFFFFF回答正确.奖励|r %s x |cffff0000%s|r |cffFFFFFF个|r",d.ok,p:GetName(),GetItemLink(d.it),d.it_c))
			p:AddItem(dt.reward.id,dt.reward.count)
			dt.id = 0
		else
			p:SendBroadcastMessage(string.format("你回答错误.扣除|r %s x |cffff0000%s|r 个|r\n|cff00cc00你失去了:|r%s|cff00cc00x|r|cff00cc00%s|r|cff00cc00。|r",GetItemLink(d.it),d.it_c,GetItemLink(d.it),d.it_c))
			--p:RemoveItem(dt.reward.id,dt.reward.count)
		end
		p:GossipComplete()
	end
end

RegisterPlayerEvent(42,dt.comm)
CreateLuaEvent(dt.re,dt.time*60*1000,0)
RegisterPlayerGossipEvent(60001,2,dt.sele)
dt.load()