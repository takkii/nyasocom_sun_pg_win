### 仕様の説明

```markdown
# 検証済: 開発環境
・ Windows11 pro
・ Docker
・ Nginx
```

```markdown
# 環境構築: 前提条件
git clone git@github.com:takkii/nyasocom_sun_pg_win.git
cd nyasocom_sun_pg_win
bundle update
yarn install
yarn build
yarn build:css
```



※ 環境構築前提条件を満たすこと、リアルタイム顔認識システムでログを書き出すこと。

#### ログイン

| [ユーザ側](http://localhost/users/sign_in) | [管理者側](http://localhost/admins/sign_in) |
| :----------------------------------------: | :-----------------------------------------: |

#### Docker側

```sql
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

```ruby
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

```ruby
# データセット

docker-compose exec web rails db:default_db

# データ入れ直し

docker-compose exec web rails db:environment:set RAILS_ENV=development
docker-compose exec web rails db:pg_default_db

# adminとuserのメールアドレスとパスワードを入れる。
rails c / docker-compose exec web rails c
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

```ruby
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
```
#### 証明書

```shell
# use scoop
scoop install mkcert

# 管理者権限で実行
mkcert --install
mkcert --uninstall

# localhost
mkcert localhost
```

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



> hyokaprojectでリアルタイム顔認識を行う → ログを書き出す
>
> nyasocom_sun_pg_winを起動する → 3段階認証確立完了✅️

### .env：設定

- [x] Windows 11 pro 25H2/ruby-3.4.9/pgroonga-4.0.6で動作を確認しました。

```ruby
# postgresユーザ
DATABASE_USER = "takkii"
# postgresユーザ、パスワード
DATABASE_PASSWORD = "20070920"
# 名無しの権兵衛: John Doe
EQUAL_PASSWORD = "Doe"
# 設定: ./ファイル名.txt
MEMBERS_CARD = "~/hyokaproject/"
# カード名: ファイル名
CARD_NAME = "effect.txt"
# バージョン情報: x.x
NYASOCOMSUN_VERSION = "3.2"
# サーキットブレーカー: 失敗回数
FAILURE_NUMBER = "3"
# サーキットブレーカー: 分数を秒計算
WITHIN = "60"
```

[golden-eagle](https://github.com/takkii/golden_eagle/tree/main/wiki)を参考に、flare/meteorなどを使いeffect.txtを生成しclarifyで出力結果を確認してください。

_※ にゃそこん参ぴーじるんがを起動する前に、上記手順を行って下さい。_

#### RubyGems: 依存ライブラリのライセンス一覧

> license_finder

```ruby
Dependencies that need approval:
@cspotcode/source-map-support, 0.8.1, MIT
@esbuild/win32-x64, 0.28.0, MIT
@fortawesome/fontawesome-free, 7.2.0, "(CC-BY-4.0 AND OFL-1.1 AND MIT)"
@jridgewell/resolve-uri, 3.1.2, MIT
@jridgewell/sourcemap-codec, 1.5.5, MIT
@jridgewell/trace-mapping, 0.3.9, MIT
@parcel/watcher, 2.5.6, MIT
@parcel/watcher-win32-x64, 2.5.6, MIT
@rails/ujs, 7.1.600, MIT
@tsconfig/node10, 1.0.12, MIT
@tsconfig/node12, 1.0.11, MIT
@tsconfig/node14, 1.0.3, MIT
@tsconfig/node16, 1.0.4, MIT
@types/node, 25.6.0, MIT
acorn, 8.16.0, MIT
acorn-walk, 8.3.5, MIT
action_text-trix, 2.1.18, MIT
actioncable, 8.1.3, MIT
actionmailbox, 8.1.3, MIT
actionmailer, 8.1.3, MIT
actionpack, 8.1.3, MIT
actiontext, 8.1.3, MIT
actionview, 8.1.3, MIT
activejob, 8.1.3, MIT
activemodel, 8.1.3, MIT
activerecord, 8.1.3, MIT
activestorage, 8.1.3, MIT
activesupport, 8.1.3, MIT
addressable, 2.9.0, "Apache 2.0"
arg, 4.1.3, MIT
base64, 0.3.0, "Simplified BSD, ruby"
bcrypt, 3.1.22, MIT
bigdecimal, 4.1.2, "Simplified BSD, ruby"
bindex, 0.8.1, MIT
bootsnap, 1.24.1, MIT
bootswatch, 5.3.8, MIT
builder, 3.3.0, MIT
bundler, 4.0.11, MIT
capybara, 3.40.0, MIT
carrierwave, 3.1.2, MIT
chokidar, 4.0.3, MIT
coderay, 1.1.3, MIT
concurrent-ruby, 1.3.6, MIT
connection_pool, 3.0.2, MIT
crass, 1.0.6, MIT
create-require, 1.1.1, MIT
cssbundling-rails, 1.4.3, MIT
csv, 3.3.5, "Simplified BSD, ruby"
date, 3.5.1, "Simplified BSD, ruby"
detect-libc, 2.1.2, "Apache 2.0"
devise, 4.9.4, MIT
devise-bootstrap-views, 1.1.0, MIT
devise-i18n, 1.15.0, MIT
diff, 4.0.4, "New BSD"
diff-lcs, 1.6.2, "Artistic-1.0-Perl, GPL-2.0-or-later, MIT"
docile, 1.4.1, MIT
dotenv, 3.2.0, MIT
dotenv-rails, 3.2.0, MIT
drb, 2.2.3, "Simplified BSD, ruby"
erb, 6.0.4, "Simplified BSD, ruby"
erubi, 1.13.1, MIT
esbuild, 0.28.0, MIT
factory_bot, 6.5.6, MIT
factory_bot_rails, 6.5.1, MIT
feedjira, 3.2.6, MIT
ffi, 1.17.4, "New BSD"
font-awesome-sass, 6.7.2, MIT
globalid, 1.3.0, MIT
grouse, 1.1.5.2, MIT
httparty, 0.24.2, MIT
i18n, 1.14.8, MIT
image_processing, 1.14.0, MIT
immutable, 5.1.5, MIT
io-console, 0.8.2, "Simplified BSD, ruby"
irb, 1.18.0, "Simplified BSD, ruby"
is-extglob, 2.1.1, MIT
is-glob, 4.0.3, MIT
jbuilder, 2.14.1, MIT
jn-server, 1.0.8, MIT
jquery, 4.0.0, MIT
jquery-ujs, 1.2.3, MIT
jsbundling-rails, 1.3.1, MIT
json, 2.19.5, ruby
kaminari, 1.2.2, MIT
kaminari-actionview, 1.2.2, MIT
kaminari-activerecord, 1.2.2, MIT
kaminari-core, 1.2.2, MIT
kaminari-i18n, 0.5.0, MIT
listen, 3.10.0, MIT
logger, 1.7.0, "Simplified BSD, ruby"
loofah, 2.25.1, MIT
mail, 2.9.0, MIT
make-error, 1.3.6, ISC
marcel, 1.0.4, "Apache 2.0, MIT"
matrix, 0.4.3, "Simplified BSD, ruby"
method_source, 1.1.0, MIT
mini_magick, 5.3.1, MIT
mini_mime, 1.1.5, MIT
minitest, 5.27.0, MIT
msgpack, 1.8.0, "Apache 2.0"
multi_xml, 0.9.0, MIT
net-imap, 0.6.4, "Simplified BSD, ruby"
net-pop, 0.1.2, "Simplified BSD, ruby"
net-protocol, 0.2.2, "Simplified BSD, ruby"
net-smtp, 0.5.1, "Simplified BSD, ruby"
nio4r, 2.7.5, "MIT, Simplified BSD"
node-addon-api, 7.1.1, MIT
nokogiri, 1.19.3, MIT
npm-check-updates, 19.6.6, "Apache 2.0"
observer, 0.1.2, "Simplified BSD, ruby"
orm_adapter, 0.5.0, MIT
ostruct, 0.6.3, "Simplified BSD, ruby"
paranoia, 3.1.0, MIT
pg, 1.6.3, "Simplified BSD"
picomatch, 4.0.4, MIT
pkg-config, 1.6.5, LGPLv2+
pp, 0.6.3, "Simplified BSD, ruby"
prettyprint, 0.2.0, "Simplified BSD, ruby"
prism, 1.9.0, MIT
propshaft, 1.3.2, MIT
pry, 0.16.0, MIT
psych, 5.3.1, MIT
public_suffix, 7.0.5, MIT
puma, 8.0.1, "New BSD"
pycall, 1.5.2, MIT
pygments-rouge-css, 0.1.0, MIT
racc, 1.8.1, "Simplified BSD, ruby"
rack, 3.2.6, MIT
rack-session, 2.1.2, MIT
rack-test, 2.2.0, MIT
rackup, 2.3.1, MIT
rails, 8.1.3, MIT
rails-dom-testing, 2.3.0, MIT
rails-html-sanitizer, 1.7.0, MIT
rails-i18n, 8.1.0, MIT
railties, 8.1.3, MIT
rake, 13.4.2, MIT
rb-fsevent, 0.11.2, MIT
rb-inotify, 0.11.1, MIT
rdoc, 7.2.0, ruby
readdirp, 4.1.2, MIT
redcarpet, 3.6.1, MIT
regexp_parser, 2.12.0, MIT
reline, 0.6.3, ruby
responders, 3.2.0, MIT
rinku, 2.0.6, ISC
rmagick, 7.0.0, MIT
roo, 3.0.0, MIT
rouge, 4.7.0, "MIT, Simplified BSD"
rspec, 3.9.0, MIT
rspec-core, 3.9.3, MIT
rspec-expectations, 3.9.4, MIT
rspec-mocks, 3.9.1, MIT
rspec-rails, 3.9.1, MIT
rspec-support, 3.9.4, MIT
ruby-vips, 2.3.0, MIT
rubyzip, 3.3.0, "Simplified BSD"
sanitize, 7.0.0, MIT
sass, 1.99.0, MIT
sassc, 2.4.0, MIT
sax-machine, 1.3.2, MIT
securerandom, 0.4.1, "Simplified BSD, ruby"
sheltered-girl, 4.0.7.11, MIT
simplecov, 0.22.0, MIT
simplecov-html, 0.13.2, MIT
simplecov_json_formatter, 0.1.4, MIT
source-map-js, 1.2.1, "New BSD"
spring, 4.5.0, MIT
spring-commands-rspec, 1.0.4, MIT
ssrf_filter, 1.5.0, MIT
stimulus-rails, 1.3.4, MIT
stringio, 3.2.0, "Simplified BSD, ruby"
thor, 1.5.0, MIT
timeout, 0.6.1, "Simplified BSD, ruby"
ts-node, 10.9.2, MIT
tsort, 0.2.0, "Simplified BSD, ruby"
turbo-rails, 2.0.23, MIT
typescript, 5.9.3, "Apache 2.0"
tzinfo, 2.0.6, MIT
tzinfo-data, 1.2026.2, MIT
undici-types, 7.19.2, MIT
uri, 1.1.1, "Simplified BSD, ruby"
useragent, 0.16.11, MIT
v8-compile-cache-lib, 3.0.1, MIT
warden, 1.2.9, MIT
wdm, 0.2.0, MIT
web-console, 4.3.0, MIT
websocket-driver, 0.8.0, "Apache 2.0"
websocket-extensions, 0.1.5, "Apache 2.0"
xpath, 3.2.0, MIT
yn, 3.1.1, MIT
zeitwerk, 2.7.5, MIT
```

#### yarn: 依存ライブラリのライセンス一覧

> yarn licenses list

```javascript
yarn licenses v1.22.22
├─ (CC-BY-4.0 AND OFL-1.1 AND MIT)
│  └─ @fortawesome/fontawesome-free@7.2.0
│     ├─ URL: https://github.com/FortAwesome/Font-Awesome
│     ├─ VendorName: The Font Awesome Team
│     └─ VendorUrl: https://fontawesome.com/
├─ Apache-2.0
│  ├─ detect-libc@2.1.2
│  │  ├─ URL: git://github.com/lovell/detect-libc.git
│  │  └─ VendorName: Lovell Fuller
│  ├─ npm-check-updates@19.6.6
│  │  ├─ URL: git+https://github.com/raineorshine/npm-check-updates.git
│  │  ├─ VendorName: Tomas Junnonen
│  │  └─ VendorUrl: https://github.com/raineorshine/npm-check-updates
│  └─ typescript@5.9.3
│     ├─ URL: https://github.com/microsoft/TypeScript.git
│     ├─ VendorName: Microsoft Corp.
│     └─ VendorUrl: https://www.typescriptlang.org/
├─ BSD-3-Clause
│  ├─ diff@4.0.4
│  │  └─ URL: git://github.com/kpdecker/jsdiff.git
│  └─ source-map-js@1.2.1
│     ├─ URL: https://github.com/7rulnik/source-map-js.git
│     ├─ VendorName: Valentin 7rulnik Semirulnik
│     └─ VendorUrl: https://github.com/7rulnik/source-map-js
├─ ISC
│  └─ make-error@1.3.6
│     ├─ URL: git://github.com/JsCommunity/make-error.git
│     ├─ VendorName: Julien Fontanet
│     └─ VendorUrl: https://github.com/JsCommunity/make-error
└─ MIT
   ├─ @cspotcode/source-map-support@0.8.1
   │  └─ URL: https://github.com/cspotcode/node-source-map-support
   ├─ @esbuild/win32-x64@0.28.0
   │  └─ URL: git+https://github.com/evanw/esbuild.git
   ├─ @jridgewell/resolve-uri@3.1.2
   │  ├─ URL: https://github.com/jridgewell/resolve-uri
   │  └─ VendorName: Justin Ridgewell
   ├─ @jridgewell/sourcemap-codec@1.5.5
   │  ├─ URL: git+https://github.com/jridgewell/sourcemaps.git
   │  ├─ VendorName: Justin Ridgewell
   │  └─ VendorUrl: https://github.com/jridgewell/sourcemaps/tree/main/packages/sourcemap-codec
   ├─ @jridgewell/trace-mapping@0.3.9
   │  ├─ URL: git+https://github.com/jridgewell/trace-mapping.git
   │  └─ VendorName: Justin Ridgewell
   ├─ @parcel/watcher-win32-x64@2.5.6
   │  └─ URL: https://github.com/parcel-bundler/watcher.git
   ├─ @parcel/watcher@2.5.6
   │  └─ URL: https://github.com/parcel-bundler/watcher.git
   ├─ @rails/ujs@7.1.600
   │  ├─ URL: https://github.com/rails/rails.git
   │  └─ VendorUrl: https://rubyonrails.org/
   ├─ @tsconfig/node10@1.0.12
   │  └─ URL: https://github.com/tsconfig/bases.git
   ├─ @tsconfig/node12@1.0.11
   │  └─ URL: https://github.com/tsconfig/bases.git
   ├─ @tsconfig/node14@1.0.3
   │  └─ URL: https://github.com/tsconfig/bases.git
   ├─ @tsconfig/node16@1.0.4
   │  └─ URL: https://github.com/tsconfig/bases.git
   ├─ @types/node@25.6.0
   │  ├─ URL: https://github.com/DefinitelyTyped/DefinitelyTyped.git
   │  └─ VendorUrl: https://github.com/DefinitelyTyped/DefinitelyTyped/tree/master/types/node
   ├─ acorn-walk@8.3.5
   │  ├─ URL: https://github.com/acornjs/acorn.git
   │  └─ VendorUrl: https://github.com/acornjs/acorn
   ├─ acorn@8.16.0
   │  ├─ URL: git+https://github.com/acornjs/acorn.git
   │  └─ VendorUrl: https://github.com/acornjs/acorn
   ├─ arg@4.1.3
   │  ├─ URL: https://github.com/zeit/arg.git
   │  └─ VendorName: Josh Junon
   ├─ bootswatch@5.3.8
   │  ├─ URL: git+https://github.com/thomaspark/bootswatch.git
   │  ├─ VendorName: Thomas Park
   │  └─ VendorUrl: https://bootswatch.com/
   ├─ chokidar@4.0.3
   │  ├─ URL: git+https://github.com/paulmillr/chokidar.git
   │  ├─ VendorName: Paul Miller
   │  └─ VendorUrl: https://github.com/paulmillr/chokidar
   ├─ create-require@1.1.1
   │  └─ URL: https://github.com/nuxt-contrib/create-require.git
   ├─ esbuild@0.28.0
   │  └─ URL: git+https://github.com/evanw/esbuild.git
   ├─ immutable@5.1.5
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
   ├─ jn-server@1.0.8
   │  ├─ URL: https://github.com/takkii/json-server.git
   │  ├─ VendorName: Takayuki Kamiyama
   │  └─ VendorUrl: http://pieceof.shop/
   ├─ jquery-ujs@1.2.3
   │  ├─ URL: https://github.com/rails/jquery-ujs.git
   │  └─ VendorUrl: https://github.com/rails/jquery-ujs#readme
   ├─ jquery@4.0.0
   │  ├─ URL: git+https://github.com/jquery/jquery.git
   │  ├─ VendorName: OpenJS Foundation and other contributors
   │  └─ VendorUrl: https://jquery.com/
   ├─ node-addon-api@7.1.1
   │  ├─ URL: git://github.com/nodejs/node-addon-api.git
   │  └─ VendorUrl: https://github.com/nodejs/node-addon-api
   ├─ picomatch@4.0.4
   │  ├─ URL: https://github.com/micromatch/picomatch.git
   │  ├─ VendorName: Jon Schlinkert
   │  └─ VendorUrl: https://github.com/micromatch/picomatch
   ├─ pygments-rouge-css@0.1.0
   │  ├─ URL: git+https://github.com/zslucky/pygments-css.git
   │  ├─ VendorName: lucky zhou
   │  └─ VendorUrl: https://github.com/richleland/pygments-css#readme
   ├─ readdirp@4.1.2
   │  ├─ URL: git://github.com/paulmillr/readdirp.git
   │  ├─ VendorName: Thorsten Lorenz
   │  └─ VendorUrl: https://github.com/paulmillr/readdirp
   ├─ sass@1.99.0
   │  ├─ URL: https://github.com/sass/dart-sass
   │  ├─ VendorName: Natalie Weizenbaum
   │  └─ VendorUrl: https://github.com/sass/dart-sass
   ├─ ts-node@10.9.2
   │  ├─ URL: git://github.com/TypeStrong/ts-node.git
   │  ├─ VendorName: Blake Embrey
   │  └─ VendorUrl: https://typestrong.org/ts-node
   ├─ undici-types@7.19.2
   │  ├─ URL: git+https://github.com/nodejs/undici.git
   │  └─ VendorUrl: https://undici.nodejs.org/
   ├─ v8-compile-cache-lib@3.0.1
   │  ├─ URL: https://github.com/cspotcode/v8-compile-cache-lib.git
   │  └─ VendorName: Andrew Bradley
   └─ yn@3.1.1
      ├─ URL: https://github.com/sindresorhus/yn.git
      ├─ VendorName: Sindre Sorhus
      └─ VendorUrl: sindresorhus.com
Done in 0.27s.
```

#### にゃそこん参ぴーじーうぃんのルーティング

```markdown
 Prefix Verb   URI Pattern                                                                                       Controller#Action
                                                /assets                                                                                           Propshaft::Server
                       new_admin_session GET    /admins/sign_in(.:format)                                                                         admins/sessions#new
                           admin_session POST   /admins/sign_in(.:format)                                                                         admins/sessions#create
                   destroy_admin_session DELETE /admins/sign_out(.:format)                                                                        admins/sessions#destroy
                         admins_sign_out GET    /admins/sign_out(.:format)                                                                        devise/sessions#destroy
                        new_user_session GET    /users/sign_in(.:format)                                                                          users/sessions#new
                            user_session POST   /users/sign_in(.:format)                                                                          users/sessions#create
                    destroy_user_session DELETE /users/sign_out(.:format)                                                                         users/sessions#destroy
                          users_sign_out GET    /users/sign_out(.:format)                                                                         devise/sessions#destroy
                                    root GET    /                                                                                                 top#index
                               top_index GET    /top(.:format)                                                                                    top#index
                           blog_comments DELETE /blog_comments(.:format)                                                                          blog_comments#destroy
                                         POST   /blog_comments(.:format)                                                                          blog_comments#create
                                   users GET    /users(.:format)                                                                                  users#show
                                     top POST   /top(.:format)                                                                                    top#index
                              user_index GET    /user(.:format)                                                                                   user#index
                                    user DELETE /user/:id(.:format)                                                                               user#destroy
                            import_blogs POST   /blogs/import(.:format)                                                                           blogs#import
                                   blogs GET    /blogs(.:format)                                                                                  blogs#index
                                         POST   /blogs(.:format)                                                                                  blogs#create
                                new_blog GET    /blogs/new(.:format)                                                                              blogs#new
                               edit_blog GET    /blogs/:id/edit(.:format)                                                                         blogs#edit
                                    blog GET    /blogs/:id(.:format)                                                                              blogs#show
                                         PATCH  /blogs/:id(.:format)                                                                              blogs#update
                                         PUT    /blogs/:id(.:format)                                                                              blogs#update
                                         DELETE /blogs/:id(.:format)                                                                              blogs#destroy
                                 reblogs GET    /reblogs(.:format)                                                                                reblogs#index
                                comments GET    /comments(.:format)                                                                               comments#index
                                         POST   /comments(.:format)                                                                               comments#create
                             new_comment GET    /comments/new(.:format)                                                                           comments#new
                            edit_comment GET    /comments/:id/edit(.:format)                                                                      comments#edit
                                 comment GET    /comments/:id(.:format)                                                                           comments#show
                                         PATCH  /comments/:id(.:format)                                                                           comments#update
                                         PUT    /comments/:id(.:format)                                                                           comments#update
                                         DELETE /comments/:id(.:format)                                                                           comments#destroy
                            secret_index GET    /secret(.:format)                                                                                 secret#index
                             create_like POST   /like/:id(.:format)                                                                               likes#create
                            destroy_like DELETE /like/:id(.:format)                                                                               likes#destroy
                  two_step_verifications POST   /two_step_verifications(.:format)                                                                 two_step_verifications#create
               new_two_step_verification GET    /two_step_verifications/new(.:format)                                                             two_step_verifications#new
                                         GET    /*unmatched_route                                                                                 application#raise_not_found!
        turbo_recede_historical_location GET    /recede_historical_location(.:format)                                                             turbo/native/navigation#recede
        turbo_resume_historical_location GET    /resume_historical_location(.:format)                                                             turbo/native/navigation#resume
       turbo_refresh_historical_location GET    /refresh_historical_location(.:format)                                                            turbo/native/navigation#refresh
           rails_postmark_inbound_emails POST   /rails/action_mailbox/postmark/inbound_emails(.:format)                                           action_mailbox/ingresses/postmark/inbound_emails#create
              rails_relay_inbound_emails POST   /rails/action_mailbox/relay/inbound_emails(.:format)                                              action_mailbox/ingresses/relay/inbound_emails#create
           rails_sendgrid_inbound_emails POST   /rails/action_mailbox/sendgrid/inbound_emails(.:format)                                           action_mailbox/ingresses/sendgrid/inbound_emails#create
     rails_mandrill_inbound_health_check GET    /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#health_check
           rails_mandrill_inbound_emails POST   /rails/action_mailbox/mandrill/inbound_emails(.:format)                                           action_mailbox/ingresses/mandrill/inbound_emails#create
            rails_mailgun_inbound_emails POST   /rails/action_mailbox/mailgun/inbound_emails/mime(.:format)                                       action_mailbox/ingresses/mailgun/inbound_emails#create
          rails_conductor_inbound_emails GET    /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#index
                                         POST   /rails/conductor/action_mailbox/inbound_emails(.:format)                                          rails/conductor/action_mailbox/inbound_emails#create
       new_rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/new(.:format)                                      rails/conductor/action_mailbox/inbound_emails#new
           rails_conductor_inbound_email GET    /rails/conductor/action_mailbox/inbound_emails/:id(.:format)                                      rails/conductor/action_mailbox/inbound_emails#show
new_rails_conductor_inbound_email_source GET    /rails/conductor/action_mailbox/inbound_emails/sources/new(.:format)                              rails/conductor/action_mailbox/inbound_emails/sources#new
   rails_conductor_inbound_email_sources POST   /rails/conductor/action_mailbox/inbound_emails/sources(.:format)                                  rails/conductor/action_mailbox/inbound_emails/sources#create
   rails_conductor_inbound_email_reroute POST   /rails/conductor/action_mailbox/:inbound_email_id/reroute(.:format)                               rails/conductor/action_mailbox/reroutes#create
rails_conductor_inbound_email_incinerate POST   /rails/conductor/action_mailbox/:inbound_email_id/incinerate(.:format)                            rails/conductor/action_mailbox/incinerates#create
                      rails_service_blob GET    /rails/active_storage/blobs/redirect/:signed_id/*filename(.:format)                               active_storage/blobs/redirect#show
                rails_service_blob_proxy GET    /rails/active_storage/blobs/proxy/:signed_id/*filename(.:format)                                  active_storage/blobs/proxy#show
                                         GET    /rails/active_storage/blobs/:signed_id/*filename(.:format)                                        active_storage/blobs/redirect#show
               rails_blob_representation GET    /rails/active_storage/representations/redirect/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations/redirect#show
         rails_blob_representation_proxy GET    /rails/active_storage/representations/proxy/:signed_blob_id/:variation_key/*filename(.:format)    active_storage/representations/proxy#show
                                         GET    /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format)          active_storage/representations/redirect#show
                      rails_disk_service GET    /rails/active_storage/disk/:encoded_key/*filename(.:format)                                       active_storage/disk#show
               update_rails_disk_service PUT    /rails/active_storage/disk/:encoded_token(.:format)                                               active_storage/disk#update
                    rails_direct_uploads POST   /rails/active_storage/direct_uploads(.:format)                                                    active_storage/direct_uploads#create
```

_※ 更新履歴: 2026/05/04🔄_
