Array::uniq = ->
  output = {}
  output[@[key]] = @[key] for key in [0...@length]
  value for key, value of output

$ ->
  # 管理画面のタグ付け関連の処理
  find_active_tags = ->
    active_tags = []
    $('.tags a.label.active').each ->
      active_tags.push($(this).attr('href').substr(1))
    active_tags.uniq()

  $('.tags a.label.label-tag').on 'click', ->
    if $(this).hasClass('active')
      $('.tags a.label.label-tag[href=#' + $(this).attr('href').substr(1) + ']').removeClass 'active'
      $(this).removeClass 'active'
    else
      $('.tags a.label.label-tag[href=#' + $(this).attr('href').substr(1) + ']').addClass 'active'
      $(this).addClass 'active'
    $('input[type="hidden"]#product_tags').val(find_active_tags().join(','))
    false

  # カテゴリのセレクトボックスの中身を書き換える処理
  $('.categories select').on 'change', ->
    el = $(this)
    return unless el.val()
    $.ajax
      url: '/categories.json'
      method: 'get'
      data:
        parent: el.val()
      success: (res) ->
        options = ['<option value=""
        ></option>']
        options.push('<option value="' + r['id'] + '">' + r['name'] + '</option>') for r in res
        level = parseInt(el.attr('data-level'))
        target = $('select[data-level=' + (level + 1) + ']')
        $('select[data-level=' + (i + 1) + ']').empty() for i in [level..4]
        $('select[data-level=' + (level + 1) + ']').append(options)

  # モーダルウィンドウをHTML属性だけで再利用する
  # data-title : モーダルウィンドウのタイトルになるテキスト
  # data-body : モーダルウィンドウの本文に入るテキストが出力されているエレメントへのセレクタ
  $('#modal-generic').on 'show.bs.modal', (e) ->
    $from = $(e.relatedTarget)
    $(this).find('.modal-title').html($from.data('title'))
    $(this).find('.modal-body').html($($from.data('body')).html())
