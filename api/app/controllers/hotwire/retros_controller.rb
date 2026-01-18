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
  class RetrosController < BaseController
    before_action :set_retro, only: [:show, :edit, :update, :archive]
    before_action -> { authenticate_retro!(@retro) }, only: [:show, :edit, :update, :archive]

    def index
      @retros = Retro.order(created_at: :desc).limit(20)
    end

    def show
      @items_by_category = @retro.items.grouped_by_category
      @action_items = @retro.action_items.order(created_at: :asc)
      @highlighted_item = @retro.items.find_by(id: @retro.highlighted_item_id) if @retro.highlighted_item_id
    end

    def new
      @retro = Retro.new
    end

    def create
      @retro = Retro.new(retro_params)

      if @retro.save
        store_retro_session(@retro)
        redirect_to retro_path(@retro), notice: 'Retro was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def edit
    end

    def update
      if @retro.update(retro_update_params)
        redirect_to retro_path(@retro), notice: 'Retro was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def archive
      RetroArchiveService.archive(@retro, Time.now, params[:send_archive_email] != 'false')
      redirect_to retro_path(@retro), notice: 'Retro was successfully archived.'
    end

    private

    def set_retro
      @retro = Retro.friendly.find(params[:id])
    end

    def retro_params
      params.require(:retro).permit(:name, :slug, :password, :item_order, :is_private, :is_magic_link_enabled)
    end

    def retro_update_params
      params.require(:retro).permit(:name, :video_link, :is_private, :is_magic_link_enabled)
    end
  end
end
