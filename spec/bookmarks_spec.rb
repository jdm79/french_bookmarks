require 'bookmarks'

describe Bookmarks do

  describe '.all' do
    it '.all returns a list of bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.makersacademy.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.destroyallsoftware.com');")
      connection.exec("INSERT INTO bookmarks (url) VALUES('http://www.google.com');")

      bookmarks = Bookmarks.all
      expect(bookmarks).to include('http://www.makersacademy.com')
      expect(bookmarks).to include('http://www.destroyallsoftware.com')
      expect(bookmarks).to include('http://www.google.com')
    end
  end

  describe '.add' do
    it 'adds a new bookmark' do
      Bookmarks.add(url: 'http://twitter.com')
      Bookmarks.add(title: 'twitter')

      expect(Bookmarks.all).to include 'http://twitter.com'
      expect(Bookmarks.all).to include 'twitter'

    end

    it 'does not create a new bookmark if the URL is not valid' do
      Bookmarks.add(url: 'not a real bookmark')
      expect(Bookmarks.all).not_to include 'not a real bookmark'
    end
  end

end
