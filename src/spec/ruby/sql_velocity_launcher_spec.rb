require 'extensions/all'
require_relative '../../main/ruby/SqlVelocityLauncher.rb'

describe SqlVelocityLauncher do
	it 'should merge a template from a velocity file' do
		context = {
		  'host' => 'Cardinal Fang',
		  'weapons' => ['Fear', 'Surprise', 'Ruthless Efficiency']
		}
		launcher = SqlVelocityLauncher.new
		launcher.merge(context, 'template.vm').should eq "- Fear\n- Surprise\n- Ruthless Efficiency\n"
	end
end
