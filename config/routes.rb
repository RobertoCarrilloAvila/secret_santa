# frozen_string_literal: true

Rails.application.routes.draw do
  root 'families#index'
  resources :families
end
