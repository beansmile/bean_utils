# BeanUtils

Rails-based base tool engine integrates a variety of services

## Usage

### Sms
TBD...

### IdVerification
TBD...

### Third-Party Application

Save third-party application data to database, make the operation and maintenance easier, you can update the data directly and add a restart step to the service if necessary.

1. New a model inheritance `BeanUtils::ThirdPartyApplication` (STI), like `BeanUtils::GoogleApplication`
2. Define the attributes in your application model
  * Normal attributes `application_attrs :api_base_uri`, this will generate these methods: `api_base_uri=`, `api_base_uri`
  * Secret attributes `application_secret_attrs :api_key, :api_secret`, this will generate these methods: `api_key=`, `api_key`(Encrypted), `api_key_decryption`(Decrypted)
3. Defining method like `api_config`, then you can use it where you want to use it.
4. Make your Admin-end of this module.

Example: using in your third-party request client.

```ruby
# models/bean_utils/google_application.rb
def api_config
 {
   api_base_uri: api_base_uri,
   api_key: api_key_decryption,
   api_secret: api_secret_decryption,
 }
end
```

```ruby
# lib/google/client.rb
module Google
  class Client
    include HTTParty

    class << self
      def config
        ::BeanUtils::GoogleApplication.first.api_config
      end
    end

    def http_post()
      post(path, body: body, headers: headers)
    end

    def headers
      { api_key: Google::Client.config.dig(:api_key) }
    end
  end
end

Google::Client.base_uri Google::Client.config.dig(:api_base_uri)
```

## Installation

Add this line to your application's Gemfile:

1. Copy repo to your rails project, like `engines/`
2. Add this to your gemfile `gem 'bean_utils', path: 'engines/bean_utils'`
3. Run `bundle install`
4. Run `rake bean_utils:install:migrations` generate migrations
5. Delete the migrations files that are not needed for this project
6. Run `rake db:migrate`

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
