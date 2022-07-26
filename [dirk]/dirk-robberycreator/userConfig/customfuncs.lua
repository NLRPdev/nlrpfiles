CustomFuncs = {
  ['Blow Up Item'] = {
    ---------------------------------
    Label       = "Blow Up",
    Key         = "n",
    KeyCode     = 25,
    ---## Require Item for this func? 
    reqItem     = false, 
    reqAmt      = 0, 
    ----------------------------------
    OnlyRunThis = true, --## This can be true or false. If true then it'll only run this function else it'll display grab/carry/search functions as normal for this object
    Action = function(robId,entId, entType,entData,ent) --## Passes the robId: The ID of this robbery zone, entId: The id of the entity used for the robbery, the entType which is Inhabitant or Object, entData: Config.Objects data for this obj, ent: the entity you are interacting with
      --## You can run whatever function you want in here this is obviously ran client side. Feel free to add your own server events to myserverevents.lua
      

      local ply = PlayerPedId()
      

    end,
  }
}