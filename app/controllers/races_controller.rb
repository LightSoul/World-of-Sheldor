class RacesController < ApplicationController

  def show
    @race = Race.find(params[:id])
    @title = @race.name
    @bonuses = Bonus.paginate :page => params[:page], :per_page => 10, :order => 'created_at DESC'
    @race_bonus = RaceBonus.new
  end

  def create
    @race = Race.new(params[:race])
    if @race.save
      flash[:success] = "Race added successfully"
    else
      flash[:error] = "Failed creating race"
    end
    redirect_to races_path
  end
  
  def edit
    @race = Race.find(params[:id])
    @title = "Edit race"
  end
  
  def update
    @race = Race.find(params[:id])
    if @race.update_attributes(params[:race])
      flash[:success] = "Race updated."
      redirect_to races_path
    else
      @title = "Edit race"
      render 'edit'
    end
  end
  
  def index
    @title = "Races"
    @races = Race.paginate :page => params[:page], :per_page => 10, :order => 'created_at DESC'
    @race = Race.new
  end
  
  def destroy
    race = Race.find(params[:id])
    race.destroy
    flash[:success] = "Race destroyed."
    redirect_to races_path
  end

  def add_bonus
    @race = Race.find(params[:id])
    @race_bonus = RaceBonus.new(params[:race_bonus])

    @unit_attribute = UnitAttribute.find_by_id(params[:race_bonus][:unit_attribute_id])
    @race_bonus.race = @race
    @race_bonus.unit_attribute = @unit_attribute
    
    if @race_bonus.save
      flash[:success] = "Bonus added successfully"
    else
      flash[:error] = "Failed creating bonus"
    end
    redirect_to race_path
  end

  def delete_bonus
    race_bonus = RaceBonus.find(params[:bonus_id])
    race_bonus.destroy
    flash[:success] = "Bonus removed."
    redirect_to race_path
  end

  def edit_bonus
    @race_bonus = RaceBonus.find(params[:bonus_id])
    @title = "Edit bonus"
    
    render 'race_bonus/edit'
  end

  def update_bonus
    @race = Race.find(params[:id])
    @race_bonus = RaceBonus.find(params[:bonus_id])
    @unit_attribute = UnitAttribute.find_by_id(params[:race_bonus][:unit_attribute_id])
    @race_bonus.race = @race
    @race_bonus.unit_attribute = @unit_attribute
    
    if @race_bonus.update_attributes(params[:race_bonus])
      flash[:success] = "Bonus updated."
    end
    redirect_to race_path
    #render 'race_bonus/edit'
  end
end
