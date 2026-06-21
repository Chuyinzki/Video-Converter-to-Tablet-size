# Video Converter to Tablet Size

Drop your source videos into this folder, or into `Temp/` if you want a staging area, then run the converter script.

## What it does

- Finds `.mp4`, `.mkv`, `.avi`, and `.divx` files in this folder and all subfolders.
- Converts each video to a smaller 720p `.mp4`.
- Keeps the original folder structure inside `converted/`.
- Uses software decoding for compatibility.
- Uses your NVIDIA GPU for H.264 encoding when available.
- Skips anything already inside `converted/` so reruns do not reconvert output files.

## Output Settings

- Video codec: `h264_nvenc`
- Video bitrate: `800k`
- Audio codec: `aac`
- Audio bitrate: `96k`
- Target height: `720`

## How To Run

```powershell
.\convert_videos.ps1
```

## Notes

- Increase the PC sleep timer if you are converting a large batch.
- The script always writes `.mp4` files at the moment.
- If a file gives decode errors, the input may be damaged or use an unusual MPEG-4 variant.
