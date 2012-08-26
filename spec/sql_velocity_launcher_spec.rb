require 'yaml'
require 'lib/velocity/SqlVelocityLauncher.rb'

describe Velocity::SqlVelocityLauncher do
  let(:launcher) { Velocity::SqlVelocityLauncher.new YAML.load_file('spec/resources/sql_connection.yaml') }
  subject { launcher }
  it 'should merge a template from a database table' do
    context = {
      'host' => 'Cardinal Fang',
      'weapons' => ['Fear', 'Surprise', 'Ruthless Efficiency']
    }
    subject.merge(context, 'template.vm').should eq "- Fear\n- Surprise\n- Ruthless Efficiency\n"
  end
end
