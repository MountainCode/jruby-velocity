# JRuby-Velocity

Original idea stolen from [Martin Fowler](http://martinfowler.com/bliki/JRubyVelocity.html)

When I originally built this, I was doing a lot of Java web development and used
Velocity a lot.  However, since discovering
[Mustache templates](http://mustache.github.io/) which also has a
[Java implementation](https://github.com/samskivert/jmustache), I no longer use
this gem.

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

### output
    Name: Abraham Lincoln
    Occupation: POTUS

    Job History:
      - Congressman
      - Lawyer
      - Vampire Hunter

See the [Velocity User Guide](http://velocity.apache.org/engine/devel/user-guide.html)

## Java Runtime Dependencies
- org.apache.velocity:velocity:1.7
- commons-collections:commons-collections:3.2.1
- commons-lang:commons-lang:2.4
- mysql:mysql-connector-java:5.1.21

## Useful Environment Variables

    $ export JRUBY_OPTS=--1.9
    $ export JAVA_OPTS=-d32

## Test Database

In order to run database tests, you'll need a test database.  Run the following to create it.

```bash
$ mysql -uroot -p < sql/create_test_db.sql
```

## Building

You will need [Apache Buildr](http://buildr.apache.org/).  The main reason for choosing Buildr as a build tool is for easy access to Maven dependencies.

    $ buildr test:*   # Run all tests even if no code changes have been made
    $ buildr package   # Package as gem to target directory
