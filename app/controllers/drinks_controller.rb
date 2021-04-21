class DrinksController < ApplicationController
  before_action :set_drink, only: %i[ show edit update destroy ]

  # GET /drinks or /drinks.json
  def index
    @drinks = Drink.all
  end

  def graphic
    @sales_12_months = Sale.where(created_at: 11.months.ago..Date.today)
                      .group("strftime('%m-%Y', created_at)")
                      .order(created_at: :asc)
                      .sum(:total)

    @quantity_12_months = Sale.where(created_at: 11.months.ago..Date.today)
                         .group("strftime('%m-%Y', created_at)")
                         .order(created_at: :asc)
                         .count

    @average_12_months = Sale.where(created_at: 11.months.ago..Date.today)
                        .group("strftime('%m-%Y', created_at)")
                        .order(created_at: :asc)
                        .average(:total)

    @pie_chart_12_months = Sale.where(created_at: 11.months.ago..Date.today)
                          .group(:origin)
                          .limit(30)
                          .count
                  
    @pie_chart_6_months = Sale.where(created_at: 5.months.ago..Date.today)
                          .group(:origin)
                          .limit(30)
                          .count

    @pie_chart_3_months = Sale.where(created_at: 2.months.ago..Date.today)
                          .group(:origin)
                          .count
                          
    @pie_chart_last_month = Sale.where(created_at: 30.days.ago..Date.today)
                          .group(:origin)
                          .count

    @pie_chart_12_months_blend_name = Sale.where(created_at: 11.months.ago..Date.today)
                                      .group(:blend_name)
                                      .limit(40)
                                      .count
                  
    @pie_chart_6_months_blend_name = Sale.where(created_at: 5.months.ago..Date.today)
                                    .group(:blend_name)
                                    .limit(40)
                                    .count

    @pie_chart_3_months_blend_name = Sale.where(created_at: 2.months.ago..Date.today)
                                    .group(:blend_name)
                                    .count
                          
    @pie_chart_last_month_blend_name = Sale.where(created_at: 30.days.ago..Date.today)
                                      .group(:blend_name)
                                      .count

  end

  # GET /drinks/1 or /drinks/1.json
  def show
  end

  # GET /drinks/new
  def new
    @drink = Drink.new
  end

  # GET /drinks/1/edit
  def edit
  end

  # POST /drinks or /drinks.json
  def create
    @drink = Drink.new(drink_params)

    respond_to do |format|
      if @drink.save
        format.html { redirect_to @drink, notice: "Drink was successfully created." }
        format.json { render :show, status: :created, location: @drink }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @drink.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /drinks/1 or /drinks/1.json
  def update
    respond_to do |format|
      if @drink.update(drink_params)
        format.html { redirect_to @drink, notice: "Drink was successfully updated." }
        format.json { render :show, status: :ok, location: @drink }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @drink.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /drinks/1 or /drinks/1.json
  def destroy
    @drink.destroy
    respond_to do |format|
      format.html { redirect_to drinks_url, notice: "Drink was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drink
      @drink = Drink.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def drink_params
      params.require(:drink).permit(:price, :origin, :blend_name)
    end
end
