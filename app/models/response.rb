class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :not_duplicate_response
  validate :respondent_not_author

  def respondent_not_author
    if poll_author_id == self.user_id
      self.errors[:response] << "author is the same as respondent"
    end
  end

  def better_respondent_not_author
  end

  def poll_author_id
    self.answer_choice.question.poll.author_id
  end

  def not_duplicate_response
    if respondent_already_answered?
      self.errors[:response] << "already exists for user and question"
    end
  end

  def sibling_responses
    self.question.responses.where.not(id: self.id)
  end

  def respondent_already_answered?
    sibling_responses.exists?(user_id: self.user_id)
  end



  has_one :question,
    through: :answer_choice,
    source: :question

  belongs_to :user,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

  belongs_to :answer_choice,
    primary_key: :id,
    foreign_key: :answer_choice_id,
    class_name: :AnswerChoice
end
