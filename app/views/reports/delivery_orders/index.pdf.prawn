pdf.text "Delivery Order", :size => 18, :style => :bold, :align => :center
pdf.text "Report per #{@until}", :align => :center if @until
pdf.move_down 20

data = @delivery_orders.map do |delivery_order|
  [ delivery_order.number, delivery_order.do_date, delivery_order.customer_id, delivery_order.customer ]
end

  pdf.table data, 
    :headers => ['DO Number', 'Date', 'Cust. ID', 'Cust. Name' ],
    :column_widths => { 2 => 75},
    :header_color => "cccccc",
    :header_text_color  => "ffffff",
    :align_headers => { 2 => :right },
    :border_style => :underline_header,
    :width => pdf.margin_box.width
