class Responder < ActiveRecord::Base

  self.inheritance_column = nil

  EXCLUDED_JSON_ATTRIBUTES = [:id, :created_at, :updated_at]

  RESPONDER_TYPES = %w(Fire Medical Police)

  validates :type, :presence => true
  validates :name, :presence => true, uniqueness: {case_sensitive: false}
  validates :capacity, :presence => true, inclusion: { in: 1..5 }


  def as_json(options={})
    exclusion_list = []
    exclusion_list += EXCLUDED_JSON_ATTRIBUTES
    options[:except] ||= exclusion_list
    super(options)
  end

  def self.capacity
    capacities = {}
    RESPONDER_TYPES.each do |responder_type|
      capacities[responder_type] = capacity_for(responder_type)
    end
    capacities
  end

  def self.capacity_for(responder_type)
    capacities = []
    responders = Responder.all
    responders = responders.where(type: responder_type)
    capacities << responders.sum(:capacity)
    capacities << (responders.where(emergency_code: nil)).sum(:capacity)
    capacities << (responders.where(on_duty: true)).sum(:capacity)
    capacities << (responders.where(on_duty:true, emergency_code: nil)).sum(:capacity)
  end 

end
