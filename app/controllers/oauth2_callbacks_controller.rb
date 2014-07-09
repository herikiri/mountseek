require 'youtube_it'

class Oauth2CallbacksController < ApplicationController
  def google

    if params[:code]
      conn = Faraday.new(:url => 'https://accounts.google.com',:ssl => {:verify => false}) do |faraday|
       faraday.request  :url_encoded
       faraday.response :logger
       faraday.adapter  Faraday.default_adapter
      end

      result = conn.post '/o/oauth2/token', {
        'code' => params[:code], 
        'client_id' => Settings.google_client_id,
        'client_secret' => Settings.google_client_secret,
        'redirect_uri' => Settings.google_redirect_uri,
        'grant_type' => 'authorization_code'}
    
      access_token_line = result.body.lines.second
      expires_in_line = result.body.lines.fourth
      refresh_token_line = result.body.lines.fifth

      key, access_token_value = access_token_line.split ': ', 2
      key, expires_in_value = expires_in_line.split ': ', 2
      key, refresh_token_value = refresh_token_line.split ': ', 2

      access_token = access_token_value.gsub(/"/, "").gsub(/,/,"").gsub("\n","")
      expires_at = expires_in_value.gsub(/"/, "").gsub(/,/,"").gsub("\n","")
      refresh_token = refresh_token_value.gsub(/"/, "").gsub(/,/,"").gsub("\n","")

      # Store oauth2 results to session variable
      session[:oauth2_result] = []
      session[:oauth2_result][0] = access_token
      session[:oauth2_result][1] = expires_at
      session[:oauth2_result][2] = refresh_token
  
      redirect_to session[:redirect_uri]

    else
      redirect_to session[:redirect_uri]
    end

  end

end
