class SecuredResourceController < ApplicationController
  before_action :authenticate
end