# frozen_string_literal: true

module Validators
  module Books
    class Index
      attr_reader :params
      private :params

      PERMITTED_FILTERS = %i[title].freeze
      private_constant :PERMITTED_FILTERS

      def self.validate!(params)
        new(params).validate!
      end

      def initialize(params)
        @params = params
      end

      def validate!
        { filter: filter_params }.compact.deep_symbolize_keys
      end

      def filter_params
        return if filters.blank?

        filters.permit(PERMITTED_FILTERS).to_h
      end

      def filters
        @filters ||= params[:filter]
      end
    end
  end
end
