echo "please input push info:"
read msg
hexo d
git pull origin master
git add .
git commit -a -m "$msg"
git push -u origin master

