echo "please input push info:"
read msg
hexo clean
hexo g
hexo d
git pull origin master
git add .
git commit -a -m "$msg"
git push -u origin master

