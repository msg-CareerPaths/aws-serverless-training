# Use the current working directory as the starting point
$directory = $PWD.Path

# Find all the markdown files recursively
$markdownFiles = Get-ChildItem -Path $directory -Filter "*.md" -Recurse | Where-Object { !$_.PSIsContainer }

foreach ($file in $markdownFiles) {
    # Read the first line from the file
    $firstLine = Get-Content -Path $file.FullName -TotalCount 1

    # Check if the line is a level 1 markdown header
    if ($firstLine -match "^#\s+(.+)") {
        $title = $matches[1]

        # Create a relative path from the directory where the script is run to the markdown file
        $relativePath = $file.FullName.Replace($directory, '').TrimStart('\')

        # Create a relative markdown link and print it
        $link = "1. [$title]($relativePath)"
        Write-Output $link
    }
}
