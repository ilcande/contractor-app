# frozen_string_literal: true

Rails.application.routes.draw do
  root 'contractors#index'

  resources :contractors do
    resources :payment_requests
  end
end
