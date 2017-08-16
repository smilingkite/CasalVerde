module ApplicationHelper
  def money(number)
    number_to_currency(number, unit: "€ ", separator: ",", delimiter: ".")
  end

  def title(page_title)
    content_for :title, page_title.to_s
  end

  # def title(page_title)
  #   content_for :title, "just testing"
  # end

  # if page title is empty > use default title

  # OR

  # on user-created pages: use page.name + default title

end
