require './lib/velocity/version'

repositories.remote << "http://repo1.maven.org/maven2"

gem_layout = Layout.new
gem_layout[:source, :main, :ruby] = 'lib'
gem_layout[:source, :spec, :ruby] = 'spec'

desc "JRuby Velocity Wrapper"
define "velocity", :layout => gem_layout do
  project.version = Velocity::VERSION
  
  package(:gem).path('lib')
  package(:gem).spec do |s|
    s.name          = 'velocity'
    s.version       = Velocity::VERSION
    s.summary       = 'Velocity Templates for JRuby'
    s.description   = <<-eos
      Ruby wrapper for Java Velocity templates.
      Includes classes for reading from a file or MySql database.
      Works with ruby hashes, objects and arrays and has been tested with JRuby on Rails.
    eos
    s.author        = 'Chris Kentfield'
    s.email         = 'ridevermont@gmail.com'
    s.files         = ['lib/velocity.rb'] + Dir.glob('lib/velocity/*.rb')
    s.homepage      = 'https://github.com/MountainCode/jruby-velocity'
  end

  clean do
    rm 'velocity.log' if File.exists? 'velocity.log'
  end

  test.with transitive('org.apache.velocity:velocity:jar:1.7')
  test.with 'mysql:mysql-connector-java:jar:5.1.21'
end
