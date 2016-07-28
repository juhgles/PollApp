class Question < ActiveRecord::Base
  validates :text, :poll_id, presence: true

  def dumb_results
    results = {}
    self.answer_choices.each do |ac|
      results[ac.text] = ac.responses.count
    end
    results
  end

  def okay_results
    results = {}
    ac = self.answer_choices.includes(:responses)
    ac.each do |choice|
      results[choice.text] = choice.responses.length
    end
    results
  end


  # SELECT answer_choices.*, COUNT(responses.id) as count
  # FROM answer_choices
  # LEFT OUTER JOIN responses
  # ON responses.answer_choice_id = answer_choices.id
  # WHERE answer_choices.question_id = 1
  # GROUP BY answer_choices.id

  def results
    ac = self.answer_choices.joins('LEFT OUTER JOIN responses ON responses.answer_choice_id = answer_choices.id')
    .select('answer_choices.*')
    .group('answer_choices.id, answer_choices.text')
    .count('responses.id')
  end

  has_many :answer_choices,
    primary_key: :id,
    foreign_key: :question_id,
    class_name: :AnswerChoice,
    :dependent => :destroy

  belongs_to :poll,
    primary_key: :id,
    foreign_key: :poll_id,
    class_name: :Poll

  has_many :responses,
    through: :answer_choices,
    source: :responses

end
