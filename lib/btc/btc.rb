# The following code I transformed from lian / bitcoin-ruby.
#    https://github.com/lian/bitcoin-ruby/blob/a9a20a1146c68e2377b4b4f500ff694a7946fcec/lib/bitcoin.rb
# I was only interested in the key pair and address portion of the code.
# Synopsis: 
#    random_coin = BTC::Btc.coin
#    puts "New BTC Address: #{random_coin.address}"
#    puts "Private Key: #{random_coin.prvkey}"
#    same_coin = BTC::Btc.coin(random_coin.prvkey)

module BTC
class Btc < OpenSSL::PKey::EC
  attr_reader :prvkey, :pubkey, :hash160, :checksum, :address

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

  # prvkey is the hexadecimal string given by #prvkey below...
  def self.coin(prvkey=nil)
    btc = Btc.new
    if prvkey
      case prvkey
      when /^[0123456789abcdef]{64}$/
        btc.private_key!(prvkey)
     #when I get around to doing another format...
      else
        raise "Unrecognized prvkey"
      end
    else
      btc.generate_key
    end
    return btc
  end

  private

  def nilprv
    @prvkey = nil
  end

  def nilpub
    @pubkey = @hash160 = @checksum = @base58 = @address = nil
  end

  def initprv
    @prvkey = self.private_key.to_i.to_s(16).rjust(64, '0')
  end

  # https://en.bitcoin.it/wiki/Address
  def initpub
    @pubkey     = self.public_key.to_bn.to_s(16).rjust(130, '0')
    @hash160    = '00' + (Digest::RMD160.hexdigest(Digest::SHA256.digest([@pubkey].pack('H*'))))
    @checksum   = Digest::SHA256.hexdigest( Digest::SHA256.digest( [@hash160].pack('H*') ) )[0...8]
    @address    = '1' + Btc.number_to_base( (@hash160+@checksum).to_i(16), BASE58 )
  end

  public

  def initialize(seed='secp256k1', *args)
    super(seed, *args)
    (self.private_key?)? initprv : nilprv
    (self.public_key?)?  initpub : nilpub
  end

  def generate_key
    super
    initprv
    initpub
    self
  end

  def private_key!(prvkey)
    self.private_key = prvkey.to_i(16)
    self.public_key  = self.group.generator.mul(self.private_key)
    self.check_key # OK, did we really do this right???
    self.private_key
  end

  def private_key=(kv)
    super(kv)
    initprv
  end

  def public_key=(kb)
    super(kb)
    initpub
  end

end
end
