require 'btc'
include BTC

# IRB Tools
require 'irbtools/configure'
_ = BTC::VERSION.split('.')[0..1].join('.')
Irbtools.welcome_message = "### BTC(#{_}) ###"
require 'irbtools'
IRB.conf[:PROMPT][:BTC] = {
  PROMPT_I:    '> ',
  PROMPT_N:    '| ',
  PROMPT_C:    '| ',
  PROMPT_S:    '| ',
  RETURN:      "=> %s \n",
  AUTO_INDENT: true,
}
IRB.conf[:PROMPT_MODE] = :BTC
