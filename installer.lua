
http.request("https://raw.githubusercontent.com/gquarles/goscript/master/compile.lua")

local requesting = true

while requesting do
  local event, url, sourceText = os.pullEvent()
  
  if event == "http_success" then
    respondedText = sourceText.readAll()
    
    sourceText.close()
    
    requesting = false
    print("Cloned compiler from GitHub Repo at compiler.lua")

    osfile = fs.open("compile.lua", "w")
    osfile.writeLine(respondedText)
	osfile.close()

  else
    print("Error not connect to GitHub. Make sure your server allows HTTP requests.")
    requesting = false
  end
end

