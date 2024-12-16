# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Examples:
# movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
# Character.create(name: "Luke", movie: movies.first)
# Blog.create(:days=>'', :title=>'', :body=>'')

Comment.create(body: 'ブログの追記、コメントはこちら。')
Comment.create(body: 'コメント、データベース入れ直し後。追加')
Comment.create(body: '記事、レイアウト調整。2022/03/05。')
Comment.create(body: 'コメント、更新。2022/03/19。')
Comment.create(body: '2022/03/24更新。メガテン。バッグなど。')
Comment.create(:body=>'2022/03/25、更新。メガテン、フォントなど。')
Comment.create(:body=>'2022/03/27、にゃそこん3の更新内容。')
Comment.create(:body=>'2022/03/27、にゃそこん3の更新内容。')
Comment.create(:body=>'2022/04/27、2022/04/26、更新。にゃそこん2より機能追加一旦停止。

    今後は自動テスト設置後に新規機能追加やリファクタリングなどを行う予定。')
Comment.create(:body=>'2022/04/30、GitHub Actionをにゃそこん参カスタムに設置。
    mainブランチにpushまたはPRで自動テスト回ります。')
Comment.create(:body=>'2022/05/14 記事に公開、非公開の権限を付けました。
    非公開にチェックでログイン時のみに公開で通常は公開になります。')
Comment.create(:body=>'2022/06/15、独自ドメインを取得、設定後にゃそこん３カスタムを稼働。
    現在、稼働中。')
Comment.create(:body=>'2022/06/20、サーバ監視を設定しました。')

# Comment.create(:body=>'')
