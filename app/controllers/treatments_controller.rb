
class TreatmentsController < ApplicationController
  helper_method :sort_column, :sort_direction
  # GET /treatments
  # GET /treatments.json
  def index
    @treatments = Treatment.order(sort_column + ' ' + sort_direction).page(params[:page]).per(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @treatments }
    end
  end

  # GET /treatments/1
  # GET /treatments/1.json
  def show
    @treatment = Treatment.find(params[:id])
    @scans = Scan.where("treatment_id = ?", params[:id]).order('created_at').joins(:scantype)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @treatment }
    end
  end

  # GET /treatments/new
  # GET /treatments/new.json
  def new
    @treatment = Treatment.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @treatment }
    end
  end

  # GET /treatments/1/edit
  def edit
    @treatment = Treatment.find(params[:id])
  end

  # POST /treatments
  # POST /treatments.json
  def create
    @treatment = Treatment.new(params[:treatment])

    respond_to do |format|
      if @treatment.save
        format.html { redirect_to @treatment, notice: 'Treatment was successfully created.' }
        format.json { render json: @treatment, status: :created, location: @treatment }
      else
        format.html { render action: "new" }
        format.json { render json: @treatment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /treatments/1
  # PUT /treatments/1.json
  def update
    @treatment = Treatment.find(params[:id])

    respond_to do |format|
      if @treatment.update_attributes(params[:treatment])
        format.html { redirect_to @treatment, notice: 'Treatment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @treatment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /treatments/1
  # DELETE /treatments/1.json
  def destroy
    @treatment = Treatment.find(params[:id])
    @treatment.destroy

    respond_to do |format|
      format.html { redirect_to treatments_url }
      format.json { head :no_content }
    end
  end

  private
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "desc"
  end

  def sort_column
    Treatment.column_names.include?(params[:sort]) ? params[:sort] : "created_at"
  end   
end
