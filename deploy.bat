git checkout --orphan gh-pages
git rm -rf .
cp -r book/* .
git add .
git commit -m "deploy GitHub Pages"
git push origin gh-pages --force