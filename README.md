#Attix.us


项目部署文档
项目源码地址：https://github.com/parano/attix.us


1 Dependencies

* Ruby Language
  ruby 1.9.3
* Rails Version
  Rails 3.1.3
* MongoDB
  MongoDB v2.0.1
* Redis
  Redis server version 2.4.2

2 Deploy

You need to install Ruby 1.9.3, Rubygems and Rails 3.3 first.
Install and start MongoDB, Redis, Python, Pygments.

* ``` bundle exec rake sunspot:solr:start ``` to start the solr full-text search engine
* ```rake db:populate``` to make sample data into the database
* ```rails s``` to start the webrick web servers





