---Potentially spawn a Lorax (small biter)
---@param event EventData.on_entity_died | EventData.on_robot_pre_mined | EventData.on_pre_player_mined_item
local function spawnLorax(event)
  local entity = event.entity
  local prototype = entity.prototype
  if not prototype.mineable_properties.minable then return end
  if #prototype.mineable_properties.products < 1 then return end
  local index = 0
  for i,product in pairs(prototype.mineable_properties.products) do
    if product.name == "wood" then
      index = i
      break
    end
  end
  if index == 0 then return end
  --TODO identify live/dead trees better than hard coded "4 wood = live tree"
  if prototype.mineable_properties.products[index].amount ~= 4 then return end
  if math.random()*100 > settings.global['lorax-probability'].value then return end
  entity.surface.create_entity{position=entity.position,name="small-biter",force="enemy"}
end

---@type EventFilter
local event_filters = {{filter="type",type="tree"}}
script.on_event(defines.events.on_entity_died, spawnLorax, event_filters)
script.on_event(defines.events.on_pre_player_mined_item, spawnLorax, event_filters)
script.on_event(defines.events.on_robot_pre_mined, spawnLorax, event_filters)
script.on_event(defines.events.script_raised_destroy, spawnLorax, event_filters)