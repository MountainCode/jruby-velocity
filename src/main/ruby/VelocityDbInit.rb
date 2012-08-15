require 'java'
require 'src/main/ruby/VelocityLauncher.rb'

java_import 'org.apache.velocity.app.Velocity'

class VelocityDbInit
  include VelocityLauncher
  def initialize context, template
    @context = context
    @template = template
  end
end