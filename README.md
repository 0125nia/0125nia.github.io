### publish Github Pages

1. use `.\deploy.sh`

2. use shell

```shell
git checkout --orphan gh-pages
git rm -rf .
cp -r book/* .
git add .
git commit -m "发布 GitHub Pages"
git push origin gh-pages --force
```
