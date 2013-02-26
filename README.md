exchange-rate
=============

**Several notes:**

 - Rails seems to be a kind of overkill here, I would rather use Sinatra app instead. But the task is the task.
 - I thought about wrapping ExchangeRate lib into a gem, but changed my mind in favor of simplicity.
 - Local storage. I have choosen the simplest way: file system and YAML format. I understand that it might not work in some environments, such as Heroku with that readonly file system. I could use database instead, but it would me more complicated.

 **ExchangeRate** lib itself can be found in <code>/lib/exchange_rate.rb</code>.
