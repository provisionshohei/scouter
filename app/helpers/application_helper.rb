module ApplicationHelper
  def set_sex(user)
    if user.sex == 0
      "女性"
    else
      "男性"
    end
  end

  def set_generation(user)
    if user.generation == 0
      "10代★"
    elsif user.generation == 1
      "20代★★"
    elsif user.generation == 2
      "30代★★★"
    elsif user.generation == 3
      "40代★★★★"
    elsif user.generation == 4
      "50代★★★★★"
    else
      "60代以上★★★★★★"
    end
  end
end
