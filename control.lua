---Potentially spawn a Lorax (small biter)
---@param event EventData.on_entity_died | EventData.on_robot_pre_mined | EventData.on_pre_player_mined_item
local function spawnLorax(event)
  if event.entity.type ~= "tree" or
     event.entity.prototype.mineable_properties.products == nil or
     event.entity.prototype.mineable_properties.products[1].name ~= "wood" or
     event.entity.prototype.mineable_properties.products[1].amount ~= 4 or
     math.random()*100 > settings.global['lorax-probability'].value then
      return
  end
  event.entity.surface.create_entity{position=event.entity.position,name="small-biter",force="enemy"}
end

local event_filters = {{filter="type",type="tree"}}
script.on_event(defines.events.on_pre_player_mined_item, spawnLorax, event_filters)
script.on_event(defines.events.on_robot_pre_mined, spawnLorax, event_filters)
script.on_event(defines.events.on_entity_died, spawnLorax, event_filters)
