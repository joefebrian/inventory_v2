# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100727052203) do

  create_table "assemblies", :force => true do |t|
    t.integer  "company_id"
    t.string   "number"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tipe"
    t.string   "name"
    t.integer  "category_id"
    t.string   "code"
  end

  create_table "assembly_entries", :force => true do |t|
    t.integer  "assembly_id"
    t.string   "item_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.text     "description"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "code"
  end

  create_table "companies", :force => true do |t|
    t.string   "name"
    t.text     "address"
    t.string   "phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "subdomain"
  end

  create_table "customer_prices", :force => true do |t|
    t.integer  "customer_id"
    t.integer  "item_id"
    t.integer  "unit_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "price"
  end

  create_table "customers", :force => true do |t|
    t.integer  "profile_id"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "price_list_id"
  end

  create_table "entries", :force => true do |t|
    t.integer  "company_id"
    t.integer  "transaction_id"
    t.integer  "plu_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "item_id"
    t.integer  "value"
  end

  create_table "entry_details", :force => true do |t|
    t.integer  "entry_id"
    t.integer  "ref_entry_detail_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "used_up"
    t.integer  "available_quantity"
    t.integer  "value"
  end

  create_table "items", :force => true do |t|
    t.integer  "category_id"
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "count_method",       :default => "avg"
    t.boolean  "active"
    t.boolean  "is_stock"
    t.integer  "length"
    t.integer  "width"
    t.integer  "height"
    t.integer  "weight"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.boolean  "assembly"
  end

  create_table "kurs_ids", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "kurs_rates", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.integer  "value"
    t.date     "tgl_berlaku"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "locations", :force => true do |t|
    t.integer  "warehouse_id"
    t.string   "code"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "position"
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
  end

  create_table "material_request_entries", :force => true do |t|
    t.integer  "material_request_id"
    t.integer  "item_id"
    t.integer  "quantity"
    t.date     "estimated_delivery_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "material_requests", :force => true do |t|
    t.integer  "company_id"
    t.string   "number"
    t.date     "userdate"
    t.string   "reference"
    t.string   "requester"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "placements", :force => true do |t|
    t.integer  "company_id"
    t.integer  "warehouse_id"
    t.integer  "plu_id"
    t.integer  "quantity"
    t.string   "reference"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plus", :force => true do |t|
    t.integer  "item_id"
    t.integer  "supplier_id"
    t.string   "payment_term"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "code"
  end

  create_table "price_list_entries", :force => true do |t|
    t.integer  "price_list_id"
    t.integer  "item_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "unit_id"
  end

  create_table "price_lists", :force => true do |t|
    t.integer  "company_id"
    t.string   "code"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "active_from"
    t.date     "active_until"
  end

  create_table "profiles", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address"
    t.string   "city"
    t.string   "phone"
    t.string   "fax"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotation_entries", :force => true do |t|
    t.integer  "quotation_id"
    t.integer  "item_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotation_request_entries", :force => true do |t|
    t.integer  "quotation_request_id"
    t.integer  "item_id"
    t.integer  "quantity"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotation_requests", :force => true do |t|
    t.integer  "company_id"
    t.string   "number"
    t.date     "request_date"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotation_requests_suppliers", :id => false, :force => true do |t|
    t.integer  "quotation_request_id"
    t.integer  "supplier_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "quotations", :force => true do |t|
    t.string   "number"
    t.date     "tanggal_berlaku"
    t.integer  "customer_id"
    t.string   "hal"
    t.string   "penerima"
    t.string   "nama_proyek_customer"
    t.text     "keterangan"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_id"
  end

  create_table "sales_order_entries", :force => true do |t|
    t.integer  "sales_order_id"
    t.string   "item_id"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sales_orders", :force => true do |t|
    t.integer  "company_id"
    t.integer  "quotation_id"
    t.string   "number"
    t.date     "tanggal"
    t.integer  "top"
    t.integer  "advance"
    t.integer  "status"
    t.integer  "totral_bruto"
    t.integer  "total_disc"
    t.integer  "total_netto"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "retensi"
    t.integer  "customer_id"
    t.string   "order_ref"
    t.integer  "kurs_id"
    t.integer  "kurs_value"
  end

  create_table "salesmen", :force => true do |t|
    t.integer  "company_id"
    t.integer  "profile_id"
    t.string   "code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", :force => true do |t|
    t.integer  "company_id"
    t.string   "code"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "profile_id"
    t.string   "email"
  end

  create_table "tax_profiles", :force => true do |t|
    t.integer  "customer_id"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "address"
    t.string   "postal_code"
    t.string   "npwp_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "trackers", :force => true do |t|
    t.integer  "stock_entry_id"
    t.integer  "consumer_entry_id"
    t.integer  "available_stock"
    t.integer  "consumed_stock"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "item_id"
    t.boolean  "closed",            :default => false
    t.integer  "value"
    t.string   "type"
  end

  create_table "transaction_types", :force => true do |t|
    t.integer  "company_id"
    t.string   "code"
    t.text     "description"
    t.integer  "direction",   :default => 0
    t.boolean  "negate",      :default => false
    t.boolean  "alter_date",  :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alter_stock"
    t.string   "name"
    t.boolean  "edittable",   :default => true
  end

  create_table "transactions", :force => true do |t|
    t.string   "number"
    t.integer  "origin_id"
    t.integer  "destination_id"
    t.integer  "quantity"
    t.string   "transaction_ref"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.string   "type"
    t.text     "remark"
    t.boolean  "alter_stock",         :default => true
    t.integer  "transaction_type_id"
  end

  create_table "units", :force => true do |t|
    t.integer  "item_id"
    t.integer  "position"
    t.string   "name"
    t.integer  "conversion_rate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "value"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
  end

  create_table "warehouses", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.text     "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.boolean  "default"
  end

end
