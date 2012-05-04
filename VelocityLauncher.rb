require 'java'

require 'MySqlDataSource.rb'

class VelocityLauncher
  def initialize context, template
    @context = context
    @template = template
  end

  java_import 'org.apache.velocity.Template'
  java_import 'org.apache.velocity.app.Velocity'
  java_import 'org.apache.velocity.VelocityContext'
  java_import 'java.io.StringWriter'
  java_import 'org.apache.velocity.runtime.RuntimeSingleton'
  java_import 'org.apache.velocity.runtime.resource.loader.DataSourceResourceLoader'

  def run
    vc = VelocityContext.new(@context)
    writer = StringWriter.new
    loader = DataSourceResourceLoader.new
    loader.setDataSource(MySqlDataSource.new 'jdbc:mysql://localhost/test', 'root', 'swordfish')
    {
      'resource.loader' => 'ds',
      'ds.resource.loader.instance' => loader,
      'ds.resource.loader.public.name' => 'DataSource',
      'ds.resource.loader.description' => 'Velocity DataSource Resource Loader',
      'ds.resource.loader.class' => DataSourceResourceLoader.class.name,
      'ds.resource.loader.resource.datasource' => 'java:comp/env/jdbc/Velocity',
      'ds.resource.loader.resource.table' => 'template',
      'ds.resource.loader.resource.keycolumn' => 'id',
      'ds.resource.loader.resource.templatecolumn' => 'body',
      'ds.resource.loader.resource.timestampcolumn' => 'lastModified'
    }.each do |key, value|
      Velocity.setProperty key, value
    end
    Velocity.init
    t = RuntimeSingleton.getTemplate 'template.vm'
    t.merge(vc, writer)
    return writer.getBuffer
  end
end
