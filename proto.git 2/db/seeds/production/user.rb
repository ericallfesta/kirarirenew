{
  'tamaki' => {
    name: 'Tamaki Maeda',
    email: 'tmaeda@clustium.com'
  },
  'yuya' => {
    name: 'Yuya Miyazaki',
    email: 'ymiyazaki@clustium.com'
  },
  'shota' => {
    name: 'Shota Nagasaki',
    email: 'snagasaki@clustium.com'
  },
  'ayumi' => {
    name: 'Ayumi Suenari',
    email: 'asuenari@clustium.com'
  },
  'sadamitsu' => {
    name: 'Kenichi Sadamitsu',
    email: 'sadamitsu@kirari.jp'
  },
  'sakai' => {
    name: 'Eriko Sakai',
    email: 'sakai@kirari.jp'
  },
  'matsuura' => {
    name: 'Reiko Matsuura',
    email: 'matsuura@kirari.jp'
  }
}.each do |username, u|
  User.where(username: username).first_or_create(display_name: u[:name], email: u[:email], password: 'secret', password_confirmation: 'secret', range_policy: 'public', role: 'admin', column_writer: true)
end
