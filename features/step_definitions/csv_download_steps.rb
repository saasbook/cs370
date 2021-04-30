When('I download {string}') do |link|
  if Capybara.current_driver == :selenium
    href = find_link(link)['href']
    result = page.evaluate_async_script(<<~JS, href)
      let [url, done] = arguments
      fetch(url).then((response) => {
        if (response.status >= 400) {
          done({ error: 'download failed' })
        } else {
          window.lastResponse = response
          done({ content_disposition: response.headers.get('Content-Disposition') })
        }
      })
    JS
    expect(result['error']).to eq(nil), result['error']
    @content_disposition = result['content_disposition']
  else
    @content_disposition = response_headers['Content-Disposition']
  end
end

Then('the download should have the filename {string}') do |filename|
  expect(@content_disposition).to match(/.*filename=\"#{filename}\".*/)
end

Then('the downloaded file content should include the following lines:') do |table|
  if Capybara.current_driver == :selenium
    file_content = page.evaluate_async_script(<<~JS)
      let [done] = arguments
      lastResponse.text().then((text) => {
        done(text)
      })
    JS
    single_line_file = file_content.gsub("\n", '').gsub('  ', '')

    table.raw.each do |row|
      expect(single_line_file).to include(*row), "expected \n file to include \n #{row} \n"
    end
  else
    raise 'not implemented for driver'
  end
end
