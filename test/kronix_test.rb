require 'test_helper'

class KronixTest < Test::Unit::TestCase
  def setup
    @project = File.expand_path("test/cloned_projects/walky/")
    @project_fails = File.expand_path("test/cloned_projects/walky_fails/")

    FileUtils.rm_rf(@path) rescue nil
  end


  def test_can_run_and_parse_test_framework
    result = Kronix::TestResponse.process
    assert_equal true, result.pass?
  end

  def test_parse_from_config_file
    result = Kronix::TestResponse.run_tests_command
    assert_equal result, 'rspec test/fixtures'
  end

  def test_build_ok_project
    assert_equal true, Kronix.build(@project)
  end

  def test_build_fail_project
    assert_equal false, Kronix.build(@project_fails)
  end

  def test_build_with_migration
    project = File.expand_path("test/dummy")
    assert_equal false, Kronix.build(project)
  end
end
