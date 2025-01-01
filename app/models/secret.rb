require 'date'

class Secret
  def matches?(request)
    current = Date.today

    # 期間指定、1年単位で更新を任意でする。
    b_date = Date.parse('2025-1-1')
    e_date = Date.parse('2025-12-31')

    # 期間限定
    (current <=> b_date) >= 0 && (current <=> e_date) <= 0
  end
end
