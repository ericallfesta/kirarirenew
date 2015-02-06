# Kirari Conding Guideline

## Backbone & JavaScripts

### Directory

- views, models, collections, routes, tampltes が backbone 以下に設置される。
- ファイル名とその中で定義されるクラス名は、`filename.classify == class_name` とする。
	- `sample_view.js => SampleView`
- Router は Rails Controller と 1:1 対応する。
	- `DiariesController => DiariesRouter`
- Rails Controller の名称から Router の存在確認を行い、自動で初期化処理が行われる。
	- See: `app/assets/javascripts/application.js`
	- See: `app/views/layout/application.html.erb`
	- 例えば DiariesController の場合、DiariesRouter のインスタンスが自動生成され、`Backbone.history.start()` まで行われる。

### Comment Rules

- http://yui.github.io/yuidoc/ を参考につけている。
- 将来的に YUI Documentation Tool を導入するかどうかについては未定。
- コメントはできるだけつける。できるだけ。

### Script Order

- Backbone クラスを継承した任意のクラスは、以下の順番にコードを書く。
	1. プロパティ
	2. Backbone で標準的に使われるメソッド
	3. 独自のメソッド
	4. クラス自身が使うユーティリティメソッド

~~~~
(function(){
	window.Kirari.Views.SampleView = Backbone.View.extend({
		// ---- Property ----

		// ---- Backbone methods ----

		// ---- Original methods ----
		
		// ---- Utility methods ----
	})
}).call(this);
~~~~

- ユーティリティメソッドの先頭には Underscore (`_`) をつける。
- ユーティリティメソッドはイベントにバインドせず、かつ外部からコールしない。

## HTML & CSS

### .active Class

- .active クラスは「その要素がアクティブである」ことを示す。
- JS によってアクティブ／非アクティブが切り替えられるような要素に設定される。

### .xxx-list Class & .item Class

- .xxx-list は「何か」の一覧に付与される。例えば、商品一覧には .products-list が付与される。
- 基本的に一覧にしか付与されない。（縦に要素が並んでいることを想定している）
- 子要素・一つ一つの項目が .item クラスを持つ。
- 横並びのリストは .xxx-bricks とする。
- list.css.scss に定義される。

## Rails View and Flash

- `flash[:notice]` が存在する場合、 `app/views/layout/application.html.erb` 内部で `#global-notice` としてレンダリングされる。`flash[:notice]` の内容は一行を想定している。
- フォームのエラー表示は各フォームのビューに委ねられる。
