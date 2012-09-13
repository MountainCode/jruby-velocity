Original idea stolen from [Martin Fowler](http://martinfowler.com/bliki/JRubyVelocity.html)

### Java Runtime Dependencies
- org.apache.velocity:velocity:1.7
- commons-collections:commons-collections:3.2.1
- commons-lang:commons-lang:2.4
- mysql:mysql-connector-java:5.1.21

### Useful Environment Variables

    $ export JRUBY_OPTS=--1.9
    $ export JAVA_OPTS=-d32

### Building

You will need [Apache Buildr](http://buildr.apache.org/).  The main reason for choosing Buildr as a build tool is for easy access to Maven dependencies.

    $ buildr test:*   # Run all tests even if no code changes have been made
    $ build package   # Package as gem to target directory
