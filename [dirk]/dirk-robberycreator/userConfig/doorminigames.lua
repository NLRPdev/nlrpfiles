DoorMiniGames = { --## If you have the know how it's pretty easy to add any entry method for a door you want. Will likely update these as people request more minigames. (Must be an already existing minigame as no plans to make individually minigames)
  
  ['NONE'] = {}, --## reqItem and reqAmt will deteremine wether you need an item or not. View more info in the readme.

  ['Key-Master'] = {
    Settings = {
      settings = {
          handleEnd = false;  --Send a result message if true and callback when message closed or callback immediately without showing the message
          speed = 10; --pixels / second
          scoreWin = 100; --Score to win
          scoreLose = -150; --Lose if this score is reached
          maxTime = 60000; --sec
          maxMistake = 5; --How many missed keys can there be before losing
          speedIncrement = 1; --How much should the speed increase when a key hit was successful
      },
      keys = {"a", "w", "d", "s", "g"}; --You can hash this out if you want to use default keys in the java side.
    },

    Action = function(self)
      local game = exports['cd_keymaster']:StartKeyMaster(self.Settings)
      while game == nil do Wait(750); end  
      if game then
        return true
      end 
      return false
    end   
  },

  ['NP-MiniGame'] = {
    Action = function(self)
      local answer = nil 
      exports["hacking"]:hacking(
        function() -- success
          answer = true
        end,
        function() -- failure
        answer = false
      end)    
      while answer == nil do Wait(500); end
      return answer
    end
  },

  ['Lockpick'] = {
    reqItem = false, -- Can be false
    reqAmt  = 5, 
   

    Action = function(self) --## Use self to access any information within the table for this minigame to add your own settings etc.
      local success, lockpickbroken = exports['qb-lockpick']:openLockpick()
      while success == nil do Wait(500); end
      
      if success then
        return true
      else
        if lockpickbroken then
          TriggerServerEvent("HR:BreakEntryFail", robZone)  --## "HR:LockpickFail" --## Use this event to take an item away for failure (has to have a reqItem to begin with)              
        end
      end
      return false   
    end
  }
}