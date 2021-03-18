# frozen_string_literal: true

require 'rails_helper'

RSpec.describe BookSerializer, type: :serializer do
  context 'A book is serialized' do
    subject { serialized_attributes }

    let(:serialized_attributes) { described_class.attributes_to_serialize.keys }
    let(:expected_values) do
      %i[
        title
        author
        description
      ]
    end

    it 'serializes the correct attributes' do
      expect(subject).to match_array(expected_values)
    end
  end
end
