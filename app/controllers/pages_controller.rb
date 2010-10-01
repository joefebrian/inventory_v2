class PagesController < ApplicationController
  before_filter :authenticate
  def index
    @tab = 'dashboard'
    @unconfirmed_item_receives = current_company.item_receives.unconfirmed
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
