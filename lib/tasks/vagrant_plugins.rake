namespace :vagrant do
  namespace :plugins do
    task :install => :environment do
      plugins = ["vagrant-faster", "vagrant-gatling-rsync"]
      plugins.each do |plugin|
        line = Cocaine::CommandLine.new('vagrant', "plugin install #{plugin}")
        puts line.command(plugin: plugin)
        line.run
      end
    end
  end
end
