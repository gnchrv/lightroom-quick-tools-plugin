--- Menu command: brighten the current photo by half a stop
-- Lightroom runs this file top to bottom every time the menu item is picked, so the call at the bottom is the whole command
-- @script IncreaseExposure

local adjustExposure = require 'AdjustExposure'    -- shared nudge, see AdjustExposure.lua

adjustExposure(0.5)                                -- half a stop up
