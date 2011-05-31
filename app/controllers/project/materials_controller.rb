class Project
  class MaterialsController < ApplicationController
    before_filter :authenticate
    before_filter :set_tab
    load_and_authorize_resource :spk, :class => "Project::Spk", :through => :current_company
    load_and_authorize_resource :material, :class => "Project::Material::Spk", :through => :spk

    def index
      @search = @spk.materials.search(params[:search])
      @materials = @search.paginate(:page => params[:page])
    end

    def new
      @material = @spk.materials.build
    end

    def create
      @material = @spk.materials.build
      @material.attributes = params[:project_material_spk]
      if @material.save
        flash[:notice] = "Material saved"
        redirect_to project_spk_materials_path(@spk)
      else
        render :action => "index"
      end
    end

    def edit
    end

    def update
       if @material.update_attributes(params[:project_material_spk])
         flash[:notice] = "Material updated"
         redirect_to project_spk_materials_path(@spk)
       else
         render :action => 'edit'
       end
    end

    private
    def set_tab
      @tab = 'transactions'
      @current = 'prj'
    end
  end
end
