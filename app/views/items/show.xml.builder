xml.instruct! :xml, :version => "1.0"
xml.item do
  xml.id @item.id
  xml.name @item.name
  xml.code @item.code

  xml.units do
    for unit in @item.units
      xml.unit do
        xml.id unit.id
        xml.name unit.name
        xml.position unit.position
        xml.conversion_rate unit.conversion_rate
      end
    end
  end
end
