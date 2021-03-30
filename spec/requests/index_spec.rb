# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books index', type: :request do
  subject { get '/books', params: params }

  let(:params) { {} }

  context 'with records in the database' do
    let!(:books_array) { create_list(:book, 3) }
    context 'with no filter params' do
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

      it 'returns an array of all books' do
        subject

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to match_array(expected_response)
        end
      end
    end
    context 'with title filter param' do
      let(:params) { { filter: { title: filtered_book[:title] } } }
      let(:filtered_book) { books_array.first }
      let(:book_json) do
        [{
          id: filtered_book.id.to_s,
          type: 'book',
          attributes: {
            title: filtered_book.title,
            author: filtered_book.author,
            description: filtered_book.description
          }
        }]
      end
      let(:expected_response) { { data: book_json }.deep_stringify_keys }

      it 'returns only the book with filtered title' do
        subject

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to match_array(expected_response)
        end
      end
    end
  end

  context 'with no records in the database' do
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
