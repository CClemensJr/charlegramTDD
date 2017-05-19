require 'rails_helper.rb'

feature 'Deleting posts' do
  background do
    user = create(:user)
    post = create(:post, caption: 'Glutes for days.')

    sign_in_with user

    find(:xpath, "//a[contains(@href,'posts/1')]").click
    click_link 'Edit'
  end

  scenario 'Can delete a post' do
    click_link 'Delete'

    expect(page).to have_content("Problem solved! Post deleted.")
    expect(page).to_not have_content('Abs for days')
  end
end
