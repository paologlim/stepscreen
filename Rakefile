require 'rubygems'
gem 'echoe'
require 'echoe'

Echoe.new("stepscreen") do |p|
  p.author="Palmade"
  p.project = "stepscreen"
  p.summary = "Gem for communicating with ScreenSteps Live API"

  p.dependencies = [ 'http_service' ]

  p.need_tar_gz = false
  p.need_tgz = true

  p.clean_pattern += ["pkg", "lib/*.bundle", "*.gem", ".config"]
  p.rdoc_pattern = ['README', 'LICENSE', 'COPYING', 'lib/**/*.rb', 'doc/**/*.rdoc']
end

require File.join(File.dirname(__FILE__), 'test/rake_helper')

require 'yard'
YARD::Rake::YardocTask.new do |t|
  t.files   = [ 'lib/**/*.rb' ]
end

gem 'rspec'
require 'spec/rake/spectask'
Spec::Rake::SpecTask.new do |t|
  t.spec_opts.push("-f s")
end

task :default => [ :test, :spec ]

