#  select Name, BaseName or select DirectoryName, FullName can only take up to 2 arguments
Get-ChildItem -Path "C:\GIT\Notebooks\TestBatchExport" -Recurse -Filter *.docx | Select-Object BaseName, Name, DirectoryName
Foreach-Object {
        Write-Host $result.Name+$result.BaseName+$result.DirectoryName
}