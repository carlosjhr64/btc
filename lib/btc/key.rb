# The following code I transformed from lian / bitcoin-ruby.
#    https://github.com/lian/bitcoin-ruby/blob/a9a20a1146c68e2377b4b4f500ff694a7946fcec/lib/bitcoin.rb
# I was only interested in the key pair and address portion of the code.
# Synopsis:
#    bc = BTC::Key.new.generate_key
#    puts "New BTC Address: #{bc.address}"
#    puts "Private Key: #{bc.prvkey}"
#    # Check DER use...
#    der = bc.key.to_der
#    derbc = BTC::Key.new(der)
#    raise "Bad DER?" unless derbc.address == bc.address

require 'digest/sha2'
require 'digest/rmd160'
require 'openssl'

module BTC
class Key
  attr_reader :key, :prvkey, :pubkey, :hash160, :checksum, :address

  BASE58 = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'
  def self.number_to_base(number,alpha=BASE58)
    string, base = '', alpha.size
    while(number >= base)
      mod       = number % base
      string    = alpha[mod,1] + string
      number    = (number - mod)/base
    end
    alpha[number,1] + string
  end

  private

  def nilprv
    @prvkey = nil
  end

  def nilpub
    @pubkey = @hash160 = @checksum = @base58 = @address = nil
  end

  def initprv
    @prvkey = @key.private_key.to_i.to_s(16).rjust(64, '0')
  end

  # https://en.bitcoin.it/wiki/Address
  def initpub
    @pubkey     = @key.public_key.to_bn.to_s(16).rjust(130, '0')
    @hash160    = '00' + (Digest::RMD160.hexdigest(Digest::SHA256.digest([@pubkey].pack('H*'))))
    @checksum   = Digest::SHA256.hexdigest( Digest::SHA256.digest( [@hash160].pack('H*') ) )[0...8]
    @address    = '1' + Key.number_to_base( (@hash160+@checksum).to_i(16), BASE58 )
  end

  public

  def initialize(seed='secp256k1')
    @key = OpenSSL::PKey::EC.new(seed)
    (@key.private_key?)? initprv : nilprv
    (@key.public_key?)? initpub : nilpub
  end

  def generate_key
    @key.generate_key
    initprv
    initpub
    self
  end

end
end
