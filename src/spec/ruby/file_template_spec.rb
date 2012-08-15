require 'extensions/all'
require_relative '../../main/ruby/VelocityDbInit.rb'

describe VelocityLauncher do
	it 'should merge a template from a velocity file' do
		ct = {
		  'host' => 'Cardinal Fang',
		  'weapons' => ['Fear', 'Surprise', 'Ruthless Efficiency']
		}
		template = File.readlines('src/spec/resources/template.vm').join
		launcher = VelocityDbInit.new(ct, template)
		launcher.run.should eq "- Fear\n- Surprise\n- Ruthless Efficiency\n"
	end
end
