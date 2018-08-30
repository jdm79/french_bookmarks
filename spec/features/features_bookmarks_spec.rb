feature 'Bookmarks features' do

  scenario 'homepage displays welcome message' do
    visit('/')
    expect(page).to have_content('Welcome')
  end

  scenario 'a user can see bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    Bookmarks.add(url: 'http://www.makersacademy.com')
    Bookmarks.add(url: 'http://www.destroyallsoftware.com')
    Bookmarks.add(url: 'http://www.google.com')

    visit('/bookmarks')
    expect(page).to have_content('http://www.makersacademy.com')
    expect(page).to have_content('http://www.destroyallsoftware.com')
    expect(page).to have_content('http://www.google.com')
  end

  scenario 'a user can bookmark a page' do
    visit('/add_bookmark')
    fill_in('url', with: 'http://www.franceinter.fr')
    click_button 'Submit'
    expect(page).to have_content('http://www.franceinter.fr')
  end

  scenario 'a user cannot bookmark an invalid URL' do
    visit('/add_bookmark')
    fill_in :url, with: "James est fatigué"
    click_button 'Submit'
    expect(page).not_to have_content('James est fatigué')
    expect(page).to have_content('You must submit a valid URL.')
  end


end
