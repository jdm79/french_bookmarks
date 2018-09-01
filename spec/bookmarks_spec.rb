require 'bookmarks'

describe Bookmarks do

  describe '.all' do
    it '.all returns a list of bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      connection.exec("INSERT INTO bookmarks (title, url) VALUES('makers','http://www.makersacademy.com');")
      connection.exec("INSERT INTO bookmarks (title, url) VALUES('destroy all software','http://www.destroyallsoftware.com');")
      connection.exec("INSERT INTO bookmarks (title, url) VALUES('google','http://www.google.com');")

      bookmarks = Bookmarks.all
      expect(bookmarks).to include('makers')
      expect(bookmarks).to include('destroy all software')
      expect(bookmarks).to include('google')
    end
  end

  describe '.add' do
    it 'adds a new bookmark' do

      bookmark = Bookmarks.add(url: 'http://www.testbookmark.com', title: 'Test Bookmark')

      bookmark = Bookmarks.all.first

      expect(bookmark).to eq 'http://www.testbookmark.com'

    end

    it 'does not create a new bookmark if the URL is not valid' do
      Bookmarks.add(url: 'not a real bookmark', title: 'not real')

      expect(Bookmarks.all).not_to include 'not a real bookmark'
    end
  end

end
