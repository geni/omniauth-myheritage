# OmniAuth MyHeritage

MyHeritage OAuth2 Strategy for OmniAuth 1.0.

Supports the OAuth 2.0 server-side. Read the MyHeritage docs for more details: http://www.familygraph.com/documentation/authentication

## Installing

Add to your `Gemfile`:

```ruby
gem 'omniauth-myheritage'
```

Then `bundle install`.

## Usage

`OmniAuth::Strategies::MyHeritage` is simply a Rack middleware. Read the OmniAuth 1.0 docs for detailed instructions: https://github.com/intridea/omniauth.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :myheritage, ENV['MY_HERITAGE_KEY'], ENV['MY_HERITAGE_SECRET']
end
```

## Configuring

You can configure several options, which you pass in to the `provider` method via a `Hash`:

* `scope`: A comma-separated list of permissions you want to request from the user. See the MyHeritage docs for a full list of available permissions. Default: `email`.

For example, to request `email` permission:
 
```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :myheritage, ENV['MY_HERITAGE_KEY'], ENV['MY_HERITAGE_SECRET'], :scope => 'email'
end
```

## Authentication Hash

Here's an example *Authentication Hash* available in `request.env['omniauth.auth']`:

```ruby
{
  :provider => 'myheritage',
  :uid => '123',
  :info => {
    :first_name => 'Alex',
    :last_name => 'Thompson',
    :email => 'alex@sample.com',
    :name => 'Alex Thompson'
  },
  :credentials => {
    :token => 'ABCDEF...',      # OAuth 2.0 access_token
    :expires_at => 1321747205   # when the access token expires
  },
  :extra => {
    :profile => {
      :id => '1234567',
      :name => 'Alex Thompson',
      :first_name => 'Alex',
      :last_name => 'Thompson'
    }
  }
}
```

The precise information available may depend on the permissions which you request.
