require 'java'
require 'src/main/ruby/VelocityLauncher.rb'

java_import 'org.apache.velocity.app.Velocity'

class FileVelocityLauncher
  include VelocityLauncher
  def initialize template_dir
    init({
      'resource.loader' => 'file',
      'file.resource.loader.path' => template_dir
    })
  end
end