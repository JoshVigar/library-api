# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  it { is_expected.to have_many(:reviews) }
  it { is_expected.to validate_presence_of(:author) }
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_uniqueness_of(:title) }

  describe '.title' do
    let(:book) { create(:book, title: title) }
    let(:other_book) { create(:book, title: 'no expectations') }
    let(:title) { 'great expectations' }

    let(:filtered_results) { described_class.title(title) }

    it 'includes books with the title' do
      expect(filtered_results).to include(book)
    end

    it 'excludes book without title' do
      expect(filtered_results).not_to include(other_book)
    end
  end
end
