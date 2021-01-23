local system = require 'pandoc.system'
local mb = require 'pandoc.mediabag'

function relativePath()
    local fname = print(system.environment()["MEDIA_FOLDER_NAME"]) .. '/'

    for fp, mt, contents in pandoc.mediabag.items() do
        pandoc.mediapath.delete(fp)
        local relativePath = fname .. fp
        print(relativePath)
        pandoc.mediabag.insert(relativePath, mt, contents)
    end
end
