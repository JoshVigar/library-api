# frozen_string_literal: true

shared_examples 'streamable' do
  it { is_expected.to have_one(:medium) }
end
