require 'java'
require 'yaml'

require_relative 'MySqlDataSource.rb'

module VelocityLauncher

  java_import 'org.apache.velocity.Template'
  java_import 'org.apache.velocity.app.Velocity'
  java_import 'org.apache.velocity.VelocityContext'
  java_import 'java.io.StringWriter'
  java_import 'org.apache.velocity.runtime.RuntimeSingleton'
  java_import 'org.apache.velocity.runtime.resource.loader.DataSourceResourceLoader'

  def self.included(base)
    loader = DataSourceResourceLoader.new
    connection = YAML.load_file 'src/spec/resources/sql_connection.yaml'

    loader.setDataSource(MySqlDataSource.new "jdbc:mysql://#{connection['server']}/#{connection['database']}",
      connection['username'], connection['password'])
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
  end

  def run
    vc = VelocityContext.new(@context)
    writer = StringWriter.new
    t = RuntimeSingleton.getTemplate 'template.vm'
    t.merge(vc, writer)
    return writer.getBuffer.toString
  end
end
