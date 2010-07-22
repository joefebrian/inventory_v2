class SalesOrder < ActiveRecord::Base
  attr_accessible :company_id, :quotation_id, :number, :tanggal, :top, :advance, :status, :totral_bruto, :total_disc, :total_netto
end
