$ModulePath = $PSScriptRoot

$LoadDirectories = @(
  $ModulePath
  ( Join-Path $ModulePath "Private" ),
  ( Join-Path $ModulePath "Public" )
)

$LoadDirectories | ForEach-Object {
  Get-ChildItem $_\*.ps1 | ForEach-Object {
    . $_.FullName
  }
}

$ExportDirectories = $LoadDirectories[0], $LoadDirectories[ 2 .. 2 ]

$ExportDirectories | ForEach-Object {
  Get-ChildItem $_\*.ps1 | ForEach-Object {
    $FunctionName = $_.BaseName
    Export-ModuleMember -Function $FunctionName
  }
}
