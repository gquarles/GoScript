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

function addMoveAPI()
    writeF("---------MOVEAPI---------")

    writeF("--GlobalVars--")

    writeF("xCord = 0")
    writeF("yCord = 0")
    writeF("zCord = 0")
    writeF("facing = 0")
    
    writeF("--GlobalVars END--")

    writeF("function forward(moveAmount)")
    writeF("    for u=1, moveAmount do")
    writeF("       if turtle.forward() then")
    writeF("          if (facing == 0) then")
    writeF("              xCord = xCord + 1")
    writeF("          elseif (facing == 1) then")
    writeF("              yCord = yCord - 1")
    writeF("          elseif (facing == 2) then")
    writeF("              xCord = xCord - 1")
    writeF("          elseif (facing == 3) then")
    writeF("            yCord = yCord + 1")
    writeF("           end")
    writeF("       else")
    writeF("           sleep(2)")
    writeF("            turtle.dig()")
    writeF("           turtle.forward()")
    writeF("        end")
    writeF("    end")
    writeF("end")

    writeF("function back(moveAmount)")
    writeF("    for u=1, moveAmount do")
    writeF("       if turtle.back() then")
    writeF("           if (facing == 0) then")
    writeF("              xCord = xCord - 1")
    writeF("          elseif (facing == 1) then")
    writeF("               yCord = yCord + 1")
    writeF("          elseif (facing == 2) then")
    writeF("              xCord = xCord + 1")
    writeF("           elseif (facing == 3) then")
    writeF("              yCord = yCord - 1")
    writeF("          end")
    writeF("      else")
    writeF("           sleep(2)")
    writeF("           turnLeft()")
    writeF("           turnLeft()")
    writeF("           turtle.dig()")
    writeF("           turnLeft()")
    writeF("           turnLeft()")
    writeF("           turtle.back()")
    writeF("        end")
    writeF("    end")
    writeF("end")

    writeF("function up(moveAmount)")
    writeF("iter = moveAmount")
    writeF("    for u=1, moveAmount do")
    writeF("        if turtle.up() then")
    writeF("            zCord = zCord + 1")
    writeF("		iter = iter - 1")
    writeF("        else")
    writeF("            sleep(1)")
    writeF("            turtle.digUp()")
    writeF("            up(iter)")
    writeF("        end")
    writeF("    end")
    writeF("end")

    writeF("function down(moveAmount)")
    writeF("iter = moveAmount")
    writeF("    for u=1, moveAmount do")
    writeF("       if turtle.down() then")
    writeF("           zCord = zCord - 1")
    writeF("		iter = iter - 1")
    writeF("       else")
    writeF("           sleep(1)")
    writeF("           turtle.digDown()")
    writeF("           down(iter)")
    writeF("        end")
    writeF("    end")
    writeF("end")

    writeF("function turnLeft()")
    writeF("    turtle.turnLeft()")
    writeF("    if (facing == 3) then")
    writeF("        facing = 0")
    writeF("    else")
    writeF("        facing = facing + 1")
    writeF("    end")
    writeF("end")

    writeF("function turnRight()")
    writeF("    turtle.turnRight()")
    writeF("    if (facing == 0) then")
    writeF("        facing = 3")
    writeF("    else")
    writeF("        facing = facing - 1")
    writeF("    end")
    writeF("end")

    writeF("function orientate()")
    writeF("    while facing > 0 do")
    writeF("        turnLeft()")
    writeF("    end")
    writeF("end")

    writeF("function goto(xGoto, yGoto, zGoto)")
    writeF("    orientate()")
    writeF("    xCordSave = xCord")
    writeF("    yCordSave = yCord")
    writeF("    zCordSave = zCord")
    writeF("    if (xGoto > xCordSave) then")
    writeF("        for i=1, xGoto - xCordSave do")
    writeF("            forward()")
    writeF("        end")
    writeF("    end")
    writeF("    if (xGoto < xCordSave) then")
    writeF("        for i=1, xCordSave - xGoto do")
    writeF("            back()")
    writeF("        end")
    writeF("    end")
    writeF("    if (yGoto > yCordSave) then")
    writeF("        turnLeft()")
    writeF("        for i=1, yGoto - yCordSave do")
    writeF("            forward()")
    writeF("        end")
    writeF("        turnRight()")
    writeF("    end")
    writeF("    if (yGoto < yCordSave) then")
    writeF("        turnLeft()")
    writeF("        for i=1, yCordSave - yGoto do")
    writeF("            back()")
    writeF("        end")
    writeF("        turnRight()")
    writeF("    end")
    writeF("    if (zGoto > zCordSave) then")
    writeF("        for i=1, zGoto - zCordSave do")
    writeF("            up(1)")
    writeF("        end")
    writeF("    end")
    writeF("    if (zGoto < zCordSave) then")
    writeF("        for i=1, zCordSave - zGoto do")
    writeF("            down(1)")
    writeF("        end")
    writeF("    end")
    writeF("end")

    writeF("---------MOVEAPI END---------")
end

function compile()
    openFile()
    compiledFileName = filePath:sub(1,-2)
    compiledFileName = compiledFileName:sub(1,-2)
    compiledFileName = compiledFileName:sub(1,-2)
    compiledFileName = compiledFileName .. ".lua"

    addMoveAPI()

    loops = 0

    for i = 1, #lines do
        words = {}
        goscript = lines[i]
        for word in goscript:gmatch("%w+") do table.insert(words, word) end
        
        if (words[1] == "loop") then
            loopAmount = 0
            exit = 0

            if (#words == 2) then
                if (words[2] == "end") then
                    loops = loops - 1
                    writeF("end")
                    exit = 1
                else
                    loopAmount = words[2]
                end
            end
            if (exit == 0) then
                if (loopAmount == 0) or (words[2] == "forever") then
                    writeF("while true do")
                else
                    writeF("for i = 1, " .. loopAmount .. " do")
                end
                loops = loops + 1
            end
        elseif (words[1] == "move") then
            moveAmount = 0

            if (#words == 3) then
                moveAmount = words[3]
            else
                moveAmount = 1
            end

            if (#words == 1) then
                writeF("forward(" .. moveAmount ..  ")")
            elseif (words[2] == "forward") then
                writeF("forward(" .. moveAmount ..  ")")
            elseif (words[2] == "back") then
                writeF("back(" .. moveAmount .. ")")
            elseif (words[2] == "left") then
                writeF("turnLeft()")
                writeF("forward(" .. moveAmount ..  ")")
                writeF("turnRight()")
            elseif (words[2] == "right") then
                writeF("turnRight()")
                writeF("forward(" .. moveAmount ..  ")")
                writeF("turnLeft()")
            elseif (words[2] == "up") then
                writeF("up(".. moveAmount .. ")")
            elseif (words[2] == "down") then
                writeF("down(" .. moveAmount .. ")")
            else
                print("error unknown move: " .. words[2] .. " line: " .. i)
            end

        elseif (words[1] == "turn") then
            if (#words == 1) then
                writeF("turnLeft()")
            else
                if (words[2] == "left") then
                    writeF("turnLeft()")
                elseif (words[2] == "right") then
                    writeF("turnRight()")
                elseif (words[2] == "back") or (words[2] == "behind") then
                    writeF("turnRight()")
                    writeF("turnRight()")
                else
                    print("error unkown turn: " .. words[2] .. " line: " .. i)
                end
            end
        
        elseif (words[1] == "dig") or (words[1] == "mine") then
            if (#words == 1) then
                writeF("turtle.dig()")
            else
                if (words[2] == "up") then
                    writeF("turtle.digUp()")
                elseif (words[2] == "down") then
                    writeF("turtle.digDown()")
                elseif (words[2] == "left") then
                    writeF("turnLeft()")
                    writeF("turtle.dig()")
                    writeF("turnRight()")
                elseif (words[2] == "right") then
                    writeF("turnRight()")
                    writeF("turtle.dig()")
                    writeF("turnLeft()")
                elseif (words[2] == "back") then
                    writeF("turnLeft()")
                    writeF("turnLeft()")
                    writeF("turtle.dig()")
                    writeF("turnLeft()")
                    writeF("turnLeft()")
                elseif (words[2] == "forward") then
                    writeF("turtle.dig()")
                else
                    writeF("turtle.dig()")
                end
            end
        elseif (words[1] == "wait") or (words[1] == "sleep") then
            if (#words == 1) then
                writeF("sleep(1)")
            else
                writeF("sleep(" .. words[2] .. ")")
            end
        elseif (words[1] == "orientate") or (words[1] == "center") then
            writeF("orientate()")

        elseif (words[1] == "place") or (words[1] == "use") then
            if (#words == 1) then
                writeF("turtle.place()")
            else
                if (words[2] == "up") then
                    writeF("turtle.placeUp()")
                elseif (words[2] == "down") then
                    writeF("turtle.placeDown()")
                elseif (words[2] == "left") then
                    writeF("turnLeft()")
                    writeF("turtle.place()")
                    writeF("turnRight()")
                elseif (words[2] == "right") then
                    writeF("turnRight()")
                    writeF("turtle.place()")
                    writeF("turnLeft()")
                elseif (words[2] == "back") or (words[2] == "behind") then
                    writeF("turnLeft()")
                    writeF("turnLeft()")
                    writeF("turtle.place()")
                    writeF("turnRight()")
                    writeF("turnRight()")
                elseif(words[2] == "front") or (words[2] == "forward") then
                    writeF("turtle.place()")
                else
                    writeF("turtle.place()")
                end
            end
        elseif (words[1] == "say") or (words[1] == "print") or (words[1] == "log") then
            tempString = ""
            for i = 1, #words do
                if (i == 1) then
                else
                    tempString = tempString .. words[i] .. " "
                end
            end
            writeF("print('" .. tempString .. "')")
        elseif (words[1] == "select") or (words[1] == "slot") then
            slot = 0
            if (#words == 2) then
                slot = words[2]
            else
                slot = 1
            end
            slotN = tonumber(slot)
            if (slotN > 12) or (slotN < 1) then
                print("Error Slot has to be 1-12 Line: " .. i)
            else
                writeF("turtle.select(" .. slot .. ")")
            end

        end
    
    end

    if (loops > 0) then
        for i = 1, loops do
            writeF("end")
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
