require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmarks'

class BookmarkManager < Sinatra::Base
  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb :index
  end

  get '/bookmarks' do
    @bookmarks = Bookmarks.all
    erb :bookmarks
  end

  get '/add_bookmark' do
    erb :add_bookmark
  end

  post '/add_bookmark' do
    # @url = params[:url]
    # Bookmarks.add(@url)
    flash[:notice] = 'You must submit a valid URL.' unless Bookmarks.add(url: params['url'])
    redirect '/bookmarks'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
