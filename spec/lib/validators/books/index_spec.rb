# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Validators::Books::Index do
  subject(:validate_params) do
    described_class.validate!(ActionController::Parameters.new(params))
  end

  context 'with valid params' do
    context 'with a valid title' do
      let(:params) { { filter: { title: 'title' } } }

      it { is_expected.to eql(params) }
    end

    context 'with extra params' do
      let(:params) { { filter: { title: 'title', blah: 'blah' } } }
      let(:expected_params) { { filter: { title: 'title' } } }

      it { is_expected.to eql(expected_params) }
    end
  end

  context 'with invalid params' do
    let(:params) { { filter: { blah: 'blah' } } }
    let(:expected_params) { { filter: {} } }

    it { is_expected.to eql(expected_params) }
  end
end
