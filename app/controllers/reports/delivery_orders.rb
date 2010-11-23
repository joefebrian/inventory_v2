/bin/bash: : command not found

  def index
=begin    all_sales_orders = SalesOrder.search(:company_id => current_company)
    @until = params[:until] unless params[:until].blank?
    @sales_orders = all_sales_orders.all(:order => 'number ASC').paginate(:page => params[:page])
    @sales_orders.each { |sales_order| sales_order.all(nil, @until) }
=end
    @search = current_company.sales_orders.search(params[:search])
    if params[:state] == 'closed'
      @sales_orders = @search.search(:closed => true)
    elsif params[:state] == 'all'
      @sales_orders = @search.all
    else
      @sales_orders = @search.search(:closed => false)
    end
    @sales_orders.paginate(:page => params[:page])


    respond_to do |format|
      format.html
      format.pdf
    end
  end

  private
  def assign_tab
    @tab = 'reports'
    @current = 'so'
  end

end
