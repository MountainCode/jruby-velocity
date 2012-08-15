require 'java'
require 'src/main/ruby/VelocityLauncher.rb'

java_import 'org.apache.velocity.app.Velocity'

class SqlVelocityLauncher
  include VelocityLauncher
  def initialize
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
end