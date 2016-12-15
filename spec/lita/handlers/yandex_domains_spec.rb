require "spec_helper"

describe Lita::Handlers::YandexDomains, lita_handler: true do

  before do
    robot.auth.add_user_to_group!(user, :yandex_admins)
  end

  describe 'lita routes' do
    it { is_expected.to route_command('yandex create email test@test.com').to(:create_email).with_authorization_for(:yandex_admins) }
    it { is_expected.to route_command('yandex delete email test@test.com').to(:delete_email).with_authorization_for(:yandex_admins) }
    it { is_expected.to route_command('yandex show all human emails').to(:show_all_emails) }
    it { is_expected.to route_command('yandex create maillist maillist@test.com').to(:create_maillist).with_authorization_for(:yandex_admins) }
    it { is_expected.to route_command('yandex delete maillist maillist@test.com').to(:delete_maillist).with_authorization_for(:yandex_admins) }
    it { is_expected.to route_command('yandex show all maillists').to(:show_all_maillists) }
    it { is_expected.to route_command('yandex add test@devico.io to maillist maillist@test.com').to(:add_subscriber).with_authorization_for(:yandex_admins) }
    it { is_expected.to route_command('yandex delete test@devico.io from maillist maillist@test.com').to(:remove_subscriber).with_authorization_for(:yandex_admins) }
  end

end
