# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books index', type: :request do
  subject(:request_with_params) { get '/books', params: params, headers: headers }

  let(:params) { {} }
  let(:headers) { { "Content-Type": 'application/vnd.api+json' } }

  it_behaves_like 'a json api enforced endpoint'

  context 'with records in the database' do
    let!(:books_array) { create_list(:book, 3) }

    context 'with includes in the database' do
      let!(:reviews_array) { create_list(:review, 3, book: books_array.first) }

      let(:books_array_json) do
        books_array.map do |book|
          {
            id: book.id.to_s,
            type: 'book',
            attributes: {
              title: book.title,
              author: book.author,
              description: book.description
            },
            relationships: {
              reviews: {
                data: book.reviews.map do |review|
                        {
                          id: review.id.to_s,
                          type: 'review'
                        }
                      end
              }
            }
          }
        end
      end

      let(:reviews_array_json) do
        reviews_array.map do |review|
          {
            id: review.id.to_s,
            type: 'review',
            attributes: {
              rating: review.rating,
              comment: review.comment,
              user_name: review.user_name
            },
            relationships: {
              book: {
                data: {
                  id: review.book.id.to_s,
                  type: 'book'
                }
              }
            }
          }
        end
      end
      let(:expected_response) do
        { data: books_array_json }
          .merge({ included: reviews_array_json }).deep_stringify_keys
      end

      it 'returns an array of all books with reviews includes' do
        request_with_params

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to match_array(expected_response)
        end
      end
    end

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
            },
            relationships: {
              reviews: {
                data: []
              }
            }
          }
        end
      end
      let(:expected_response) do
        { data: books_array_json }.merge({ included: [] }).deep_stringify_keys
      end

      it 'returns an array of all books' do
        request_with_params

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
          },
          relationships: {
            reviews: {
              data: []
            }
          }
        }]
      end
      let(:expected_response) do
        { data: book_json }.merge({ included: [] }).deep_stringify_keys
      end

      it 'returns only the book with filtered title' do
        request_with_params

        aggregate_failures do
          expect(response).to have_http_status(:ok)
          expect(JSON.parse(response.body)).to match_array(expected_response)
        end
      end
    end
  end

  context 'with no records in the database' do
    let(:expected_response) do
      { data: [] }.merge({ included: [] }).stringify_keys
    end

    it 'returns an empty array' do
      request_with_params

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eql(expected_response)
      end
    end
  end
end
