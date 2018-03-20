# GoScript

GoScript is a easy to use scripting language that compailes to **native** lua code. GoScript can be used in junction with the turtle operating system Go (in development). GoScript is still in active development and will have frequent updates. As of right now the standalone compiler will not come with an auto update function. Visit this page for news and updates.


# Installing

There are many methods of getting the GoScript compiler onto your turtle. Go the operating system made for turtles will come with GoScript and keep it up to date for you. If you wish to download the standalone GoScript compiler use one of the following methods.
* Pastebin. Using pastebin and the built in computercraft pastebin command you can put in a command into your turtle to get the _installer_ for GoScript, then all you will need to do is run the installer to get the latest version of GoScript. To do this open your turtle's shell and type `pastebin get NOTYETFINISHED installer` Then still in the shell just run the installer by typing `installer` This will install the latest version of GoScript, you can run the installer again at a later date to reinstall and update the GoScript compiler.
* Cloning the GitHub repo will always provide you with and up to date version of the standalone compiler. just clone the compiler.lua file housed in the root folder of the repo and run that to compile GoScripts.
* Go the OS will always check for the latest updates right here in the GitHub repo and will do all of the work for you. Go the OS is still in the very early stages of development check back later for more information.

## Compiling a file

Compiling a GoScript is very easy and can be done in two similar ways. Both ways require the GoScript file to be in the same directory as the compiler file. GoScript files require a `.go` file extension. The compiler will output the *native* lua code with the same file name with the extension changed to `.lua` so if you compiled a script called `example.go` it would compile to `example.lua`
1. Running the compiler script with `compiler.lua` or `compiler` in the same directory as both the compiler and the GoScript. The compiler will then ask for a script to compile, you will then enter the script name with the extenstion such as `GoScript.go` 
2. Running the compiler script with arguements, you can give the compiler arguements so if wanted you can automate the process of compiling your scripts. The syntax is `compiler.lua GoScriptName.go` 

__Example__ 
1. Using method one to compile `foo.go` you would run `compiler` then input `foo.go` 
2. Using method two to compiler `foo.go` you would run `compiler.lua foo.go`

## MoveAPI

GoScript will always include a small API written by me called **MoveAPI** that will give your script some basic movement functions to make your life easier. You won't directly call these functions in your GoScript but they will be used if you use the base command move or goto/return. If you want to add extra lua code to your already compiled GoScript lua files the Coord system will keep track of your added movement and the goto functions in the script will still work. Look in the top of the compiled lua file for a brief description of the functions. Later they will be added here or possibly their own repo.

## How GoScript Works

GoScript currently works off of a command system. Each line is a new command, and every command will have exactly **one** *base* command with multiple *sub* commands that follow on the same line. For example a base command called foo with one sub command called bar would look like `foo bar` just like a base command of `move` with a following sub command of a direction like `forward` and an optional following sub command of an amount of moves like `3` putting it all together would look like `move forward 3`

