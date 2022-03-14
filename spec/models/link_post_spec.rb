require 'rails_helper'

describe LinkPost do
  context 'validations' do
    it { should validate_presence_of(:link_text) }
    it { should validate_presence_of(:content) }
    it { should validate_presence_of(:link) }
    it { should validate_length_of(:link_text).is_at_most(75) }
    it { should validate_length_of(:content).is_at_most(500) }
    it { should validate_length_of(:link).is_at_most(2000) }
  end

  it { should have_implicit_order_column('created_at') }

  context 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:users).through(:bookmarks) }
  end

  context 'link format validation' do
    it { should allow_value('http://www.example.com').for(:link) }
    it { should allow_value('https://www.example.com').for(:link) }
    it { should allow_value('http://example.com').for(:link) }
    it { should allow_value('https://example.com').for(:link) }
    it { should allow_value('http://www.example.com/').for(:link) }
    it { should allow_value('https://www.example.com/').for(:link) }
    it { should allow_value('http://example.com/').for(:link) }
    it { should allow_value('https://example.com/').for(:link) }

    it { should allow_value('http://www.example.com/?').for(:link) }
    it { should allow_value('https://www.example.com/?').for(:link) }
    it { should allow_value('http://example.com/?').for(:link) }
    it { should allow_value('https://example.com/?').for(:link) }

    it { should allow_value('http://www.example.com/?key=value').for(:link) }
    it { should allow_value('https://www.example.com/?key=value').for(:link) }
    it { should allow_value('http://example.com/?key=value').for(:link) }
    it { should allow_value('https://example.com/?key=value').for(:link) }

    it { should allow_value('http://www.example.com/?key=value&key=value').for(:link) }
    it { should allow_value('https://www.example.com/?key=value&key=value').for(:link) }
    it { should allow_value('http://example.com/?key=value&key=value').for(:link) }
    it { should allow_value('https://example.com/?key=value&key=value').for(:link) }

    it { should_not allow_value('ftp://www.example.com').for(:link) }
    it { should_not allow_value('mailto://www.example.com').for(:link) }
    it { should_not allow_value('irc://www.example.com').for(:link) }
    it { should_not allow_value('file://www.example.com').for(:link) }
    it { should_not allow_value('data://www.example.com').for(:link) }
    it { should_not allow_value('javascript://www.example.com').for(:link) }

    it { should_not allow_value('ftp://www.example.com').for(:link) }
    it { should_not allow_value('mailto:example@example.com').for(:link) }
    it { should_not allow_value('irc://www.example.com:6667/test').for(:link) }
    it { should_not allow_value('file://example/file').for(:link) }
    it {
      should_not allow_value('data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==').for(:link)
    }
    it { should_not allow_value('javascript:alert();').for(:link) }

    it { should_not allow_value('http:www.example.com').for(:link) }
    it { should_not allow_value('https:www.example.com').for(:link) }

    it { should_not allow_value('http://').for(:link) }
    it { should_not allow_value('https://').for(:link) }

    it { should_not allow_value('http:///').for(:link) }
    it { should_not allow_value('https:///').for(:link) }

    it { should_not allow_value('http://user@www.example.com').for(:link) }
    it { should_not allow_value('https://user@www.example.com').for(:link) }
    it { should_not allow_value('http://user@example.com').for(:link) }
    it { should_not allow_value('https://user@example.com').for(:link) }

    # it { should_not allow_value('http://user@www.example.com:80').for(:link) }
    # it { should_not allow_value('https://user@www.example.com:443').for(:link) }
    # it { should_not allow_value('http://user@example.com:80').for(:link) }
    # it { should_not allow_value('https://user@example.com:443').for(:link) }

    # it { should_not allow_value('http://www.example.com:80').for(:link) }
    # it { should_not allow_value('https://www.example.com:443').for(:link) }
    # it { should_not allow_value('http://example.com:80').for(:link) }
    # it { should_not allow_value('https://example.com:443').for(:link) }
  end

  describe '.newest' do
    it 'is the most recently created link post' do
      newest = create(:link_post)
      create(:link_post, created_at: 5.minutes.ago)
      create(:link_post, created_at: 10.minutes.ago)

      expect(LinkPost.newest).to eq(newest)
    end
  end

  describe '.newest_to_oldest' do
    it 'is all link posts ordered from newest created to oldest created' do
      newest = create(:link_post)
      oldest = create(:link_post, created_at: 10.minutes.ago)
      middle = create(:link_post, created_at: 5.minutes.ago)

      expect(LinkPost.newest_to_oldest).to eq([newest, middle, oldest])
    end
  end
end
