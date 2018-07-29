# frozen_string_literal: true

class UniversitiesController < ApplicationController
  def index
    @universities = University.all
  end
end
