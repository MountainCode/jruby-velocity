require 'java'

module VelocityLauncher

  java_import 'org.apache.velocity.VelocityContext'
  java_import 'java.io.StringWriter'
  java_import 'org.apache.velocity.runtime.RuntimeSingleton'

  def merge context, template
    vc = VelocityContext.new(context)
    writer = StringWriter.new
    t = RuntimeSingleton.getTemplate template
    t.merge(vc, writer)
    return writer.getBuffer.toString
  end
end
