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

  # Hotwire frontend (primary)
  root 'hotwire/retros#index'

  resources :retros, param: :slug, controller: 'hotwire/retros' do
    resource :session, controller: 'hotwire/sessions', only: [:new, :create, :destroy]

    resources :items, controller: 'hotwire/items', only: [:create, :update, :destroy] do
      member do
        post :vote
        post :highlight
        delete :unhighlight
        patch :done
      end
    end

    resources :action_items, controller: 'hotwire/action_items', only: [:create, :update, :destroy] do
      member do
        patch :toggle_done
      end
    end

    resources :archives, controller: 'hotwire/archives', only: [:index, :show]

    post :archive, on: :member
  end

  get '/join/:token', to: 'hotwire/sessions#magic_link', as: :magic_link
end
