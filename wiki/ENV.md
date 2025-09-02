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

# Webカメラを起動します
python take.py

# images/face.jpg → face.gifに変換します。
python convert.py

# パスはその都度変えてください
mv ./images/face.gif ./hyokaproject/hold/face.gif

python manage.py migrate

python manage.py runserver

# wiki/manual.mdを読んで環境構築

rails s
```

ブラウザに文字列(百人一首)が表示されていればOK!

> nyasocom_sun_pg_winを起動、スクレイピング開始 → 顔認証、./pass.txtを生成 (処理の起動対象)。

```markdown
# ☒ Error, list of range
Windows 11 Home
Python 3.13.7
iiyama notebook

# ◯
Window 11 pro
Python 3.11.9
Surface Pro 3
```

※ Python3のバージョンが悪いのか、ログを吐いて動作しなかった環境もあります。
