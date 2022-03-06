module UsersHelper

  # Returns the Gravatar for the given user
  #
  # @param user [User]
  # @param options
  def gravatar_for(user, options = { size: 80 })
    option_size = options[:size]

    gravatar_id  = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{option_size}"
    image_tag(gravatar_url, alt: user.username, class: 'gravatar')
  end
end
