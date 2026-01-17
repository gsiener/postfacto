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
  class ActionItemsController < BaseController
    before_action :set_retro
    before_action -> { authenticate_retro!(@retro) }
    before_action :set_action_item, only: [:update, :destroy, :toggle_done]

    def create
      @action_item = @retro.action_items.build(action_item_params)

      respond_to do |format|
        if @action_item.save
          format.turbo_stream
          format.html { redirect_to retro_path(@retro) }
        else
          format.html { redirect_to retro_path(@retro), alert: @action_item.errors.full_messages.join(', ') }
        end
      end
    end

    def update
      respond_to do |format|
        if @action_item.update(action_item_params)
          format.turbo_stream
          format.html { redirect_to retro_path(@retro) }
        else
          format.html { redirect_to retro_path(@retro), alert: @action_item.errors.full_messages.join(', ') }
        end
      end
    end

    def destroy
      @action_item.destroy

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to retro_path(@retro) }
      end
    end

    def toggle_done
      @action_item.update!(done: !@action_item.done)

      respond_to do |format|
        format.turbo_stream { render 'update' }
        format.html { redirect_to retro_path(@retro) }
      end
    end

    private

    def set_retro
      @retro = Retro.friendly.find(params[:retro_id])
    end

    def set_action_item
      @action_item = @retro.action_items.find(params[:id])
    end

    def action_item_params
      params.require(:action_item).permit(:description)
    end
  end
end
