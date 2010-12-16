ActionController::Routing::Routes.draw do |map|
  map.resources :sales_prices
  map.resources :direct_sales
  map.resources :customer_down_payments
  map.resources :sales_returns
  map.resources :credit_debit_notes
  map.resources :sales_invoices
  map.resources :delivery_orders
  map.resources :item_receives
  map.resources :trans_assemblies
  map.resources :trans_diassemblies
  map.resources :roles
  map.resources :currencies, :member => { :latest_rate => :get } do |currency|
    currency.resources :exchange_rates
  end
  map.resources :salesmen
  map.resources :assemblies, :collection => { :search => :get }
  map.resources :services
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
    sales.resources  :sales_orders
  end
  map.resources :customers, :collection => {:prices => :get, :search => :get }, :member => {:price => :get} do |customer|
    customer.resource :profile
    customer.resource :tax_profile
    customer.resources :customer_prices,
      :only => [:index, :new, :create],
      :collection => { :edit_prices => :get, :update_prices => :put }
  end

  map.resources :price_lists
  map.resources :general_transactions, :member => { :detail => :get }
  map.resources :transaction_types
  map.resources :beginning_balances
  map.resources :placements
  map.resources :plus, :collection => { :search => :get }
  map.resources :suppliers
  map.connect 'created_transactions', :controller => :transactions, :action => :created
  map.resources :warehouses, :member => { :plu_available => :get, :setdefault => :get, :setasdefault => :put } do |warehouse|
    warehouse.resources :locations
  end
  map.resources :user_sessions
  map.resources :items, :collection => { :lookup => :get, :search => :get, :picker => :get }, :member => { :customer_prices => :get }
  map.resources :categories, :member => {:items_for_begining_balance => :get}, :collection => {:search => :get} do |category|
    category.resources :items, :member => { :activate => :get, :deactivate => :get }
  end
  map.resources :companies
  map.resources :users

  map.namespace(:reports) do |report|
    report.resources :on_hands
    report.resources :item_movements, :collection => { :generate => :get, :excel => :get }
    report.resources :stock_cards
    report.resources :sales_orders
    report.resources :quotations
    report.resources :delivery_orders
  end

  map.with_options(:controller => :pages, :action => :show) do |page|
    page.transactions 'transactions', :id => 'transactions'
    page.reports 'reports', :id => 'reports'
    page.administrations 'administrations', :id => 'administrations'
  end
  map.sales 'sales', :controller => :pages, :action => 'sales'
  map.purchasing 'purchasing', :controller => :pages, :action => 'purchasing'
  map.assy 'assy', :controller => :pages, :action => 'assembling_disassembling'
  map.connect 'sales/search', :controller => :pages, :action => 'sales_search'
  map.connect 'purchasing/search', :controller => :pages, :action => 'purchasing_search'
  map.connect 'assy/search', :controller => :pages, :action => 'assy_search'
  map.resources 'hpp', :controller => 'hpp'
  map.dashboard 'dashboard', :controller => :pages
  map.signin "signin", :controller => :user_sessions, :action => :new
  map.signout "signout", :controller => :user_sessions, :action => :destroy

  map.root :controller => :pages
  map.connect ':controller/:action.:format'
end
