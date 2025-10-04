> git clone git@github.com:takkii/hyokaproject.git

```markdown
cd hyokaproject

pip3 install -r requiremens.txt

mysql -u root -p

create database hyokaproject_develop;

exit

git clone git@github.com:takkii/picture.git

cd picture

pip3 install -r requiremens.txt

# Webカメラを起動、撮影します。
python take.py

# images/face.jpg → face.gifに変換します。
python convert.py

# 移動先はその都度変えてください。
mv ./images/face.gif ./hyokaproject/hold/face.gif

python manage.py migrate

python manage.py runserver

# wiki/README.mdを参考に環境構築します。

rails s
```

#### ブラウザに文字列が表示されていれば顔認識システムが正しく動作しています。

顔認証で例外を発生させているとき、精度評価の数値を小数点数単位で上げてみてください。

プロジェクト直上階層、ログが出力されていれば、顔認識の精度評価以外の理由で例外が発生しています。

> nyasocom_sun_pg_win起動 → スクレイピング開始
>
> → 顔認証後メンバーズカード生成 → パスワードを動作中にチェック
>
> → 継続|停止を条件分岐で確認するのを繰り返します。

```ruby
# .env / 設定例

# postgresユーザ
DATABASE_USER = "postgres"
# postgresユーザ、パスワード
DATABASE_PASSWORD = "password"
# 比較先: パスワード
EQUAL_PASSWORD = "TRUE"
# 比較元: パスワードをもう一度入れてください。
SECRET_WORD = "TRUE"
# 設定: ./ファイル名.txt
MEMBERS_CARD = "./pass.txt"
```

※ 問題の調査は終わりました、ユーザテスト済みです。照明を点けて顔認証してください。
