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

def script
  if ARGV[0].nil?
    "echo 'One successful ssh and script' >> CICICI.txt"
  else
    ARGV[0]
  end
end

def parse(response)
  JSON.parse(response.body)
end

def repo_call
  JSON.parse(@pong.get("repos/#{@user}/#{@repo}/commits").
  body)[0]["commit"]["committer"]["date"]
end

if `cat ./commit_date.md`.gsub("\n", "") == "#{repo_call}"
  puts "Same"
else
  `ssh root@"#{@ip}" "#{script}"`
end

`rm -rf ./commit_date.md`
`echo "#{repo_call}" >> ./commit_date.md`
