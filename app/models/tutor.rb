class Tutor < User
  has_many :meetings
  has_many :evaluations, through: :meetings

  def my_total_hours
    @all_evals = self.evaluations
    return @all_evals.sum(:hours)
  end

  def my_hours_this_week
    return self.evaluations.where(created_at: Time.now.beginning_of_week.strftime("%Y-%m-%d")..Time.now).sum(:hours)
  end

end
