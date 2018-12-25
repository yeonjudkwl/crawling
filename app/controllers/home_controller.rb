class HomeController < ApplicationController
  require 'mechanize'
  
  def index
  end

  def user_data
    agent = Mechanize.new
    page = agent.get('https://uni.likelion.org/users/1143')
    
    my_page = page.form_with(:action => "/users/sign_in") do |f|
        f.field_with(:name => "user[email]").value = "hyj9785@likelion.org"        #field_with는 가져오는거 
        f.field_with(:name => "user[password]").value = "pko6739yj-"
    end.submit
    
    1143.downto(1).each do |x|
      begin
          @user = User.new
          page2 = agent.get("https://uni.likelion.org/users/#{x}")
          
          
          page2.search("#main > header > div > div > h1").map(&:text).each do |n|
            @user.name = n
          end
          page2.search("#main > header > div > p:nth-child(2) > span").map(&:text).each do |e|
            @user.email = e
          end
          page2.search("#main > header > div > p.meta.mt-2 > span").map(&:text).each do |s|
            @user.subtitle = s
          end
          page2.search("#main > section > div > section > div").map(&:text).each do |c|
            @user.content =c
          end
          @user.number = x
          @user.save
          
      rescue Mechanize::ResponseCodeError => e
      end
    end
    
    redirect_to "/home/user_view"
  end

  def idea_data
    agent = Mechanize.new
    page = agent.get('https://uni.likelion.org/users/1143')
    
    my_page = page.form_with(:action => "/users/sign_in") do |f|
        f.field_with(:name => "user[email]").value = "hyj9785@likelion.org"        #field_with는 가져오는거 
        f.field_with(:name => "user[password]").value = "pko6739yj-"
    end.submit
    
    278.downto(1).each do |x|
      begin
          @idea = Idea.new
          page2 = agent.get("https://uni.likelion.org/ideathon/ideas/#{x}")
          @idea.number = x
          
          page2.search("#header > div > div > div > h1").map(&:text).each do |t|
            @idea.title = t
          end
          page2.search("#header > div > div > div > p").map(&:text).each do |s|
            @idea.subtitle = s
          end
          page2.search("#header > div > div > div > div.header__info > div:nth-child(1) > p").map(&:text).each do |v|
            @idea.vote = v
          end
          page2.search("#header > div > div > div > div.header__info__members > div > div > a").each do |c|
            @idea.cap =c['href'].split("/").last
          end

          @idea.save
          
      rescue Mechanize::ResponseCodeError => e
      end
    end
    
    redirect_to "/home/idea_view"
  end

  def user_view
    @user = User.all
  end

  def idea_view
    @idea = Idea.all
  end
end
