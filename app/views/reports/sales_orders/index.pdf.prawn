pdf.text "Sales Order", :size => 18, :style => :bold, :align => :center
pdf.text "Report per #{@until}", :align => :center if @until
pdf.move_down 20

data = @sales_orders.map do |sales_order|
  [ sales_order.number, sales_order.tanggal, sales_order.customer_id, sales_order.customer, sales_order.vat, sales_order.vat, sales_order.vat ]
end

  pdf.table data, 
    :headers => ['SO Number', 'Date', 'Cust. ID', 'Cust. Name', 'Total Bruto', 'Total Disc', 'Total Netto' ],
    :column_widths => { 2 => 75},
    :header_color => "cccccc",
    :header_text_color  => "ffffff",
    :align_headers => { 2 => :right },
    :border_style => :underline_header,
    :width => pdf.margin_box.width
