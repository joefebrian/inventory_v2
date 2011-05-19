module RecordNumberFormat

  def number_format
    RecordNumberFormat.number_format
  end

  def self.number_format
    @@number_format
  end

  def self.number_format=(fmt)
    @@number_format = fmt
  end

  def self.included(base)
    base.extend         ClassMethods
  end

  module ClassMethods
    def number_format
      RecordNumberFormat.number_format
    end

    def number_format=(fmt)
      RecordNumberFormat.number_format = fmt
    end

    def record_number_format(fmt)
      self.number_format = fmt
    end

    def first_number(month = nil)
      p1, p2, p3 = number_format.split('.')
      if month
        [p1, "#{Time.now.year}#{'%.2d' % month}", "00001"].join('.')
      else
        [p1, "#{Time.now.year}#{"%.2d" % Time.now.month}", "00001"].join('.')
      end
    end

    def next_number_for_company(company)
      assoc = company.class.to_s.constantize.reflect_on_all_associations(:has_many).detect { |a| a.class_name == self.to_s }.name.to_s
      last = company.send(assoc).last
      if last
        p1, p2, p3 = last.number.split('.')
        if "#{p2}01".to_date.month == Time.now.month
          [p1, p2, "%.5d" % (p3.to_i + 1)].join('.')
        else
          first_number(Time.now.month)
        end
      else
        first_number
      end
    end
  end
end
