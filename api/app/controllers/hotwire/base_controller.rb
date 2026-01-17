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
  class BaseController < ApplicationController
    layout 'hotwire'

    # Session-based authentication for Hotwire views
    helper_method :current_retro_session, :retro_authenticated?

    private

    def current_retro_session
      return nil unless session[:retro_sessions].present?
      session[:retro_sessions]
    end

    def retro_authenticated?(retro)
      return true unless retro.requires_authentication?
      return false unless current_retro_session.present?

      current_retro_session[retro.slug].present?
    end

    def authenticate_retro!(retro)
      return if retro_authenticated?(retro)

      session[:return_to] = request.fullpath
      redirect_to hotwire_retro_login_path(retro), alert: 'Please enter the password to access this retro.'
    end

    def store_retro_session(retro)
      session[:retro_sessions] ||= {}
      session[:retro_sessions][retro.slug] = {
        authenticated_at: Time.current,
        retro_id: retro.id
      }
    end

    def clear_retro_session(retro)
      session[:retro_sessions]&.delete(retro.slug)
    end
  end
end
