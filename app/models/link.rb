class Link < ApplicationRecord
  belongs_to :user
  before_save :linkify
  has_many :comments, as: :commentable
  acts_as_votable

  def linkify
    if !(self.url.include?("http"))
      self.url = "http://"+self.url
    end
  end
end
