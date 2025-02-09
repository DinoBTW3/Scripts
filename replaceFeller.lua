local downloadUrl = "https://raw.githubusercontent.com/DinoBTW3/Scripts/refs/heads/main/feller.lua"

if not http then
    printError("wget requires http API")
    printError("Set http_enable to true in ComputerCraft.cfg")
    return
end
 
local function get(sUrl)
    write("Connecting to " .. sUrl .. "... ")
 
    local ok, err = http.checkURL(sUrl)
    if not ok then
        print("Failed.")
        if err then
            printError(err)
        end
        return nil
    end
 
    local response = http.get(sUrl, nil, true)
    if not response then
        print("Failed.")
        return nil
    end
 
    print("Success.")
 
    local sResponse = response.readAll()
    response.close()
    return sResponse
end
 
-- Determine file to download
local sFile = "feller"
local sPath = shell.resolve(sFile)
 
-- Do the get
local res = get(downloadUrl)
if res then
    if fs.exists(sPath) then
        fs.delete(sPath)
    end
 
    local file = fs.open(sPath, "wb")
    file.write(res)
    file.close()
 
    print("Downloaded and replaced as " .. sFile)
end
 