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
  
  compile.with transitive('org.apache.velocity:velocity:jar:1.7')
  package(:gem).path('lib')
  package(:gem).spec do |s|
    s.name          = 'velocity'
    s.version       = '1.0.0'
    s.date          = '2012-08-15'
    s.summary       = 'Velocity Templates for JRuby'
    s.description   = 'Velocity Templates for JRuby'
    s.author        = 'Chris Kentfield'
    s.email         = 'ridevermont@gmail.com'
    s.files         = ['lib/velocity.rb'] + Dir.glob('lib/velocity/*.rb')
    s.files         << Dir.glob('velocity-libs/*.jar')
    s.homepage      = 'http://logic-shop.com/velocity-gem'
  end

  clean do
    rm_rf 'velocity-libs' if File.exists? 'velocity-libs'
    rm 'velocity.log' if File.exists? 'velocity.log'
  end

  build do
    if !File.exists? 'velocity-libs'
      mkdir 'velocity-libs'
    end
    cp compile.dependencies.collect { |t| t.to_s }, project.path_to('velocity-libs')
  end
  test.with 'mysql:mysql-connector-java:jar:5.1.21'

end
