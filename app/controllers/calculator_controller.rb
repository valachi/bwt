class CalculatorController < ApplicationController
  
  def show
    @size = params[:size].to_i
    @from = Date.civil(params[:calculator]["from(1i)"].to_i,
                         params[:calculator]["from(2i)"].to_i,
                         params[:calculator]["from(3i)"].to_i)
    @to = Date.civil(params[:calculator]["to(1i)"].to_i,
                         params[:calculator]["to(2i)"].to_i,
                         params[:calculator]["to(3i)"].to_i)
#    @to = Time.local(*params[:calculator].sort.map(&:last).map(&:to_i)) 
    @days = (@to.yday - @from.yday)+1
    @terminal = params[:terminal]
    @price = calculate(@days, @size, @terminal)
  end

  private

  def calculate(days, size, terminal) 
    (0..days).inject {|sum, day| sum + costs(day, size, terminal)} 
  end

  def costs(days, size, terminal)
    if terminal == "PLP"
      if size == 20
        case days
          when 0..5 then 0
          when 6 then 75
          when 7..8 then 25
          when 9..20 then 75
          else 125
        end
      elsif size == 40
        case days
          when 0..5 then 0
          when 6 then 150
          when 7..8 then 50
          when 9..20 then 150
          else 250
        end
      end
    elsif terminal == "FCT"
      if size == 20
        case days
          when 0..5 then 0
          when 6 then 75
          when 7..8 then 25
          when 9..20 then 115
          when 21..30 then 165
          when 31..60 then 150
          else 135
        end
      elsif size == 40
        case days
          when 0..5 then 0
          when 6 then 150
          when 7..8 then 50
          when 9..20 then 230
          when 21..30 then 330
          when 31..60 then 300
          else 270
        end
      end
    end
  end

end
