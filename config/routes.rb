ActionController::Routing::Routes.draw do |map|
  map.resources :material_allocations

  map.namespace :project do |prj|
    prj.resources :spks do |spk|
      spk.resources :materials
      spk.resources :requests, :class_name => "Project::MaterialRequest", :member => { 'allocations' => :get }
      spk.resources :deliveries, :class_name => "DeliveryOrder"
    end
  end

  #map.resources :projects do |prj|
    #prj.resource :spk, :class_name => "ProjectWorkOrder", :controller => "project_work_order"
    #prj.resources :materials, :class_name => "ProjectMaterial", :controller => "project_materials"
    #prj.resources :lot_materials, :controller => "project_lot_items"
    #prj.resources :deliveries, :controller => "project_delivery_orders"
    #prj.resources :material_requests, :controller => "project_material_requests" do |mr|
      #mr.resources :delivery_orders, :controller => "projects/delivery_orders"
    #end
    #prj.resources :work_orders, :controller => "production/work_orders"
    #prj.resources :sales_orders, :controller => "projects/sales_orders" do |so|
      #so.resources :delivery_orders, :controller => "projects/sales_orders/delivery_orders", :member => { :plu_confirmation => :get } do |dlv|
        #dlv.resource :invoice, :class_name => "SalesInvoice", :controller => "projects/sales_orders/delivery_orders/invoice"
      #end
    #end
    #prj.resources :delivery_orders, :controller => "projects/delivery_orders", :member => { :plu_confirmation => :get } do |dlv|
      #dlv.resource :invoice, :class_name => "SalesInvoice", :controller => "projects/delivery_orders/invoice"
    #end
    #prj.resources :invoices, :class_name => "SalesInvoice", :controller => "projects/invoices"
  #end
  map.namespace(:purchasing) do |purchase|
    purchase.resources :material_requests
    purchase.resources :quotation_requests, :member => { :send_request => :get }
    purchase.resources :purchase_orders, :member => { :manual_close => :get, :close => :put }
    purchase.resources :item_receives, :member => { :confirmation => :get, :confirm => :put }
    purchase.resources :purchase_returns
    purchase.resources :invoices
  end
  map.namespace(:sales) do |sales|
    sales.resources :quotations, :member => { :send_request => :get }
    sales.resources  :sales_orders, :member => { :preparation => :get, :prepared => :put } do |so|
      so.resources :delivery_orders, :controller => "sales_orders/delivery_orders", :member => { :plu_confirmation => :get } do |dlv|
        dlv.resource :invoice, :class_name => "SalesInvoice", :controller => "sales/sales_orders/delivery_orders/invoice"
      end
    end
    sales.resources :delivery_orders, :member => { :plu_confirmation => :get } do |order|
      order.resource :invoice, :class_name => "SalesInvoice", :controller => "delivery_orders/invoice"
    end
  end
  map.namespace(:production) do |production|
    production.resources :work_orders do |wo|
      wo.resources :completions
    end
    production.resources :material_requests, :member => { :confirmation => :get, :confirm => :put }
  end
  map.resources :customers, :collection => {:prices => :get, :search => :get }, :member => {:price => :get} do |customer|
    customer.resource :profile
    customer.resource :tax_profile
    customer.resources :customer_prices,
      :only => [:index, :new, :create],
      :collection => { :edit_prices => :get, :update_prices => :put }
  end
  map.namespace(:reports) do |report|
    report.resources :on_hands
    report.resources :item_movements, :collection => { :generate => :get, :excel => :get }
    report.resources :stock_cards
    report.resources :sales_orders
    report.resources :quotations
    report.resources :delivery_orders
  end
  map.resources :trans_assemblies do |assy|
    assy.resources :assembly_progress_entries, :as => "progress"
  end
  map.resources :currencies, :member => { :latest_rate => :get } do |currency|
    currency.resources :exchange_rates
  end
  map.resources :warehouses, :member => { :plu_available => :get, :setdefault => :get, :setasdefault => :put } do |warehouse|
    warehouse.resources :locations
  end
  map.resources :categories, :member => {:items_for_begining_balance => :get}, :collection => {:search => :get} do |category|
    category.resources :items, :member => { :activate => :get, :deactivate => :get }
  end

  map.resources :sales_prices
  map.resources :direct_sales
  map.resources :customer_down_payments
  map.resources :sales_returns
  map.resources :credit_debit_notes
  map.resources :sales_invoices
  map.resources :item_receives
  map.resources :trans_diassemblies
  map.resources :roles
  map.resources :salesmen
  map.resources :assemblies, :collection => { :search => :get, :item_base_search => :get }
  map.resources :services
  map.resources :price_lists
  map.resources :general_transactions, :member => { :detail => :get }
  map.resources :transaction_types
  map.resources :beginning_balances
  map.resources :placements
  map.resources :plus, :collection => { :search => :get }
  map.resources :suppliers
  map.resources :user_sessions
  map.resources :items, :collection => { :lookup => :get, :search => :get, :picker => :get }, :member => { :customer_prices => :get }
  map.resources :companies
  map.resources :users

  map.with_options(:controller => :pages, :action => :show) do |page|
    page.transactions 'transactions', :id => 'transactions'
    page.reports 'reports', :id => 'reports'
    page.administrations 'administrations', :id => 'administrations'
  end
  map.connect 'created_transactions', :controller => :transactions, :action => :created
  map.connect 'sales/search', :controller => :pages, :action => 'sales_search'
  map.connect 'purchasing/search', :controller => :pages, :action => 'purchasing_search'
  map.connect 'assy/search', :controller => :pages, :action => 'assy_search'
  map.connect 'production/search', :controller => :pages, :action => 'production_search'
  map.resources 'hpp', :controller => 'hpp'
  map.sales 'sales', :controller => :pages, :action => 'sales'
  map.purchasing 'purchasing', :controller => :pages, :action => 'purchasing'
  map.assy 'assy', :controller => :pages, :action => 'assembling_disassembling'
  map.production 'production', :controller => :pages, :action => 'production'
  map.project 'project', :controller => :pages, :action => 'project'
  map.dashboard 'dashboard', :controller => :pages
  map.signin "signin", :controller => :user_sessions, :action => :new
  map.signout "signout", :controller => :user_sessions, :action => :destroy

  map.root :controller => :pages
  map.connect ':controller/:action.:format'
end
