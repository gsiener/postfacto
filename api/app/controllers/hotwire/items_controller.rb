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
  class ItemsController < BaseController
    before_action :set_retro
    before_action -> { authenticate_retro!(@retro) }
    before_action :set_item, only: [:update, :destroy, :vote, :done, :highlight, :unhighlight]

    def create
      @item = @retro.items.build(item_params)

      respond_to do |format|
        if @item.save
          format.turbo_stream
          format.html { redirect_to hotwire_retro_path(@retro) }
        else
          format.html { redirect_to hotwire_retro_path(@retro), alert: @item.errors.full_messages.join(', ') }
        end
      end
    end

    def update
      respond_to do |format|
        if @item.update(update_item_params)
          format.turbo_stream
          format.html { redirect_to hotwire_retro_path(@retro) }
        else
          format.html { redirect_to hotwire_retro_path(@retro), alert: @item.errors.full_messages.join(', ') }
        end
      end
    end

    def destroy
      @item.destroy

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to hotwire_retro_path(@retro) }
      end
    end

    def vote
      @item.vote!

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to hotwire_retro_path(@retro) }
      end
    end

    def done
      @item.update!(done: params[:done] != 'false')

      # Clear highlight if this item was highlighted
      if @retro.highlighted_item_id == @item.id
        @retro.update!(highlighted_item_id: nil)
      end

      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to hotwire_retro_path(@retro) }
      end
    end

    def highlight
      @retro.update!(highlighted_item_id: @item.id)

      respond_to do |format|
        format.turbo_stream { render 'highlight' }
        format.html { redirect_to hotwire_retro_path(@retro) }
      end
    end

    def unhighlight
      @retro.update!(highlighted_item_id: nil) if @retro.highlighted_item_id == @item.id

      respond_to do |format|
        format.turbo_stream { render 'unhighlight' }
        format.html { redirect_to hotwire_retro_path(@retro) }
      end
    end

    private

    def set_retro
      @retro = Retro.friendly.find(params[:retro_id])
    end

    def set_item
      @item = @retro.items.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:description, :category)
    end

    def update_item_params
      params.require(:item).permit(:description)
    end
  end
end
