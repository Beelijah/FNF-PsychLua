local IsmousePressed = false
local loopa = 1
local loopaStart = 0
local circleSize = 0.5
local shouldBeRemovingArt = false
local secondsNotWriting = 0
local framesNotWriting = 0
local hasWritten = 0
local bgMoveTime = 10
local spotlightMoveTime = 3
local loopaErase = 0
local loopDat = false

local moveSpotlightX = 267
local moveSpotlightY = -345

local moddingText = hello

local correctDraws = 0
local incorrectDraws = 0

-- okay now im actually getting really good at lua scripting
-- i am proud, as i started not that long ago :D

-- by scrambled_egg3

function onCountdownStarted()
    local value2 = 0.001

    --debugPrint('            lX: ' .. defaultPlayerStrumX0 .. ' dX: ' .. defaultPlayerStrumX1 .. ' uX: ' .. defaultPlayerStrumX2 .. ' rX: ' .. defaultPlayerStrumX3 .. '        bye')

    makeLuaSprite('moddingMouse', 'Mouse')
    setObjectCamera('moddingMouse', 'hud')
    addLuaSprite('moddingMouse', true)

    scaleObject('moddingMouse', 0.5, 0.5, true)

    makeLuaText('moddingTut', 'Click to draw, Hold Back to erase.', 0, 320, 0)
    setTextFont('moddingTut', 'vcr.ttf')
    setTextSize('moddingTut', 32)
    setTextAlignment('moddingTut', 'center')
    addLuaText('moddingTut')

    precacheMusic('artistic-expression')
    playSound('artistic-expression', 1, 'musichaha', true)
end

function onPause()
    pauseSound('musichaha')
end

function onResume()
    resumeSound('musichaha')
end

function onUpdate(elapsed)
    local mouseX = 0
    local mouseY = 0
    local debugKeyPressed = false
    local circleNameTMP = 'circle' .. loopaStart
    local paperY = 0
    local cameraX
    local cameraY
    local circleSkin
    paperY = getProperty('paper.y')

    circleSkin = 'littleCircleBlue'

    --print('cameraX: ', cameraX, ' cameraY: ', cameraY)

    shouldBeRemovingArt = false

    circleName = 'circle' .. loopa

    --debugPrint('circleName: ' .. circleName .. ' circleNameTMP: ' .. circleNameTMP)

    mouseX = getMouseX('hud')
    mouseY = getMouseY('hud')

    --debugPrint('mouseX: ' .. mouseX .. ' mouseY: ' .. mouseY)

    setProperty('moddingMouse.x', mouseX)
    setProperty('moddingMouse.y', mouseY)

    IsmousePressed = mousePressed()
    debugKeyPressed = keyPressed('back')

    if IsmousePressed then
        if not shouldBeRemovingArt then 
            loopa = loopa + 1

            makeLuaSprite(circleName, circleSkin, mouseX + 10, mouseY) -- tl;dr: make a million circles when mouse is clicked and in paper box
            addLuaSprite(circleName, true)
            setObjectCamera(circleName, 'hud')
            scaleObject(circleName, circleSize, circleSize, true)

            removeLuaSprite('moddingMouse', false)
            makeLuaSprite('moddingMouse', 'Mouse')
            setObjectCamera('moddingMouse', 'hud')
            addLuaSprite('moddingMouse', true)
            scaleObject('moddingMouse', 0.5, 0.5, true)
            setProperty('moddingMouse.x', mouseX)
            setProperty('moddingMouse.y', mouseY)
        end
    end

    if debugKeyPressed then -- basically if you press backspace it also erases :D
        if not shouldBeRemovingArt then 
            if loopaStart == loopa then
                print('stop ;(')
            else
                circleNameTMP = 'circle' .. loopaStart
                print('circleNameTMP: ', circleNameTMP)
                removeLuaSprite('circle' .. loopaStart, false)
                loopaStart = loopaStart + 1
            end
        end
    end
end