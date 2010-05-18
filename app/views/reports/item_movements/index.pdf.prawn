pdf.text "Quantity On-hand", :size => 18, :style => :bold, :align => :center
pdf.text "Report per #{@until}", :align => :center if @until
pdf.move_down 20


data = [ [ { :rowspan => 2, :text => '01/01/2008' }, '525.00', '999.99' ],
  [ '125.00', '525.00' ], 
  [ '4.2', '125.00', '525.00' ], 
  [ '4.2', '125.00', '525.00' ], 
  [ '4.2', '125.00', '525.00' ],
  [ '4.2', '125.00', '525.00' ],
  [ '4.2', '125.00', '525.00' ],
  [ '4.2', '125.00', '525.00' ],
  [ '4.2', '125.00', '525.00' ],
  [ '4.2', '125.00', '525.00' ],
  [ '4.2', '125.00', '525.00' ],
  [ '4.2', '125.00', '525.00' ],
  [ '3.2', '75.50', '241.60'  ] ]


pdf.flexible_table data,
  :position => :center,
  :headers => ['Date', 'Employee', 'Hours'],
  :border_style => :grid
