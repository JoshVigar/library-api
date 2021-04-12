# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Books create', type: :request do
  subject(:request_with_params) do
    post '/books', params: params.to_json, headers: headers
  end

  let(:headers) { { "Content-Type": 'application/vnd.api+json' } }
  let(:params) do
    {
      data: {
        type: 'book',
        attributes: attributes
      }
    }
  end
  let(:attributes) do
    {
      title: 'a title',
      author: 'an author',
      description: 'a description'
    }
  end

  it_behaves_like 'a json api enforced endpoint'

  context 'with no items in the database' do
    let(:params) do
      {
        data: {
          type: 'book',
          attributes: attributes
        }
      }
    end

    context 'with valid params' do
      let(:attributes) do
        {
          title: title,
          author: author,
          description: description
        }
      end
      let(:expected_attributes) do
        {
          id: 1,
          title: title,
          author: author,
          description: description
        }
      end

      let(:title) { 'a-book-title' }
      let(:author) { 'a-book-author' }
      let(:description) { 'a-book-desc' }

      it 'creates a book with the given attributes' do
        aggregate_failures do
          expect { request_with_params }.to change(Book, :count).from(0).to(1)
          expect(Book.first.attributes)
            .to eql(expected_attributes.stringify_keys)
          expect(response).to have_http_status(:created)
        end
      end
    end

    context 'with extra params' do
      let(:attributes) do
        {
          title: title,
          author: author,
          description: description,
          beans: 'baked'
        }
      end
      let(:expected_attributes) do
        {
          id: 1,
          title: title,
          author: author,
          description: description
        }
      end

      let(:title) { 'a-book-title' }
      let(:author) { 'a-book-author' }
      let(:description) { 'a-book-desc' }

      it 'creates a book ignoring extra parameter' do
        aggregate_failures do
          expect { request_with_params }.to change(Book, :count).from(0).to(1)
          expect(Book.first.attributes)
            .to eql(expected_attributes.stringify_keys)
          expect(response).to have_http_status(:created)
        end
      end
    end

    context 'with invalid params' do
      context 'with missing parameter' do
        let(:params) do
          {
            data: {
              attributes: {}
            }
          }
        end

        it 'throws a ParameterMissing exception' do
          aggregate_failures do
            expect { request_with_params }.not_to(change(Book, :count))
            expect(response).to have_http_status(:bad_request)
          end
        end
      end

      context 'with validation error' do
        let(:attributes) do
          {
            description: description
          }
        end

        let(:description) { 'a-book-desc' }

        it 'throws a ParameterMissing exception' do
          aggregate_failures do
            expect { request_with_params }.not_to(change(Book, :count))
            expect(response).to have_http_status(:bad_request)
          end
        end
      end
    end
  end
end
