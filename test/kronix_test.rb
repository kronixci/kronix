require 'kronix'
require 'test/unit'

class TestKronix < Test::Unit::TestCase
  def setup
    FileUtils.rm('test_log') rescue nil

    @path = "test/fixtures/projects"
    @project = File.expand_path("test/cloned_projects/walky/")
    @project_fails = File.expand_path("test/cloned_projects/walky_fails/")

    FileUtils.rm_rf(@path) rescue nil
  end

  def test_can_extract_one_passing_rspec_response
    response = "1 example, 0 failures"
    result   = Kronix::TestResponse.parse(response)
    assert_equal result.tests, 1
    assert_equal result.fails, 0
  end

  def test_can_extract_multiple_passing_rspec_response
    response = "2 examples, 0 failures"
    result   = Kronix::TestResponse.parse(response)
    assert_equal result.tests, 2
    assert_equal result.fails, 0
  end

  def test_can_extract_pending_tests
    response = "4 examples, 2 failures, 1 pending"
    result   = Kronix::TestResponse.parse(response)
    assert_equal result.tests, 4
    assert_equal result.fails, 2
    assert_equal result.wait, 1
  end

  def test_have_no_pending_tests
    response = "4 examples, 2 failures"
    result   = Kronix::TestResponse.parse(response)
    assert_equal result.tests, 4
    assert_equal result.fails, 2
    assert_equal result.wait, 0
  end

  def test_can_run_test_framework
    Kronix::TestResponse.run
    assert File.exists? 'test_log'
  end

  def test_can_run_and_parse_test_framework
    result = Kronix::TestResponse.process
    assert_equal result.tests, 1
    assert_equal result.fails, 0
    assert_equal result.wait, 0
  end

  def test_parse_from_config_file
    result = Kronix::TestResponse.run_tests_command
    assert_equal result, 'rspec test/fixtures'
  end

  def test_can_clone_project
    Kronix::Project.clone(@project, @path)
    assert Dir.exists? "#{@path}/walky"
  end

  def test_can_run_ok_project
    assert Kronix.ci(@project, @path)
  end

  def test_can_run_fail_project
    assert_equal false, Kronix.ci(@project_fails, @path)
  end
end
