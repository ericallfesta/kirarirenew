(function(){
  window.Kirari.Views.SearchBrandsByKanaView = Backbone.View.extend({
    el: '#search-by-kana'
  , target: 'ul.brands'
  , initialize: function (options) {
      if ( typeof this.collection == 'undefined' ) {
        this.collection = new Kirari.Collections.BrandsCollection()
      }
      this.collection.on('reset', this.render, this)
      this.collection.on('add', this.addOne, this)
      this.on("update:kana", this.updateKana, this)
      this.on("update", this.update, this)

      if (options && options.initial) {
        this.setKana(options.initial)

        if (options.brand) this.selectedId = options.brand
      }
      else {
        this.collection.fetch({ reset: true })
      }
    }
  , selectedKana: undefined
  , selectedId: undefined
  , events: {
      'click .kana .word': 'clickKana'
    , 'click .search_item': 'clickBrand'
    }
  , render: function () {
      $(this.target).empty()
      this.collection.each(_.bind(this.addOne, this))

      if (this.selectedId) {
        this.setBrand(this.selectedId, false)
      }
    }
  , clickKana: function (event) {
      event.preventDefault()
      event.stopPropagation()
      this.setKana($(event.target).text())
    }
  , setKana: function (kana) {
      $('.kana .active').removeClass('active');
      $('.kana [data-kana=' + kana + ']').addClass('active');
      this.selectedKana = kana
      this.trigger("update:kana")
    }
  , clickBrand: function (event) {
      event.preventDefault()
      event.stopPropagation()
      this.setBrand($(event.target).attr('data-id'))
    }
  , setBrand: function (brand_id, update) {
      if (typeof update === 'undefined') update = true
      var $li = $('.brands [data-id=' + brand_id + ']').closest('li')
      if (! $li.length) return;

      this.selectedId = brand_id
      if (update) this.trigger("update", this)
      $('.brands .active').removeClass('active');
      $li.addClass('active');
    }
  , update: function () {
    }
  , updateKana: function () {
      this.collection.fetch({ reset: true, data: { kana: this.selectedKana } })
    }
  , addOne: function (model) {
      view = new Kirari.Views.SearchBrandsResultItemView({ model: model })
      $(this.target).append(view.el)
    }
  })
}).call(this)
