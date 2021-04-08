# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Validators::JsonapiHeaders do
  describe '.validate_content_type' do
    subject(:validate_content_type) do
      described_class.validate_content_type(headers)
    end

    let(:headers) { { 'Content-Type' => content_type } }

    context 'with valid Content-Type' do
      let(:content_type) { 'application/vnd.api+json' }

      it { is_expected.to be true }
    end

    context 'with invalid Content-Type' do
      context 'with media type param' do
        let(:content_type) { 'application/vnd.api+json;param=value' }

        it { is_expected.to be false }
      end

      context 'with no json api Content-Type' do
        let(:content_type) { 'text/html' }

        it { is_expected.to be false }
      end
    end
  end

  describe '.validate_accept' do
    subject(:validate_accept) do
      described_class.validate_accept(headers)
    end

    let(:headers) { { Accept: accept } }

    context 'with valid Accept header' do
      context 'with json api mime type' do
        let(:accept) { 'application/vnd.api+json' }

        it { is_expected.to be true }
      end

      context 'with no json api mime type' do
        let(:accept) { 'text/html' }

        it { is_expected.to be true }
      end
    end

    context 'with invalid Accept header' do
      context 'when jsonapi mime type has media type param' do
        context 'when at the start of the header' do
          let(:accept) { 'application/vnd.api+json;param=value,text/html' }

          it { is_expected.to be false }
        end

        context 'when in the middle of the header' do
          let(:accept) do
            'text/xml,application/vnd.api+json;param=value,text/html'
          end

          it { is_expected.to be false }
        end

        context 'when at the end of the header' do
          let(:accept) { 'text/html,application/vnd.api+json;param=value' }

          it { is_expected.to be false }
        end
      end
    end
  end
end
