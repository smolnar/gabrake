module Gabrake
  class Notifier
    def self.deliver(exception, env:, **options)
      context   = Env.extract_context(env)
      event_url = Gabrake::Collector.event_for(exception, context)

      HTTParty.get(URI.encode(event_url), headers: { 'User-Agent' => env['HTTP_USER_AGENT'] })
    end

    class Env
      def self.extract_context(env)
        cookies = env['action_dispatch.cookies']
        _, version, client_id = *(cookies['_ga'] || 'GA1.1.1.1').match(/GA(\d+)\..+\.(\d+\.\d+)\z/)

        {
          version: version,
          client_id: client_id,
          url: env['REQUEST_URI']
        }
      end
    end
  end
end
