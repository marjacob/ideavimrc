$invocation = (Get-Variable MyInvocation).Value

$directory = Split-Path ${invocation}.MyCommand.Path
$here = Join-Path "${directory}" "ideavimrc"
$there = ".ideavimrc"

New-Item -Force `
    -ItemType "HardLink" `
    -Name "${there}" `
    -Path "${Home}" `
    -Value "${here}"