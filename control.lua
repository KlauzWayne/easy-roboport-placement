script.on_event(defines.events.on_built_entity, function(event)
    local setting_value = settings.get_player_settings(event.player_index)["draw-roboport-ghost-range"]
    if setting_value.value and event.created_entity.type == "entity-ghost" and event.created_entity.ghost_type == "roboport" then
        local roboportghost = event.created_entity
        local player = game.players[event.player_index]
        local col = { r = 0.2, g = 0.1, b = 0.2, a = 0.01 }
        local rad = game.entity_prototypes[roboportghost.ghost_name].logistic_radius
        if rad then
            rendering.draw_polygon { draw_on_ground = true, color = col, target = roboportghost, surface = player
                .surface_index, only_in_alt_mode = true, vertices = {
                { target = roboportghost, target_offset = { rad, rad } },
                { target = roboportghost, target_offset = { -rad, rad } },
                { target = roboportghost, target_offset = { -rad, -rad } } } }
            rendering.draw_polygon { draw_on_ground = true, color = col, target = roboportghost, surface = player
                .surface_index, only_in_alt_mode = true, vertices = {
                { target = roboportghost, target_offset = { rad, rad } },
                { target = roboportghost, target_offset = { rad, -rad } },
                { target = roboportghost, target_offset = { -rad, -rad } } } }
        end
    end
end)

script.on_event("toggle-ghost-logistic-range", function(event)
    settings.get_player_settings(event.player_index)["draw-roboport-ghost-range"] = {
        value = not settings.get_player_settings(event.player_index)["draw-roboport-ghost-range"].value }
end)
