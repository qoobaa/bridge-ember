json.(table, :id)
json.user_n { json.(table.user_n, :id, :email) if table.user_n }
json.user_e { json.(table.user_e, :id, :email) if table.user_e }
json.user_s { json.(table.user_s, :id, :email) if table.user_s }
json.user_w { json.(table.user_w, :id, :email) if table.user_w }
