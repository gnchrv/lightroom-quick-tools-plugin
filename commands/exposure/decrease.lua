--- Menu command: lower Exposure by the medium step

-- Import the main function
local adjustSetting = require 'adjust-setting'

-- Execute the actual command
adjustSetting('Exposure', 'medium', -1)
