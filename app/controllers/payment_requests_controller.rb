class PaymentRequestsController < ApplicationController
  before_action :find_contractor
  before_action :find_payment_request, only: %i[show edit update destroy]

  def index
    # GET    /contractors/:contractor_id/payment_requests
    @payment_requests = PaymentRequest.where(contractor_id: @contractor.id)
  end

  def new
    # GET    /contractors/:contractor_id/payment_requests/new
    @payment_request = @contractor.payment_requests.new
  end

  def create
    # POST   /contractors/:contractor_id/payment_requests
    @payment_request = @contractor.payment_requests.new(payment_request_params)

    if @payment_request.save
      redirect_to contractor_payment_request_path(@contractor, @payment_request)
    else
      render :new
    end
  end

  # /contractors/:contractor_id/payment_requests/:id
  def show; end

  # GET    /contractors/:contractor_id/payment_requests/:id/edit
  def edit; end

  def update
    # PATCH  /contractors/:contractor_id/payment_requests/:id
    # PUT  /contractors/:contractor_id/payment_requests/:id
    if @payment_request.update_attributes(payment_request_params)

      redirect_to contractor_payment_requests_path
    else
      render :edit
    end
  end

  def destroy
    # DELETE /contractors/:contractor_id/payment_requests/:id
    if @payment_request.destroy
      redirect_to contractor_payment_requests_path
    else
      redirect_to contractor_payment_requests_path
    end
  end

  private

  def find_contractor
    @contractor = Contractor.find(params[:contractor_id])
  end

  def payment_request_params
    params.require(:payment_request).permit(:amount, :currency, :description, :status)
  end

  def find_payment_request
    @payment_request = PaymentRequest.find(params[:id])
  end
end
