# lita-yandex-domains

[![Build Status](https://travis-ci.org/DevicoSolutions/lita-yandex-domains.svg?branch=master)](https://travis-ci.org/DevicoSolutions/lita-yandex-domains)
[![Coverage Status](https://coveralls.io/repos/github/DevicoSolutions/lita-yandex-domains/badge.svg?branch=master)](https://coveralls.io/github/DevicoSolutions/lita-yandex-domains?branch=master)

Lita handler to interact with yandex domain API

## Installation

Add lita-yandex-domains to your Lita instance's Gemfile:

``` ruby
gem 'lita-yandex-domains'
```

## Configuration

### Required attributes

[How to get PDD token](https://tech.yandex.com/domain/doc/concepts/access-docpage/)

* `pdd_token` (String) - Yandex PDD Token. Default: `nil`.
 
* `domain` (String) - Your domain name that is linked to yandex domain service. Default: `nil`.

### Example

``` ruby
Lita.configure do |config|
  config.handlers.yandex_domains.pdd_token  = 'XXXXXXX'
  config.handlers.yandex_domains.domain = 'example.com'
end
```

## Usage

Please note 

```
yandex show all human emails - Show all emails that not include mailing lists
yandex show all maillists - Show all maillists
yandex add email <email> - Add email with random generated password
yandex delete email <email> - Delete user email
yandex add maillist <email> - Add maillist
yandex delete maillist <email> - Delete maillist
yandex add <email> to maillist <email> - Add subcriber to maillist
yandex delete <email> from maillist <email> - Remove subcriber from maillist
```

*Note:* The above commands except show commands require that the user be a member of the `:yandex_admins` authorization group.
For example: to add admin for ```lita yandex domain``` run the following command - ``` Lita, auth add username yandex_admins ```

## License

[MIT](http://opensource.org/licenses/MIT)
