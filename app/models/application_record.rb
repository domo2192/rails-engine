class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.collect_records(per_page, page)
    per_page = (per_page || 20).to_i
    page = (page || 1).to_i

    limit(per_page).offset((page - 1) * per_page)
  end

  def self.find_record(id)
    find(id)
  end

  def self.find_by_fragment(params)
    params.downcase
    search_key = "%#{params}%"
    self.where("name ilike ?", "%#{search_key}%")
  end

  def self.find_by_max_price(price)
    self.where('unit_price < ?', price)
  end

  def self.find_by_min_price(price)
      self.where('unit_price > ?', price)
  end

  def self.find_by_range_price(max, min)
    self.where(['unit_price < ? AND unit_price > ?', max, min])
  end
end
