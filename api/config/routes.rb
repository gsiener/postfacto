#
# Postfacto, a free, open-source and self-hosted retro tool aimed at helping
# remote teams.
#
# Copyright (C) 2016 - Present Pivotal Software, Inc.
#
# This program is free software: you can redistribute it and/or modify
#
# it under the terms of the GNU Affero General Public License as
#
# published by the Free Software Foundation, either version 3 of the
#
# License, or (at your option) any later version.
#
#
#
# This program is distributed in the hope that it will be useful,
#
# but WITHOUT ANY WARRANTY; without even the implied warranty of
#
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#
# GNU Affero General Public License for more details.
#
#
#
# You should have received a copy of the GNU Affero General Public License
#
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Hotwire routes (new frontend)
  scope module: :hotwire, as: :hotwire do
    resources :retros, only: [:index, :new, :create, :show, :edit, :update] do
      member do
        post :archive
      end
      resources :items, only: [:create, :update, :destroy] do
        member do
          post :vote
          patch :done
          post :highlight
          delete :unhighlight
        end
      end
      resources :action_items, only: [:create, :update, :destroy] do
        member do
          patch :toggle_done
        end
      end
      get 'login', to: 'sessions#new', as: :login
      post 'login', to: 'sessions#create'
      delete 'logout', to: 'sessions#destroy', as: :logout
      get 'join/:token', to: 'sessions#magic_link', as: :magic_link
    end
  end

  # API routes (legacy React frontend)
  scope '/api' do
    put '/retros/:id/archive', to: 'retros#archive'
    patch '/retros/:id/password', to: 'retros#update_password', as: :retro_update_password

    get '/config', to: 'config#show'

    resources :oauth_sessions, path: 'sessions', only: [:create]
    resources :users, only: [:create]

    resources :retros, only: [:index, :create, :show, :update] do
      resources :archives, only: [:index, :show]
      resources :settings, only: [:index]
      resources :action_items, only: [:create, :destroy, :update]
      resources :items, only: [:create, :update, :destroy] do
        member do
          patch 'done'
          post 'vote'
        end
      end
      resource :discussion, only: [:create, :destroy, :update] do
        post 'transitions', controller: 'transitions'
      end

      resources :sessions, only: [:new, :create]
    end
  end

  # pushstate routing
  get '/' => 'static#home', as: 'home', constraints: { format: :html }
  get '*url' => 'static#home', constraints: { format: :html }
end
