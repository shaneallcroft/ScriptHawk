local environ = {}

-- States are a tuple of dealer's first card (1-10) and the player's sum
-- Set of actions

environ.A = {'no input', 'A', 'B', 'R', 'Z' --standard button inputs
             'up full', 'up half', 'up right full', 'up right half', 'right full', 'right half'--plain directions
             'down right full', 'down right half', 'down full', 'down half', 'down left full', 'down left half',
             'left full', 'left half', 'up left full', 'up left half'
             'A + up full', 'A + up half', 'A + up right full', 'A + up right half', 'A + right full', --directional attacks 
             'A + right half', 'A + down full', 'A + down half', 'A + left full', 'A + left half',
             'B + up full', 'B + down full', --directional specials
             'Z + left full', 'Z + right full'} --rolling
-- 35 possible actions
-- State transitions are not explicitly stored

-- Draws a card (with replacement)
local drawCard = function()
  -- Draw number uniformly from 1-10
  local num = torch.random(1, 10)
  -- Draw colour red with p = 1/3 and black with p = 2/3
  if torch.uniform() <= 1/3 then
    return {num, 'red'}
  else
    return {num, 'black'}
  end

-- Adds a card to an existing sum
local addCard = function(sum, card)
  if card[2] == 'black' then
    return sum + card[1]
  else
    return sum - card[1]
  end
end

-- Checks if bust
local checkBust = function(sum)
  return sum > 21 or sum < 1
end

-- Perform a step in the environment
environ.step = function(s,a)
  -- Current state

  local sPrime = {}

  --[[
        Standard Button Inputs
  --]]
  if a == 'no input' then
    -- No input Action

  else if a == 'A' then
    -- A attack Action

  else if a == 'B' then
    -- B attack Action

  else if a == 'R' then
    -- R grab Action

  else if a == 'Z' then
    -- Z shield Action

  --[[
        Plain Directions
  --]]
  else if a == 'up full' then
    -- Move up fully Action

  else if a == 'up half' then
    -- Move up half Action

  else if a == 'up right full' then
    -- Move up right fully Action
  
  else if a == 'up right half' then
    -- Move up right half Action

  else if a == 'right full' then
    -- Move right fully Action
  
  else if a == 'right half' then
    -- Move right half Action

  else if a == 'down right full' then 
    -- Move down right fully Action

  else if a == 'down right half' then
    -- Move down right half Action

  else if a == 'down full' then
    -- Move down fully half Action

  else if a == 'down half' then
    -- Move down half Action

  else if a == 'down left full' then
    -- Move down left fully Action

  else if a == 'down left half' then
    -- Move down left half Action

  else if a == 'left full' then
    -- Move left fully Action

  else if a == 'left half' then
    -- Move left half Action

  else if a == 'up left full' then
    -- Move up left fully Action

  else if a == 'up left half' then
    -- Move up left half Action

  else if a == 'up left full' then
    -- Move up left fully Action

  else if a == 'up left half' then
    -- Move up left half

  
  --[[
        Directional Attacks
  --]]
  else if a == 'A + up full' then
    -- Move up fully and use A attack
  
  else if a == 'A + up half' then
    -- Move up half and use A attack
  
  else if a == 'A + up right full' then
    -- Move up right fully and use A attack

  else if a == 'A + up right half' then
    -- Move up right half and use A attack

  else if a == 'A + right full' then
    -- Move right fully and use A attack

  else if a == 'A + right half' then
    -- Move right half and use A attack
    
  else if a == 'A + down full' then
    -- Move down fully and use A attack

  else if a == 'A + down half' then
    -- Move down half and use A attack

  else if a == 'A + left full' then
    -- Move left fully and use A attack

  else if a == 'A + left half' then
    -- Move left half and use A attack

  else if a == 'B + up full' then
    -- Move up fully and use B attack

  else if a == 'B + down full' then
    -- Move down fully and use B attack

  else if a == 'Z + left full' then
    -- Move left fully and use Z

  else if a == 'Z + right full'
    -- Move right fully and use Z


-- Performs a step in the environment
environ.step = function(s, a)
  -- Current state
  local dealersFirstCard = s[1]
  local playersSum = s[2]
  -- Next state (initialised with deep copy of current state)
  local sPrime = {}
  sPrime[1] = dealersFirstCard
  sPrime[2] = playersSum
  -- Reward (0 by default)
  local r = 0

  -- Process actions
  if a == 'hit' then
    -- Draw and add next card
    sPrime[2] = addCard(playersSum, drawCard())

    -- Check player fail conditions
    if checkBust(sPrime[2]) then
      r = -1
    end
  elseif a == 'stick' then
    local dealersSum = dealersFirstCard

    -- Dealer sticks when on 17 or higher
    while dealersSum < 17 and dealersSum >= 1 do
      -- Draw and add next card
      dealersSum = addCard(dealersSum, drawCard())
    end

    -- Check dealer fail conditions and winning conditions otherwise (player with largest sum)
    if checkBust(dealersSum) or dealersSum < playersSum then
      r = 1
    elseif dealersSum > playersSum then
      r = -1
    end
  end

  return sPrime, r
end

-- Calculates if the current state is terminal given previous action and reward
environ.isTerminal = function(a, r)
  return a == 'stick' or r == -1
end

local environ.cartesianDistanceFromEnemy = function(currentX, currentY)
    
end

return environ