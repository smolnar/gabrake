$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rails'
require 'gabrake'
require 'rspec'

RSpec.configure do |config|
  config.before :each do
    allow(::Rails).to receive(:root) { File.dirname(File.expand_path(File.dirname("#{__FILE__}"), '..')) }
  end
end
