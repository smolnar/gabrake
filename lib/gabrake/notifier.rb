module Gabrake
  class Notifier
    def self.deliver(exception, env:, **options)
      context   = Env.extract_context(env)
      event_url = Gabrake::Collector.event_for(exception, context)

      HTTParty.get(URI.encode(event_url), headers: { 'User-Agent' => env['HTTP_USER_AGENT'] })
    end

    class Env
      def self.extract_context(env)
        cookies = env ? env['action_dispatch.cookies'] : Hash.new
        default_client_id = "GA1.1.#{(rand() * 2147483647).to_i}.#{Time.now.to_i}"
        _, version, client_id = *(cookies['_ga'] || default_client_id).match(/GA(\d+)\..+\.(\d+\.\d+)\z/)

        {
          version: version,
          client_id: client_id,
          url: env['REQUEST_URI']
        }
      end
    end
  end
end
