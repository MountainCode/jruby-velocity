require 'extensions/all'
require_relative '../../main/ruby/VelocityLauncher.rb'

describe VelocityLauncher do
	it 'should merge a template from a velocity file' do
		ct = {
		  'host' => 'Cardinal Fang',
		  'weapons' => ['Fear', 'Surprise', 'Ruthless Efficiency']
		}
		template = File.readlines('src/spec/resources/template.vm').join
		launcher = VelocityLauncher.new(ct, template)
		launcher.run.should eq "- Fear\n- Surprise\n- Ruthless Efficiency\n"
	end
end
