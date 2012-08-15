require 'java'
require 'src/main/ruby/VelocityLauncher.rb'

java_import 'org.apache.velocity.app.Velocity'

class FileVelocityLauncher
  include VelocityLauncher
  def initialize template_dir
  	{
      'resource.loader' => 'file',
      'file.resource.loader.path' => template_dir
    }.each do |key, value|
      Velocity.setProperty key, value
    end
    Velocity.init
  end
end