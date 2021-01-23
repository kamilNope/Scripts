#  select Name, BaseName or select DirectoryName, FullName can only take up to 2 arguments
$fileSet = Get-ChildItem -Path "C:\GIT\Notebooks\TestBatchExport" -Recurse -Filter *.docx | select BaseName, Name, DirectoryName
foreach($file in $fileSet){
       $resultPath=$file.DirectoryName+"\"+$file.BaseName
       Write-Output $resultPath `n
}