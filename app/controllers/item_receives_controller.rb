class ItemReceivesController < ApplicationController
  def index
    @item_receives = ItemReceive.all
  end
  
  def show
    @item_receive = ItemReceive.find(params[:id])
  end
  
  def new
    @item_receive = ItemReceive.new
  end
  
  def create
    @item_receive = ItemReceive.new(params[:item_receive])
    if @item_receive.save
      flash[:notice] = "Successfully created item receive."
      redirect_to @item_receive
    else
      render :action => 'new'
    end
  end
  
  def edit
    @item_receive = ItemReceive.find(params[:id])
  end
  
  def update
    @item_receive = ItemReceive.find(params[:id])
    if @item_receive.update_attributes(params[:item_receive])
      flash[:notice] = "Successfully updated item receive."
      redirect_to @item_receive
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @item_receive = ItemReceive.find(params[:id])
    @item_receive.destroy
    flash[:notice] = "Successfully destroyed item receive."
    redirect_to item_receives_url
  end
end
