class AssemblyProgressEntriesController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab
  def index
  end

  def new
  end

  def edit
  end

  private
  def assign_tab
    @tab = 'transactions'
    @current = 'assy'
  end

end
