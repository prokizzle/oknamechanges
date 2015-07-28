class HomeController < ApplicationController
  def index
    @first_change = UsernameChange.random
  end
end