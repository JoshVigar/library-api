# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tags create', type: :request do
  subject(:request_with_params) { post '/tags', params: params, headers: headers }

  let(:headers) { { "Content-Type": 'application/vnd.api+json' } }
  let(:params) do
    {
      data: {
        type: 'tag',
        attributes: attributes
      }
    }.to_json
  end
  let(:attributes) { { name: tag } }
  let(:tag) { 'tag' }
  let(:parsed_response) { JSON.parse(response.body) }

  it_behaves_like 'a json api enforced endpoint'

  context 'with valid params' do
    context 'when tag does not already exist' do
      let(:expected_response) do
        {
          data: {
            id: '1',
            type: 'tag',
            attributes: {
              name: tag
            },
            relationships: {
              books: {
                data: []
              }
            }
          }
        }.deep_stringify_keys
      end

      it 'creates a new tag' do
        request_with_params

        aggregate_failures do
          expect(response).to have_http_status(:created)
          expect(parsed_response).to eql(expected_response)
        end
      end
    end

    context 'when tag already exists' do
      before { create(:tag, name: tag) }

      let(:expected_response) do
        {
          errors: {
            status: 400,
            message: {
              name: [
                'has already been taken'
              ]
            }
          }
        }.deep_stringify_keys
      end

      it 'returns an error response' do
        request_with_params

        aggregate_failures do
          expect(response).to have_http_status(:bad_request)
          expect(parsed_response).to eql(expected_response)
        end
      end
    end
  end

  context 'with invalid params' do
    let(:attributes) { {} }

    it 'returns an error response' do
      expect { request_with_params }
        .to raise_error(ActionController::ParameterMissing)
    end
  end
end
