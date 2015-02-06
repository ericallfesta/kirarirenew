stamps = {
  'register_kirari' => {
    label: 'Kirariに会員登録',
    description: '',
    point: 10
  },
  'followed_3_users' => {
    label: 'ユーザを３人以上をフォローする',
    description: '',
    point: 10
  },
  'followed_1_brand' => {
    label: 'ブランドをフォローする',
    description: '',
    point: 10
  },
  'write_profile' => {
    label: 'プロフィールの入力する',
    description: '',
    point: 10
  },
  'write_diary' => {
    label: '日記を書く',
    description: '',
    point: 10
  },
  'write_report' => {
    label: '商品にレポート・評価をつける',
    description: '',
    point: 10
  },
  'write_question' => {
    label: '商品に関する質問をする',
    description: '',
    point: 10
  },
  'write_comment_for_question' => {
    label: '質問に返答をする',
    description: '',
    point: 10
  },
  'write_comment_for_diary' => {
    label: '他ユーザーの日記にコメントをする',
    description: '',
    point: 10
  },
  'send_kirari_for_product' => {
    label: '商品にキラリを贈る',
    description: '',
    point: 10
  },
  'send_kirari_for_diary' => {
    label: '日記にキラリを贈る',
    description: '',
    point: 10
  },
  'try_search' => {
    label: '検索機能を使ってみる',
    description: '',
    point: 10
  },
  # 未実装機能なのでコメントアウト
  # 'apply_campaign' => {
  #   label: 'キャンペーンに応募する',
  #   description: '',
  #   image: nil,
  #   point: 10
  # },
  # 'invite_friend' => {
  #   label: '友人をKirariへ招待する',
  #   description: '',
  #   image: nil,
  #   point: 10
  # },
  # '' => {
  #   label: '未登録の商品を報告する',
  #   description: '',
  #   image: nil,
  #   point: 10
  # }
}

stamps.each do |slug, s|
  stamp = Stamp.where(slug: slug).first_or_create label: s[:label], description: s[:description], point: s[:point]
end
