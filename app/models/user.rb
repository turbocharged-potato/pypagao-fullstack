# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :inet
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :inet
#  name                   :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  university_id          :bigint(8)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_university_id         (university_id)
#
# Foreign Keys
#
#  fk_rails_...  (university_id => universities.id)
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable
  has_many :answers, dependent: :destroy
  belongs_to :university, optional: true

  def karma
    upvotes = Vote.joins(answer: :user).where(score: 1, answers: { users: { id: id } }).size
    downvotes = Vote.joins(answer: :user).where(score: -1, answers: { users: { id: id } }).size
    upvotes - downvotes
  end

  def karma_formatted
    karma.positive? ? "+#{karma}" : karma.to_s
  end
end
