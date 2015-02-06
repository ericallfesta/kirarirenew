BodyPart.create! name: '頭／髪', slug: :head, group_code: :head
BodyPart.create! name: '目／眉', slug: :eyes, group_code: :head
BodyPart.create! name: '歯／唇／口内', slug: :mouth, group_code: :head
BodyPart.create! name: '耳', slug: :ears, group_code: :head
BodyPart.create! name: '鼻', slug: :nose, group_code: :head
BodyPart.create! name: '首／喉', slug: :neck, group_code: :head
BodyPart.create! name: '肌', slug: :skin, group_code: :head

BodyPart.create! name: '呼吸器系', slug: :lung, group_code: :upper
BodyPart.create! name: '消化器系', slug: :stomach, group_code: :upper
BodyPart.create! name: '循環器系', slug: :heart, group_code: :upper
BodyPart.create! name: '肩／背中／腰', slug: :back, group_code: :upper
BodyPart.create! name: '脇／バスト', slug: :chest, group_code: :upper

BodyPart.create! name: '腕', slug: :arms, group_code: :arms
BodyPart.create! name: '手', slug: :hands, group_code: :arms

BodyPart.create! name: '下腹部', slug: :abdomen, group_code: :lower
BodyPart.create! name: '尻', slug: :hips, group_code: :lower
BodyPart.create! name: '脚', slug: :legs, group_code: :lower
BodyPart.create! name: '足', slug: :feet, group_code: :lower

BodyPart.create! name: 'サプリ', slug: :supplements, group_code: :etc
BodyPart.create! name: '食べ物', slug: :foods, group_code: :etc
BodyPart.create! name: 'その他', slug: :etc, group_code: :etc