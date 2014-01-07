Gem::Specification.new do |s|

  s.name     = 'btc'
  s.version  = '1.0.0'

  s.homepage = 'https://github.com/carlosjhr64/btc'

  s.author   = 'CarlosJHR64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2014-01-07'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
BTC is a Ruby Library to create Bitcoin private/public key pairs.

It subclasses OpenSSL::PKey::EC, and adds attributes related to Bitcoin.
DESCRIPTION

  s.summary = <<SUMMARY
BTC is a Ruby Library to create Bitcoin private/public key pairs.
SUMMARY

  s.extra_rdoc_files = ['README.rdoc']
  s.rdoc_options     = ["--main", "README.rdoc"]

  s.require_paths = ["lib"]
  s.files = %w(
Manifest.txt
README.rdoc
TODO.txt
bin/bitcoin-tool
bin/check_bitcoin_address
btc.gemspec
lib/btc.rb
lib/btc/btc.rb
lib/btc/version.rb
project.gemspec
test/test_btc.rb
  )

  s.add_development_dependency 'test-unit', '~> 2.5', '>= 2.5.5'
  s.requirements << 'ruby: ruby 2.1.0p0 (2013-12-25 revision 44422) [x86_64-linux]'
  s.requirements << 'system in development: linux/bash'

end
