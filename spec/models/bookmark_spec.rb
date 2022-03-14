require 'rails_helper'

describe Bookmark do
  it { should belong_to(:user) }
  it { should belong_to(:link_post) }
end
