require 'java'

java_import 'javax.sql.DataSource'
java_import 'java.sql.DriverManager'
java_import 'com.mysql.jdbc.Driver' # We need to load the Driver class even though we don't explicitly use it.

class MySqlDataSource
  include DataSource
  
  def initialize url, user, password
    @url = url
    @user = user
    @password = password
  end
  
  def getConnection
    return DriverManager.getConnection(@url, @user, @password)
  end
  
end