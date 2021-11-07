local function PromptDiscordInvite(invite, showPrompt)
    if not syn then
        return warn('Synapse X essential to run this script!')
    end
    local Inv, ServerInfo, ServerName = {'s', 'c', 'R', 'a', 'm', 'D', 'a', '4', '6', 'e'}, nil, ''
   
    if invite and type(invite) == 'string' and invite:match('%a') then
        Inv = invite
        data_url = 'https://discord.com/api/v6/invite/'..Inv
    else
        Inv = table.concat(Inv)
        data_url = 'https://discord.com/api/v6/invite/'..Inv
    end
   
    ServerInfo = syn.request({
        Url = 'https://discord.com/api/v6/invite/'..Inv,
        Method = 'GET'
    })
   
    if ServerInfo.Success then
        ServerInfo = game:GetService('HttpService'):JSONDecode(ServerInfo.Body)
    else
        warn(ServerInfo.StatusCode, ServerInfo.StatusMessage, '|', ServerInfo.Body)
        return
    end
   
    local getsynassetfromurl = function(url)
        local File, Raw = 'SynAsset [', syn.request({
            Url = url,
            Method = 'GET'
        }).Body
        if url and type(url) == 'string' and tostring(Raw):find('PNG') then
            for i = 1, 5 do
                File = tostring(File..string.char(math.random(65, 122)))
            end
            File = File..'].png'
            writefile(File, Raw)
            coroutine.wrap(function()
                wait(10)
                if isfile(File) then
                    delfile(File)
                end
            end)()
            return getsynasset(File)
        end
    end
   
    local function Request()
        syn.request(
            {
                Url = 'http://127.0.0.1:6463/rpc?v=1',
                Method = 'POST',
                Headers = {
                    ['Content-Type'] = 'application/json',
                    ['origin'] = 'https://ptb.discord.com',
                },
                Body = game:GetService('HttpService'):JSONEncode({
                    ['args'] = {
                    ['code'] = Inv,
                    ['sex'] = '?species=Goblin&realm=Toril'
                },
                ['cmd'] = 'INVITE_BROWSER',
                ['nonce'] = 'OwO'
            })
        })
    end -- trollage ... (Credits to whoever discovered this invite method)
    
