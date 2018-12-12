library(rvest)
library(httr)
library(stringr)
library(xml2)
library(RSelenium)
library(tm)
library(NLP)
library(wordcloud)
library(wordcloud2)

data(crude)
summary(crude)



setwd("D:/bb")   

url_base <- 'http://211.189.132.164:8088/redmine/issues/'   


remDr <- remoteDriver(remoteServerAddr = 'localhost', 
                      port = 4445L, 
                      browserName = "chrome") 
remDr$open() 

remDr$navigate(url_base)
html <- remDr$getPageSource()[[1]] 

id <- remDr$findElement(using="xpath", value='//*[@id=\"username\"]') 
pw <- remDr$findElement(using="xpath", value='//*[@id=\"password\"]') 


id$sendKeysToElement(list("ljgon")) 
pw$sendKeysToElement(list("stephen123!@#")) 


btn <- remDr$findElement(using="xpath",  "//input[@name = 'login']")


btn$clickElement() 

 
who <- c() 
what <- c()
title <- c()
id <- c()
urlwhat <- c()

for(page in 251:1800)
{   
  
  url <- paste(url_base, page) 
  
  id <- page
  
  
  htxt <- read_html(url)                       
  
  remDr$navigate(url)
  
  
  
  tryCatch(
    
    #expr
    {
      
      
        
          print(var)
          comments<-remDr$findElement(using="xpath",  "//*[@id='content']/div[2]/div[2]/div[1]/div[1]/div[3]/div[2]/a")
          
          reviews <- comments$getElementText()
          
          if( length(reviews) == 0 )
          {  
            
          }                        
          reviews <- str_trim(reviews)                                      
          reviews <- repair_encoding(reviews, from = 'utf-8')  
          
          
          who <- c(who, reviews)  
          
      
    },
    error = function(e){
      
      message(e)
      print(page)
    },
    warning = function(e)
    {
      message(e)
    
    },
    finally = {
       
    }
  )
    
    
    tryCatch(
      
      #expr
      {
        
        
        #��???ޱ?
        comments1<-remDr$findElement(using="xpath",  "//*[@id='content']/div[2]/div[1]/div/h3")
        
        var1 <- comments1$getElementText()
        
        if( length(var1) == 0 )
        {  
          
        }                        
        var1 <- str_trim(var1)                                      
        var1 <- repair_encoding(var1, from = 'utf-8')  
        
        
        title <- c(title, var1)
        urlwhat <- c(urlwhat, url)
        
        
      },
      error = function(e){
        
    
        tryCatch(
        
          {
            #��???ޱ?
            comments1<-remDr$findElement(using="xpath",  "//*[@id='content']/div[2]/div[1]/div/div/h3")
            
            var1 <- comments1$getElementText()
            
            if( length(var1) == 0 )
            {  
              
            }                        
            var1 <- str_trim(var1)                                      
            var1 <- repair_encoding(var1, from = 'utf-8')  
            
            
            title <- c(title, var1)
            urlwhat <- c(urlwhat, url)
            
            message(e)
            print(page)
            
          },
          error = function(e){},
          finally = {}
          
        )
      },
      warning = function(e)
      {
        message(e)
        
      },
      finally = {
      }
      
    )
    
    
    
      tryCatch(
        
        #expr
        {
          
          #?????ޱ?
          comments2<-remDr$findElement(using="xpath",  "//*[@id='content']/div[2]/div[3]/div[2]")
          
          reviews2 <- comments2$getElementText()
          
          if( length(reviews2) == 0 )
          {  
            
          }                        
          reviews2 <- str_trim(reviews2)                                      
          reviews2 <- repair_encoding(reviews2, from = 'utf-8')  
          
          
          what <- c(what, reviews2)
          
          
          count <- c(count, page)
          
          
        },
        error = function(e){
          
          
          
          
          
          message(e)
          print(page)
        },
        warning = function(e)
        {
          message(e)
          
        },
        finally = {
        }
    
    
    
   
    
  )
  
  #기존 html ???근소???
  #comments <- html_nodes(htxt, ".title")  ## comment 가 ?????? ?????? 찾아 ??????가??? 
  #comments <- htxt %>% html_nodes("wrapper2") %>% html_nodes("div")
  
  #reviews <- html_text(comments)               # ?????? 리뷰??? text ????????? 추출
  
  #reviews <- repair_encoding(reviews, from = 'utf-8')  ## ???코딩 변???

  
}





write.table(what, file = "what.txt", sep = "\t", row.names = TRUE, col.names = NA)
write.table(who, file = "who.txt", sep = "\t", row.names = TRUE, col.names = NA)
write.csv(dat, file = "title.csv")
write.table(urlwhat, file = "url.txt", sep = "\t", row.names = FALSE)
write.table(id, file = "id.txt", sep = "\t", row.names = FALSE)




View(count)
