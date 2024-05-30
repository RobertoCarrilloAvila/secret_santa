# frozen_string_literal: true

Rails.application.routes.draw do
  root 'families#index'
  resources :families do
    resources :gift_assigments, only: %i[index create]
  end
end
