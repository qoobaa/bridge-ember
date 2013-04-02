class Table < ActiveRecord::Base
  %w[n e s w].each { |direction| belongs_to :"user_#{direction}", class_name: "User" }
end
