# Version number for this release
VERSION_NUMBER = "1.0.0"
# Group identifier for your projects
GROUP = "velocity"
COPYRIGHT = ""

# Specify Maven 2.0 remote repositories here, like this:
repositories.remote << "http://repo1.maven.org/maven2"

gem_layout = Layout.new
gem_layout[:source, :main, :ruby] = 'lib'
gem_layout[:source, :spec, :ruby] = 'spec'

desc "The Velocity project"
define "velocity", :layout => gem_layout do

  project.version = VERSION_NUMBER
  project.group = GROUP
  manifest["Implementation-Vendor"] = COPYRIGHT

  test.with 'mysql:mysql-connector-java:jar:5.1.21', transitive('org.apache.velocity:velocity:jar:1.7')

end
