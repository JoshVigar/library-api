# frozen_string_literal: true

RSpec.shared_examples 'a json api enforced endpoint' do
  subject { request_with_params }

  let(:request_with_params) { raise 'request path not defined in spec' } unless method_defined?(:request_with_params)

  context 'with valid headers' do
    let(:headers) { { 'Content-Type' => 'application/vnd.api+json' } }

    it 'is a valid request' do
      request_with_params

      expect(response).to have_http_status(:success)
    end
  end

  context 'with invalid Content-Type header' do
    let(:headers) { { 'Content-Type' => 'text/html' } }

    it 'returns a status 406' do
      request_with_params

      expect(response).to have_http_status(:not_acceptable)
    end
  end

  context 'with invalid Accept header' do
    let(:headers) do
      { 'Content-Type' => 'application/vnd.api+json',
        'Accept' => 'application/vnd.api+json;blah=blah' }
    end

    it 'returns a status 415' do
      request_with_params

      expect(response).to have_http_status(:unsupported_media_type)
    end
  end
end
