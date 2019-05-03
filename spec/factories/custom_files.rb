# == Schema Information
#
# Table name: custom_files
#
#  id          :bigint(8)        not null, primary key
#  path        :string(255)      not null
#  description :string(255)
#

FactoryBot.define do
  factory :default_custom_file, class: Category do
    path { 'dummy.txt' }
    description { 'description1' }
    initialize_with { CustomFile.find_or_create_by(path: path) }
  end
end
