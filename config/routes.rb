ActionController::Routing::Routes.draw do |map|

  map.resources :customers do |customer|
    customer.resource :profile
    customer.resource :tax_profile
    customer.resources :customer_prices,
      :only => [:index, :new, :create],
      :collection => { :edit_prices => :get, :update_prices => :put }
  end

  map.resources :general_transactions, :member => { :detail => :get }
  map.resources :transaction_types
  map.resources :begining_balances
  map.resources :placements
  map.resources :plus
  map.resources :suppliers
  map.connect 'created_transactions', :controller => :transactions, :action => :created
  map.resources :warehouses, :member => { :plu_available => :get, :setdefault => :get, :setasdefault => :put } do |warehouse|
    warehouse.resources :locations
  end
  map.resources :user_sessions
  map.resources :items, :collection => { :lookup => :get }, :member => { :customer_prices => :get }
  map.resources :categories, :member => {:items_for_begining_balance => :get} do |category|
    category.resources :items, :member => { :activate => :get, :deactivate => :get }
  end
  map.resources :companies
  map.resources :users

  map.namespace(:reports) do |report|
    report.resources :on_hands
    report.resources :item_movements, :collection => { :generate => :get, :excel => :get }
    report.resources :stock_cards
  end
  map.signin "signin", :controller => :user_sessions, :action => :new
  map.signout "signout", :controller => :user_sessions, :action => :destroy

  map.with_options(:controller => :pages, :action => :show) do |page|
    page.transactions 'transactions', :id => 'transactions'
    page.reports 'reports', :id => 'reports'
    page.administrations 'administrations', :id => 'administrations'
  end
  map.dashboard 'dashboard', :controller => :pages

  map.root :controller => :pages
  map.connect ':controller/:action.:format'
end
