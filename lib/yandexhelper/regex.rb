module YandexHelper
  module Regex
    EMAIL_PATTERN = /(?<email>[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+)/i
    MAILLIST_PATTERN = /(?<maillist>[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+)/i

  end
end