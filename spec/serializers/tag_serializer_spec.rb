# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TagSerializer, type: :serializer do
  context 'when a tag is serialized' do
    subject(:serialized_tag_attributes) { serialized_attributes }

    let(:serialized_attributes) { described_class.attributes_to_serialize.keys }
    let(:expected_values) do
      %i[name]
    end

    it 'serializes the correct attributes' do
      expect(serialized_tag_attributes).to match_array(expected_values)
    end
  end
end
