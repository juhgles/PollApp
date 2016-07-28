class User < ActiveRecord::Base
  validates :user_name, presence: true, uniqueness: true

  def completed_polls
    Poll.find_by_sql([<<-SQL, self.id])

    SELECT polls.*, COUNT(DISTINCT(questions.id)) AS num_questions
    FROM polls
    JOIN questions ON questions.poll_id = polls.id
    JOIN answer_choices ON answer_choices.question_id = questions.id
    LEFT OUTER JOIN (
      SELECT *
      FROM responses
      WHERE responses.user_id = ?
    ) r
    ON answer_choices.id = r.answer_choice_id
    GROUP BY polls.id
    HAVING COUNT(DISTINCT(questions.id)) = COUNT(r.id)
    SQL

  end

  has_many :authored_polls,
    primary_key: :id,
    foreign_key: :author_id,
    class_name: :Poll

  has_many :responses,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :Response

  has_many :answer_choices,
    through: :responses,
    source: :answer_choice



end
