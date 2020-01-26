# BTC

* [VERSION 1.0.200126](https://github.com/carlosjhr64/btc/release)
* [github](https://github.com/carlosjhr64/btc)
* [rubygems](https://rubygems.org/gems/btc)

## DESCRIPTION:

BTC is a Ruby Library to create Bitcoin private/public key pairs.
It subclasses OpenSSL::PKey::EC, and adds attributes related to Bitcoin.

This is a build refresh of the original 1.0.0/2014 code.

## INSTALL:

    $ gem install btc

## REQUIREMENTS:

BTC only uses the Standard Libraries.

## SYNOPSIS:

    require 'btc'

    coin = BTC::Btc.coin
    coin.address    #~> ^1[a-km-zA-HJ-NP-Z1-9]{25,34}$
    coin.prvkey     #~> ^\h{64}$

    coin.pubkey     #~> ^\h{130}$
    coin.hash160    #~> ^\h{42}$
    coin.checksum   #~> ^\h{8}$

    # From a given private key...
    same_coin = BTC::Btc.coin(coin.prvkey)
    same_coin.address == coin.address   #=> true

## ISSUES:

A lot has happened to Bitcoin since I published this gem in 2014.
This library only does what it did in 2014 and nothing else.
This latest update is just a build/repo cleanup.

## Credits

As I read back in 2014, but still there:

* [lian / bitcoin-ruby](https://github.com/lian/bitcoin-ruby)
* [How to create Bitcoin Address](https://en.bitcoin.it/wiki/Address)

## LICENCE:

(The MIT License)

Copyright (c) 2020 CarlosJHR64

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
