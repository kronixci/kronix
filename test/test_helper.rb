require 'kronix'
require 'test/unit'

def cloned_projects_path
  File.expand_path("../cloned_projects", __FILE__)
end

["#{cloned_projects_path}/failed_project", "#{cloned_projects_path}/sample_project"].each do |repo|
  unless File.exists? repo
    `git clone git@github.com:kronixci/#{repo.split("/").last}.git #{repo}`
  end
end
