# Model
class Ranking
  include Mongoid::Document

  # Create demo objects
  def self.create_objects(count)
    count.times do
      Ranking.create member: "Member #{Random.rand(1_000_000)}", ranking1: Random.rand(100), ranking2: Random.rand(100), ranking3: Random.rand(100)
    end
  end

  # Apply filter
  def self.filter(params)
    pp params

    all = self
    if params[:type].present?
      all = all.order_by(params[:type] => -1)
    end

    all
  end

  # Fields
  field :member, type: String
  field :ranking1, type: Integer
  field :ranking2, type: Integer
  field :ranking3, type: Integer

  # Indexes
  index({member: 1}, unique: false)
  index ranking1: 1
  index ranking2: 1
  index ranking3: 1
end

# REST
class RankingsApp < Sinatra::Base
  helpers Sinatra::JSON

  configure :development do
    register Sinatra::Reloader
  end

  # Index
  get '/' do
    rankings = Ranking.filter(params).limit(10)
    json rankings: rankings
  end

  # Show
  get '/:id' do
    ranking = Ranking.find(params[:id])
    json ranking: ranking
  end

  # Create
  post '/' do
    ranking = Ranking.create!(params[:ranking])
    json ranking: ranking
  end

  # Update
  put '/:id' do
    ranking = Ranking.find(params[:id])
    ranking.update_attributes(params[:ranking])
    json ranking: ranking
  end

  # Delete
  delete '/:id' do
    ranking = Ranking.find(params[:id])
    ranking.destroy
    json ranking: {}
  end
end
