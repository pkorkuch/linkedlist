module UsersHelper
  # Returns the Gravatar for the given user.
  def gravatar_for(user, options = {})
    gravatar_id = Digest::MD5.hexdigest(user.email.strip.downcase)
    gravatar_url = "https://www.gravatar.com/avatar/#{gravatar_id}?r=g&d=mp"
    image_tag(gravatar_url, alt: "Profile picture of user #{user.name}", class: "#{options[:class]} gravatar")
  end
end
