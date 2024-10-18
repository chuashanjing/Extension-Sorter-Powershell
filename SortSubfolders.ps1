# Define the main folder path
$mainFolder = "<main folder>"

# Destination path for PDF files
$destinationFolder = "<destination>"

# Ensure the destination folder exists
if (!(Test-Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder
}

# Move only PDF files from subfolders
Get-ChildItem -Path $mainFolder -Recurse -File -Filter *.pdf | ForEach-Object {
    if($_.Name -notlike "*SHEET*"){
        Copy-Item -LiteralPath $_.FullName -Destination $destinationFolder
    }
}

