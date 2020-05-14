# NaganoCake
長野県にある洋菓子店「ながのCAKE」の商品を販売するECサイト

## 仕様

* 顧客側ページ

* 管理者側ページ


## 実装機能

* 顧客ページ
  * 会員登録・編集・退会
  * 商品閲覧(一覧・詳細)・カートに入れる・注文
  * 商品ジャンル検索
  * 注文履歴確認

* 管理者ページ
  * 商品登録・編集
  * 注文履歴確認（当日分・全ユーザ・ユーザ毎）
  * 会員情報確認

## バージョン

* Ruby 2.5.7

* Rails 5.2.4.2

* SQLite3

* HTML5

* CSS3

* Gem

  * devise

  * bootstrap3

  * refile 

  * refile-mini_magick

  * kaminari

  * jquery-rails

  * data-confirm-modal

  * pry-byebug

## 導入方法

```
$ git clone git@github.com:dwc-pillows/nagano_cake.git

$ cd nagano_cake

$ rails db:migrate

$ rails db:seed

$ bundle install

$ rails s -b 0.0.0.0
```

管理者ページへのログイン<br>
メールアドレス： admin@admin.com<br>
パスワード： password

テスト用デフォルトユーザー3人<br>
メールアドレス： test1@test.com/test2@test.com/test3@test.com
パスワード： password

上記のコマンド入力後 http://localhost:3000/ をお使いのブラウザに入力してアクセスしてください。