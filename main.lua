return function(mod)
  -- Ultimate Arena Battles v1.0.1
  -- Top-down style, location-matched, weather-aware battles for Gen1Recomp.

  local HEIGHTS = {
    GYARADOS = 6.5, SNORLAX = 2.1, LAPRAS = 2.5, CHARIZARD = 1.7,
    BLASTOISE = 1.6, VENUSAUR = 2.0, DRAGONITE = 2.2, ONIX = 8.8,
    PIKACHU = 0.4, EEVEE = 0.3, MAGIKARP = 0.9, -- add more as needed
  }

  mod.options:define({
    { key = "sprite_source", label = "SPRITE SOURCE", type = "choice", default = "custom",
      choices = {{"Custom Folder", "custom"}, {"PokePC Followers", "follower"}, {"Stadium Extracted", "stadium"}} },
    { key = "auto_battle", label = "AUTO BATTLE PARTIES", type = "toggle", default = true },
    { key = "weather_fx", label = "WEATHER EFFECTS", type = "toggle", default = true },
    { key = "field_match", label = "LOCATION FIELD MATCH", type = "toggle", default = true },
    { key = "scale_giants", label = "SCALE GIANTS", type = "toggle", default = true },
    { key = "show_menu_btn", label = "SHOW MENU BUTTON", type = "toggle", default = true },
  })

  local battleState = { active = false, playerIndex = 1, enemyIndex = 1, menuOpen = false, fieldType = "field" }
  local currentMap = "pallet_town"

  -- Track location for field matching
  mod.events:on("map.entered", function(ev)
    currentMap = ev.mapId or "unknown"
    local m = currentMap:lower()
    if m:find("gym") or m:find("league") then battleState.fieldType = "gym"
    elseif m:find("forest") or m:find("viridian") then battleState.fieldType = "forest"
    elseif m:find("cave") or m:find("mt") or m:find("tunnel") then battleState.fieldType = "cave"
    elseif m:find("center") or m:find("mart") or m:find("house") or m:find("lab") then battleState.fieldType = "indoor"
    elseif m:find("water") or m:find("sea") or m:find("lake") then battleState.fieldType = "water"
    else battleState.fieldType = "field" end
  end)

  -- Battle lifecycle
  mod.events:on("battle.started", function(ev)
    battleState.active = true
    battleState.playerIndex = 1
    battleState.enemyIndex = 1
    battleState.menuOpen = false
    -- Apply initial weather if enabled
    if mod.options:get("weather_fx") then
      -- Simple rain detection stub; integrate with Weather-fx via mod.find if present
      local weatherMod = mod.find("Weather-fx") or mod.find("kanto_dynamic_weather")
      if weatherMod then
        -- Placeholder: assume rain possible; real integration would query its exports
      end
    end
  end)

  mod.events:on("battle.ended", function()
    battleState.active = false
    battleState.menuOpen = false
  end)

  mod.events:on("battle.fainted", function(ev)
    if mod.options:get("auto_battle") and not battleState.menuOpen then
      -- Auto-advance party index (engine handles send-out; we track for overlay)
      if ev.battler and ev.battler.side == "player" then
        battleState.playerIndex = battleState.playerIndex + 1
      else
        battleState.enemyIndex = battleState.enemyIndex + 1
      end
    end
  end)

  -- Sprite scaling for giants
  if mod.options:get("scale_giants") then
    for species, h in pairs(HEIGHTS) do
      if h >= 2.0 then
        pcall(function()
          mod.content.pokemon:patch(species, { battleScaleFront = math.min(3.0, 1.0 + h * 0.4), battleScaleBack = 1.2 })
        end)
      end
    end
  end

  -- Custom overlay: top-down field approximation + menu button
  mod.hooks:wrap("battle.overlay", function(next, battle)
    next(battle)
    if not battleState.active then return end

    local Font = mod.ui.Font
    local field = battleState.fieldType
    local colors = {
      field = {0.4, 0.7, 0.3}, forest = {0.2, 0.5, 0.2}, gym = {0.5, 0.4, 0.3},
      cave = {0.3, 0.3, 0.35}, indoor = {0.6, 0.55, 0.5}, water = {0.2, 0.4, 0.8}
    }
    local c = colors[field] or colors.field

    -- Draw simple field circle (native coords 160x144)
    -- (Real implementation would use love.graphics via render hooks for full canvas;
    --  this is the safe public overlay path.)
    Font.draw("FIELD: " .. field:upper(), 4, 4)
    if mod.options:get("weather_fx") then
      Font.draw("WEATHER ACTIVE", 4, 14)
    end

    -- Menu button bottom-right
    if mod.options:get("show_menu_btn") then
      Font.draw("[MENU]", 120, 128)
    end

    if battleState.menuOpen then
      Font.draw("1 SWITCH", 100, 100)
      Font.draw("2 ITEM", 100, 110)
      Font.draw("3 FLEE", 100, 120)
      Font.draw("B CLOSE", 100, 130)
    end
  end)

  -- Damage weather modifiers (rain example)
  mod.hooks:wrap("battle.damage", function(next, ctx)
    local dmg, info = next(ctx)
    if mod.options:get("weather_fx") and battleState.active then
      -- Stub: if rain (check external or own flag), boost water / dampen fire
      local moveType = ctx.move and ctx.move.type or ""
      if moveType == "WATER" then dmg = math.floor(dmg * 1.3) end
      if moveType == "FIRE" then dmg = math.floor(dmg * 0.7) end
    end
    return dmg, info
  end)

  -- Input for menu button (simple key check via events or assume B / Start)
  -- Full input handling would wrap battle.menu_auxiliary or use a custom screen.
  -- For now, toggle via documented hook when available.
  mod.hooks:wrap("battle.menu_auxiliary", function(next, game, context)
    -- Allow START to open menu in battle
    if mod.options:get("show_menu_btn") then
      battleState.menuOpen = not battleState.menuOpen
      return true -- consume
    end
    return next(game, context)
  end)

  mod.log:info("Ultimate Arena Battles loaded. Sprite source: %s", mod.options:get("sprite_source"))
end
