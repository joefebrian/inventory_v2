require 'rubygems'
require 'active_record'
require 'populator'
require 'faker'
namespace :db do
  namespace :populate do

    desc "Populate company data if none exists"
    task :company => :environment do
      if Company.first.nil?
        Company.create(:name => "Monster Inc.",
                       :subdomain => "monsterinc",
                       :phone => Faker::PhoneNumber.phone_number,
                       :address => "#{Faker::Address::street_address}, #{Faker::Address::city}")
      end
    end

    desc "Populate category data"
    task :category => :environment do
      Category.connection.execute('TRUNCATE TABLE categories')
      comp = Company.first
      10.times do |cat|
        cat = Category.new
        cat.company_id = comp.id
        cat.name = Populator.words(2..3).titleize
        cat.code = cat.name.split.collect {|t| t[0...1]}.join
        cat.description = Populator.words(5..10)
        cat.save(false)
        cat.move_to_root
      end
      max_id = Category.last.id
      Category.all.each do |cat|
        rand(10).times do |i|
          sub = Category.new
          sub.company_id = comp.id
          sub.name = Populator.words(2..3).titleize
          sub.code = cat.name.split.collect {|t| t[0...1]}.join
          sub.description = Populator.words(5..10)
          sub.save(false)
          parent_id = rand(max_id)
          parent_id = 1 if parent_id.zero?
          sub.move_to_child_of(Category.find(parent_id))
        end
      end
    end
  end
end
