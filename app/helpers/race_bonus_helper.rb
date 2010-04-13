module RaceBonusHelper

  def print_nicely(race_bonus)
    @output = ""
    if race_bonus.value>0
      @output = "+"
    end
    
    @output += race_bonus.value.to_s
    if race_bonus.bonusType=="relative"
      @output += "%"
    end
    @output += " "+race_bonus.unit_attribute.symbol
    @output += ", "+race_bonus.race.name
  end
  
end
