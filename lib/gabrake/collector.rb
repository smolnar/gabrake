module Gabrake
  class Collector
    URL = 'http://www.google-analytics.com/collect'

    def self.event_for(exception, context)
      event = Event.new(exception)

      unless Gabrake.tracking_id
        raise ArgumentError.new('You need to specify Google Analytics Tracking ID in `Gabrake.tracking_id\'')
      end

      params = {
        v:   context[:version],
        dl:  CGI::escape(context[:url]),
        cid: context[:client_id],
        tid: Gabrake.tracking_id,
        t:   :event,
        ec:  event.category,
        ea:  event.action,
        el:  event.label
      }

      params[:"cd#{Gabrake.custom_dimension_index}"] = Gabrake.tracked_version if Gabrake.custom_dimension_index

      "#{URL}?#{params.map { |key, value| "#{key}=#{value}" }.join('&') }"
    end

    class Event
      def initialize(exception)
        @exception = exception
      end

      def category
        'Gabrake (Rails)'
      end

      def action
        @message ||= "#{@exception.class}: #{@exception.message}"
      end

      def label
        "#{location.gsub(/\A#{::Rails.root}\//, '')}" if location
      end

      private

      def location
        return @location if @location

        backtrace = @exception.backtrace.try(:first)

        return unless backtrace

        _, @location, _ = *backtrace.match(/\A(.+?:\d+):in/)
      end
    end
  end
end
