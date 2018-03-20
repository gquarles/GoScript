---------MOVEAPI---------
--GlobalVars--
xCord = 0
yCord = 0
zCord = 0
--GlobalVars END--
function forward()
    if turtle.forward() then
        xCord = xCord + 1
    else
        sleep(2)
        forward()
    end
end
function back()
    if turtle.back() then
        xCord = xCord - 1
    else
        sleep(2)
        back()
    end
end
function up()
    if turtle.up() then
        yCord = yCord + 1
    else
        sleep(2)
        up()
    end
end
function down()
    if turtle.down() then
        yCord = yCord - 1
    else
        sleep(2)
        down()
    end
end
---------MOVEAPI END---------
forward()
turtle.turnLeft()
forward()
turtle.digDown()
down()
turtle.turnLeft()
turtle.dig()
turtle.turnRight()
turtle.turnLeft()
forward()
turtle.turnRight()
turtle.turnRight()
turtle.turnRight()
turtle.dig()
forward()
up()
turtle.turnLeft()
