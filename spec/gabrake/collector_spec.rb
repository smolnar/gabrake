require 'spec_helper'

describe Gabrake::Collector do
  let(:collector) { described_class }
  let(:exception) {
    exception = Exception.new('Something went wrong')

    exception.set_backtrace('app/models/post.rb:5:in `__method')

    exception
  }

  describe '.event_for' do
    it 'generates url for analytics event' do
      Gabrake.tracking_id = 'UA-0'

      context = { client_id: 1, version: 2, url: 'http://google.sk' }

      url = collector.event_for(exception, context)

      expect(url).to eql('http://www.google-analytics.com/collect?v=2&dl=http%3A%2F%2Fgoogle.sk&cid=1&tid=UA-0&t=event&ec=Gabrake+%28Rails%29&ea=Exception%3A+Something+went+wrong&el=app%2Fmodels%2Fpost.rb%3A5')
    end

    context 'with parametrized url' do
      it 'correctly adds url as parameter' do
        Gabrake.tracking_id = 'UA-0'

        context = { client_id: 1, version: 2, url: 'http://google.sk?a=1&b=2' }

        url = collector.event_for(exception, context)

        expect(url).to eql('http://www.google-analytics.com/collect?v=2&dl=http%3A%2F%2Fgoogle.sk%3Fa%3D1%26b%3D2&cid=1&tid=UA-0&t=event&ec=Gabrake+%28Rails%29&ea=Exception%3A+Something+went+wrong&el=app%2Fmodels%2Fpost.rb%3A5')
      end
    end

    context 'with dimension index' do
      it 'embeds dimension' do
        Gabrake.tracking_id = 'UA-0'
        Gabrake.custom_dimension_index = 1
        Gabrake.tracked_version = "git version"

        context = { client_id: 1, version: 2, url: 'http://google.sk' }

        url = collector.event_for(exception, context)

        expect(url).to eql('http://www.google-analytics.com/collect?v=2&dl=http%3A%2F%2Fgoogle.sk&cid=1&tid=UA-0&t=event&ec=Gabrake+%28Rails%29&ea=Exception%3A+Something+went+wrong&el=app%2Fmodels%2Fpost.rb%3A5&cd1=git+version')
      end
    end

    context 'without tracking id' do
      it 'raises an exception' do
        Gabrake.tracking_id = nil

        expect { collector.event_for(nil, nil) }.to raise_error(ArgumentError, 'You need to specify Google Analytics Tracking ID in `Gabrake.tracking_id\'')
      end
    end
  end
end
