> git clone git@github.com:takkii/hyokaproject.git

```python
cd hyokaproject

pip3 install -r requiremens.txt

mysql -u root -p

create database hyokaproject_develop;

exit

python manage.py migrate

python manage.py runserver localhost:80

# wiki/README.mdを参考に環境構築します。

rails s
```



> hyokaprojectでリアルタイム顔認識を行う →
>
> nyasocom_sun_pg_win 起動 → パスワードを動作中にチェック
>
> → 継続|停止を条件分岐で確認するのを繰り返します。

### .env / 設定例

```ruby
# postgresユーザ
DATABASE_USER = "takkii"
# postgresユーザ、パスワード
DATABASE_PASSWORD = "20070920"
# 比較先: パスワード
EQUAL_PASSWORD = "Takayuki"
# 比較元: パスワードをもう一度入れてください。
SECRET_WORD = "Takayuki"
# 設定: ./ファイル名.txt
MEMBERS_CARD = "~/hyokaproject/hyokaproject.log"
# バージョン情報: x.x
NYASOCOMSUN_VERSION = "3.2"
```

※ 現在、WindowsでRubyの動作確認ができないため動作未検証です。
