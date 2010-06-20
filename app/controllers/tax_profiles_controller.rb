class TaxProfilesController < ApplicationController
  def index
    @tax_profiles = TaxProfile.all
  end
  
  def show
    @tax_profile = TaxProfile.find(params[:id])
  end
  
  def new
    @tax_profile = TaxProfile.new
  end
  
  def create
    @tax_profile = TaxProfile.new(params[:tax_profile])
    if @tax_profile.save
      flash[:notice] = "Successfully created tax profile."
      redirect_to @tax_profile
    else
      render :action => 'new'
    end
  end
  
  def edit
    @tax_profile = TaxProfile.find(params[:id])
  end
  
  def update
    @tax_profile = TaxProfile.find(params[:id])
    if @tax_profile.update_attributes(params[:tax_profile])
      flash[:notice] = "Successfully updated tax profile."
      redirect_to @tax_profile
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @tax_profile = TaxProfile.find(params[:id])
    @tax_profile.destroy
    flash[:notice] = "Successfully destroyed tax profile."
    redirect_to tax_profiles_url
  end
end
