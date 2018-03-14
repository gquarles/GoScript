--GOScript Compiler--

--Reads .go files and compiles to .lua

--Usage compile <goscriptname.go>
--Output <goscriptname.lua>

--GOScript Compiler--



--Global Vars--
args = {...}
filePath = args[1]
lines = {}
compiledLines = {}
--Global Vars End--

--Functions--
function clear()
    term.clear()
    term.setCursorPos(1,1)
end

function getFilePath()
    write("script: ")
    filePath = read()
end

function fileExists()
    if (fs.exists(filePath)) then
        return true
    else
        return false
    end
end

function openFile()
    file = fs.open(filePath, "r")
    for line in file.readLine do
        lines[ #lines + 1 ] = line
    end
    file.close()
end

function writeF(command)
    luafile = fs.open(compiledFile .. ".lua", "w")
    luafile.writeLine(command)
    table.insert(compiledLines, command)
    print(command)
end

function compile()
    openFile()
    compiledFile = filePath:sub(1,-2)
    compiledFile = compiledFile:sub(1,-2)
    compiledFile = compiledFile:sub(1,-2)
    

    for i = 1, #lines do
        local words = {}
        goscript = lines[i]
        for word in goscript:gmatch("%w+") do table.insert(words, word) end
        
        if (words[1] == "move") then
            if (words[2] == "forward") then
                writeF("turtle.forward()")
            elseif (words[2] == "back") then
                writeF("turtle.back()")
            elseif (words[2] == "left") then
                writeF("left()")
            elseif (words[2] == "right") then
                writeF("right()")
            else
                print("error unknown move: " .. words[2] .. " line: " .. i)
            end

        end
        
    end
    
end
--Functions End--



--Main--

if (filePath == nil) then
    getFilePath()
end
if (fileExists()) then
    compile()
else
    print("Error - File does not exist at " .. filePath)
end
