local system = require 'pandoc.system'
local mb = require 'pandoc.mediabag'

local fname = system.environment()["MEDIA_FOLDER_NAME"] .. '/'

for fp, mt, contents in pandoc.mediabag.items() do
    pandoc.mediabag.delete(fp)
    local relativePath = fname .. fp
    print(relativePath)
    pandoc.mediabag.insert(relativePath, mt, contents)
end

-- function relative_path (path)
--   local fname = system.get_working_directory() .. '/'
--   return fname .. 'you/path/prefix' .. path
-- end

-- function Image (element)
--   element.src = relative_path(element.src)
--   return element
-- end

