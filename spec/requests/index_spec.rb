# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books index', type: :request do
  subject { get '/books' }

  context 'There are records in the database' do
    before do
      create(:book, title: 'title-one')
      create(:book, title: 'title-two')
      create(:book, title: 'title-three')
    end

    let(:expected_response) { %w[title-one title-two title-three] }

    it 'returns an array of all book titles' do
      subject

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to match_array(expected_response)
      end
    end
  end

  context 'There are no records in the database' do
    let(:expected_response) { [] }

    it 'returns an empty array' do
      subject

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eql(expected_response)
      end
    end
  end
end
