namespace :db do
  desc 'Fill database with sample data'
  task :populate => :environment do
    Rake::Task['db:drop'].invoke
    make_users
    make_nodes
    make_posts
    make_comments
  end


  def make_users
    User.create!(:email => 'parano@qq.com',
                 :name => 'parano',
                 :password => 'password',
                 :password_confirmation => 'password')

    99.times do |n|
      puts n
      name = Faker::Name.first_name
      email = "example-#{n}@gmail.com"
      password = "password"
      User.create!(:email => email,
                   :name => name,
                   :password => password,
                   :password_confirmation => password )
    end
  end

  def make_nodes
    puts 'nodes'
    ['Ruby','Python','NoSQL','MySQL','SoftwareEngineering',
     'Java','C++','Database','NodeJS','Matlab'].each do |item|
      Node.create!(:title => item)
     end
  end


  def make_posts
    User.all.each do |user|
      puts user.id
      10.times do
        print 'posts'
        raw_content = Faker::Lorem.sentence(500)
        title = Faker::Lorem.sentence(3)
        node_id = Node.all[(rand()*10).to_i].id
        post = Post.new(:title => title,
                        :raw_content =>  raw_content)
        post.user_id = user.id
        post.node_id = node_id
        post.save!
      end
    end
  end

  def make_comments
    User.all.each do |user|
      raw_content = Faker::Lorem.sentence(50)
      puts user.id
      30.times do
        print 'comments'
        post = Post.all[(rand()*1000).to_i]
        comment = post.comments.build(:raw_content => raw_content)
        comment.user_id = user.id
        comment.save!
      end
    end
  end


end
