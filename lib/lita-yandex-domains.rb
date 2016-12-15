require 'lita'

require 'yandexhelper/regex'
require 'yandex-pdd-2'

Lita.load_locales Dir[File.expand_path(
  File.join("..", "..", "locales", "*.yml"), __FILE__
)]

require 'lita/handlers/yandex_domains'

Lita::Handlers::YandexDomains.template_root File.expand_path(
  File.join("..", "..", "templates"),
 __FILE__
)
