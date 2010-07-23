class PurchasingMailer < ActionMailer::Base

  def quotation_request(quotation)
    recipients quotation.suppliers.collect { |supp| supp.email }
    from "Purchasing Dept. #{quotation.company.name} <rbudiharso@gmail.com>"
    subject "Quotation request"
    sent_on Time.now
    body :quotation => quotation
  end
end
