---------MOVEAPI---------
--GlobalVars--
xCord = 0
yCord = 0
zCord = 0
facing = 0
--GlobalVars END--
function forward(moveAmount)
    for u=1, moveAmount do
       if turtle.forward() then
          if (facing == 0) then
              xCord = xCord + 1
          elseif (facing == 1) then
              yCord = yCord - 1
          elseif (facing == 2) then
              xCord = xCord - 1
          elseif (facing == 3) then
            yCord = yCord + 1
           end
       else
           sleep(1)
           turtle.dig()
           turtle.forward()
        end
    end
end
function back(moveAmount)
    for u=1, moveAmount do
       if turtle.back() then
           if (facing == 0) then
              xCord = xCord - 1
          elseif (facing == 1) then
               yCord = yCord + 1
          elseif (facing == 2) then
              xCord = xCord + 1
           elseif (facing == 3) then
              yCord = yCord - 1
          end
      else
           sleep(1)
           turnLeft()
           turnLeft()
           turtle.dig()
           turnLeft()
           turnLeft()
           turtle.back()
        end
    end
end
function up(moveAmount)
    iter = moveAmount
    for u=1, moveAmount do
        if turtle.up() then
            zCord = zCord + 1
		    iter = iter - 1
        else
            sleep(1)
            turtle.digUp()
            up(iter)
        end
    end
end
function down(moveAmount)
    iter = moveAmount
    for u=1, moveAmount do
       if turtle.down() then
           zCord = zCord - 1
		   iter = iter - 1
       else
           sleep(1)
           turtle.digDown()
           down(iter)
        end
    end
end
function turnLeft()
    turtle.turnLeft()
    if (facing == 3) then
        facing = 0
    else
        facing = facing + 1
    end
end
function turnRight()
    turtle.turnRight()
    if (facing == 0) then
        facing = 3
    else
        facing = facing - 1
    end
end
function orientate()
    while facing > 0 do
        turnLeft()
    end
end
function goto(xGoto, yGoto, zGoto)
    orientate()
    xCordSave = xCord
    yCordSave = yCord
    zCordSave = zCord
    if (xGoto > xCordSave) then
        for i=1, xGoto - xCordSave do
            forward(1)
        end
    end
    if (xGoto < xCordSave) then
        for i=1, xCordSave - xGoto do
            back(1)
        end
    end
    if (yGoto > yCordSave) then
        turnLeft()
        for i=1, yGoto - yCordSave do
            forward(1)
        end
        turnRight()
    end
    if (yGoto < yCordSave) then
        turnLeft()
        for i=1, yCordSave - yGoto do
            back(1)
        end
        turnRight()
    end
    if (zGoto > zCordSave) then
        for i=1, zGoto - zCordSave do
            up(1)
        end
    end
    if (zGoto < zCordSave) then
        for i=1, zCordSave - zGoto do
            down(1)
        end
    end
end
---------MOVEAPI END---------
turnLeft()
forward(1)
turnRight()
turnRight()
up(2)
turtle.dig()
turtle.placeDown()
turtle.select(2)
print('Done ')
