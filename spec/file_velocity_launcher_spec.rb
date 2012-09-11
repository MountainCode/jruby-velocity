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

  it 'should merge a template with a list of objects' do
    class Listing
      attr_accessor :listing_number, :description
    end
    l = Listing.new
    l.listing_number = 'ABC123'
    l.description = 'A description'
    context = {
      'listings' => [l]
    }
    merged = subject.merge context, 'html/listings.html'
    merged.should include 'description: A description'
  end
end
