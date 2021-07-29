# frozen_string_literal: true

Rails.application.routes.draw do
  resources :books, only: %i[index create update] do
    resources :tags
  end
  resources :tags
end
