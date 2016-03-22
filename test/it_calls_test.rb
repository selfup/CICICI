require 'pry'
require 'minitest/autorun'
require 'minitest/pride'
require_relative './../lib/deployer.rb'

class ItCalls < Minitest::Test
  def d
    Deployer.new
  end

  def test_it_can_make_a_repo_call_with_env_vars
    call = d.repo_call

    assert_equal String, call.class
    assert_equal true, call[-1] == "Z"
  end

  def test_it_can_git_clone_if_no_repo_is_there
    @ip = ENV['ip']
    `ssh root@"#{@ip}" "rm -rf CICICI"`
    `ssh root@"#{@ip}" "git clone https://github.com/selfup/CICICI"`
    d.check_dir

    assert_equal true, `ssh root@"#{@ip}" "ls"`.split("\n").include?("CICICI")
  end
end
