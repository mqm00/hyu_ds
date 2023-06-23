library(httr)
library(rvest)


url = 'https://movie.daum.net/ranking/reservation'
movie = GET(url)

movie_html = read_html(movie)

movie_div = movie_html %>% html_nodes('div.box_ranking') %>% 
  html_nodes('div.item_poster') %>% html_nodes('div.thumb_cont') %>%
  html_nodes('strong.tit_item') %>% html_nodes('a.link_txt')

movie_text = movie_div %>% html_text()

grade_div = movie_html %>% html_nodes('div.box_ranking') %>% 
  html_nodes('div.item_poster') %>% html_nodes('div.thumb_cont') %>%
  html_nodes('span.txt_append') %>% html_nodes('span.info_txt') %>%
  html_nodes('span.txt_grade')

grade_text = grade_div %>% html_text()


num_div = movie_html %>% html_nodes('div.box_ranking') %>% 
  html_nodes('div.item_poster') %>% html_nodes('div.thumb_cont') %>%
  html_nodes('span.txt_append') %>% html_nodes('span.info_txt') %>%
  html_nodes('span.txt_num')

num_text = num_div %>% html_text()

date_div = movie_html %>% html_nodes('div.box_ranking') %>% 
  html_nodes('div.item_poster') %>% html_nodes('div.thumb_cont') %>%
  html_nodes('span.txt_info') %>% html_nodes('span.txt_num')

date_text = date_div %>% html_text()


result = data.frame(movie_text, grade_text, num_text, date_text)
names(result) = c("제목", "평점", "예매율", "개봉")

View(result)



