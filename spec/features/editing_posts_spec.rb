require 'rails_helper.rb'

feature 'Editing posts' do
  background do
    post = create(:post)

    visit '/'
    find(:xpath, "//a[contains(@href,'posts/1')]").click
    click_link 'Edit'
  end

  scenario 'Can edit a post' do
    fill_in 'Caption', with: "Whoopsie, you weren’t meant to see that!"
    click_button 'Update'

    expect(page).to have_content("Post updated hombre")
    expect(page).to have_content("Whoopsie, you weren’t meant to see that!")
  end

  it  "won't update a post without an image" do
    attach_file('Image', 'spec/files/coffee.txt')
    click_button 'Update'

    expect(page).to have_content("Something is wrong with your form!")
  end
end
