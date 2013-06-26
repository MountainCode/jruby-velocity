create database if not exists jruby_velocity_test;

grant all on jruby_velocity_test.* to 'jruby_velocity'@'%' identified by 'swordfish';

drop table if exists jruby_velocity_test.templates;
create table jruby_velocity_test.templates (
  id varchar(64) primary key,
  body text not null,
  lastModified timestamp
);

insert into jruby_velocity_test.templates(id, body, lastModified)
values('template.vm', '#foreach ($w in $weapons)
- $w
#end', curdate());