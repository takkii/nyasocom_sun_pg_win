#### rails 8.0.0.1

```markdown
Information for cause: ArgumentError (Passed nil to the :model argument, expect an object or false):
```

※ 対処済み、rails 8.0.1でコメント機能非同期動作確認！

#### rails 8.0.1に向けて内部仕様の変更

- 音楽(mp3)をアップロード&視聴、機能を削除しました。

※ 7 ~ 8年前からプロジェクトの更新が止まっていました。

- 禁止ワードでカスタムバリデーションを廃止しました。

※ 画像、動画アップローダーが正常に動作しないためです。

- 複数画像機能を削除しました。

※ 使用回数が少なく不要なためです。


### 環境

```markdown
・ Windows11
・ Docker
・ Nginx
```

#### 仕様

- [x] マイページ機能を実装

- [x] 記事を投稿時にユーザIDを割り振るようにしました。

※ インポートした記事ではデフォルトの0を割り振ります。

#### ログイン非表示

| [ユーザ側](http://localhost/users/sign_in) | [管理者側](http://localhost/admins/sign_in) |
| :----------------------------------------: | :-----------------------------------------: |

※ ログイン後、google authenticatorなどで番号を発行し認証する。

∟ current_user.idとログインユーザのidが一致しないときraiseを発生。

#### Docker側

```markdown
# bashでコンテナ内に入る

docker-compose exec db bash

# postgresパスワード設定

passwd postgres

# postgresユーザ切り替え

su - postgres

# スーパーユーザでログイン

psql

# role 新規ユーザのようなもの

create role takkii WITH CREATEDB login password '20070920';

# HINT: Must be superuser to create this extension.

ALTER ROLE takkii SUPERUSER;

# pgroonga有効化

CREATE EXTENSION pgroonga;

# takkiiがSUPERUSERかどうか

\du
```

#### 新規機能追加

```markdown
# msys2 install

pacman -S mingw-w64-ucrt-x86_64-libyaml

# モデル作成

rails g model BlogComment review:text user_id:integer

# コントローラ作成

rails g controller blog_comments

# ローカルDB、入れ直し

rails db:migrate:reset
```

#### 起動

```markdown
# データセット

docker-compose exec web rails db:default_db

# データ入れ直し

docker-compose exec web rails db:environment:set RAILS_ENV=development
docker-compose exec web rails db:pg_default_db
```

#### 管理者側

```ruby
admin = Admin.create! do |u|
u.email = 'sound_gear_0830@yahoo.co.jp'
u.password = 'DQjZs!edkzrgbM$4VVte2!LZE'
u.password_confirmation = 'DQjZs!edkzrgbM$4VVte2!LZE'
end
```

#### ユーザ側

```ruby
user = User.create! do |u|
u.email = 'karuma.reason@gmail.com'
u.password = 'jbUuwYC-4lWO8JMFruPvePQGA'
u.password_confirmation = 'jbUuwYC-4lWO8JMFruPvePQGA'
end
```

※ seedデータ内、整理。

#### ローカル環境構築

```markdown
# Nginx

cd C:\nginx-1.22.0

# テスト

nginx -t

# 起動

start nginx

# 再読み込み

nginx -s reload

# 停止
nginx -s stop

# 起動

rails s

# データセット

rails db:defualt_db

# 入れ直し

rails db:pg_default_db

記事→CSVインポート、文章データ復元。

# デーモン化起動
docker compose up -d

# config/puma.rb

修正、コメント内容確認。

# その他、nyasocom_sun_pgroonga/wiki/manual.mdを参照。
```
#### 証明書

```markdown
# use scoop
scoop install mkcert

# 管理者権限で実行
mkcert --install
mkcert --uninstall

# localhost
mkcert localhost
```

#### 依存ライブラリ

> license_finder

```markdown
Dependencies that need approval:
@esbuild/win32-x64, 0.24.0, MIT
@fortawesome/fontawesome-free, 6.7.1, "(CC-BY-4.0 AND OFL-1.1 AND MIT)"
@parcel/watcher, 2.5.0, MIT
@parcel/watcher-win32-x64, 2.5.0, MIT
@rails/ujs, 7.1.501, MIT
actioncable, 8.0.1, MIT
actionmailbox, 8.0.1, MIT
actionmailer, 8.0.1, MIT
actionpack, 8.0.1, MIT
actiontext, 8.0.1, MIT
actionview, 8.0.1, MIT
activejob, 8.0.1, MIT
activemodel, 8.0.1, MIT
activerecord, 8.0.1, MIT
activestorage, 8.0.1, MIT
activesupport, 8.0.1, MIT
addressable, 2.8.7, "Apache 2.0"
audiojs, 0.1.0, MIT
base64, 0.2.0, "Simplified BSD, ruby"
bcrypt, 3.1.20, MIT
benchmark, 0.4.0, "Simplified BSD, ruby"
bigdecimal, 3.1.8, "Simplified BSD, ruby"
bindex, 0.8.1, MIT
bootsnap, 1.18.4, MIT
bootswatch, 5.3.3, MIT
braces, 3.0.3, MIT
builder, 3.3.0, MIT
bundler, 2.5.23, MIT
carrierwave, 3.1.0, MIT
chokidar, 4.0.1, MIT
chunky_png, 1.4.0, MIT
concurrent-ruby, 1.3.4, MIT
connection_pool, 2.4.1, MIT
crass, 1.0.6, MIT
cssbundling-rails, 1.4.1, MIT
csv, 3.3.1, "Simplified BSD, ruby"
date, 3.4.1, "Simplified BSD, ruby"
detect-libc, 1.0.3, "Apache 2.0"
devise, 4.9.4, MIT
devise-bootstrap-views, 1.1.0, MIT
devise-i18n, 1.12.1, MIT
dotenv, 3.1.6, MIT
dotenv-rails, 3.1.6, MIT
drb, 2.2.1, "Simplified BSD, ruby"
erubi, 1.13.0, MIT
esbuild, 0.24.0, MIT
ffi, 1.17.0, "New BSD"
fill-range, 7.1.1, MIT
font-awesome-sass, 6.5.2, MIT
globalid, 1.2.1, MIT
i18n, 1.14.6, MIT
image_processing, 1.13.0, MIT
immutable, 5.0.3, MIT
io-console, 0.8.0, "Simplified BSD, ruby"
irb, 1.14.2, "Simplified BSD, ruby"
is-extglob, 2.1.1, MIT
is-glob, 4.0.3, MIT
is-number, 7.0.0, MIT
jbuilder, 2.13.0, MIT
jquery, 3.7.1, MIT
jquery-ujs, 1.2.3, MIT
jsbundling-rails, 1.3.1, MIT
kaminari, 1.2.2, MIT
kaminari-actionview, 1.2.2, MIT
kaminari-activerecord, 1.2.2, MIT
kaminari-core, 1.2.2, MIT
kaminari-i18n, 0.5.0, MIT
listen, 3.9.0, MIT
logger, 1.6.3, "Simplified BSD, ruby"
loofah, 2.23.1, MIT
mail, 2.8.1, MIT
marcel, 1.0.4, "Apache 2.0, MIT"
micromatch, 4.0.8, MIT
mini_magick, 4.13.2, MIT
mini_mime, 1.1.5, MIT
minitest, 5.25.4, MIT
msgpack, 1.7.5, "Apache 2.0"
net-imap, 0.5.1, "Simplified BSD, ruby"
net-pop, 0.1.2, "Simplified BSD, ruby"
net-protocol, 0.2.2, "Simplified BSD, ruby"
net-smtp, 0.5.0, "Simplified BSD, ruby"
nio4r, 2.7.4, "MIT, Simplified BSD"
node-addon-api, 7.1.1, MIT
nokogiri, 1.17.2, MIT
observer, 0.1.2, "Simplified BSD, ruby"
orm_adapter, 0.5.0, MIT
ostruct, 0.6.1, "Simplified BSD, ruby"
paranoia, 3.0.0, MIT
pg, 1.5.9, "Simplified BSD"
picomatch, 2.3.1, MIT
pkg-config, 1.5.8, LGPLv2+
propshaft, 1.1.0, MIT
psych, 5.2.1, MIT
public_suffix, 6.0.1, MIT
puma, 6.5.0, "New BSD"
pygments-rouge-css, 0.1.0, MIT
racc, 1.8.1, "Simplified BSD, ruby"
rack, 3.1.8, MIT
rack-session, 2.0.0, MIT
rack-test, 2.1.0, MIT
rackup, 2.2.1, MIT
rails, 8.0.1, MIT
rails-dom-testing, 2.2.0, MIT
rails-html-sanitizer, 1.6.2, MIT
railties, 8.0.1, MIT
rake, 13.2.1, MIT
rb-fsevent, 0.11.2, MIT
rb-inotify, 0.11.1, MIT
rdoc, 6.9.0, ruby
readdirp, 4.0.2, MIT
redcarpet, 3.6.0, MIT
reline, 0.5.12, ruby
responders, 3.1.1, MIT
rmagick, 6.0.1, MIT
roo, 2.10.1, MIT
rotp, 6.3.0, MIT
rouge, 4.5.1, "MIT, Simplified BSD"
rqrcode, 2.2.0, MIT
rqrcode_core, 1.2.0, MIT
ruby-vips, 2.2.2, MIT
rubyzip, 2.3.2, "Simplified BSD"
sass, 1.83.0, MIT
sassc, 2.4.0, MIT
securerandom, 0.4.0, "Simplified BSD, ruby"
source-map-js, 1.2.1, "New BSD"
ssrf_filter, 1.2.0, MIT
stimulus-rails, 1.3.4, MIT
stringio, 3.1.2, "Simplified BSD, ruby"
thor, 1.3.2, MIT
timeout, 0.4.2, "Simplified BSD, ruby"
to-regex-range, 5.0.1, MIT
turbo-rails, 2.0.11, MIT
tzinfo, 2.0.6, MIT
tzinfo-data, 1.2024.2, MIT
uri, 1.0.2, "Simplified BSD, ruby"
useragent, 0.16.11, MIT
warden, 1.2.9, MIT
wdm, 0.2.0, MIT
web-console, 4.2.1, MIT
websocket-driver, 0.7.6, "Apache 2.0"
websocket-extensions, 0.1.5, "Apache 2.0"
zeitwerk, 2.7.1, MIT
```

### yarn licenses list

```markdown
yarn licenses v1.22.21
├─ (CC-BY-4.0 AND OFL-1.1 AND MIT)
│  └─ @fortawesome/fontawesome-free@6.7.1
│     ├─ URL: https://github.com/FortAwesome/Font-Awesome
│     ├─ VendorName: The Font Awesome Team
│     └─ VendorUrl: https://fontawesome.com/
├─ Apache-2.0
│  └─ detect-libc@1.0.3
│     ├─ URL: git://github.com/lovell/detect-libc
│     └─ VendorName: Lovell Fuller
├─ BSD-3-Clause
│  └─ source-map-js@1.2.1
│     ├─ URL: https://github.com/7rulnik/source-map-js.git
│     ├─ VendorName: Valentin 7rulnik Semirulnik
│     └─ VendorUrl: https://github.com/7rulnik/source-map-js
└─ MIT
   ├─ @esbuild/win32-x64@0.24.0
   │  └─ URL: git+https://github.com/evanw/esbuild.git
   ├─ @parcel/watcher-win32-x64@2.5.0
   │  └─ URL: https://github.com/parcel-bundler/watcher.git
   ├─ @parcel/watcher@2.5.0
   │  └─ URL: https://github.com/parcel-bundler/watcher.git
   ├─ @rails/ujs@7.1.501
   │  ├─ URL: https://github.com/rails/rails.git
   │  └─ VendorUrl: https://rubyonrails.org/
   ├─ audiojs@0.1.0
   ├─ bootswatch@5.3.3
   │  ├─ URL: git+https://github.com/thomaspark/bootswatch.git
   │  ├─ VendorName: Thomas Park
   │  └─ VendorUrl: https://bootswatch.com/
   ├─ braces@3.0.3
   │  ├─ URL: https://github.com/micromatch/braces.git
   │  ├─ VendorName: Jon Schlinkert
   │  └─ VendorUrl: https://github.com/micromatch/braces
   ├─ chokidar@4.0.1
   │  ├─ URL: git+https://github.com/paulmillr/chokidar.git
   │  ├─ VendorName: Paul Miller
   │  └─ VendorUrl: https://github.com/paulmillr/chokidar
   ├─ esbuild@0.24.0
   │  └─ URL: git+https://github.com/evanw/esbuild.git
   ├─ fill-range@7.1.1
   │  ├─ URL: https://github.com/jonschlinkert/fill-range.git
   │  ├─ VendorName: Jon Schlinkert
   │  └─ VendorUrl: https://github.com/jonschlinkert/fill-range
   ├─ immutable@5.0.3
   │  ├─ URL: git://github.com/immutable-js/immutable-js.git
   │  ├─ VendorName: Lee Byron
   │  └─ VendorUrl: https://immutable-js.com/
   ├─ is-extglob@2.1.1
   │  ├─ URL: https://github.com/jonschlinkert/is-extglob.git
   │  ├─ VendorName: Jon Schlinkert
   │  └─ VendorUrl: https://github.com/jonschlinkert/is-extglob
   ├─ is-glob@4.0.3
   │  ├─ URL: https://github.com/micromatch/is-glob.git
   │  ├─ VendorName: Jon Schlinkert
   │  └─ VendorUrl: https://github.com/micromatch/is-glob
   ├─ is-number@7.0.0
   │  ├─ URL: https://github.com/jonschlinkert/is-number.git
   │  ├─ VendorName: Jon Schlinkert
   │  └─ VendorUrl: https://github.com/jonschlinkert/is-number
   ├─ jquery-ujs@1.2.3
   │  ├─ URL: https://github.com/rails/jquery-ujs.git
   │  └─ VendorUrl: https://github.com/rails/jquery-ujs#readme
   ├─ jquery@3.7.1
   │  ├─ URL: https://github.com/jquery/jquery.git
   │  ├─ VendorName: OpenJS Foundation and other contributors
   │  └─ VendorUrl: https://jquery.com/
   ├─ micromatch@4.0.8
   │  ├─ URL: https://github.com/micromatch/micromatch.git
   │  ├─ VendorName: Jon Schlinkert
   │  └─ VendorUrl: https://github.com/micromatch/micromatch
   ├─ node-addon-api@7.1.1
   │  ├─ URL: git://github.com/nodejs/node-addon-api.git
   │  └─ VendorUrl: https://github.com/nodejs/node-addon-api
   ├─ picomatch@2.3.1
   │  ├─ URL: https://github.com/micromatch/picomatch.git
   │  ├─ VendorName: Jon Schlinkert
   │  └─ VendorUrl: https://github.com/micromatch/picomatch
   ├─ pygments-rouge-css@0.1.0
   │  ├─ URL: git+https://github.com/zslucky/pygments-css.git
   │  ├─ VendorName: lucky zhou
   │  └─ VendorUrl: https://github.com/richleland/pygments-css#readme
   ├─ readdirp@4.0.2
   │  ├─ URL: git://github.com/paulmillr/readdirp.git
   │  ├─ VendorName: Thorsten Lorenz
   │  └─ VendorUrl: https://github.com/paulmillr/readdirp
   ├─ sass@1.83.0
   │  ├─ URL: https://github.com/sass/dart-sass
   │  ├─ VendorName: Natalie Weizenbaum
   │  └─ VendorUrl: https://github.com/sass/dart-sass
   └─ to-regex-range@5.0.1
      ├─ URL: https://github.com/micromatch/to-regex-range.git
      ├─ VendorName: Jon Schlinkert
      └─ VendorUrl: https://github.com/micromatch/to-regex-range
Done in 0.21s.
```

※ 更新: 2024/12/15
