# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Book, type: :model do
  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:title) }
  it { should validate_uniqueness_of(:title) }

  describe '.title' do
    let(:book) { create(:book, title: title) }
    let(:other_book) { create(:book, title: 'no expectations') }
    let(:title) { 'great expectations' }

    let(:filtered_results) { Book.title(title) }
    it 'includes books with the title' do
      expect(filtered_results).to include(book)
    end

    it 'excludes users without admin flag' do
      expect(filtered_results).to_not include(other_book)
    end
  end
end
