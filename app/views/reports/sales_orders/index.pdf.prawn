pdf.text "Quantity On-hand", :size => 18, :style => :bold, :align => :center
pdf.text "Report per #{@until}", :align => :center if @until
pdf.move_down 20

data = @items.map do |item|
  [ item.code, item.name, item.on_hand_stock ]
end

  pdf.table data, 
    :headers => ['Code', 'Name', 'Quantity'],
    :column_widths => { 2 => 75},
    :header_color => "cccccc",
    :header_text_color  => "ffffff",
    :align_headers => { 2 => :right },
    :border_style => :underline_header,
    :width => pdf.margin_box.width
