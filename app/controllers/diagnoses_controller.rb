
class DiagnosesController < ApplicationController
  helper_method :sort_column, :sort_direction

  # GET /diagnoses
  # GET /diagnoses.json
  def index
    @diagnoses = Diagnosis.search(params[:search]).order(sort_column + ' ' + sort_direction).page(params[:page]).per(20)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @diagnoses }
    end
  end

  # GET /diagnoses/1
  # GET /diagnoses/1.json
  def show
    @diagnosis = Diagnosis.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @diagnosis }
    end
  end

  # GET /diagnoses/new
  # GET /diagnoses/new.json
  def new
    @diagnosis = Diagnosis.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @diagnosis }
    end
  end

  # GET /diagnoses/1/edit
  def edit
    @diagnosis = Diagnosis.find(params[:id])
  end

  # POST /diagnoses
  # POST /diagnoses.json
  def create
    @diagnosis = Diagnosis.new(params[:diagnosis])

    respond_to do |format|
      if @diagnosis.save
        format.html { redirect_to @diagnosis, notice: t('diagnoses.new.notice') }
        format.json { render json: @diagnosis, status: :created, location: @diagnosis }
      else
        format.html { render action: "new" }
        format.json { render json: @diagnosis.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /diagnoses/1
  # PUT /diagnoses/1.json
  def update
    @diagnosis = Diagnosis.find(params[:id])

    respond_to do |format|
      if @diagnosis.update_attributes(params[:diagnosis])
        format.html { redirect_to @diagnosis, notice: t('diagnoses.edit.notice') }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @diagnosis.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diagnoses/1
  # DELETE /diagnoses/1.json
  def destroy
    @diagnosis = Diagnosis.find(params[:id])
    @diagnosis.destroy

    respond_to do |format|
      format.html { redirect_to diagnoses_url }
      format.json { head :no_content }
    end
  end

  private
  def sort_direction
    %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  end

  def sort_column
    Diagnosis.column_names.include?(params[:sort]) ? params[:sort] : "code"
  end  
end
