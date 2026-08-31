--- Menu command: lower the white point of the current photo

-- Import the main function
local adjustSetting = require 'AdjustSetting'

-- Execute the actual command
adjustSetting('Whites', -5)
