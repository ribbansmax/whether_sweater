require 'rails_helper'

describe "Pexels API" do
  it "sends an image" do
    VCR.use_cassette("image_denver") do
      get "/api/v1/backgrounds?location=denver,co"

      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)[:data]

      expect(data.keys).to eq([:id, :type, :attributes])

      data = data[:attributes]

      expect(data.keys).to eq([:location, :image_url, :credit])

      expect(data[:credit].keys).to eq([:source, :author, :author_page])
    end
  end

  it 'sad path, detects no location given' do
    get "/api/v1/backgrounds?location="

    expect(response.status).to eq(400)

    data = JSON.parse(response.body, symbolize_names: true)

    expect(data[:error]).to eq('no location given')
  end

  it 'sad path, no picture matches search' do
    VCR.use_cassette('bad_picture_search') do
      get "/api/v1/backgrounds?location=adjashdwaqs89jkqwoiqqw09202"

      expect(response.status).to eq(404)
  
      data = JSON.parse(response.body, symbolize_names: true)
  
      expect(data[:error]).to eq('no pictures match search')
    end
  end
end