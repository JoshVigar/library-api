# frozen_string_literal: true

module Validators
  class JsonapiHeaders
    attr_reader :headers
    private :headers

    JSONAPI_MEDIA_TYPE = 'application/vnd.api+json'
    private_constant :JSONAPI_MEDIA_TYPE

    def self.validate_content_type(headers)
      new(headers).validate_content_type
    end

    def self.validate_accept(headers)
      new(headers).validate_accept
    end

    def initialize(headers)
      @headers = headers
    end

    def validate_content_type
      jsonapi_media_type_regex.match?(headers['Content-Type'])
    end

    def validate_accept
      return true unless headers[:Accept].include?(JSONAPI_MEDIA_TYPE)

      jsonapi_media_type_regex.match?(headers[:Accept])
    end

    private

    def jsonapi_media_type_regex
      %r{(application/vnd\.api\+json)([^;]|$)}
    end
  end
end
