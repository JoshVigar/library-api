# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books index', type: :request do
  subject { get '/books' }

  context 'There are records in the database' do
    let!(:books_array) { create_list(:book, 3) }
    let(:books_array_json) do
      books_array.map do |book|
        {
          id: book.id.to_s,
          type: 'book',
          attributes: {
            title: book.title,
            author: book.author,
            description: book.description
          }
        }
      end
    end
    let(:expected_response) { { data: books_array_json }.deep_stringify_keys }

    it 'returns an array of all book titles' do
      subject

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        pp JSON.parse(response.body)
        puts '------------------------------'
        pp expected_response
        expect(JSON.parse(response.body)).to match_array(expected_response)
      end
    end
  end

  context 'There are no records in the database' do
    let(:expected_response) { { data: [] }.stringify_keys }

    it 'returns an empty array' do
      subject

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eql(expected_response)
      end
    end
  end
end
