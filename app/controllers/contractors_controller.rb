class ContractorsController < ApplicationController
  before_action :find_contractor, only: %i[show edit update destroy]

  def index
    # GET /contractors
    @contractors = Contractor.all
  end

  def new
    # GET /contractors/new
    @contractor = Contractor.new
  end

  def create
    # POST /contractors/new
    @contractor = Contractor.new(contractor_params)

    if @contractor.save
      redirect_to contractor_path(@contractor)
    else
      render :new
    end
  end

  # GET    /contractors/:id
  def show; end

  # GET    /contractors/:id/edit
  def edit; end

  def update
    # PATCH  /contractors/:id
    # PUT  /contractors/:id
    if @contractor.update_attributes(contractor_params)

      redirect_to contractors_path
    else
      render :edit
    end
  end

  def destroy
    # DELETE /contractors/:id
    if @contractor.destroy
      redirect_to contractors_path
    else
      redirect_to contractors_path
    end
  end

  private

  def contractor_params
    params.require(:contractor).permit(:name, :email)
  end

  def find_contractor
    @contractor = Contractor.find(params[:id])
  end
end
