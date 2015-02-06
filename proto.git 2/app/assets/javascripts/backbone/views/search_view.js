(function(){
  window.Kirari.Views.SearchView = Backbone.View.extend({
    conditionPanels: ["brands", "categories", "query", "bodymap"]
  , el: '#search'
  , initialize: function() {
      this.bind("update", this.update, this)
      this.collection.on('reset', this.render, this)

      this.pagination = this.$('#search-pagination')
      this.queries = this.$('#search-queries')
      this.conditions = this.$("#search-conditions")
      this.results = this.$("#search-results")

      this.initializeData()
      this.initializeCategoryHierarchyList()
      this.initializeSearchByKana()
      this.initializeSearchQuery()
      this.initializeBodymap()
      this.setHashchangeActions()
      this.render()

      if ( location.hash.substring(1) ) this.update()
    }
  , initializeCategoryHierarchyList: function () {
      var categoryHierarchyList = {}
        , self = this
      $('.category-hierarchy').each(function() {
        var view = new Kirari.Views.CategoryHierarchyView({
          el: this,
          collection: new Kirari.Collections.CategoriesCollection(),
        })
        view.on("rendered", self.render, self)
        view.on("update", self.categorySelect, self)
        categoryHierarchyList[view.level] = view
      })
      _.each(categoryHierarchyList, function(view) {
        view.child = categoryHierarchyList[view.level+1]
      })
    }
  , initializeSearchByKana: function () {
      var brandsByKana = new Kirari.Views.SearchBrandsByKanaView({
        initial: this.data.initial
      , brand: this.data.brand
      })

      brandsByKana.on("update", this.brandSelect, this)
    }
  , initializeSearchQuery: function () {
      var view = new Kirari.Views.SearchQueryView({
        q: this.data.q
      })
      view.on("update", this.queryInput, this)
    }
  , initializeBodymap: function () {
      var view = new Kirari.Views.SearchBodymapView()
      view.on("update", this.tagSelect, this)
    }
  , initializeData: function () {
      if ( ! location.hash.substring(1) ) return;

      var search = decodeURIComponent(location.hash.substring(1))
      this.data = ( search ? JSON.parse('{"' + search.replace(/&/g, '","').replace(/=/g,'":"') + '"}', function(key, value) { return key===""?value:decodeURIComponent(value) }) : this.data )

      if ( this.data.hasOwnProperty("brand") ) {
        this.hideCondition(function(c) { return _.filter(c, function(v) { return v != 'brands' }) })
      }
      else if ( this.data.hasOwnProperty("category") ) {
        this.hideCondition(function(c) { return _.filter(c, function(v) { return v != 'categories' }) })
      }
      else if ( this.data.hasOwnProperty("tag") ) {
        this.hideCondition(function(c) { return _.filter(c, function(v) { return v != 'bodymap' }) })
      }
      else if ( this.data.hasOwnProperty("q") ) {
        this.hideCondition(function(c) { return _.filter(c, function(v) { return v != 'query' }) })
      }
    }
  , setHashchangeActions: function () {
    $(window).on('hashchange', _.bind(function () {
      if (location.hash.substring(1) == '') this.clearSearchResult()
      else this.initializeData()
    }, this))
  }

  , data: { page: 1 }
  , sample: function () { console.log("ok") }
  , events: {
      'click .page-item': 'pageSelect',
      'click .report-target #search-results .item a': 'transitToFrom'
    }
  , render: function () {
      if ( typeof this.pagination != 'undefined' ) { this.renderPagenation() }
      this.renderQuery()
      this.renderResults()
      this.delegateEvents()
    }
  , renderPagenation: function () {
      this.pagination.empty()
      for ( var i = 1; i < this.collection.pages; i++ ) {
        if ( this.data.page == i ) {
          this.pagination.append('<span class="page current">'+i+"</span>")
        } else {
          this.pagination.append('<span class="page"><a href="#" class="page-item" data-page="'+i+'">'+i+"</a></span>")
        }
      }
    }
  , renderQuery: function () {
      this.queries.empty()
      for ( var i in this.collection.queries ) {
        var label = this.collection.queries[i]
        this.queries.append('<li class="tag no-link">'+label+'</li> ')
      }
    }
  , renderResults: function () {
      if ( this.collection.size() > 0 || _.size(this.collection.queries) > 0 ) {
        this.results.show()
      } else {
        this.results.hide()
      }
    }
  , hideCondition: function (target) {
      if ( typeof target == "undefined" ) { target = "all" }
      if ( target == "all" ) {
        _.each(this.conditionPanels, _.bind(this.hideCondition, this))
      } else if ( typeof target == "function" ) {
        _.each(target(this.conditionPanels), _.bind(this.hideCondition, this))
      } else {
        var panel = this.getConditionsPanel(target)
        if ( typeof panel != 'undefined' ) { panel.slideUp('fast') }
      }
    }
  , clearSearchResult: function () {
    this.collection.queries = {}
    this.collection.reset()
    $('.content-panel', this.conditions).show()
    this.renderResults()
  }
  , getConditionsPanel: function (target) {
      if ( target == "categories" ) { return this.$('#search-by-categories') }
      if ( target == "bodymap" ) { return this.$("#search-by-bodymap") }
      if ( target == "brands" ) { return this.$("#search-by-kana") }
      if ( target == "query" ) { return this.$("#search-by-query") }
    }
  , pageSelect: function(event) {
      event.preventDefault()
      event.stopPropagation()
      this.data.page = $(event.target).attr("data-page")
      this.trigger("update")

      // scroll
      $(document).scrollTop($('#search-queries').offset().top - 10)
    }
  , categorySelect: function(view) {
      this.data = {
        category: view.selectedId
      , page: 1
      }
      var kind = view.kind
      this.hideCondition(function(c) { return _.filter(c, function(v) { return v != kind }) })
      this.trigger("update")
    }
  , tagSelect: function(view) {
      this.data = {
        tag: view.selectedId
      , page: 1
      }
      var kind = view.kind
      this.hideCondition(function(c) { return _.filter(c, function(v) { return v != kind }) })
      this.trigger("update")
    }
  , queryInput: function (view) {
      this.data = {
        q: view.q
      , page: 1
      }
      this.hideCondition(function(c) { return _.filter(c, function(v) { return v != 'query' }) })
      this.trigger("update")
    }
  , brandSelect: function(view) {
      this.data = {
        initial: view.selectedKana
      , brand: view.selectedId
      , page: 1
      }
      this.hideCondition(function(c) { return _.filter(c, function(v) { return v != 'brands' }) })
      this.trigger("update")
    }
  , update: function() {
      if ( typeof this.collection != 'undefined' ) {
        this.collection.fetch({ reset: true, data: this.data })
        location.hash = $.param(this.data)
      }
    }
  , transitToFrom: function(event) {
      var target = event.currentTarget
      location.href = '/reports/new?product_id=' + $(target).data('id') // TODO: use new_report_path

      event.preventDefault()
      event.stopPropagation()
    }
  })
}).call(this)
