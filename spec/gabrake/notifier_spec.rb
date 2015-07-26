require 'spec_helper'

describe Gabrake::Notifier do
  let(:notifier) { described_class }

  describe '.deliver' do
    it 'delivers exception' do
      exception = Exception.new('Something went wrong')

      env = {
        'action_dispatch.cookies' => {
          '_ga' => 'GA1.4.121.121'
        },

        'REQUEST_URI' => 'http://google.sk',
        'HTTP_USER_AGENT' => 'Chrome'
      }

      context = {
        version: '1',
        client_id: '121.121',
        url: 'http://google.sk'
      }

      expect(Gabrake::Collector).to receive(:event_for).with(exception, context) { 'http://google.sk' }
      expect(HTTParty).to receive(:get).with('http://google.sk', headers: { 'User-Agent' => 'Chrome' })

      notifier.deliver(exception, env: env)
    end

    context 'without Analytics client ID' do
      it 'creates random new one' do
        exception = Exception.new('Something went wrong')
        time = Time.now

        allow(Gabrake::Notifier::Env).to receive(:rand) { 0.1 }
        allow(Time).to receive(:now) { time}

        env = {
          'action_dispatch.cookies' => {
          },

          'REQUEST_URI' => 'http://google.sk',
          'HTTP_USER_AGENT' => 'Chrome'
        }

        context = {
          version: '1',
          client_id: "214748364.#{time.to_i}",
          url: 'http://google.sk'
        }

        expect(Gabrake::Collector).to receive(:event_for).with(exception, context) { 'http://google.sk' }
        expect(HTTParty).to receive(:get).with('http://google.sk', headers: { 'User-Agent' => 'Chrome' })

        notifier.deliver(exception, env: env)
      end
    end
  end
end
