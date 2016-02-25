# CircleCI to Hatena blog

## 事前準備
1. 本リポジトリをforkするなりして自分のプロジェクトとしてCircleCIをまわせるようにする。
2. CircleCIのEnvironment variablesに下記項目を設定する

```
* CONSUMER_KEY: コンシューマーキー
* CONSUMER_SECRET: コンシューマーシークレット
* ACCESS_TOKEN: アクセストークン
* ACCESS_TOKEN_SECRET: アクセストークンシークレット
* USER_ID: はてなID
* BLOG_ID: ブログid(例:http://blog.hatena.ne.jp/[はてなid]/[ブログid]/) 
```

## 運用
1. masterからブランチをきる
2. `articles`ディレクトリの中に１記事あたり１つディレクトリを作成する。
3. 作成したディレクトリの中に[任意の名前].mdで記事を作成する。
4. 一通り記事をかいたらmasterにむけてPRをおくる。
5. マージされると自動で投稿される