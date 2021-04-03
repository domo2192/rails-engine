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
end
