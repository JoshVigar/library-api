# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tags index', type: :request do
  subject(:request_with_params) { get '/tags', params: params, headers: headers }

  let(:params) { {} }
  let(:headers) { { "Content-Type": 'application/vnd.api+json' } }

  let(:parsed_response) { JSON.parse(response.body) }

  it_behaves_like 'a json api enforced endpoint'

  context 'with records in the database' do
    let!(:tags_array) { create_list(:tag, 3) }

    it 'lists all tags from the database' do
      request_with_params
      aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(parsed_response['data'].size).to eql(tags_array.size)
      end
    end
  end

  context 'when nested in a book' do
    subject(:request_with_params) do
      get "/books/#{book.id}/tags", params: params, headers: headers
    end

    before do
      book.tags << book_tag
    end

    let!(:tags_array) { create_list(:tag, 3) }
    let(:book_tag) { tags_array.first }
    let!(:book) { create(:book) }

    it 'lists all tags on that book' do
      request_with_params

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(parsed_response['data'].size).to eql(book.tags.size)
      end
    end
  end

  context 'with no records in the database' do
    it 'returns an empty array' do
      request_with_params

      aggregate_failures do
        expect(response).to have_http_status(:ok)
        expect(parsed_response['data'].size).to be(0)
      end
    end
  end
end
