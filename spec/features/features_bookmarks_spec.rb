feature 'Bookmarks features' do

  scenario 'homepage displays welcome message' do
    visit('/')
    expect(page).to have_content('Welcome')
  end

  scenario 'a user can see bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO bookmarks VALUES(1, 'http://www.makersacademy.com');")
    connection.exec("INSERT INTO bookmarks VALUES(2, 'http://www.destroyallsoftware.com');")
    connection.exec("INSERT INTO bookmarks VALUES(3, 'http://www.google.com');")

    visit('/bookmarks')
    expect(page).to have_content('http://www.makersacademy.com')
    expect(page).to have_content('http://www.destroyallsoftware.com')
    expect(page).to have_content('http://www.google.com')
  end

  scenario 'a user can bookmark a page' do
    visit('/add_bookmark')
    fill_in :url, with: "www.franceinter.fr"
    click_button 'Submit'
    expect(page).to have_content("www.franceinter.fr")
  end


end
