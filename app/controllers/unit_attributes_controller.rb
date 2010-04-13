class UnitAttributesController < ApplicationController

  def show
    @unit_attribute = UnitAttribute.find(params[:id])
    @title = @unit_attribute.name
  end

  def create
    @unit_attribute = UnitAttribute.new(params[:unit_attribute])
    if @unit_attribute.save
      flash[:success] = "Attribute added successfully"
    else
      flash[:error] = "Failed creating attribute"
    end
    redirect_to unit_attributes_path
  end
  
  def edit
    @unit_attribute = UnitAttribute.find(params[:id])
    @title = "Edit unit attribute"
  end
  
  def update
      @unit_attribute = UnitAttribute.find(params[:id])
    if @unit_attribute.update_attributes(params[:unit_attribute])
      flash[:success] = "Attribute updated."
      redirect_to unit_attributes_path
    else
      @title = "Edit unit attribute"
      render 'edit'
    end
  end
  
  def index
    @title = "Unit Attributes"
    @unit_attributes = UnitAttribute.paginate :page => params[:page], :per_page => 20, :order => 'created_at DESC'
    @unit_attribute = UnitAttribute.new
  end
  
  def destroy
    unit_attribute = UnitAttribute.find(params[:id])
    unit_attribute.destroy
    flash[:success] = "Unit Attribute destroyed."
    redirect_to unit_attributes_path
  end

end
