module Lita
  module Handlers
    class YandexDomains < Handler

      config :pdd_token, required: false, type: String
      config :domain, required: false, type: String

      include ::YandexHelper::Regex

      def yandex_client
        @yandex_client ||= Yandex::Pdd::Client.new(config.pdd_token)
      end

      route(
          /^yandex\screate\semail\s#{EMAIL_PATTERN}$/,
          :create_email,
          command: true,
          restrict_to: :yandex_admins,
          help: {
              t('help.create_email.syntax') => t('help.create_email.desc')
          }
      )

      route(
          /^yandex\sdelete\semail\s#{EMAIL_PATTERN}$/,
          :delete_email,
          command: true,
          restrict_to: :yandex_admins,
          help: {
              t('help.delete_email.syntax') => t('help.delete_email.desc')
          }
      )

      route(
          /^yandex\sshow\sall\shuman\semails$/,
          :show_all_emails,
          command: true,
          help: {
              t('help.show_human_emails.syntax') => t('help.show_human_emails.desc')
          }
      )

      route(
          /^yandex\screate\smaillist\s#{MAILLIST_PATTERN}$/,
          :create_maillist,
          command: true,
          restrict_to: :yandex_admins,
          help: {
              t('help.create_maillist.syntax') => t('help.create_maillist.desc')
          }
      )

      route(
          /^yandex\sdelete\smaillist\s#{MAILLIST_PATTERN}$/,
          :delete_maillist,
          command: true,
          restrict_to: :yandex_admins,
          help: {
              t('help.delete_maillist.syntax') => t('help.delete_maillist.desc')
          }
      )

      route(
          /^yandex\sshow\sall\smaillists$/,
          :show_all_maillists,
          command: true,
          help: {
              t('help.show_maillists.syntax') => t('help.show_maillists.desc')
          }
      )

      route(
          /^yandex\sadd\s#{EMAIL_PATTERN}\sto\smaillist\s#{MAILLIST_PATTERN}$/,
          :add_subscriber,
          command: true,
          restrict_to: :yandex_admins,
          help: {
              t('help.add_subscriber.syntax') => t('help.add_subscriber.desc')
          }
      )

      route(
          /^yandex\sdelete\s#{EMAIL_PATTERN}\sfrom\smaillist\s#{MAILLIST_PATTERN}$/,
          :remove_subscriber,
          command: true,
          restrict_to: :yandex_admins,
          help: {
              t('help.delete_subscriber.syntax') => t('help.delete_subscriber.desc')
          }
      )

      route(
          /^yandex\sshow\ssubscribers\sfor\smaillist\s#{MAILLIST_PATTERN}$/,
          :show_subscribers,
          command: true,
          help: {
              t('help.show_subscribers.syntax') => t('help.show_subscribers.desc')
          }
      )

      def create_email(response)
        email = response.match_data['email']
        domain = email.split('@').last
        if domain == config.domain
          password = generate_passwd
          status = yandex_client.mailbox_add(options = { domain: config.domain, login: email, password: password })
          if status['success'] == 'error'
            message = status
          else
            message = "Email #{email} with password #{password} was successfully created. Please login to mailbox using https//mail.#{domain}"
          end
        else
          message = error_message(domain)
        end
        response.reply(message)
      end

      def delete_email(response)
        email = response.match_data['email']
        message = yandex_client.mailbox_delete(options = { domain: config.domain, login: email })
        response.reply(message)
      end

      def show_all_emails(response)
        show_emails(response, maillist='no')
      end

      def create_maillist(response)
        email = response.match_data['maillist']
        domain = email.split('@').last
        if domain == config.domain
          message = yandex_client.maillist_add(options = { domain: config.domain, maillist: email })
        else
          message = error_message(domain)
        end
        response.reply(message)
      end

      def delete_maillist(response)
        email = response.match_data['maillist']
        message = yandex_client.maillist_delete(options = { domain: config.domain, maillist: email })
        response.reply(message)
      end

      def show_all_maillists(response)
        emails = []
        message = yandex_client.maillist_list(domain=config.domain)
        message['maillists'].each do |maillist|
          emails.push(maillist['maillist'])
        end
        response.reply(emails)
      end

      def add_subscriber(response)
        email = response.match_data['email']
        maillist = response.match_data['maillist']
        message = yandex_client.subscription_add(options = { domain: config.domain, maillist: maillist, subscriber: email })
        response.reply(message)
      end

      def remove_subscriber(response)
        email = response.match_data['email']
        maillist = response.match_data['maillist']
        message = yandex_client.subscription_destroy(options = { domain: config.domain, maillist: maillist, subscriber: email })
        response.reply(message)
      end

      def show_subscribers(response)
        emails = []
        maillist = response.match_data['maillist']
        message = yandex_client.subscription_sublist(config.domain, maillist)
        message['subscribers'].each do |subscriber|
          emails.push(subscriber)
        end
        response.reply(emails.sort)
      end

      Lita.register_handler(self)

      private

      def show_emails(response, maillist)
        emails = []
        accounts = yandex_client.mailbox_list(config.domain, page=1, on_page=500)
        accounts['accounts'].each do |account|
          emails.push(account['login']) if account['maillist'] == maillist
        end
        response.reply(emails.sort)
      end

      def error_message(domain)
        "Domain '#{domain}' is not valid. You authorize to manage emails only for #{config.domain} domain"
      end

      def generate_passwd(length=8)
        chars = 'abcdefghjkmnpqrstuvwxyzABCDEFGHJKLMNOPQRSTUVWXYZ23456789'
        Array.new(length) { chars[rand(chars.length)].chr }.join
      end

    end
  end
end
