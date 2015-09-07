Capybara.add_selector(:delete_book_icon) do
  css { |name| %{.collection-item div:contains("#{name}") form button} }
end

Capybara.add_selector(:next_page_link) do
  css { ".pagination a:contains('chevron_right')" }
end

Capybara.add_selector(:previous_page_link) do
  css { ".pagination a:contains('chevron_left')" }
end

Capybara.add_selector(:next_page_link_disabled) do
  css { ".pagination li.disabled a:contains('chevron_right')" }
end

Capybara.add_selector(:previous_page_link_disabled) do
  css { ".pagination li.disabled a:contains('chevron_left')" }
end
