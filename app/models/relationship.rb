class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User" #フォローしている側のidを管理
  belongs_to :followed, class_name: "User" #フォローした相手のidを管理
end
