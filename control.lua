--TODO identify modded live/dead trees somehow
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

script.on_event(defines.events.on_pre_player_mined_item, spawnLorax)
script.on_event(defines.events.on_robot_pre_mined, spawnLorax)
script.on_event(defines.events.on_entity_died, spawnLorax)
