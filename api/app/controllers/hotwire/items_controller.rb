# frozen_string_literal: true

class Hotwire::ItemsController < Hotwire::BaseController
  before_action :load_retro
  before_action :load_item, only: [:update, :destroy, :vote, :highlight, :unhighlight, :done]
  skip_before_action :authenticate_retro!, only: [:create, :vote]

  def create
    @item = @retro.items.build(item_params)
    if @item.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to retro_path(@retro) }
      end
    else
      head :unprocessable_entity
    end
  end

  def update
    if @item.update(item_params)
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to retro_path(@retro) }
      end
    else
      head :unprocessable_entity
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to retro_path(@retro) }
    end
  end

  def vote
    @item.increment!(:vote_count)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to retro_path(@retro) }
    end
  end

  def highlight
    @retro.update!(highlighted_item_id: @item.id)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to retro_path(@retro) }
    end
  end

  def unhighlight
    @retro.update!(highlighted_item_id: nil)
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to retro_path(@retro) }
    end
  end

  def done
    @item.update!(done: true)
    @retro.update!(highlighted_item_id: nil) if @retro.highlighted_item_id == @item.id
    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to retro_path(@retro) }
    end
  end

  private

  def load_item
    @item = @retro.items.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:description, :category)
  end
end
