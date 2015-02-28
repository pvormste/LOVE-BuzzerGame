-------------------------------------------------------------------------------
-- LOAD
function love.load()
	loveframes = require("lib.loveframes")
	
	love.graphics.setBackgroundColor(120, 185, 215)
	
	-- started variable
	started = false
	running = false
	
	-- Get controllers
	joys = love.joystick.getJoysticks()
	joysCount = love.joystick.getJoystickCount()
	
	joyPressed = {}
	
	if joysCount > 0 then        
      for i=1, joysCount do
          joyPressed[i] = false
      end
    end
    
    -- images
    joyImages = {}
    
    if joysCount > 0 then        
      for i=1, joysCount do
          joyImages[i] = love.graphics.newImage("res/".. tostring(i) ..".png")
      end
    end
    
    joyRunningImages = {}
    
    if joysCount > 0 then        
      for i=1, joysCount do
          joyRunningImages[i] = love.graphics.newImage("res/".. tostring(i) .."-started.png")
      end
    end
	
	-- Build frame
	local frame = loveframes.Create("frame")
	frame:SetName("Setup Player/Teams")
	frame:ShowCloseButton(false)
	frame:SetResizable(true)
	frame.width = 600
	frame:SetMinWidth(frame.width)
	frame.height = 200
	frame:SetMinHeight(frame.height)
	
	-- Avail Controllers
	availControllers = loveframes.Create("multichoice", frame)
	availControllers:SetPos(380, 80)
	
	if joysCount > 0 then        
      for i=1, joysCount do
          availControllers:AddChoice(tostring(i) .. ": " .. tostring(joys[i]:getName()))
      end
    end
	
	-- Player/Team 1
	playerOneActive = loveframes.Create("checkbox", frame)
	playerOneActive:SetChecked(true)
	playerOneActive:SetEnabled(false)
	playerOneActive:SetText("Player/Team 1:")
	playerOneActive:SetPos(10, 34)
	playerOneNameInput = loveframes.Create("textinput", frame)
	playerOneNameInput:SetPos(140, 30)
	--playerOneChoice = loveframes.Create("multichoice", frame)
    --playerOneChoice:SetPos(340, 30)
  
    --if joysCount > 0 then        
    --  for i=1, joysCount do
    --      playerOneChoice:AddChoice(tostring(i) .. ": " .. tostring(joys[i]:getName()))
    --  end
    --end
	
	-- Player/Team 2
	playerTwoActive = loveframes.Create("checkbox", frame)
	playerTwoActive:SetChecked(true)
	playerTwoActive:SetEnabled(false)
	playerTwoActive:SetText("Player/Team 2:")
	playerTwoActive:SetPos(10, 64)
	playerTwoNameInput = loveframes.Create("textinput", frame)
	playerTwoNameInput:SetPos(140, 60)
	--playerTwoChoice = loveframes.Create("multichoice", frame)
    --playerTwoChoice:SetPos(340, 60)
  
    --  if joysCount > 0 then        
    --   for i=1, joysCount do
    --        playerTwoChoice:AddChoice(tostring(i) .. ": " .. tostring(joys[i]:getName()))
    --    end
    --  end
	
	-- Player/Team 3
	playerThreeActive = loveframes.Create("checkbox", frame)
	playerThreeActive:SetText("Player/Team 3:")
	playerThreeActive:SetPos(10, 94)
	playerThreeNameInput = loveframes.Create("textinput", frame)
	playerThreeNameInput:SetPos(140, 90)
	--playerThreeChoice = loveframes.Create("multichoice", frame)
    --playerThreeChoice:SetPos(340, 90)
  
    --if joysCount > 0 then        
    --  for i=1, joysCount do
    --      playerThreeChoice:AddChoice(tostring(i) .. ": " .. tostring(joys[i]:getName()))
    --  end
    --end
	
	-- Player/Team 4
	playerFourActive = loveframes.Create("checkbox", frame)
	playerFourActive:SetText("Player/Team 4:")
	playerFourActive:SetPos(10, 124)
	playerFourNameInput = loveframes.Create("textinput", frame)
	playerFourNameInput:SetPos(140, 120)
	--playerFourChoice = loveframes.Create("multichoice", frame)
    --playerFourChoice:SetPos(340, 120)
  
    --if joysCount > 0 then        
    -- for i=1, joysCount do
    --      playerFourChoice:AddChoice(tostring(i) .. ": " .. tostring(joys[i]:getName()))
    -- end
    --end
  
	startButton = loveframes.Create("button", frame)
	startButton:SetPos(10, 170)
	startButton:SetText("Start")
	startButton.OnClick = function(object)
	   playerOneNameInput:SetEditable(false)
	   --playerOneChoice:SetEnabled(false)
	   
	   playerTwoNameInput:SetEditable(false)
       --playerTwoChoice:SetEnabled(false)
       
       playerThreeActive:SetEnabled(false)
       playerThreeNameInput:SetEditable(false)
       --playerThreeChoice:SetEnabled(false)
       
       playerFourActive:SetEnabled(false)
       playerFourNameInput:SetEditable(false)
      -- playerFourChoice:SetEnabled(false)
	   
	   stopButton:SetClickable(true)
	   startButton:SetClickable(false)
	   
	   started = true
	end
	
	
	stopButton = loveframes.Create("button", frame)
    stopButton:SetPos(100, 170)
    stopButton:SetText("Stop")
    stopButton:SetClickable(false)
    stopButton.OnClick = function(object)
         playerOneNameInput:SetEditable(true)
         --playerOneChoice:SetEnabled(true)
         
         playerTwoNameInput:SetEditable(true)
         --playerTwoChoice:SetEnabled(true)
       
         playerThreeActive:SetEnabled(true)
         playerThreeNameInput:SetEditable(true)
        --playerThreeChoice:SetEnabled(true)
       
         playerFourActive:SetEnabled(true)
         playerFourNameInput:SetEditable(true)
         --playerFourChoice:SetEnabled(true)
         
         startButton:SetClickable(true)
         stopButton:SetClickable(false)  
         
         started = false   
    end
end

-------------------------------------------------------------------------------
-- UPDATE
function love.update(dt)

    if started then
        if love.keyboard.isDown('f') or love.mouse.isDown("r") then
            running = true
            
            for i=1, joysCount do
              if joyPressed[i] then
                joyPressed[i] = false
              end
            end
        end
    end
             
    -- your code
    if not started then
      if joysCount > 0 then        
          for i=1, joysCount do
            for j=1, joys[i]:getButtonCount() do
              if joys[i]:isDown(j) then
                joyPressed[i] = true
                print(tostring(joys[i]:getName() .. " pressed"))
                break  
              else
                joyPressed[i] = false
              end
            end
          end
      end        
    end
    
    
    local noButtonPressed = true
    
    if started and running then
      if joysCount > 0 then        
          for i=1, joysCount do
            for j=1, joys[i]:getButtonCount() do
              if joys[i]:isDown(j) and noButtonPressed then
                joyPressed[i] = true
                running = false
                noButtonPressed = false
                break  
              end
              
              if joyPressed[i] == true then
                break
              end
            end
          end
      end        
    end
 
    --print(tostring(running) .. " | " .. tostring(started))
 
	loveframes.update(dt) 
end
            
-------------------------------------------------------------------------------          
-- DRAW     
function love.draw()
 	
 	--love.graphics.print("Player/Team 1:", 70, 18)
 	--love.graphics.print("Player/Team 2:", 70, 48)
 	--love.graphics.print("Player/Team 3:", 70, 78)
 	--love.graphics.print("Player/Team 4:", 70, 108)
 	if not started and joysCount > 0 then        
      for i=1, joysCount do
          if joyPressed[i] then
            love.graphics.draw(joyImages[i], 300, 300)
          end
      end
    end
    
    if started and joysCount > 0 then        
      for i=1, joysCount do
          if joyPressed[i] then
            love.graphics.draw(joyRunningImages[i], 300, 300)
            
            if i == 1 then
                love.graphics.print(playerOneNameInput:GetText(), 310, 540, 0, 2, 2)
            elseif i == 2 then
                love.graphics.print(playerTwoNameInput:GetText(), 310, 540, 0, 2, 2)
            elseif i == 3 then
                love.graphics.print(playerThreeNameInput:GetText(), 310, 540, 0, 2, 2)
            elseif i == 4 then
                love.graphics.print(playerFourNameInput:GetText(), 310, 540, 0, 2, 2)
            end
          end
      end
    end
    
    if started and running then
        love.graphics.print("Running!", 10, 580)
    end
 
	loveframes.draw() 
end

-------------------------------------------------------------------------------
-- MOUSEPRESSED
function love.mousepressed(x, y, button)
 
	-- your code
 
	loveframes.mousepressed(x, y, button) 
end

-------------------------------------------------------------------------------
-- MOUSERELEASED
function love.mousereleased(x, y, button)
 
	-- your code
 
	loveframes.mousereleased(x, y, button) 
end

-------------------------------------------------------------------------------
-- KEYPRESSED
function love.keypressed(key, unicode)
 
	-- your code
 
	loveframes.keypressed(key, unicode) 
end

-------------------------------------------------------------------------------
-- KEYRELEASED
function love.keyreleased(key)
 
	-- your code
 
	loveframes.keyreleased(key) 
end

-------------------------------------------------------------------------------
-- TEXTINPUT
function love.textinput(text)
             
	-- your code
 
	loveframes.textinput(text)
end