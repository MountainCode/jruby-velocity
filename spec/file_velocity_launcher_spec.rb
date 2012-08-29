require 'lib/velocity'

describe Velocity::FileVelocityLauncher do
  let(:launcher) { Velocity::FileVelocityLauncher.new 'spec/resources' }
  subject { launcher }
  it 'should merge a template from a velocity file' do
    context = {
      'host' => 'Cardinal Fang',
      'weapons' => ['Fear', 'Surprise', 'Ruthless Efficiency']
    }
    subject.merge(context, 'template.vm').should eq "- Fear\n- Surprise\n- Ruthless Efficiency\n"
  end
  it 'should merge a template from a file in a subdirectory' do
    context = {
      'title' => 'Nobody Expects Us!',
      'host' => 'Cardinal Fang',
      'weapons' => ['Fear', 'Surprise', 'Ruthless Efficiency']
    }
    merged = subject.merge(context, 'html/template.html')
    merged.should include '<h1>Cardinal Fang</h1>'
    merged.should include '<title>Nobody Expects Us!</title>'
    merged.should include '<li>Fear</li>'
    merged.should include '<li>Surprise</li>'
    merged.should include '<li>Ruthless Efficiency</li>'
  end
end
