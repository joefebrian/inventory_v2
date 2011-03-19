module Sales
  class SalesOrdersController < ApplicationController
    before_filter :authenticate
    before_filter :assign_tab
    load_and_authorize_resource :through => :current_company

    def index
      @search = current_company.sales_orders.search(params[:search])
      if params[:state] == 'closed'
        @sales_orders = @search.search(:closed => true)
      elsif params[:state] == 'all'
        @sales_orders = @search.all
      else
        @sales_orders = @search.search(:closed => false)
      end
      @sales_orders.paginate(:page => params[:page])
      if params[:project_id]
        @project = current_company.projects.find(params[:project_id])
        @sales_orders = @project.sales_orders.paginate(:page => params[:page])
      end
    end

    def show
      if params[:project_id]
        @project = current_company.projects.find(params[:project_id])
        @sales_order = @project.sales_orders.find(params[:id])
      else
        @sales_order = current_company.sales_orders.find(params[:id])
      end
      respond_to do |format|
        format.html
        format.pdf { render :pdf => "SO-#{@sales_order.number}" }
      end
    end


    def new
        @customer = current_company.customers
        @assembly = current_company.assemblies
        @currencies = current_company.currencies
        @exchange_rate = current_company.exchange_rates
        @salesman = current_company.salesmen
      if params[:project_id]
        @project = current_company.projects.find(params[:project_id])
        @sales_order = current_company.sales_orders.new(:project_id => @project.id)
        @sales_order.order_ref = "Project #{@project.number}"
        @sales_order.customer = @project.customer
        @project.materials.each do |mtr|
          @sales_order.entries.build(:item_id => mtr.item_id, :quantity => mtr.value, :discount => 0, :price => mtr.item.latest_hpp)
        end
      else
        @sales_order = current_company.sales_orders.new
        @sales_order.attributes = params[:sales_order] if params[:sales_order]
        if params[:sales_order]
          @quotations = current_company.quotations.customer_id_is(params[:sales_order][:customer_id])
        else
          @quotations = current_company.quotations
        end
        @sales_order.entries.clear
        @sales_order.entries.build(:discount => 0, :quantity => 0, :price => 0)
      end
      @sales_order.tanggal = Time.now.to_date if @sales_order.tanggal.blank?
      if request.xhr?
        render :layout => false
      end
    end

    def create
      @sales_order = current_company.sales_orders.new
      @salesman = current_company.salesmen
      @customer = current_company.customers
      @quotation = current_company.quotations
      @assembly = current_company.assemblies
      @currencies = current_company.currencies
      @exchange_rate = current_company.exchange_rates
      @sales_order.attributes = params[:sales_order]
      if params[:get_quots] && params[:get_quots].to_i == 1
        @sales_order.build_entries_from_quot
        @sales_order.entries.build(:discount => 0, :quantity => 0)
        @currencies = current_company.currencies
        render("new", :layout => false) and return
      end
      if @sales_order.save
        flash[:notice] = "Successfully created sales order."
        if @sales_order.project
          redirect_to project_sales_orders_path(@sales_order.project)
        else
          redirect_to [:sales, @sales_order]
        end
      else
        @sales_order.number = @sales_order.suggested_number if @sales_order.number.blank?
        @sales_order.entries.build(:discount => 0, :quantity => 0)
        render :action => 'new'
      end
    end

    def edit
      @sales_order = current_company.sales_orders.find(params[:id])
      @sales_order.entries.build
      @customer = current_company.customers
      @quotation = current_company.quotations
      @assembly = current_company.assemblies
      @currencies = current_company.currencies
      @exchange_rate = current_company.exchange_rates
      @salesman = current_company.salesmen
    end

    def update
      @sales_order = current_company.sales_orders.find(params[:id])
      if @sales_order.update_attributes(params[:sales_order])
        flash[:notice] = "Successfully updated sales order."
        redirect_to [:sales, @sales_order]
      else
        render :action => 'edit'
      end
    end

    def destroy
      @sales_order = current_company.sales_orders.find(params[:id])
      @sales_order.destroy
      flash[:notice] = "Successfully destroyed sales order."
      redirect_to sales_sales_orders_url
    end

    private
    def assign_tab
      @tab = 'transactions'
      @current = 'so'
    end

    def populate_fields

    end

  end
end
