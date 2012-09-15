# JRuby-Velocity

Original idea stolen from [Martin Fowler](http://martinfowler.com/bliki/JRubyVelocity.html)

## Usage

### controller.rb
```ruby
  require 'java'
  require 'velocity'

  engine = Velocity::FileVelocityLauncher.new 'path/to/templates'
  context = {
    :first_name => 'Abraham',
    :last_name => 'Lincoln',
    :occupation => 'POTUS',
    :job_history => ['Congressman', 'Lawyer', 'Vampire Hunter']
  }
  puts engine.merge(context, 'template.vm')

```

### template.vm
```velocity
  Name: $first_name $last_name
  Occupation: $occupation

  Job History:
  #foreach($job in $job_history)
    - $job
  #end
```

See the [Velocity User Guide](http://velocity.apache.org/engine/devel/user-guide.html)

## Java Runtime Dependencies
- org.apache.velocity:velocity:1.7
- commons-collections:commons-collections:3.2.1
- commons-lang:commons-lang:2.4
- mysql:mysql-connector-java:5.1.21

## Useful Environment Variables

    $ export JRUBY_OPTS=--1.9
    $ export JAVA_OPTS=-d32

## Building

You will need [Apache Buildr](http://buildr.apache.org/).  The main reason for choosing Buildr as a build tool is for easy access to Maven dependencies.

    $ buildr test:*   # Run all tests even if no code changes have been made
    $ build package   # Package as gem to target directory
