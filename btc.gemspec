Gem::Specification.new do |s|

  s.name     = 'btc'
  s.version  = '1.0.200126'

  s.homepage = 'https://github.com/carlosjhr64/btc'

  s.author   = 'carlosjhr64'
  s.email    = 'carlosjhr64@gmail.com'

  s.date     = '2020-01-26'
  s.licenses = ['MIT']

  s.description = <<DESCRIPTION
BTC is a Ruby Library to create Bitcoin private/public key pairs.
It subclasses OpenSSL::PKey::EC, and adds attributes related to Bitcoin.

This is a build refresh of the original 1.0.0/2014 code.
DESCRIPTION

  s.summary = <<SUMMARY
BTC is a Ruby Library to create Bitcoin private/public key pairs.
It subclasses OpenSSL::PKey::EC, and adds attributes related to Bitcoin.
SUMMARY

  s.require_paths = ['lib']
  s.files = %w(
README.md
lib/btc.rb
lib/btc/btc.rb
  )

  s.requirements << 'ruby: ruby 2.7.0p0 (2019-12-25 revision 647ee6f091) [x86_64-linux]'

end
