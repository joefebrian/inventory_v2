TRANS_PREFIX = { :item_transfer => 'TRF',
                 :begining_balance => 'BLC',
                 :item_in => 'INT',
                 :item_out => 'OUT',
                 :assembly => 'ASS',
                 :material_request => "MRQ",
                 :quotation_request => "QRQ",
                 :purchase_orders => "PO",
                 :purchase_returns => "PTR",
                 :item_receives => "ITR",
                 :quotation => 'QUO',
                 :sales_order => 'SO',
                 :sales_invoices => 'INVO',
                 :delivery_orders => 'DO',
                 :trans_diassemblies => 'TRAN-DISS',
                 :trans_assemblies => 'TRAN-ASS' }
COMPANY_MODE = { :inventory => false, :ca => false, :foobar => true, :rai => true }
PRIVILEGES = YAML::load_file("#{RAILS_ROOT}/config/privileges.yml")['privileges']
