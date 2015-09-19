# tasks for seeding the bots
require 'highline/import'

namespace :seeds do
  task :add => :environment do
    Match.create(name: ask("username: "))
  end

  task :add_from_clipboard => :environment do
    Match.create(name: Clipboard.paste)
  end

  task :clipboard_loop => :environment do
    clipboard_cache = Clipboard.paste
    loop do
      unless Clipboard.paste == clipboard_cache
        Match.create(name: Clipboard.paste)
        puts "Added: #{Clipboard.paste}"
        clipboard_cache = Clipboard.paste
      end
    end
  end
end
