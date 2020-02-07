class Admin::DashboardController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_AUTH_USERNAME'], password: ENV['HTTP_AUTH_PASSWORD']

  def show
    @total_products = Product.count
    @total_categories = Category.count
  end
end
