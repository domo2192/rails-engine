class MerchantItemCountSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :count
end
