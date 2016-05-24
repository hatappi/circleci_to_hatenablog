script_dir=$(cd $(dirname $0); pwd)
filepath=`printf "$(git log --name-status -p -1)" | egrep "^[AM]\s+\"?articles\/.*\.md" | awk '{print $2}' | head -1 | sed -e 's/^\"//g' | sed -e 's/\"$//g'`

# これで指定されたファイルが実行される
if [ -n "${filepath}" ]; then
  echo "deploy file is ${filepath}"
  cat <<EOF > $script_dir/config.yml
consumer_key: $CONSUMER_KEY
consumer_secret: $CONSUMER_SECRET
access_token: $ACCESS_TOKEN
access_token_secret: $ACCESS_TOKEN_SECRET
user_id: $USER_ID
blog_id: $BLOG_ID
EOF
  cd $script_dir
  bundle
  echo $filepath > file.txt
  bundle exec ruby upload.rb
fi
