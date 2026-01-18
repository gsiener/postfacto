module Hotwire
  class ArchivesController < ApplicationController
    layout 'hotwire'

    before_action :set_retro
    before_action :set_archive, only: [:show]

    def index
      @archives = @retro.archives.order(created_at: :desc)
    end

    def show
      @items = @archive.items.order(:created_at)
      @action_items = @archive.action_items.order(:created_at)
    end

    private

    def set_retro
      @retro = Retro.friendly.find(params[:retro_id])
    end

    def set_archive
      @archive = @retro.archives.find(params[:id])
    end
  end
end
