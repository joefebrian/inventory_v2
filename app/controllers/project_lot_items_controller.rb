class ProjectLotItemsController < ApplicationController
  before_filter :set_tab
  before_filter :authenticate
  load_and_authorize_resource :project, :through => :current_company

  def index
    @lot_items = @project.lot_items
    @project.lot_items.build
  end

  def create
    if @project.update_attributes(params[:project])
      respond_to do |format|
        format.html do
          flash[:success] = "Edit lot items success"
          redirect_to @project
        end
      end
    else
      respond_to do |format|
        format html do
          flash[:error] = "Oops, something went wrong. Please try again. :)"
          render :action => :index
        end
      end
    end
  end
  private
  def set_tab
    @tab = 'transactions'
    @current = 'prj'
  end
end
