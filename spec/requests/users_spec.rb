require 'rails_helper'

RSpec.describe '/users' do
  let(:path) { '/users' }
  let!(:user) { create(:user, email: 'test@email.com', name: 'test') }

  describe 'GET /' do
    let(:path) { super() + '/' }

    it 'returns all the users' do
      get path

      expect(response.body).to have_json_size(1)
      expect(response.body).to have_json_path('0/id')
      expect(response.body).to have_json_type(Integer).at_path('0/id')

      expect(response.body).to have_json_path('0/email')
      expect(response.body).to have_json_type(String).at_path('0/email')

      expect(response.body).to have_json_path('0/name')
      expect(response.body).to have_json_type(String).at_path('0/name')
    end
  end

  describe 'GET /:id' do
    let(:path) { super() + "/#{user.id}" }

    it 'returns all the users' do
      get path

      expect(response.body).to have_json_path('id')
      expect(response.body).to have_json_type(Integer).at_path('id')

      expect(response.body).to have_json_path('email')
      expect(response.body).to have_json_type(String).at_path('email')

      expect(response.body).to have_json_path('name')
      expect(response.body).to have_json_type(String).at_path('name')

      parsed = parse_json(response.body)
      expect(parsed['id']).to eq user.id
      expect(parsed['email']).to eq user.email
      expect(parsed['name']).to eq user.name
    end
  end
end
