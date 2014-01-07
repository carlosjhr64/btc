require 'btc'

bx = BTC::BlockExplorer.new

if true
  puts
  address = '1DRtb6DiEJ1nGpKzB9sR1idZL1sn6Ts5mX'
  js = bx.mytransactions(address)
  puts js
  puts js.class
end

if true
  puts
  ['getdifficulty','getblockcount','latesthash',
   'decimaltarget','probability','hashestowin',
   'nextretarget','estimate','totalbc',
   'bcperblock'].each do |stats|
     print stats.capitalize
     value = bx.get(stats)
     puts ":\t#{value}\t#{value.class}"
     puts "\t\t#{bx.message}"
  end
end

if true
  puts
  ['avgtxsize','avgtxvalue','avgblocksize','interval','eta','avgtxnumber'].each do |stats|
     print stats.capitalize
     value = bx.get(stats)
     puts ":\t#{value}\t#{value.class}"
     puts "\t\t#{bx.message}"
  end
end

if true
  puts
  address = '1DRtb6DiEJ1nGpKzB9sR1idZL1sn6Ts5mX'
  ['getreceivedbyaddress','getsentbyaddress','addressbalance','addressfirstseen'].each do |stats|
     print stats.capitalize
     value = bx.get("#{stats}/#{address}")
     puts ":\t#{value}\t#{value.class}"
     puts "\t\t#{bx.message}"
  end
end

if true
  puts
  address = '1DRtb6DiEJ1nGpKzB9sR1idZL1sn6Ts5mX'
  puts bx.checkaddress(address)
  puts bx.message
end
