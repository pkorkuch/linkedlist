require 'rails_helper'

describe UserMailer do
  describe 'account_activation' do
    it 'renders the headers' do
      user = create(:user)
      mail = UserMailer.with(user: user).account_activation
      expect(mail.subject).to eq('Activate your linkedList account.')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@linkedlist.korkuch.dev'])
    end

    it 'renders the body' do
      # user.activation_token is not idempotent if time is
      # not frozen, since the token contains an expiration time based on the
      # current time.
      freeze_time do
        user = create(:user)
        mail = UserMailer.with(user: user).account_activation
        expect(mail.body.encoded).to match('Activate Account')
        expect(mail.body.encoded).to match(activate_users_url(user.activation_token))
      end
    end
  end
end
