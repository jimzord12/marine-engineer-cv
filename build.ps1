param([string]$OutputDirectory = ("builds/" + (Get-Date -Format "yyyyMMdd-HHmmss")))
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
if (Test-Path -LiteralPath $OutputDirectory) { throw "Output directory already exists. Choose a new directory to preserve existing PDFs." }
New-Item -ItemType Directory -Path $OutputDirectory | Out-Null
Get-ChildItem designs -Filter '0*.typ' | ForEach-Object {
    typst compile --root . --font-path fonts $_.FullName (Join-Path $OutputDirectory ($_.BaseName + '.pdf'))
    if ($LASTEXITCODE -ne 0) { throw "Typst compilation failed: $($_.Name)" }
}
Write-Host "PDFs created in $OutputDirectory"
