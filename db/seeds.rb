# coding: utf-8
categories = [
    { id: 100000, category_name: 'ミステリー' }, 
    { id: 100001, category_name: 'ファンタジー' },
    { id: 100002, category_name: '歴史' },
    { id: 100003, category_name: 'サスペンス' },
    { id: 100004, category_name: 'ホラー' },
    { id: 100005, category_name: '未登録'}
]

feeling_categories = [
    { id: 100000, feeling_after_reading: '優しい' }, 
    { id: 100001, feeling_after_reading: '辛い' },
    { id: 100002, feeling_after_reading: '分かりやすい' },
    { id: 100003, feeling_after_reading: 'ハラハラ' },
    { id: 100004, feeling_after_reading: '怖い' },
    { id: 100005, feeling_after_reading: '未登録'}
]

categories.each do |category|
    Category.where(id: category[:id]).destroy_all
end

Category.create(categories)

feeling_categories.each do |feeling_category|
    FeelingCategory.where(id: feeling_category[:id]).destroy_all
end

FeelingCategory.create(feeling_categories)

