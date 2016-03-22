require 'rubygems'
require 'open-uri'
require 'hurley'
require 'json'

class Deployer
  def initialize
    @user = ENV['user']
    @repo = ENV['repo']
    @pong = Hurley::Client.new("https://api.github.com")
    @pong.query[:access_token] = ENV['g_k']
    @pong.header[:accept] = "application/vnd.github+json"
    @ip = ENV['ip']
  end

  def parse(response)
    JSON.parse(response.body)
  end

  def repo_call
    JSON.parse(@pong.get("repos/#{@user}/#{@repo}/commits").
    body)[0]["commit"]["committer"]["date"]
  end

  def check_dir
    if !`ssh root@"#{@ip}" "ls"`.split("\n").include? "CICICI"
      `ssh root@"#{@ip}" "git clone https://github.com/selfup/CICICI"`
    end
  end

  def change_state
    puts "Sleeping for 30. Cya soon :P"
    `ssh root@"#{@ip}" "reboot"`; sleep (30)
    puts "Shutting Down nginx"
    `ssh root@"#{@ip}" "service nginx stop"`
    puts "Going in to pull and re-serve"
    `ssh root@"#{@ip}" 'echo "#{Time.now}" >> CI-LOG.txt && cd CICICI/lib && python git_pull.py && cd ~/oxidizy_up && screen -d -m cargo run --release'`
    puts "Deployed"
  end

  def go_in_and_change_state
    if `cat db/commit_date.md`.gsub("\n", "") == "#{repo_call}"
      puts "Same"
    else
      check_dir
      change_state
    end
  end

  def update_date_file
    `rm -rf db/commit_date.md`
    `echo "#{repo_call}" >> db/commit_date.md`
  end

  def deploy
    repo_call
    go_in_and_change_state
    update_date_file
  end
end

if __FILE__ == $0
  Deployer.new.deploy
end
