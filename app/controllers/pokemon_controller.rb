class PokemonController < ApplicationController
  def show
    res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    body = JSON.parse(res.body)
    name = body["name"]
    types = body["types"].map { |type| type["type"]["name"] }

    res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{name}&rating=g")
    body = JSON.parse(res.body)
    gif_url = body["data"][rand(body["data"].length)]["url"]

    render json: {
      "id": params[:id],
      "name": name,
      "types": types,
      "gif": gif_url
    }
  end
end
