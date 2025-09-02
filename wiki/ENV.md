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
```

※ ブラウザに文字列が表示されていればOK!

> nyasocom_sun_pg_winを起動、スクレイピング開始 → 顔認証、./pass.txtを生成 (処理の起動対象)。
