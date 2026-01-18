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

  root to: 'hotwire/retros#index'

  scope module: :hotwire do
    resources :retros, only: [:index, :new, :create, :show, :edit, :update] do
      member do
        post :archive
      end
      resources :archives, only: [:index, :show]
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
end
