module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = { size: 80 })
    gravatar_id = Digest::MD5.hexdigest(user.email.strip.downcase)

    # Gravatar URL params:
    # r=g — only allow gravatars with a 'G' rating
    # d=mp — if a gravatar does not exist for the given email hash, return a 'gray silhouette' avatar
    # s=SIZE — resize the avatar to a SIZExSIZE pixel square
    gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}?r=g&d=mp&s=#{options[:size]}"
    image_tag(gravatar_url, alt: "Profile picture of user #{user.name}",
                            class: "h-[#{options[:size]}px] w-[#{options[:size]}px] #{options[:class]} gravatar".strip)
  end
end
