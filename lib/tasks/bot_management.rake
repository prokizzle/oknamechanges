require 'highline/import'
namespace :bots do
  task :add => :environment do
    puts Bot.create(
      username: ask('username: '),
      password: ask('password: '){ |q| q.echo = '*' }
    )
  end

  task :health_check => :environment do
    BotHealthCheckWorker.perform_async
  end
end
