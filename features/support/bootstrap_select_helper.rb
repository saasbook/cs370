#src: https://gist.github.com/aldreth/9137121e5d88b122dfb3
module BootstrapSelectHelper
  # e.g., bootstrap_select 'General', from: 'Project Type'
  def bootstrap_select(value, attrs)
    within find('label', text: attrs[:from].to_s).find(:xpath, '..') do
      find('button.dropdown-toggle').click
      select_option = find('.dropdown-menu li', text: value)
      #sleep(0.001) # wait for click handle to bind to select_option
      select_option.click
      expect(page).to have_css('button', text: value)

      # collapse dropdown if select is multiple,
      # so it doesn't block interaction with other fields
      is_multiple = find('select', visible: false)[:multiple] # true/false
      find('button.dropdown-toggle').click if is_multiple
    end
  end
end
World(BootstrapSelectHelper)
