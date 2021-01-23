$sourceDir = "C:\Users\Kamil\Notebooks"
# Copy all items to not work on sources
$copySourceDir = $sourceDir + "-copy"
New-Item -Path $copySourceDir -ItemType Directory
Get-ChildItem -Path $sourceDir | Copy-Item -Destination $copySourceDir -Recurse -Container
# Get all files in dir tree 
$fileSet = Get-ChildItem -Path $copySourceDir -Recurse -Filter *.docx | Select-Object BaseName, FullName, DirectoryName
foreach ($file in $fileSet) {
    # Create media path for each note
    $resultPath = $file.DirectoryName + "\" + $file.BaseName
    New-Item -Path $resultPath -ItemType Directory

    # Set enviroment variable for relative media path
    $env:MEDIA_FOLDER_NAME = $file.BaseName

    # Get relative media path
    Set-Location $sourceDir
    $relativePath = Get-Item $resultPath | Resolve-Path -Relative

    pandoc.exe -f docx -t gfm -s $file.FullName -o "$($resultPath).md" --file-scope --resource-path=$relativePath --extract-media=$relativePath --wrap=none --markdown-headings=atx --preserve-tabs --lua-filter C:\GIT\Scripts\WordToMarkdown\relativePath.lua

    # Remove empty media folders and copied word files
    if( ($resultPath.PSIsContainer) -and (!(Get-ChildItem -Recurse -Path $resultPath.FullName)))
	{
		# Delete it
		Remove-Item $resultPath.FullName -Confirm:$false -ErrorAction SilentlyContinue
	}
    Remove-Item $file.FullName -Confirm:$false -ErrorAction SilentlyContinue
}