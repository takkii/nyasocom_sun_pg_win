import requests
from bs4 import BeautifulSoup

# スクレイピング対象の URL にリクエストを送り HTML を取得する
res = requests.get('http://localhost:8000/hyokapp/')

# レスポンスの HTML から BeautifulSoup オブジェクトを作る
soup = BeautifulSoup(res.text, 'html.parser')

# h1 タグの文字列を取得する
h1_text = soup.find('h1').get_text()
print(h1_text)