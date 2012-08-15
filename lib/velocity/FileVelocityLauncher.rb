require 'java'
require 'lib/velocity/VelocityLauncher.rb'

class FileVelocityLauncher
  include VelocityLauncher
  def initialize template_dir
    init({
      'resource.loader' => 'file',
      'file.resource.loader.path' => template_dir
    })
  end
end