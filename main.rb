require 'rubygems'
require 'open-uri'
require 'hurley'
require 'json'
require 'pry'

@user = ENV['user']
@repo = ENV['repo']

@pong = Hurley::Client.new("https://api.github.com")
@pong.query[:access_token] = ENV['g_k']
@pong.header[:accept] = "application/vnd.github+json"

@ip = ENV['ip']

def parse(response)
  JSON.parse(response.body)
end

def repo_call
  JSON.parse(@pong.get("repos/#{@user}/#{@repo}/commits").
  body)[0]["commit"]["committer"]["date"]
end

def check_dir
  output = `ssh root@"#{@ip}" "ls"`.split("\n")
    if !output.include? "CICICI"
      `ssh root@"#{@ip}" "git clone https://github.com/selfup/CICICI"`
    end
end

if `cat ./commit_date.md`.gsub("\n", "") == "#{repo_call}"
  puts "Same"
else
  check_dir
  `ssh root@"#{@ip}" "echo '#{Time.now}' >> CI-LOG.txt && cd CICICI && python git_pull.py && cd ~/oxidizy_up && nohup cargo run --release &"`
  `ssh root@"#{@ip}" "exit"`
end

`rm -rf ./commit_date.md`
`echo "#{repo_call}" >> ./commit_date.md`
