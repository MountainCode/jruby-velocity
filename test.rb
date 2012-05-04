require 'VelocityLauncher.rb'

ct = {
  'host' => 'Cardinal Fang',
  'weapons' => ['Fear', 'Surprise', 'Ruthless Efficiency']
}
template = File.readlines('template.vm').join
puts VelocityLauncher.new(ct, template).run
