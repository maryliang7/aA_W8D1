# == Schema Information
#
# Table name: posts
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, presence: true

  belongs_to :author,
    foreign_key: :author_id,
    class_name: :User

  has_many :post_subs

  has_many :subs,
    through: :post_subs,
    source: :sub

  has_many :comments,
    foreign_key: :post_id,
    class_name: :Comment

  def comments_by_parent_id
    all_comments = self.comments
    hash = Hash.new { |h,k| h[k] = []}

    all_comments.each do |comment|
      hash[comment.parent_comment_id] << comment
    end

    hash
  end

end
