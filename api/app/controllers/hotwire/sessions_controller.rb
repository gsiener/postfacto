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
module Hotwire
  class SessionsController < BaseController
    before_action :set_retro

    def new
      # Login page for private retros
    end

    def create
      if @retro.validate_login?(params[:password])
        store_retro_session(@retro)
        redirect_to session.delete(:return_to) || hotwire_retro_path(@retro)
      else
        flash.now[:alert] = 'Incorrect password. Please try again.'
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      clear_retro_session(@retro)
      redirect_to root_path, notice: 'You have been signed out of this retro.'
    end

    # Handle magic link authentication
    def magic_link
      if @retro.magic_link_enabled? && @retro.validate_join_token?(params[:token])
        store_retro_session(@retro)
        redirect_to hotwire_retro_path(@retro)
      else
        redirect_to hotwire_retro_login_path(@retro), alert: 'Invalid or expired magic link.'
      end
    end

    private

    def set_retro
      @retro = Retro.friendly.find(params[:retro_id])
    end
  end
end
