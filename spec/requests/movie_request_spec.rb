require 'rails_helper'
require 'date'

RSpec.describe "Movies", type: :request do


  describe "GET /api/v1/movies" do

    it "gets all the movies" do
      create_list(:movie, 20)

      get '/api/v1/movies'

      json = JSON.parse(response.body)

      expect(json.length).to eq(20)
    end
  end

  describe 'POST /api/v1/movies' do

    it "creates a new movie" do
      params = { title: "New Movie",
                 rating: 9.12,
                 description: "It's amazing",
                 genre: "Horror",
                 release_date: Date.new(2002, 4, 3).strftime('%a, %d %b %Y') }

      post '/api/v1/movies', { params: { movie: params } }
      json = JSON.parse(response.body)
      expect(json['title']).to eq("New Movie")
      expect(json['rating']).to eq("9.12")
      expect(json['description']).to eq("It's amazing")
      expect(json['genre']).to eq("Horror")
    end
  end

  describe 'GET api/v1/movies/1' do

    it "gets one movie" do
      movie = create(:movie)

      get "/api/v1/movies/#{movie.id}"
      json = JSON.parse(response.body)

      expect(json['description']).to eq(movie.description)
    end
  end

  describe 'PUT api/v1/movies/1' do

    it 'edits a movie' do
      movie = create(:movie)
      new_descr = "This is a new descr"
      params = { description: new_descr }

      put "/api/v1/movies/#{movie.id}", { params: { movie: params } }
      json = JSON.parse(response.body)

      expect(json['description']).to eq(new_descr)

    end
  end
end
