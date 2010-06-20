class Reports::ItemMovementsController < ApplicationController
  before_filter :authenticate
  before_filter :assign_tab

  def index
    @categories = current_company.categories.sorted
    @transactions = current_company.transaction_types
    @warehouses = current_company.warehouses

    respond_to do |format|
      format.html
      format.pdf
    end
  end

  def generate
    @from = params[:from].blank? ? (Time.now.beginning_of_month) : Chronic.parse(params[:from]).beginning_of_day
    @to = params[:to].blank? ? (Time.now) : Chronic.parse(params[:to]).end_of_day
    @warehouse = params[:warehouse]
    @category = params[:category]
    @transactions = params[:transactions]

    @generator = ItemMovementReport.new(current_company)
    @generator.time_start = @from
    @generator.time_end = @to
    @generator.warehouse = @warehouse
    @generator.category = @category
    @generator.displayed_transactions = @transactions

    # @rows = current_company.item_movement_report(@from, @to, @category, @warehouse, @transactions)
    @rows = @generator.generate
    respond_to do |format|
      format.html { render :layout => 'wide' }
      format.pdf
    end
  end

  def excel
    @from = params[:from].blank? ? (Time.now.beginning_of_month) : Chronic.parse(params[:from]).beginning_of_day
    @to = params[:until].blank? ? (Time.now) : Chronic.parse(params[:until]).end_of_day
    @warehouse = params[:warehouse]
    @category = params[:category]

    @ins, @outs, @rows = current_company.item_movement_report(@from, @to, @category, @warehouse, params[:transactions])
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet
    sheet1[0,0] = "Item Code"
    sheet1[0,1] = "Item name"
    sheet1[0,2] = "Start"
    idx = 3
    @ins.each do |i| 
      sheet1[0,idx] = i.code
      idx = idx + 1
    end
    sheet1[0,idx] = "Other"
    idx = idx + 1
    @outs.each do |i| 
      sheet1[0,idx] = i.code
      idx = idx + 1
    end
    sheet1[0,idx] = "Other"
    idx = idx + 1
    sheet1[0,idx] = "End"
    @rows.each_with_index do |row, i|
      sheet1[i+1,0] = row[:item].code
      sheet1[i+1,1] = row[:item].name
      sheet1[i+1,2] = row[:start_balance]
      idx = 3
      row[:user_in].each_with_index do |r, z|
        sheet1[i+1,idx] = r
        idx = idx + 1
      end
      sheet1[i+1,idx] = row[:other_in]
        idx = idx + 1
      row[:user_out].each_with_index do |r, z|
        sheet1[i+1,idx] = r
        idx = idx + 1
      end
      sheet1[i+1,idx] = row[:other_out]
        idx = idx + 1
        sheet1[i+1,idx] = row[:end_balance]
    end

    book.write "#{Rails.root}/tmp/excel.xls"
    send_file "#{Rails.root}/tmp/excel.xls"
  end

  private
  def assign_tab
    @tab = 'reports'
    @current = 'im'
  end
end
