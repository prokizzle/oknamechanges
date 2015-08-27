# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "heroku"
  config.vm.box_url = "https://dl.dropboxusercontent.com/s/rnc0p8zl91borei/heroku.box"
  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.synced_folder ".", "/opt/vagrant/rsynced_folder", type: "rsync",
    rsync__exclude: [".git/", ".vagrant/", "/tmp"]

  if Vagrant.has_plugin?("vagrant-gatling-rsync")
    config.gatling.latency = 2.5
    config.gatling.time_format = "%H:%M:%S"
    config.gatling.rsync_on_startup = true
  end


end
