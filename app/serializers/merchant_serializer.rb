class MerchantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name

  def self.convert(payload)
    {data: {}} 
  end
end
