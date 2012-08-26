require 'java'
require 'lib/velocity/velocity_launcher'

module Velocity
  class FileVelocityLauncher
    include VelocityLauncher
    def initialize template_dir
      init({
        'resource.loader' => 'file',
        'file.resource.loader.path' => template_dir
      })
    end
  end
end
