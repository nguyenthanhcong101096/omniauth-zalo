# OmniAuth::Zalo

OmniAuth strategy for [Sign In with Zalo](https://developers.zalo.me/).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-zalo'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install omniauth-zalo

## Usage
omniauth.rb

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :zalo, ENV['APP_ID'], env['SERECT_ID']
end
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/nguyenthanhcong101096/omniauth-zalo

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

