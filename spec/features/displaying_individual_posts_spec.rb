require 'rails_helper.rb'

feature 'Can view individual posts' do
  background do
    user = create(:user)
    post = create(:post)

    sign_in_with user
  end

  scenario 'Can click and vew a single post' do
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    expect(page.current_path).to eq(post_path(1))
  end
end
