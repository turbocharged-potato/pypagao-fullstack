# frozen_string_literal: true

class UniversitiesController < ApplicationController
  def index
    @universities = University.all
  end

  def create
    university = University.new uni_params
    if university.save
      redirect_to university_courses_url(university.id), notice: 'New university created'
    else
      redirect_to universities_url, alert: "Failed to save university.
                                          #{university.errors.full_messages.join(', ')}"
    end
  end

  private

  def uni_params
    params.require(:university).permit(:name)
  end
end
