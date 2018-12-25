require 'mechanize'

agent = Mechanize.new
page = agent.get('https://uni.likelion.org/users/1143')

my_page = page.form_with(:action => "/users/sign_in") do |f|
    f.field_with(:name => "user[email]").value = "hyj9785@likelion.org"        #field_with는 가져오는거 
    f.field_with(:name => "user[password]").value = "pko6739yj-"
end.submit

page2 = agent.get("https://uni.likelion.org/users/103")
name = page2.search("#main > header > div > div > h1").map(&:text)              #.map은 이 파일경로에서 text만 가져와라!
email = page2.search("#main > header > div > p:nth-child(2) > span").map(&:text)
subtitle = page2.search("#main > header > div > p.meta.mt-2 > span").map(&:text)
content = page2.search("#main > section > div > section > div").map(&:text)
#num = page2.search("").map(&:text)
    
puts name + email + subtitle + content
