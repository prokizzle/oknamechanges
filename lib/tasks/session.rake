require 'highline/import'
task :login => :environment do
  CrawlSession.create(username: ask('username: '), password: ask('password: '))
end
