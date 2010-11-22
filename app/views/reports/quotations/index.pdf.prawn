pdf.text "Quotations", :size => 18, :style => :bold, :align => :center
pdf.text "Report per #{@until}", :align => :center if @until
pdf.move_down 20

data = @quotations.map do |quotation|
  [ quotation.number, quotation.do_date, quotation.customer_id, quotation.customer ]
end

  pdf.table data, 
    :headers => ['Quotation Number', 'Date', 'Cust. ID', 'Cust. Name' ],
    :column_widths => { 2 => 75},
    :header_color => "cccccc",
    :header_text_color  => "ffffff",
    :align_headers => { 2 => :right },
    :border_style => :underline_header,
    :width => pdf.margin_box.width
