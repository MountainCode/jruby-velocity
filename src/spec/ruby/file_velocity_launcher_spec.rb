require 'extensions/all'
require_relative '../../main/ruby/FileVelocityLauncher.rb'

describe FileVelocityLauncher do
	let(:launcher) { FileVelocityLauncher.new 'src/spec/resources' }
	subject { launcher }
	it 'should merge a template from a velocity file' do
		context = {
		  'host' => 'Cardinal Fang',
		  'weapons' => ['Fear', 'Surprise', 'Ruthless Efficiency']
		}
		subject.merge(context, 'template.vm').should eq "- Fear\n- Surprise\n- Ruthless Efficiency\n"
	end
end
