# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReviewSerializer, type: :serializer do
  context 'when a review is serialized' do
    subject(:serialized_book_attributes) { serialized_attributes }

    let(:serialized_attributes) { described_class.attributes_to_serialize.keys }
    let(:expected_values) do
      %i[
        rating
        comment
        user_name
      ]
    end

    it 'serializes the correct attributes' do
      expect(serialized_book_attributes).to match_array(expected_values)
    end
  end
end
