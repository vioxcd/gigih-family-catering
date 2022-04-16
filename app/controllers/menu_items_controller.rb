class MenuItemsController < ApplicationController
  before_action :set_menu_item, only: %i[ show edit update destroy ]

  # GET /menu_items or /menu_items.json
  def index
    @menu_items = MenuItem.all
  end

  # GET /menu_items/1 or /menu_items/1.json
  def show
  end

  # GET /menu_items/new
  def new
    @menu_item = MenuItem.new
  end

  # GET /menu_items/1/edit
  def edit
  end

  # POST /menu_items or /menu_items.json
  def create
    @menu_item = MenuItem.new(menu_item_params)

    if @menu_item.save
      create_menu_category
    end
  
    respond_to do |format|
      unless @menu_item.errors.any?
        format.html { redirect_to menu_item_url(@menu_item), notice: "Menu item was successfully created." }
        format.json { render :show, status: :created, location: @menu_item }
      else
        @menu_item.destroy
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menu_items/1 or /menu_items/1.json
  def update

    @menu_item.update(menu_item_params)
    create_menu_category
    
    respond_to do |format|
      unless @menu_item.errors.any?
        format.html { redirect_to menu_item_url(@menu_item), notice: "Menu item was successfully updated." }
        format.json { render :show, status: :ok, location: @menu_item }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @menu_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_items/1 or /menu_items/1.json
  def destroy
    @menu_item.destroy

    respond_to do |format|
      format.html { redirect_to menu_items_url, notice: "Menu item was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_item
      @menu_item = MenuItem.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def menu_item_params
      params.require(:menu_item).permit(:name, :description ,:price)
    end

    def create_menu_category
      @category_ids = params[:category_ids]
    
      if @category_ids == nil
        return @menu_item.add_error_at_least_one_category
      end
      
      @menu_category = MenuCategory.where(menu_item_id: @menu_item.id)
      @menu_category.destroy_all
      
      @category_ids.each do |category_id|
        @menu_category = MenuCategory.new(menu_item_id: @menu_item.id, category_id: category_id)
        @menu_category.save
      end
      
      @menu_item.has_category
    end
end
