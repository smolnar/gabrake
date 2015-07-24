require 'httparty'
require 'gabrake/version'
require 'gabrake/rails'
require 'gabrake/collector'
require 'gabrake/notifier'
require 'gabrake/middleware'
require 'net/http'

module Gabrake
  mattr_accessor :tracking_id, :tracked_version, :custom_dimension_index, instance_accessor: false

  class Railtie < ::Rails::Railtie
    initializer 'gabrake.boot_exception_catching' do |app|
      app.middleware.use Gabrake::Middleware

      Gabrake.tracked_version = version_from_git || version_from_revision_file
    end

    def version_from_git
      `git log --pretty=format:"%cd %h" --date=iso -1 2>/dev/null`.strip.presence
    end

    def version_from_revision_file
      `cat #{::Rails.root}/REVISION 2>/dev/null`.strip.presence
    end
  end
end
