module ApplicationHelper
  def money(number)
    number_to_currency(number, unit: "€ ", separator: ",", delimiter: ".")
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end
end
