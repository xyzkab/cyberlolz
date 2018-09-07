# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
{
  "uncategorized" => nil
}.each do |name,desc|
  Category.create(name: name, description: desc)
end
{
  "new" => "default post status",
  "readed" => "this post is already readed",
  "backlog" => "this post is interesting and added to queue to be research",
  "published" => "this post is already researched and being blogged",
  "researched" => "this post is being researched",
}.each do |name,desc|
  PostStatus.create(name: name, description: desc)
end