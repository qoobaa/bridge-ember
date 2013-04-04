json.array! @tables do |table|
  json.partial! "api/tables/table", table: table
end
