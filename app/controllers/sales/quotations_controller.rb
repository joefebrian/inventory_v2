module Sales
  class QuotationsController < ApplicationController
    before_filter :authenticate
    before_filter :assign_tab
    load_and_authorize_resource :through => :current_company

    def index
      @search = current_company.quotations.search(params[:search])
      @quotations = @search.paginate(:page => params[:page])
    end

    def show
      @quotation = current_company.quotations.find(params[:id])
        respond_to do |format|
          if(params[:type])
              format.html { render "print", :layout => "print"}
          else
              format.html { render "show", :layout => "application"}
          end
        end
    end

    def new
      @quotation = current_company.quotations.new
      @quotation.tanggal_berlaku = Time.now.to_date
      @quotation.entries.build
      @customer = current_company.customers.all(:include => :profile)
    end

    def create
      @quotation = current_company.quotations.new
      @quotation.attributes = params[:quotation]
      if @quotation.save
        flash[:notice] = "Successfully created quotation."
        redirect_to sales_quotation_path(@quotation)
      else
        @quotation.number = @quotation.suggested_number if @quotation.number.blank?
        @quotation.entries.build
        @customer = current_company.customers.all(:include => :profile)
        render :action => 'new'
      end
    end

    def edit
      @quotation = current_company.quotations.find(params[:id])
      @quotation.entries.build
      @customer = current_company.customers.all(:include => :profile)
    end

    def update
      @quotation = current_company.quotations.find(params[:id])
      if @quotation.update_attributes(params[:quotation])
        flash[:notice] = "Successfully updated quotation."
        redirect_to sales_quotation_path(@quotation)
      else
        @quotation.entries.build
        @customer = current_company.customers.all(:include => :profile)
        render :action => 'edit'
      end
    end

    def destroy
      @quotation = current_company.quotations.find(params[:id])
      @quotation.destroy
      flash[:notice] = "Successfully destroyed quotation."
      redirect_to sales_quotations_path
    end

    def send_request

        redirect_to sales_quotation_path(@quotation)
    end

    private
    def assign_tab
      @tab = 'transactions'
      @current = 'quo'
    end

  end
end
