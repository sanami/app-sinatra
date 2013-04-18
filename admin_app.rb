class AdminApp < Sinatra::Base
  enable :inline_templates

  configure :development do
    register Sinatra::Reloader
  end

  # Controllers
  get '/' do
    haml :index
  end

  get '/create_indexes' do
    Ranking.create_indexes

    redirect back
  end

  get '/create_objects' do
    count = params[:count].to_i
    if count > 0
      Ranking.create_objects(count)
    end

    redirect back
  end

  get '/delete_objects' do
    Ranking.delete_all

    redirect back
  end
end

__END__

@@ layout
%html
  = yield

@@ index
%p Objects count #{Ranking.count}

Rankings
%ul
  %li
    %a(href="/rankings?type=ranking1" target="_blank") rankings1
  %li
    %a(href="/rankings?type=ranking2" target="_blank") rankings2
  %li
    %a(href="/rankings?type=ranking3" target="_blank") rankings3

Admin
%ul
  %li
    %a(href="/create_indexes") create_indexes
  %li
    %a(href="/create_objects?count=100") create 100 objects
  %li
    %a(href="/create_objects?count=1000") create 1000 objects
  %li
    %a(href="/create_objects?count=10000") create 10000 objects
  %li
    %a(href="/delete_objects") delete all objects
