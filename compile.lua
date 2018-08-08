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
function clear() --Clears the terminal and sets the cursor to (1,1)
    term.clear()
    term.setCursorPos(1,1)
end

function getFilePath() --Gets the .go file name from the user if not provided
    write("script: ")
    filePath = read()
end

function fileExists() --Returns if a file at filePath currently exists
    if (fs.exists(filePath)) then
        return true
    else
        return false
    end
end

function openFile() --Opens the .go file and reads it all into a table called lines
    file = fs.open(filePath, "r")
    for line in file.readLine do
        lines[ #lines + 1 ] = line -- Loop through each line in the .go file and insert line by line into lines
    end
    file.close()
end

function writeF(command) --Writes the lua code to the .lua file 
    table.insert(compiledLines, command) --Adds the lua code to a table called compiledLines
    print(command)

    osfile = fs.open(compiledFileName, "w") --Open the .lua file
    for j = 1, #compiledLines do --Loop through compiledLines and add each line of lua to the .lua file
        osfile.writeLine(compiledLines[j])
    end
	osfile.close() --We open and close the .lua file with each line of goscript to make sure we dont lose it all if we hit an error
end

function addMoveAPI() --Injects the moveapi into the start of the .lua file for goscript to take advantage of
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
    writeF("           sleep(1)")
    writeF("           turtle.dig()")
    writeF("           turtle.forward()")
    writeF("        end")
    writeF("    end")
    writeF("end")

    writeF("function harvest()")
    writeF("local success, data = turtle.inspectDown()")
    writeF("local harvestLevel = 0")
    writeF("local isPlant = false")
    writeF("local seeds = ''")
    writeF("if success == true then")
    writeF("if data.name == 'minecraft:wheat' then")
    writeF("isPlant = true")
    writeF("seeds = 'minecraft:wheat_seeds'")
    writeF("harvestLevel = 7")
    writeF("elseif data.name == 'minecraft:carrots' then")
    writeF("isPlant = true")
    writeF("seeds = 'minecraft:carrot'")
    writeF("harvestLevel = 7")
    writeF("elseif data.name == 'minecraft:potatoes' then")
    writeF("isPlant = true")
    writeF("seeds = 'minecraft:potato'")
    writeF("harvestLevel = 7")
    writeF("else")
    writeF("end")
    writeF("if isPlant == true then")
    writeF("if data.metadata == harvestLevel then")
    writeF("turtle.digDown()")
    writeF("saveSlot = turtle.getSelectedSlot()")
    writeF("found = findItem(seeds)")
    writeF("if found == true then")
    writeF("turtle.placeDown()")
    writeF("end")
    writeF("turtle.select(saveSlot)")
    writeF("end")
    writeF("end")
    writeF("end")
    writeF("end")

    writeF("function bank(slot, direction)")
    writeF("local savedSlot = turtle.getSelectedSlot()")
    writeF("if direction == 'front' then")
    writeF("if slot == 0 then")
    writeF("for i = 1, 16 do")
    writeF("turtle.select(i)")
    writeF("turtle.drop()")
    writeF("end")
    writeF("else")
    writeF("turtle.select(slot)")
    writeF("turtle.drop()")
    writeF("end")
    writeF("elseif direction == 'back' then")
    writeF("turtle.turnLeft()")
    writeF("turtle.turnLeft()")
    writeF("if slot == 0 then")
    writeF("for i = 1, 16 do")
    writeF("turtle.select(i)")
    writeF("turtle.drop()")
    writeF("end")
    writeF("else")
    writeF("turtle.select(slot)")
    writeF("turtle.drop()")
    writeF("end")
    writeF("turtle.turnLeft()")
    writeF("turtle.turnLeft()")
    writeF("elseif direction == 'up' then")
    writeF("if slot == 0 then")
    writeF("for i = 1, 16 do")
    writeF("turtle.select(i)")
    writeF("turtle.dropUp()")
    writeF("end")
    writeF("else")
    writeF("turtle.select(slot)")
    writeF("turtle.dropUp()")
    writeF("end")
    writeF("elseif direction == 'down' then")
    writeF("if slot == 0 then")
    writeF("for i = 1, 16 do")
    writeF("turtle.select(i)")
    writeF("turtle.dropDown()")
    writeF("end")
    writeF("else")
    writeF("turtle.select(slot)")
    writeF("turtle.dropDown()")
    writeF("end")
    writeF("elseif direction == 'left' then")
    writeF("turtle.turnLeft()")
    writeF("if slot == 0 then")
    writeF("for i = 1, 16 do")
    writeF("turtle.select(i)")
    writeF("turtle.drop()")
    writeF("end")
    writeF("else")
    writeF("turtle.select(slot)")
    writeF("turtle.drop()")
    writeF("end")
    writeF("turtle.turnRight()")
    writeF("elseif direction == 'right' then")
    writeF("turtle.turnRight()")
    writeF("if slot == 0 then")
    writeF("for i = 1, 16 do")
    writeF("turtle.select(i)")
    writeF("turtle.drop()")
    writeF("end")
    writeF("else")
    writeF("turtle.select(slot)")
    writeF("turtle.drop()")
    writeF("end")
    writeF("turtle.turnLeft()")
    writeF("end")
    writeF("turtle.select(savedSlot)")
    writeF("end")

    writeF("function findItem(itemToFind)")
    writeF("local found = false")
    writeF("for i = 1, 16 do")
    writeF("item = turtle.getItemDetail(i)")
    writeF("if item then")
    writeF("if item.name == itemToFind then")
    writeF("turtle.select(i)")
    writeF("found = true")
    writeF("end")
    writeF("end")
    writeF("end")
    writeF("return found")
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
    writeF("           sleep(1)")
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
    writeF("    iter = moveAmount")
    writeF("    for u=1, moveAmount do")
    writeF("        if turtle.up() then")
    writeF("            zCord = zCord + 1")
    writeF("		    iter = iter - 1")
    writeF("        else")
    writeF("            sleep(1)")
    writeF("            turtle.digUp()")
    writeF("            up(iter)")
    writeF("        end")
    writeF("    end")
    writeF("end")

    writeF("function down(moveAmount)")
    writeF("    iter = moveAmount")
    writeF("    for u=1, moveAmount do")
    writeF("       if turtle.down() then")
    writeF("           zCord = zCord - 1")
    writeF("		   iter = iter - 1")
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
    writeF("            forward(1)")
    writeF("        end")
    writeF("    end")
    writeF("    if (xGoto < xCordSave) then")
    writeF("        for i=1, xCordSave - xGoto do")
    writeF("            back(1)")
    writeF("        end")
    writeF("    end")
    writeF("    if (yGoto > yCordSave) then")
    writeF("        turnLeft()")
    writeF("        for i=1, yGoto - yCordSave do")
    writeF("            forward(1)")
    writeF("        end")
    writeF("        turnRight()")
    writeF("    end")
    writeF("    if (yGoto < yCordSave) then")
    writeF("        turnLeft()")
    writeF("        for i=1, yCordSave - yGoto do")
    writeF("            back(1)")
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
    openFile() --Open the .go script and read it into ram
    compiledFileName = filePath:sub(1,-2)
    compiledFileName = compiledFileName:sub(1,-2)
    compiledFileName = compiledFileName:sub(1,-2)
    compiledFileName = compiledFileName .. ".lua" --change the name from file.go to file.lua

    addMoveAPI() -- inject moveapi into start of .lua file

    loops = 0 --This keeps track of how many loops the user has in the goscript file

    for i = 1, #lines do
        words = {} --This will be a table of each word in one line of a goscript file
        goscript = lines[i] --Get the line we are currently compiling
        for word in goscript:gmatch("%w+") do table.insert(words, word) end --Split the string into a table by spaces
        
        if (words[1] == "loop") or (words[1] == "l") then --If the base command was loop
            loopAmount = 0 --Establish vars for the loop to occur
            exit = 0

            if (#words == 2) then --If there was 2 words then the user wants a numbered loop or wants to end a loop
                if (words[2] == "end") or (words[2] == "e") then --User wants to end a loop
                    loops = loops - 1 --We ended a loop so no need to keep track of it
                    writeF("end") --End the loop in lua
                    exit = 1 --We are done with this loop, Exit
                else
                    loopAmount = words[2] --Will loop how many times user says in 2nd word
                end
            end
            if (exit == 0) then --If we are not done
                if (loopAmount == 0) or (words[2] == "forever") then --If the user wants a infinite loop
                    writeF("while true do")--Make the infinite loop head
                else
                    writeF("for i = 1, " .. loopAmount .. " do")--Make the loop head
                end
                loops = loops + 1--Keep track of a loop without an end statement
            end
        elseif (words[1] == "goto") or (words[1] == "g") then --Goto base command
            if (#words == 1) then --If just the base command was provided 0 out the cords
                x = 0
                y = 0
                z = 0
            else --Set the cords to the 2nd, 3rd, and 4th words in the command
                x = words[2]
                y = words[3]
                z = words[4]
            end
            writeF("goto(" .. x .. ", " .. y .. ", " .. z .. ")")--Write the goto function which is in moveapi already injected into the top of the lua
        elseif (words[1] == "lua") then --If base command is lua
            lua = string.gsub(lines[i], "lua ", "") --Remove the base command from the words and put it in one string
            writeF(lua)--Write the lua the user provided, this can cause user made errors
        elseif (words[1] == "harvest") or (words[1] == "h") then --Harvest base command
            writeF("harvest()")
        elseif (words[1] == "bank") or (words[1] == "drop") or (words[1] == "b") then

            if (#words == 1) then
                writeF("bank(0, 'front')")
            else
                local slot = words[2]
                if (#words == 2) then
                    writeF("bank(" .. slot .. ", 'front')")
                else
                    local direction = words[3]
                    if (direction == "forward") or (direction == "front") or (direction == "f") then
                        writeF("bank(" .. slot .. ", 'front')")
                    elseif (direction == "back") or (direction == "behind") or (direction == "b") then
                        writeF("bank(" .. slot .. ", 'back')")
                    elseif (direction == "up") or (direction == "u") then
                        writeF("bank(" .. slot .. ", 'up')")
                    elseif (direction == "left") or (direction == "l") then
                        writeF("bank(" .. slot .. ", 'left')")
                    elseif (direction == "right") or (direction == "r") then
                        writeF("bank(" .. slot .. ", 'right')")
                    elseif (direction == "down") or (direction == "d") then
                        writeF("bank(" .. slot .. ", 'down')")
                    end
                end
            end

        elseif (words[1] == "move") or (words[1] == "m") then --Move base command
            moveAmount = 0 --Var establishment

            if (#words == 3) then --If a direction and amount was provided
                moveAmount = words[3]
            else --If no amount was provided default to one move
                moveAmount = 1
            end

            if (#words == 1) then --If no direction was given default to forward
                writeF("forward(" .. moveAmount ..  ")") --Write lua to call the moveapi forward with how many movements function
            elseif (words[2] == "forward") then
                writeF("forward(" .. moveAmount ..  ")")
            elseif (words[2] == "back") then 
                writeF("back(" .. moveAmount .. ")")
            elseif (words[2] == "left") then
                writeF("turnLeft()") --Turn left to move left
                writeF("forward(" .. moveAmount ..  ")")
                writeF("turnRight()") --Turn right to be facing the same way as we started
            elseif (words[2] == "right") then
                writeF("turnRight()") --Turn right to move right
                writeF("forward(" .. moveAmount ..  ")")
                writeF("turnLeft()") --Turn left to be facing the sam way we started
            elseif (words[2] == "up") then
                writeF("up(".. moveAmount .. ")")
            elseif (words[2] == "down") then
                writeF("down(" .. moveAmount .. ")")
            else
                print("error unknown move: " .. words[2] .. " line: " .. i) --Print an error if a direction was given but it wasnt forward, back, up, down, left, or right
            end

        elseif (words[1] == "turn") or (words[1] == "t") then --Turn base command
            if (#words == 1) then --If no direction was given default to left
                writeF("turnLeft()")
            else
                if (words[2] == "left") then
                    writeF("turnLeft()")
                elseif (words[2] == "right") then
                    writeF("turnRight()")
                elseif (words[2] == "back") or (words[2] == "behind") then
                    writeF("turnRight()") --Turn right twice to be facing backwards
                    writeF("turnRight()")
                else
                    print("error unkown turn: " .. words[2] .. " line: " .. i) --Print an error if a direction was given that wasnt left, right, or back
                end
            end
        
        elseif (words[1] == "dig") or (words[1] == "mine") or (words[1] == "d") then --Dig base command
            if (#words == 1) then --If no sub commands just dig infront of turtle
                writeF("turtle.dig()")
            else
                if (words[2] == "up") then
                    writeF("turtle.digUp()")
                elseif (words[2] == "down") then
                    writeF("turtle.digDown()")
                elseif (words[2] == "left") then
                    writeF("turnLeft()") --Turn left to dig left
                    writeF("turtle.dig()")
                    writeF("turnRight()")--Turn right to be facing the same way we started
                elseif (words[2] == "right") then
                    writeF("turnRight()")--Turn right to dig right
                    writeF("turtle.dig()")
                    writeF("turnLeft()")--Turn left to be facing the same way we started
                elseif (words[2] == "back") then
                    writeF("turnLeft()")--Turn left 2 times to be facing backwards
                    writeF("turnLeft()")
                    writeF("turtle.dig()")
                    writeF("turnLeft()")
                    writeF("turnLeft()")--Turn left 2 times to be back facing where we started
                elseif (words[2] == "forward") then --If forward was given
                    writeF("turtle.dig()")
                else
                    writeF("turtle.dig()") --Default to dig even if more sub commands given
                end
            end
        elseif (words[1] == "wait") or (words[1] == "sleep") or (words[1] == "w") then --Wait base command
            if (#words == 1) then --If nothing was given but the base command, default to sleep 1 second
                writeF("sleep(1)")
            else
                writeF("sleep(" .. words[2] .. ")") --Sleep for user selected seconds
            end
        elseif (words[1] == "orientate") or (words[1] == "center") or (words[1] == "o") or (words[1] == "c") then --center base command
            writeF("orientate()")--Turn the turtle to face the same way when it started the script

        elseif (words[1] == "place") or (words[1] == "use") or (words[1] == "p") then--Place base command
            if (#words == 1) then --If no direction was given default to place infront of turtle
                writeF("turtle.place()")
            else
                if (words[2] == "up") then
                    writeF("turtle.placeUp()")
                elseif (words[2] == "down") then
                    writeF("turtle.placeDown()")
                elseif (words[2] == "left") then
                    writeF("turnLeft()")--Turn left to place left
                    writeF("turtle.place()")
                    writeF("turnRight()")--Turn right to be back the way we started
                elseif (words[2] == "right") then
                    writeF("turnRight()")--Turn right to place right
                    writeF("turtle.place()")
                    writeF("turnLeft()")--Turn left to be back the way we started
                elseif (words[2] == "back") or (words[2] == "behind") then
                    writeF("turnLeft()")--Turn left 2 times to be facing backwards
                    writeF("turnLeft()")
                    writeF("turtle.place()")
                    writeF("turnRight()")
                    writeF("turnRight()")--Turn right 2 times to be facing the way we started
                elseif(words[2] == "front") or (words[2] == "forward") then
                    writeF("turtle.place()")
                else
                    writeF("turtle.place()")--All other subcommands result in forward placement
                end
            end
        elseif (words[1] == "say") or (words[1] == "print") or (words[1] == "log") then --print base command
            tempString = "" --Make a string to hold the words
            for i = 1, #words do--Loop through each word
                if (i == 1) then
                else
                    tempString = tempString .. words[i] .. " " --Add each word to the tempstring except the first word which would be the command
                end
            end
            writeF("print('" .. tempString .. "')")--print the string of words
        elseif (words[1] == "select") or (words[1] == "slot") or (words[1] == "s") then --Select base command
            slot = 0--establish vars
            if (#words == 2) then --If user gives a slot number 
                slot = words[2]
            else --Otherwise default to slot 1
                slot = 1
            end
            slotN = tonumber(slot) --Change the string of the number to a number
            if (slotN > 12) or (slotN < 1) then--Error if the number is less than 1 or greater than 12
                print("Error Slot has to be 1-12 Line: " .. i)
            else
                writeF("turtle.select(" .. slot .. ")")--Select the slot
            end

        end
    
    end

    if (loops > 0) then --If we reach the end and we still have loops that do not have an end statement
        for i = 1, loops do 
            writeF("end") --Put an end statement at the end of the lua as many times as we have open loops
        end
    end
end


--Functions End--



--Main--

if (filePath == nil) then --If no file path was given as an arg
    getFilePath() --Ask the user for a file
end
if (fileExists()) then --If the file is where the user says
    compile() --Compile the goscript
else--Othereise error
    print("Error - File does not exist at " .. filePath)
end
