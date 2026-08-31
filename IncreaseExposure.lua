--- Menu command: brighten the current photo by half a stop

-- Import the main function
local adjustSetting = require 'AdjustSetting'

-- Execute the actual command
adjustSetting('Exposure', 0.5)
