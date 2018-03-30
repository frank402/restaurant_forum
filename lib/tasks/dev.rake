namespace :dev do
  task fake: :environment do
    Restaurant.destroy_all

    100.times do |_i|
      Restaurant.create!(name: FFaker::Name.first_name,
                         opening_hours: FFaker::Time.datetime,
                         tel: FFaker::PhoneNumber.short_phone_number,
                         address: FFaker::Address.street_address,
                         description: FFaker::LoremCN.word,
                         category: Category.all.sample)
    end
    puts 'have created fake restaurants'
    puts "now you have #{Restaurant.count} restaurants data"
  end

  task fake_user: :environment do
    20.times do |_i|
      user_name = FFaker::Name.first_name
      User.create!(
        name: user_name,
        email: "#{user_name}@example.com",
        password: '12345678'
      )
    end
    puts 'have created fake users'
    puts "now you have #{User.count} users data"
  end

  task fake_comment: :environment do
    Comment.destroy_all
    Restaurant.all.each do |restaurant|
      3.times do |_i|
        restaurant.comments.create!(
          content: FFaker::Lorem.sentence,
          user: User.all.sample
        )
      end
    end
    puts 'have created fake comments'
    puts "now you have #{Comment.count} comment data"
  end

  task fake_all: :environment do
    Rake::Task['db:migrate'].execute
    Rake::Task['db:seed'].execute
    Rake::Task['dev:fake_restaurant'].execute
    Rake::Task['dev:fake_user'].execute
    Rake::Task['dev:fake_comment'].execute
    #看還有甚麼fake都能放進來
  end

end
