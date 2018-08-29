require 'bookmarks'

describe Bookmarks do

  it '.all returns a list of bookmarks' do
    bookmarks = Bookmarks.all
    expect(bookmarks).to include(['http://www.makersacademy.com',
    'http://www.twitter.com', 'http://www.destroyallsoftware.com'])
  end

end
