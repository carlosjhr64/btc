require 'date'
require 'find'

project_version = File.expand_path( File.dirname(__FILE__) ).split(/\//).last
project, version = nil, nil
if project_version=~/^(\w+)-(\d+\.\d+\.\d+)$/ then
  project, version = $1, $2
  require "./lib/#{project}.rb"
  raise "versions don't match" unless BTC::VERSION == version
else
  raise 'need versioned directory'
end

spec = Gem::Specification.new do |s|
  s.name = project
  s.version = version
  s.date = Date.today.to_s

  s.homepage = 'https://github.com/carlosjhr64/btc'
  s.summary = 'BTC'
  s.description = 'BTC is a Ruby Library for Bitcoin.'

  s.authors = ['carlosjhr64@gmail.com']
  s.email = "carlosjhr64@gmail.com"

  files = []
  $stderr.puts "RBs"
  Find.find('./lib'){|fn|
    if fn=~/\.rb$/ then
      $stderr.puts fn
      files.push(fn)
    end
  }
  #if File.exists?('./pngs') then
  #  $stderr.puts "PNGs"
  #  Find.find('./pngs'){|fn|
  #    if fn=~/\.png$/ then
  #      $stderr.puts fn
  #      files.push(fn)
  #    end
  #  }
  #end

  files.push('./README.textile')

  s.files = files

  #if File.exists?('./bin')
  #  $stderr.puts "BINs"
  #  executables = []
  #  Find.find('./bin'){|fn|
  #    if File.file?(fn) then
  #      $stderr.puts fn
  #      executables.push(fn.sub(/^.*\//,''))
  #    end
  #  }
  #  s.executables = executables
  #  s.default_executable = project
  #end

  #s.add_dependency('gtk2applib','~> 15.3')
  #s.requirements << 'mpg123'

end
