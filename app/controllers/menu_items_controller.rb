class MenuItemsController < ApplicationController
  before_action :set_menu_item, only: %i[show edit update destroy]

  protect_from_forgery with: :null_session

  # GET /menu_items or /menu_items.json
  def index
    @menu_items = MenuItem.all

    render json: @menu_items.to_json(include: :menu_categories)
  end

  # GET /menu_items/1 or /menu_items/1.json
  def show
    render json: @menu_item.to_json(include: :menu_categories)
  end

  # GET /menu_items/new
  def new
    @menu_item = MenuItem.new
  end

  # GET /menu_items/1/edit
  def edit; end

  # POST /menu_items or /menu_items.json
  def create
    @menu_item = MenuItem.new(menu_item_params)

    if @menu_item.save
      render json: @menu_item.to_json(include: :menu_categories)
    else
      render json: @menu_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /menu_items/1 or /menu_items/1.json
  def update
    @menu_item.delete_associate_categories
    
    if @menu_item.update(menu_item_params)
      render json: @menu_item.to_json(include: :menu_categories)
    else
      render json: @menu_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /menu_items/1 or /menu_items/1.json
  def destroy
    @menu_item.destroy

    render json: { message: 'Menu Item was successfully destroyed.' }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_menu_item
    begin  
      @menu_item = MenuItem.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Menu Items not found' }, status: :not_found
    end
  end

  # Only allow a list of trusted parameters through.
  def menu_item_params
    begin
      params.require(:menu_item).permit(:name, :description, :price, menu_categories_attributes: %i[id menu_item_id category_id _destroy])
    rescue ActiveRecord::RecordNotFound
      render json: { message: 'Menu Item not found' }, status: :not_found
    end
  end
end
