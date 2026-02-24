# PowerShell script to remove a uniform background using ImageMagick
# Usage: Open PowerShell in this folder and run: .\remove-bg.ps1

param(
  [string]$input = "cedrickkk.jpg",
  [string]$output = "cedrickkk.png",
  [string]$fuzz = "8%",
  [string]$bgcolor = "white"
)

# Check for magick (ImageMagick)
$magick = Get-Command magick -ErrorAction SilentlyContinue
if (-not $magick) {
  Write-Host "ImageMagick 'magick' not found in PATH. Install ImageMagick and ensure 'magick' is available." -ForegroundColor Red
  exit 1
}

if (-not (Test-Path $input)) {
  Write-Host "Input file '$input' not found. Make sure the file exists in this folder." -ForegroundColor Yellow
  exit 2
}

Write-Host "Converting '$input' -> '$output' (fuzz=$fuzz, bgcolor=$bgcolor)..." -ForegroundColor Green

# Command: fuzz tolerance then make specified color transparent
magick "$input" -fuzz $fuzz -transparent $bgcolor "$output"

if (Test-Path $output) {
  Write-Host "Done. Output: $output" -ForegroundColor Green
} else {
  Write-Host "Failed to produce output." -ForegroundColor Red
}
