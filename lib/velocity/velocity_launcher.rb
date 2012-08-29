module Velocity
  module VelocityLauncher

    java_import 'org.apache.velocity.app.Velocity'
    java_import 'org.apache.velocity.app.VelocityEngine'
    java_import 'org.apache.velocity.VelocityContext'
    java_import 'java.io.StringWriter'
    java_import 'org.apache.velocity.runtime.RuntimeSingleton'

    def init properties
      @ve = VelocityEngine.new
      properties.each do |key, value|
        @ve.setProperty key, value
      end
      @ve.init
    end

    def merge context, template
      vc = VelocityContext.new(context)
      writer = StringWriter.new
      # Shouldn't be using a singleton here!
      t = @ve.getTemplate template
      t.merge(vc, writer)
      return writer.getBuffer.toString
    end
  end
end
