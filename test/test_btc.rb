require 'test/unit'
require 'btc'

class TestBtc < Test::Unit::TestCase
  include BTC
  def test_001_typical_use
    btc = nil
    # Test the two public methods available
    assert_nothing_raised(Exception){ btc = Btc.new }
    assert_nothing_raised(Exception){ btc.generate_key }
    # That's the library's expected use.
    # We can check the generated attributes.
    address = nil
    assert_nothing_raised(Exception){ address = btc.address }
    # Testing validity of public address via third party test from
    #   http://rosettacode.org/wiki/Bitcoin/address_validation
    # The perl script.
    assert( system "./bin/check_bitcoin_address #{address}" )
    # Test the chain intance and generation:
    assert_nothing_raised(Exception){ btc = Btc.new.generate_key }
    address2 = nil
    assert_nothing_raised(Exception){ address2 = btc.address }
    # We should get a different bitcoin with each generation:
    refute_equal( address, address2 )
    # And third party validation of address2:
    assert( system "./bin/check_bitcoin_address #{address2}" )
    # As a sanity check, verify that we catch bad addresses.
    refute( system "./bin/check_bitcoin_address cacahuates 2> /dev/null" )
    # Test the mnemonic shortcut to a new bitcoin.
    assert_nothing_raised(Exception){ btc = Btc.coin }
    address3 = btc.address
    # And this is yet another address...
    refute_equal( address, address3 )
    refute_equal( address2, address3 )
    # ...and valid.
    assert( system "./bin/check_bitcoin_address #{address3}" )
  end

  def test_private2public
    btc1     = Btc.coin # Some random bitcoin
    assert_nothing_raised{ btc1.check_key }
    address1 = btc1.address
    prvkey1  = btc1.prvkey
    # Valid address?
    assert( system "./bin/check_bitcoin_address #{address1}" )
    # Valid prvkey?
    refute_nil( prvkey1 =~ /^[0123456789abcdef]{64}$/ )

    btc2 = Btc.coin(prvkey1)
    assert_nothing_raised{ btc2.check_key }
    address2 = btc2.address
    prvkey2  = btc2.prvkey
    assert_equal(address1, address2)
    assert_equal(prvkey1,  prvkey2)

    # Seems pointless to test chaining, but...
    btc3 = Btc.coin(prvkey2)
    assert_nothing_raised{ btc3.check_key }
    address3 = btc3.address
    prvkey3  = btc3.prvkey
    assert_equal(address1, address3)
    assert_equal(prvkey1,  prvkey3)

    # And since I have matja's bitcoin-tool, confirm prvkey/address pair:
    hexaddress = <<CMD
./bin/bitcoin-tool                       \
  --input-type             private-key   \
  --input-format           hex           \
  --private-key-prefix     bitcoin       \
  --output-type            address       \
  --public-key-compression uncompressed  \
  --output-format          base58check   \
  --input
CMD
    hexaddress.strip!
    address = `#{hexaddress} #{prvkey3}`.strip
    assert_equal(address,  address3)
  end
end
