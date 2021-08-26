# coding: utf-8
categories = [
    { id: 1, category_name: '未登録'},
    { category_name: 'ミステリー' }, 
    { category_name: 'ファンタジー' },
    { category_name: '歴史' },
    { category_name: 'サスペンス' },
    { category_name: 'ホラー' },
]

feeling_categories = [
    { id: 1, feeling_after_reading: '未登録'},
    { feeling_after_reading: '優しい' }, 
    { feeling_after_reading: '辛い' },
    { feeling_after_reading: '分かりやすい' },
    { feeling_after_reading: 'ハラハラ' },
    { feeling_after_reading: '怖い' },
]

Category.where(user_id: nil).destroy_all

Category.create(categories)


FeelingCategory.where(user_id: nil).destroy_all

FeelingCategory.create(feeling_categories)
