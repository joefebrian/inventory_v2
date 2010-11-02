# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def prawn_header
    pdf.text "Header"
  end

  def local_currency(number)
    number_to_currency(number, :unit => 'Rp. ', :delimiter => '.', :separator => ',')
  end
end
