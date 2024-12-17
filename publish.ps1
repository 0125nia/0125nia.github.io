$bookDir = (Get-Location).Path
$publishBranch = "gh-pages"
$buildDir = "$bookDir\book"

git stash push -u -m "Stash before switching branches"

Set-Location $bookDir

mdbook build

if (-Not (Test-Path $buildDir)) {
    Write-Host "Build mdbook error" -ForegroundColor Red
    git stash pop
    exit 1
}

git checkout $publishBranch

$currentBranch = git rev-parse --abbrev-ref HEAD
if ($currentBranch -ne $publishBranch) {
    Write-Host "Failed to switch to branch '$publishBranch'. Reverting changes." -ForegroundColor Red
    git stash pop
    exit 1
} else {
    Write-Host "Successfully switched to branch '$publishBranch'." -ForegroundColor Green
}

Copy-Item -Path "$buildDir\*" -Destination $bookDir -Recurse -Force -Exclude "publish.ps1"

git add .
git commit -m "Update GitHub Pages" | Out-Null

try {
    git push origin $publishBranch --force
} catch {
    Write-Host "Failed to push to '$publishBranch' branch. Restoring state." -ForegroundColor Red
    git checkout main
    git stash pop
    exit 1
}

git checkout main

$currentBranch = git rev-parse --abbrev-ref HEAD
if ($currentBranch -ne "main") {
    Write-Host "Failed to switch back to 'main' branch. Please check manually." -ForegroundColor Red
    git stash pop
    exit 1
} else {
    Write-Host "Successfully switched back to 'main' branch." -ForegroundColor Green
}

git stash pop


Write-Host "Successfully publish mdbook to gh-pages branch" -ForegroundColor Green