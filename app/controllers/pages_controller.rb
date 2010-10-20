class PagesController < ApplicationController
  before_filter :authenticate, :except => [:index]
  def index
    if current_user
      @tab = 'dashboard'
      @unconfirmed_item_receives = current_company.item_receives.unconfirmed
      @open_purchase_orders = current_company.purchase_orders.all_open
    else
      redirect_to signin_path
    end
  end

  def show
    @tab = params[:id]
    if params[:id] == 'administrations'
      unless current_user.roles?('admin')
        flash[:error] = "Sorry, you are not allowed to access that page"
        redirect_to dashboard_path and return
      end
    end
    render @tab
  end

end
