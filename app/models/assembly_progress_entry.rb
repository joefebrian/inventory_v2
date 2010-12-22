class AssemblyProgressEntry < ActiveRecord::Base
  belongs_to :assembly, :class_name => "TransAssembly", :foreign_key => "trans_assembly_id"
  belongs_to :assembly_entry, :class_name => "TransAssembliesEntry", :foreign_key => "assembly_entry_id"

  def alter_stock
    # get the item included in the formula
    # ... code
    # kurangi stock bahan-bahan pembentuk
    ttype = TransactionType.first(:conditions => { :company_id => assembly.company.id, :code => "ASSY-COMP" })
    trans = assembly.company.general_transactions.new
    trans.transaction_type = ttype
    trans.number = GeneralTransaction.next_number(company, ttype)
    trans.origin_id = assembly.warehouse_id
    trans.alter_stock = true
    trans.remark = "Auto-generated from Assembling / Production # #{assembly.number} date #{created_at.to_s(:long)}"
    entries.each do |entry|
      trans.entries.build(:plu_id => entry.plu_id, :quantity => entry.quantity)
    end
    trans.save
    # tambah stock barang jadi hasil assembly
    ttype = TransactionType.first(:conditions => { :company_id => company.id, :code => "AUTO-ASSY" })
    trans = company.general_transactions.new
    trans.transaction_type = ttype
    trans.number = GeneralTransaction.next_number(company, ttype)
    trans.origin_id = warehouse_id
    trans.alter_stock = true
    trans.remark = "Auto-generated from Assembling / Production # #{assembly.number} date #{created_at.to_s(:long)}"
    entries.each do |entry|
      trans.entries.build(:plu_id => entry.plu_id, :quantity => entry.quantity)
    end
    trans.save
  end

end
