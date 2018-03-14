--GOScript Compiler--

--Reads .go files and compiles to .lua

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
end

function compile()
    openFile()

    
    
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
