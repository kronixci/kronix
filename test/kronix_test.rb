require 'test_helper'

class KronixTest < Test::Unit::TestCase
  def teardown
    FileUtils.rm Dir.glob("test/dummy/*.sqlite") rescue nil
  end

  def setup
    @project                = File.expand_path("test/cloned_projects/walky/")
    @project_fails          = File.expand_path("test/cloned_projects/walky_fails/")
    @project_empty          = File.expand_path("test/cloned_projects/empty_project/")
    @project_without_runner = File.expand_path("test/cloned_projects/no_run_project/")
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

  def test_build_empty_project
    assert_equal false, Kronix.build(@project_empty)
  end

  def test_build_without_run_command_project
    assert_equal false, Kronix.build(@project_without_runner)
  end

  def test_build_with_migration
    FileUtils.rm Dir.glob("test/dummy/*.sqlite") rescue nil

    assert_equal false, File.exists?("test/dummy/dummy_development.sqlite")
    assert_equal false, File.exists?("test/dummy/dummy_production.sqlite")
    assert_equal false, File.exists?("test/dummy/dummy_test.sqlite")

    project = File.expand_path("test/dummy")
    assert_equal true, Kronix.build(project)

    assert_equal true, File.exists?("test/dummy/dummy_development.sqlite")
    assert_equal true, File.exists?("test/dummy/dummy_test.sqlite")
  end
end
