# Use the 'chapters' subfolder in the current working directory as the starting point
$directory = Join-Path -Path $PWD.Path -ChildPath "chapters"

# Find all the markdown files recursively in 'chapters', sort by name, and exclude 'README.md' files
$markdownFiles = Get-ChildItem -Path $directory -Filter "*.md" -Recurse | 
                 Where-Object { !$_.PSIsContainer -and $_.Name -ne "README.md" } | 
                 Sort-Object Name

foreach ($file in $markdownFiles) {
    # Read the first line from the file
    $firstLine = Get-Content -Path $file.FullName -TotalCount 1

    # Check if the line is a level 1 markdown header
    if ($firstLine -match "^#\s+(.+)") {
        $title = $matches[1]

        # Create a relative path from the current working directory to the markdown file
        # Replace backslashes with forward slashes and start with ./
        $fullPath = "https://raw.githubusercontent.com/msg-CareerPaths/aws-serverless-training/master/" + ($file.FullName.Replace($PWD.Path, '').Replace('\', '/').TrimStart('/'))

        # Create a relative markdown link and print it
        $link = " - [$title]($fullPath)"
        Write-Output $link
    }
}
