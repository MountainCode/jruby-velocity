java_import 'org.apache.velocity.runtime.resource.loader.DataSourceResourceLoader'

module Velocity
  class SqlVelocityLauncher
    include VelocityLauncher
    def initialize connection
      loader = DataSourceResourceLoader.new

      loader.setDataSource(MySqlDataSource.new "jdbc:mysql://#{connection['server']}/#{connection['database']}",
        connection['username'], connection['password'])
      init({
        'resource.loader' => 'ds',
        'ds.resource.loader.instance' => loader,
        'ds.resource.loader.public.name' => 'DataSource',
        'ds.resource.loader.description' => 'Velocity DataSource Resource Loader',
        'ds.resource.loader.class' => DataSourceResourceLoader.class.name,
        'ds.resource.loader.resource.datasource' => 'java:comp/env/jdbc/Velocity',
        'ds.resource.loader.resource.table' => 'templates',
        'ds.resource.loader.resource.keycolumn' => 'id',
        'ds.resource.loader.resource.templatecolumn' => 'body',
        'ds.resource.loader.resource.timestampcolumn' => 'lastModified'
      })
    end
  end
end