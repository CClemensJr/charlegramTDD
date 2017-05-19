require 'rails_helper.rb'

feature 'editing posts' do
  background do
    user        = create(:user)
    second_user = create(:user, email:     'ninja@warrior.com',
                                user_name: 'aoshi',
                                password:  'shinomori',
                                id:        user.id + 1)

    post        = create(:post)
    second_post = create(:post, user_id: user.id + 1)

    sign_in_with user
    visit '/'
  end

  scenario 'can edit a post as the owner' do
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    expect(page).to have_content('Edit')

    click_link 'Edit'
    fill_in 'Caption', with: "Whoopsie, you weren’t meant to see that!"
    click_button 'Update'

    expect(page).to have_content("Post updated hombre")
    expect(page).to have_content("Whoopsie, you weren’t meant to see that!")
  end

  scenario 'cannot edit a post via show page that doesnt belong to user' do
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    expect(page).to_not have_content('Edit')
  end

  scenario 'cannot edit a post via url that doesnt belong to user' do
    visit '/posts/2/edit'

    expect(page.current_path).to eq root_path
    expect(page).to have_content("That post doesn't belong to you!")
  end

  scenario  "won't update a post without an image" do
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    click_link 'Edit'
    attach_file('Image', 'spec/files/coffee.txt')
    click_button 'Update'

    expect(page).to have_content("Something is wrong with your form!")
  end
end
