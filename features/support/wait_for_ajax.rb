module WaitForAjax
  #from https://blog.cloudinvaders.com/wait-for-ajax/
  def wait_for_ajax
    Timeout.timeout(Capybara.default_max_wait_time) do
      loop do
        active = page.execute_script('jQuery.active')
        break if active == 0
      end
    end
  end
end
World(WaitForAjax)
