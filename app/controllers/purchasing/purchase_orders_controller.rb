module Purchasing
  class PurchaseOrdersController < ApplicationController
    before_filter :authenticate
    before_filter :assign_tab
    load_and_authorize_resource :through => :current_company

    def index
      @search = current_company.purchase_orders.search(params[:search])
      if params[:state] == 'closed'
        @purchase_orders = @search.search(:closed => true).paginate(:page => params[:page])
      elsif params[:state] == 'all'
        @purchase_orders = @search.paginate(:page => params[:page])
      else
        @purchase_orders = @search.search(:closed => false).paginate(:page => params[:page])
      end
    end

    def show
      @purchase_order = current_company.purchase_orders.find(params[:id])
      respond_to do |format|
        format.html
        format.pdf { render :pdf => "PO-#{@purchase_order.number}" }
      end
    end

    def new
      @purchase_order = current_company.purchase_orders.new
      @suppliers = current_company.suppliers.all(:include => :profile)
      @material_requests = current_company.material_requests.not_closed
      if params[:create_from] && params[:allocs]
        alloc_ids = []
        params[:allocs].each do |i|
          alloc = MaterialAllocation.find(i)
          alloc_ids << MaterialAllocation.all(:conditions => { :allocatable_type => alloc.allocatable_type, :allocatable_id => alloc.allocatable_id }).map(&:id)
        end
        allocs = MaterialAllocation.all(alloc_ids)
        ids = {}
        allocs.each {|a| ids[a.item_id] = 0 if ids[a.item_id].nil?; ids[a.item_id] += a.quantity}
        ids.each do |item_id, quantity|
          item = Item.find(item_id)
          if item.stock < item.allocated_quantity
            ordered_quantity = quantity - item.stock
            @purchase_order.entries.build(:item_id => item_id, :quantity => ordered_quantity, :purchase_price => item.latest_hpp)
          end
        end
        @purchase_order.notes = allocs.collect {|a| a.allocatable.number}.uniq.join(', ')
      else
        @purchase_order.entries.build
      end
    end

    def create
      @purchase_order = current_company.purchase_orders.new(params[:purchase_order])
      @suppliers = current_company.suppliers.all(:include => :profile)
      @material_requests = current_company.material_requests.not_closed
      if params[:get_mrs] && params[:get_mrs] == '1'
          @purchase_order.build_entries_from_mr
          @purchase_order.build_mr_trackers
          @purchase_order.entries.build
        render('new') and return
      end
      if @purchase_order.save
        flash[:success] = "Purchase Order saved"
        redirect_to [:purchasing, @purchase_order]
      else
        render 'new'
      end
    end

    def edit
      @purchase_order = current_company.purchase_orders.find(params[:id])
      @suppliers = current_company.suppliers.all(:include => :profile)
      @material_requests = current_company.material_requests.all(:conditions => ["closed = 0 OR id IN (?)", @purchase_order.material_requests.collect { |mr| mr.id }])
    end

    def update
      @purchase_order = current_company.purchase_orders.find(params[:id])
      @suppliers = current_company.suppliers.all(:include => :profile)
      @material_requests = current_company.material_requests.not_closed

      updated = @purchase_order.update_attributes(params[:purchase_order])
      if updated
        flash[:success] = "Purchase Order updated"
        redirect_to [:purchasing, @purchase_order]
      else
        @purchase_order.entries.build
        render "edit"
      end
    end

    def destroy
      @purchase_order = current_company.purchase_orders.find(params[:id])
      @purchase_order.destroy
      flash[:notice] = "Successfully destroyed purchase order."
      redirect_to purchasing_purchase_orders_url
    end

    def manual_close
      @purchase_order = current_company.purchase_orders.find(params[:id])
    end

    def close
      @purchase_order = current_company.purchase_orders.find(params[:id])
      @purchase_order.closed = true
      @purchase_order.closing_note = params[:purchase_order][:closing_note]
      if @purchase_order.save
        flash[:success] = "Purchase Order # #{@purchase_order.number} successfuly closed"
        redirect_to purchasing_purchase_orders_url
      else
        flash[:error] = "Something went wrong, please try again"
        render :action => 'manual_close'
      end
    end

    private
    def assign_tab
      @tab = 'transactions'
      @current = 'po'
    end
  end
end
