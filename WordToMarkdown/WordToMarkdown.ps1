$sourceDir = "C:\GIT\Notebooks\TestBatchExport"
# Copy all items to not work on sources
$copySourceDir = $sourceDir+"-copy"
New-Item -Path $copySourceDir -ItemType Directory
Get-ChildItem -Path $sourceDir | Copy-Item -Destination $copySourceDir -Recurse -Container
# Change files in all dir tree 
$fileSet = Get-ChildItem -Path $copySourceDir -Recurse -Filter *.docx | Select-Object BaseName, FullName, DirectoryName
foreach($file in $fileSet){
    $resultPath=$file.DirectoryName+"\"+$file.BaseName
    # Get media path
    $currentMediaPath=$file.DirectoryName

    pandoc.exe -f docx -t markdown+startnum+implicit_figures+pipe_tables+emoji-link_attributes+fenced_code_blocks -i $file.FullName -o "$($resultPath).md" --resource-path=$currentMediaPath --extract-media --wrap=none --markdown-headings=atx --preserve-tabs
    Remove-Item $file.FullName
}