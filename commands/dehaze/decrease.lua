--- Menu command: lower Dehaze by the medium step

-- Import the main function
local adjustSetting = require 'adjust-setting'

-- Execute the actual command
adjustSetting('Dehaze', 'medium', -1)
