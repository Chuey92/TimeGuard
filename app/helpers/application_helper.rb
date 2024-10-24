module ApplicationHelper

  def shift_background_color(user)
    case user.id
    when 4
      '#1EDD88'  # 颜色为浅绿色
    when 5
      '#CCCCFF'  # 颜色为蓝绿色
    else
       '#CCFFCC'
    end
  end
end
