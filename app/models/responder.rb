class Responder < ActiveRecord::Base

  self.inheritance_column = nil

  EXCLUDED_JSON_ATTRIBUTES = [:id, :created_at, :updated_at]

  validates :type, :presence => true
  validates :name, :presence => true, uniqueness: {case_sensitive: false}
  validates :capacity, :presence => true, inclusion: { in: 1..5 }


  def as_json(options={})
    exclusion_list = []
    exclusion_list += EXCLUDED_JSON_ATTRIBUTES
    options[:except] ||= exclusion_list
    super(options)
  end

end
