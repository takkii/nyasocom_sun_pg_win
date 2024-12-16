require 'date'

class Secret
  def matches?(request)
    current = Date.today

    # 期間指定
    b_date = Date.parse('2024-1-1')
    e_date = Date.parse('2024-12-31')

    # 期間限定
    (current <=> b_date) >= 0 && (current <=> e_date) <= 0
  end
end
