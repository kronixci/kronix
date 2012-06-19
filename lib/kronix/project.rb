module Kronix
  class Project
    def self.clone(url, path)
      create_dir(path)
      `cd #{path} && git clone #{url}`
    end

    def self.create_dir(path)
      FileUtils.mkdir_p(path)
    end
  end
end
