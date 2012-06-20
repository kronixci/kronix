module Kronix
  class Project
    # Responsability:
    #   Clone a git project
    #
    # url  - String with git repository ( normaly from github)
    # path - String where it should be copied
    #
    # Returns a string where git repostory was copied
    def self.clone(url, path)
      create_dir(path)
      `cd #{path} && git clone #{url} 2>&1`
      File.basename(url, ".git")
    end

    # Responsability:
    #   Create a tree dir if not exists one
    #
    # path - String which represents the tree
    #
    # Returns nothing
    def self.create_dir(path)
      FileUtils.mkdir_p(path)
    end
  end
end
