

# GoScript





[![license](https://img.shields.io/github/license/mashape/apistatus.svg)](https://raw.githubusercontent.com/gquarles/goscript/master/LICENSE) ![Codebase](https://img.shields.io/badge/code-Lua-blue.svg)



GoScript is a easy to use scripting language that compiles to **native** lua code. GoScript can be used in junction with the turtle operating system Go (in development). GoScript is still in active development and will have frequent updates. As of right now the standalone compiler will not come with an auto update function. Visit this page for news and updates.


# Installing

There are many methods of getting the GoScript compiler onto your turtle. Go the operating system made for turtles will come with GoScript and keep it up to date for you. If you wish to download the standalone GoScript compiler use one of the following methods.
* Pastebin. Using pastebin and the built in computercraft pastebin command you can put in a command into your turtle to get the _installer_ for GoScript, then all you will need to do is run the installer to get the latest version of GoScript. To do this open your turtle's shell and type `pastebin get u1WgFdMF installer` Then still in the shell just run the installer by typing `installer` This will install the latest version of GoScript, you can run the installer again at a later date to reinstall and update the GoScript compiler.
* Wget. If you have the most recent version of computercraft your computers will come with a program called wget preinstalled. Simply run `wget https://raw.githubusercontent.com/gquarles/goscript/master/compile.lua compile`
* Cloning the GitHub repo will always provide you with and up to date version of the standalone compiler. just clone the compiler.lua file housed in the root folder of the repo and run that to compile GoScripts.
* Go the OS will always check for the latest updates right here in the GitHub repo and will do all of the work for you. Go the OS is still in the very early stages of development check back later for more information.

## Compiling a file

Compiling a GoScript is very easy and can be done in two similar ways. Both ways require the GoScript file to be in the same directory as the compiler file. GoScript files require a `.go` file extension. The compiler will output the *native* lua code with the same file name with the extension changed to `.lua` so if you compiled a script called `example.go` it would compile to `example.lua`
1. Running the compiler script with `compiler.lua` or `compiler` in the same directory as both the compiler and the GoScript. The compiler will then ask for a script to compile, you will then enter the script name with the extenstion such as `GoScript.go` 
2. Running the compiler script with arguements, you can give the compiler arguements so if wanted you can automate the process of compiling your scripts. The syntax is `compile.lua GoScriptName.go` 

__Example__ 
1. Using method one to compile `foo.go` you would run `compiler` then input `foo.go` 
2. Using method two to compile `foo.go` you would run `compiler.lua foo.go`

## MoveAPI

GoScript will always include a small API called **MoveAPI** that will give your script some basic movement functions to make your life easier. You won't directly call these functions in your GoScript but they will be used if you use the base command move or goto/return. If you want to add extra lua code to your already compiled GoScript lua files the Coord system will keep track of your added movement and the goto functions in the script will still work. Look in the top of the compiled lua file for a brief description of the functions. Later they will be added here or possibly their own repo.

## How GoScript Works

GoScript currently works off of a command system. Each line is a new command, and every command will have exactly **one** *base* command with multiple *sub* commands that follow on the same line. For example a base command called foo with one sub command called bar would look like `foo bar` just like a base command of `move` with a following sub command of a direction like `forward` and an optional following sub command of an amount of moves like `3` putting it all together would look like `move forward 3`

## Base Commands

Each command requires exactly __ONE__ base command which tells the compiler what the compiler will be doing such as moving around, digging, placing, or even things in the inventory. The following sub commands refine the whole command by specifying the details of the command such as how far to move or what slot to navigate to in the inventory. There are quite a few base commands and more will be added as more functionality is added to GoScript.

### Move
The `move` base command is the basis for all of the turtles movement _(excluding turning)_ the `move` command has _2_ possible sub commands. Just like all base commands there are no required sub commands. The default sub commands for move are `forward` and `1` and when put together look like `move forward 1` even though you only have to enter `move`. The sub commands for `move` are

1. The first sub command of `move` is always a direction. If the turtle can not move to where it is told it will wait 2 seconds and also attempt to mine the block infront of it. This will give time for blocking mobs to move out of the way and clear out potential blocks in the path. The following are the possible direction subcommands 
	* `forward` Which is the default
	* `right`
	* `left`
	* `back` or `behind` both of which move the turtle behind
	* `up`
	* `down`
2. The second sub command of `move` is a integer to express how many blocks you would like to move the turtle, if not given the default will always be one. This means `move forward` and `move forward 1` are both exactly the same. Any non-negative integer will work here.

### Turn
The `turn` base command will turn the turtle and keep track of the current direction relative to the starting direction for you. This means all the work here is done by the compiler and you won't have to worry about losing track about where you are facing. The `turn` base command has only __one__ sub command being the direction of the turn. Without a specified direction the `turn` command will always turn `left`. You can later center the turtle back to the starting positon, this will also occur when returning to the starting location or using some form of the MoveAPI for going to a relative coord. The sub commands for direction of `turn` are
 * `left` being the default
 * `right`
 * `behind` or `back` both turning the turtle twice to be facing backwards relative to before the command is given.

### Dig
The `dig` base command will make the turtle dig in a direction. The resulting block being mined by the turtle will go in the next open inventory slot 1-12 and if the inventory is full it will go onto the floor near the turtle. The `dig` base command only has __one__ sub command being direction and defaulting to `forward` or infront of the turtle. The sub commands for direction of `dig` are
* `forward` or `front` being the default
* `left`
* `right`
* `back` or `behind` both turning then digging the block behind the turtle then returning to the original facing direction.
* `up`
* `down`

### Place / Use
The `place` base command can also be typed as `use` will place the currently selected block/item in the inventory. Defaulting to infront of the turtle or `forward` the following are the direction sub commands for `place`/`use`
* `forward` or `front` being the default
* `left`
* `right`
* `back` or `behind` both turning then placing a block in the space behind the turtle then returning to the original facing direction.
* `up`
* `down`

### Slot
The `slot` base command will simply instruct the turtle to select a slot 1 through 12 in the inventory with the default being `1`.  Any integer between and including `1` and `12` can be used as the turtle has 12 inventory spaces.

### Wait / Sleep
The `wait` base command can also be typed as `sleep` and it will make the turtle stop and wait any number of seconds. The default is `1` and is one second. Any non negative integer can be used here. This base command has __no__ sub commands.

### Orientate / Center
The `orientate` base command can also be typed as `center` and it will turn the turtle to its original facing direction when the script started. This base command has __no__ sub commands.

### Loop
The `loop` base command is a bit more complicated than the other base commands. Loop in itself will not do anything, but it will affect code you write __after__ the loop command. There are two different ways of looping, an infinite loop and a numbered loop. The infinite loop will make all of the commands you write after the loop command repeat in order forever. While the numbered loop will make the commands you write after the loop a specified number of times. Loops __must__ have a end in the code, this is done by writing `loop end` and will no longer repeat any code after it. If you do not add this then GoScript will automaticlly generate one at the very end of your code. To loop a specified number of times do `loop number` where number is a whole number bigger than 0. (Putting 0 will make your loop infinite)
The sub commands for loop are
* `end` ending the loop
* any whole number bigger than 0 will specify the number of loops

### Print
The `print` base command will display a message in the terminal of your turtle whenever it is called. So if you say `print Done!` then whenever the script gets to the point where you passed that print, the terminal will then show `Done!`.

### Goto
The `goto` base command will tell the turtle to move to cords *relative* to the inital position and direction the script started in. This means if I tell the turtle to goto 0 on the x, y, and z axis `goto 0 0 0` then the turtle will return to its starting position. Passing just `goto` into the compiler is the same as `goto 0 0 0` If you wanted to go 5 units to the x direction and 3 units up you would pass
`goto 5 0 3`

### Harvest
The `harvest` base command will tell the turtle to check the block below it and if it is fully grown and either carrots, potatoes, or wheat the turtle will harvest and replant one seed.

### Lua
The `lua` base command allows you to insert native lua code into your script before it is compiled. Whatever is typed after the lua command will run as is, with no checks. So doing `lua print("Hello World!")` would insert `print("Hello World!")` This can present errors if you pass incorrect lua code. Just passing `lua` by itself will not do anything. This feature is more advanced but can let you do things in your script that would be otherwise impossible, like conditionals and your own functions. 

### Rapid Prototyping
GoScript was created for two main reasons, the first being to help teach people new to programming the basics and the flow of how a basic program works. Secondly it was made for prototyping your ideas *much* quicker than you can do in traditional lua. GoScript has a lot of aliases for its base commands, you can type different things for the same result. This allows newer people to not have to worry as much as remembering strict function names but it is also used to create a program very quickly to test an idea. All of the base commands (with a few exceptions) can be typed in 1 letter, allowing you to write less and get something out quick. For example if I wanted to move forward, then turn left and select slot 1 I could simply have in my GoScript `m` `t` and `s` each on their own lines. This concept is still being developed and when it is ready will have more information.
