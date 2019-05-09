
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /the login page/
      new_tutee_session_path

    when /the user page for "(.*)"$/
      tutee_path(Tutee.find_by_email($1)[:id])

    when /the update page for "(.*)"$/
      edit_tutee_registration_path(Tutee.find_by_email($1)[:id])

    when /the create account page/
      new_tutee_registration_path

    when /"(.*)'s" tutee page$/
      tutee_path(Tutee.find_by_first_name($1))


    when /^the home\s?page$/
      '/'

    when /the admin landing page/
      admin_landing_path
      
    when /the admin home page/
      admin_home_path

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)
