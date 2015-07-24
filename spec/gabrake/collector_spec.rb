require 'spec_helper'

describe Gabrake::Collector do
  let(:collector) { described_class }

  describe '.event_for' do
    it 'generates url for analytics event' do
      Gabrake.tracking_id = 'UA-0'

      exception = Exception.new('Something went wrong')
      context = { client_id: 1, version: 2, url: 'http://google.sk' }

      begin
        raise exception
      rescue Exception => exception
        url = collector.event_for(exception, context)

        expect(url).to eql('http://www.google-analytics.com/collect?v=2&dl=http://google.sk&cid=1&tid=UA-0&t=event&ec=Gabrake (Rails)&ea=Exception: Something went wrong&el=spec/gabrake/collector_spec.rb:14')
      end
    end

    context 'with dimension index' do
      it 'embeds dimension' do
        Gabrake.tracking_id = 'UA-0'
        Gabrake.custom_dimension_index = 1
        Gabrake.tracked_version = "git version"

        exception = Exception.new('Something went wrong')
        context = { client_id: 1, version: 2, url: 'http://google.sk' }

        begin
          raise exception
        rescue Exception => exception
          url = collector.event_for(exception, context)

          expect(url).to eql("http://www.google-analytics.com/collect?v=2&dl=http://google.sk&cid=1&tid=UA-0&t=event&ec=Gabrake (Rails)&ea=Exception: Something went wrong&el=spec/gabrake/collector_spec.rb:32&cd1=git version")

        end
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
