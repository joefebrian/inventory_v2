class Project
  class MaterialsController < ApplicationController
    before_filter :authenticate
    before_filter :set_tab
    load_and_authorize_resource :spk, :class => "Project::Spk", :through => :current_company
    load_and_authorize_resource :main_material, :class => "Project::Material::Main", :through => :spk
    load_and_authorize_resource :secondary_material, :class => "Project::Material::Secondary", :through => :spk

    def index
      @search = @spk.main_materials.search(params[:search])
      @m_materials = @search.all
      @secondary_materials = @spk.secondary_materials.all
      @spk.main_materials.build
      @spk.secondary_materials.build
    end

    def new
      @main_material = @spk.main_materials.build
      @secondary_material = @spk.secondary_materials.build
    end

    def create
      if @spk.update_attributes(params[:project_spk])
        flash[:notice] = "Materials saved"
        redirect_to project_spk_path(@spk) and return
      else
        render :action => 'index'
      end
      #@material = @spk.materials.build
      #@material.attributes = params[:project_material_spk]
      #if @material.save
        #flash[:notice] = "Material saved"
        #redirect_to project_spk_materials_path(@spk)
      #else
        #render :action => "index"
      #end
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

    def destroy
      @material.destroy
      flash[:notice] = "Material deleted"
      redirect_to project_spk_materials_path(@spk)
    end

    private
    def set_tab
      @tab = 'transactions'
      @current = 'prj'
    end
  end
end
