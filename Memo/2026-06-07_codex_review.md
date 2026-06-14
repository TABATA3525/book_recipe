# Categories機能 コードレビュー結果

レビュー日時: 2026-06-07

## 概要

* コード変更: なし
* Critical: なし
* Warning: 5件
* Suggestion: 6件

---

# Critical

該当なし

---

# Warning

## 1. update時のバリデーションエラーで500になる可能性

**対象**

* `app/controllers/categories_controller.rb:16`

**内容**

更新処理で `save!` を使用しているため、空文字や重複名などのバリデーションエラーが発生すると例外が発生し、500エラーになる可能性がある。

**推奨対応**

`create` と同様に失敗時のハンドリングを実装する。

```ruby
render :index, status: :unprocessable_entity
```

---

## 2. Turboキャッシュ復元時のVue再初期化問題

**対象**

* `app/frontend/entrypoints/modal_vue.js:16`
* `app/frontend/entrypoints/modal_vue.js:23`

**内容**

`data-vue-mounted` を利用した初期化制御は、Turboのキャッシュ復元時に問題になる可能性がある。

TurboのSnapshotにはDOM属性が保存されるが、Vueのイベントリスナーは復元されないため、

* 戻る
* 進む

操作後に「カテゴリーを追加する」ボタンが反応しなくなる可能性がある。

**推奨対応**

`turbo:before-cache` イベントでVueを `unmount` する設計を検討する。

---

## 3. 作成エラー時はTurbo再描画ではない

**対象**

* `app/views/categories/index.html.erb:35`

**内容**

フォームに

```erb
data: { turbo: false }
```

が設定されているため、作成失敗時の

```ruby
render :index
```

はTurboによる描画ではなく通常のフルページロードになる。

そのためVueは通常のページロードとして再初期化される。

**補足**

「Turboでrender後にVueが再初期化されるか」の検証対象にはならない。

---

## 4. category_id許可によるUnknownAttributeErrorの可能性

**対象**

* `app/controllers/categories_controller.rb:23`
* `app/controllers/categories_controller.rb:47`

**内容**

`Category.new(categories_params)` において、Strong Parametersで `category_id` が許可されている。

しかし `categories` テーブルには `category_id` カラムが存在しないため、

```ruby
UnknownAttributeError
```

が発生する可能性がある。

**推奨対応**

作成用と更新用でStrong Parametersを分離する。

---

## 5. Bootstrap Navbarが動作しない可能性

**対象**

* `app/views/layouts/application.html.erb:30`

**内容**

Bootstrap Collapse を使用しているが、レビュー範囲ではBootstrap JavaScriptの読み込みが確認できなかった。

**影響**

モバイル表示時のNavbar Toggleボタンが動作しない可能性がある。

---

# Suggestion

## 1. 変数名の命名規則

**対象**

* `app/controllers/categories_controller.rb:6`
* `app/controllers/categories_controller.rb:7`

**内容**

```ruby
@defaultCategories
```

よりも

```ruby
@default_categories
```

の方がRails/Rubyの慣習に沿っている。

---

## 2. current_user.categoriesの利用

**対象**

* `app/controllers/categories_controller.rb:7`

**内容**

現在の記述よりも

```ruby
current_user.categories.order(:id)
```

の方がRailsらしく意図が明確。

---

## 3. Rubyインデント

**対象**

* `app/models/category.rb:4`

**内容**

4スペースインデントになっている。

Rails標準は2スペース。

---

## 4. category-buttonの重複定義

**対象**

* `app/assets/stylesheets/custom.scss:480`
* `app/assets/stylesheets/custom.scss:490`

**内容**

`.category-button` が複数箇所で定義されている。

**推奨対応**

1箇所に統合して管理する。

---

## 5. data-turbolinksはTurbo Railsでは無効

**対象**

* `app/views/categories/index.html.erb:48`
* `app/views/layouts/application.html.erb:40`

**内容**

```erb
data-turbolinks
```

はTurbo Railsでは機能しない。

Turboを無効化したい場合は

```erb
data: { turbo: false }
```

を使用する。

---

## 6. N+1問題

**結果**

今回の差分範囲ではN+1問題は確認されなかった。

理由:

* `@categories.each`
* 関連モデル参照なし

のため、追加クエリは発生しない。

---

# 優先対応案

1. update時のsave!による500エラー対策
2. category_id許可の見直し
3. Turbo + Vueのキャッシュ復元問題の確認
4. Bootstrap JavaScript読込確認
5. 命名規則・SCSS整理などのリファクタリング
