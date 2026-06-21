# Base folder (current folder)
$baseDir = Get-Location

# Output folder to hold all converted files
$outputDir = Join-Path $baseDir "converted"
if (-Not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

# Find all mkv, mp4, avi, and divx files recursively, but skip anything already inside converted/
Get-ChildItem -Path $baseDir -Recurse -File -Include *.mkv, *.mp4, *.avi, *.divx |
    Where-Object { $_.FullName -notlike "$outputDir*" } |
    ForEach-Object {

        $inputFile = $_.FullName

        # Create corresponding output path inside "converted" folder
        $relativePath = $_.FullName.Substring($baseDir.Path.Length)
        $relativeDir = Split-Path $relativePath
        $outputFolder = Join-Path $outputDir $relativeDir

        # Create output folder if it doesn't exist
        if (-Not (Test-Path $outputFolder)) {
            New-Item -ItemType Directory -Path $outputFolder | Out-Null
        }

        # Construct output filename with .mp4 extension
        $outputFileName = [System.IO.Path]::GetFileNameWithoutExtension($_.Name) + ".mp4"
        $outputFile = Join-Path $outputFolder $outputFileName

        # Decode in software for compatibility, but keep GPU encoding.
        ./ffmpeg -i "`"$inputFile`"" -vf "format=yuv420p,scale=-1:720" -c:v h264_nvenc -b:v 800k -preset slow -c:a aac -b:a 96k "`"$outputFile`""
    }
