class ArticlesController < ApplicationController
	# require 'rest-client'
	require 'openssl'
	def index
		url = "https://rails-backend-api-test.herokuapp.com/api/v1/articles"
		resp = Net::HTTP.get_response(URI.parse(url))
		@articles = JSON.parse(resp.body)

		# url = "http://localhost:3000/api/v1/articles"
		# body = RestClient.get(url)
		# @articles=JSON.parse(body)
	end

	def new
		
	end

	def edit
		url = "https://rails-backend-api-test.herokuapp.com/api/v1/articles/"+params[:id]
		resp = Net::HTTP.get_response(URI.parse(url))
		@article = JSON.parse(resp.body)

		# render json: @article
	end

	def update
		require 'net/http'
		response = RestClient::Request.new({
	      method: :patch,
	      url: 'https://rails-backend-api-test.herokuapp.com/api/v1/articles/'+params[:id],
	       payload: { title: params[:title], body: params[:body] },
	      headers: { :accept => :json, content_type: :json }
	    }).execute do |response, request, result|
	      case response.code
	      when 400
	        [ :error, parse_json(response.to_str) ]
	      when 200
	        redirect_to articles_path
	      else
	        fail "Invalid response #{response.to_str} received."
	      end
	    end
	#   uri = URI.parse('http://localhost:3000/api/v1/articles/1')
	# http = Net::HTTP.new(uri.host, uri.port)
	# request = Net::HTTP::Put.new(uri.request_uri)
	# request["Accept"] = "application/json"
	# request.content_type = "application/json"
	# request.body = { title: 'some value', body: 'other value' }
	# render json: request
	 # response = RestClient::Request.execute(method: :patch, url: 'http://localhost:3000/api/v1/articles/1',  payload: {"auth_token" => params[:authenticity_token]})
	end

	def show

		url = "https://rails-backend-api-test.herokuapp.com/api/v1/articles/"+params[:id]
		body = RestClient.get(url)
		@article=JSON.parse(body)
	end



end