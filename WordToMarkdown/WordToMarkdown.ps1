$sourceDir = "C:\Users\Kamil\Notebooks"
# Copy all items to not work on sources
$copySourceDir = $sourceDir+"-copy"
New-Item -Path $copySourceDir -ItemType Directory
Get-ChildItem -Path $sourceDir | Copy-Item -Destination $copySourceDir -Recurse -Container
# Change files in all dir tree 
$fileSet = Get-ChildItem -Path $copySourceDir -Recurse -Filter *.docx | Select-Object BaseName, FullName, DirectoryName
foreach($file in $fileSet){
    $resultPath=$file.DirectoryName+"\"+$file.BaseName
    # Get absolute media path
    $currentMediaPath=$file.DirectoryName
    Set-Location $sourceDir
    $relativePath = Get-Item $currentMediaPath | Resolve-Path -Relative

    pandoc.exe -f docx -t gfm -s $file.FullName -o "$($resultPath).md" --file-scope --resource-path=$relativePath --extract-media=$relativePath --wrap=none --markdown-headings=atx --preserve-tabs
    Remove-Item $file.FullName
}