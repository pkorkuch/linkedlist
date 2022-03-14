class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :link_post
end
