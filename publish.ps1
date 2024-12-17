# filepath: publish.ps1

$bookDir = $env:MDBOOK_DIR
$publishBranch = "gh-pages"
$buildDir = "$bookDir\book"


if (-Not $bookDir) {
    Write-Host "the env MDBOOK_DIR lost" -ForegroundColor Red
    exit 1
}

Set-Location $bookDir

mdbook build
if (-Not (Test-Path $buildDir)) {
    Write-Host "mdbook build error" -ForegroundColor Red
    exit 1
}

$branchExists = git branch --list $publishBranch
if ($branchExists) {
    git checkout $publishBranch
} else {
    git checkout --orphan $publishBranch
    git rm -rf .
}

Copy-Item -Path "$buildDir\*" -Destination $bookDir -Recurse -Force

git add .

git commit -m "update GitHub Pages"

git push origin $publishBranch --force

git checkout main

Write-Host "mdbook publish to gh-pages branch success" -ForegroundColor Green