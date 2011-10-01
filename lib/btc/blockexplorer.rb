require 'open-uri'
require 'date'
require 'json'

# See http://blockexplorer.com/q
# Synopsis:
# bx = BTC::BlockExplorer.new
# if bx.checkaddress('13UQVr31P5M9A1TUhXTTcCTFrNjzBfMjuF')
#   puts bx.addressbalance('13UQVr31P5M9A1TUhXTTcCTFrNjzBfMjuF')
# else
#   puts bx.message
# end
module BTC
class BlockExplorer

  BLOCKEXPLORER = 'http://blockexplorer.com/q/'
  def self.get(path)
    open(BLOCKEXPLORER+path).read.strip
  end

  attr_accessor :address, :message
  def initialize
    @message = ''
  end

  def get(path)
    case value=BlockExplorer.get(path)
    when /^{/
      @message = ''
      JSON.parse(value)
    when '00'
      @message = 'address is valid'
      true
    when 'X5'
      @message = 'Address not base58'
      false
    when 'SZ'
      @message = 'Address not the correct size'
      false
    when 'CK'
      @message = 'Failed hash check'
      false
    when /^\d{4}\W\d\d\W\d\d\s+\d\d:\d\d:\d\d$/
      @message = value
      DateTime.parse(value)
    when /^((\d)|([^0\D]\d+))$/
      @message = value
      value.to_i
    when /^((\d)|([^0\D]\d+))\.\d+$/
      @message = value
      value.to_f
    else
      @message = ''
      value
    end
  end

  def method_missing( symbol , *args )
    get( (args.length > 0)? (symbol.to_s + '/' + args.join('/')) : symbol.to_s )
  end

end
end
