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
    table.insert(compiledLines, command)
    print(command)

    osfile = fs.open(compiledFileName, "w")
    for j = 1, #compiledLines do
        osfile.writeLine(compiledLines[j])
    end
	osfile.close()
end

function compile()
    openFile()
    compiledFileName = filePath:sub(1,-2)
    compiledFileName = compiledFileName:sub(1,-2)
    compiledFileName = compiledFileName:sub(1,-2)
    compiledFileName = compiledFileName .. ".lua"

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
                writeF("turtle.turnLeft()")
                writeF("turtle.forward()")
                writeF("turtle.turnRight()")
            elseif (words[2] == "right") then
                writeF("turtle.turnRight()")
                writeF("turtle.forward()")
                writeF("turtle.turnLeft()")
            else
                print("error unknown move: " .. words[2] .. " line: " .. i)
            end

        elseif (words[1] == "turn") then
            if (words[2] == "left") then
                writeF("turtle.turnLeft()")
            elseif (words[2] == "right") then
                writeF("turtle.turnRight()")
            else
                print("error unkown turn: " .. words[2] .. " line: " .. i)
            end
        
        elseif (words[1] == "dig") or (words[1] == "mine") then
            if (words[2] == "up") then
                writeF("turtle.digUp()")
            elseif (words[2] == "down") then
                writeF("turtle.digDown()")
            elseif (words[2] == "left") then
                writeF("turtle.turnLeft()")
                writeF("turtle.dig()")
                writeF("turtle.turnRight()")
            elseif (words[2] == "right") then
                writeF("turtle.turnRight()")
                writeF("turtle.dig()")
                writeF("turtle.turnLeft()")
            elseif (words[2] == "forward") then
                writeF("turtle.dig()")
            else
                writeF("turtle.dig()")
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
