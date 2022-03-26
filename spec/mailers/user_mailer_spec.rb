require 'rails_helper'

describe UserMailer do
  describe 'account_activation' do
    it 'renders the headers' do
      user = create(:user)
      mail = UserMailer.account_activation(user)
      expect(mail.subject).to eq('Activate your LinkedList account.')
      expect(mail.to).to eq([user.email])
      expect(mail.from).to eq(['noreply@example.com'])
    end

    it 'renders the body' do
      # Repeated calls to user.activation_token are not idempotent if time is
      # not frozen, since the token contains an expiration time based on the
      # current time.
      freeze_time do
        user = create(:user)
        mail = UserMailer.account_activation(user)
        expect(mail.body.encoded).to match('Activate Account')
        expect(mail.body.encoded).to match(activate_users_url(user.activation_token))
      end
    end
  end
end
