library("dplyr")
library("ggplot2")

mpg$total <- (mpg$cty + mpg$hwy)/2
mpg$total
mean(mpg$total)

mpg
mpg1 <- mpg
mpg1
str(mpg)
summary(mpg1$total)
hist(mpg1$total)

mpg1$test <- ifelse(mpg1$total >= 20.5, "pass", "fail")

head(mpg1, 20)

table(mpg1$test)
class(mpg1$test)
mpg1$test <- as.factor(mpg1$test)
hist(mpg1&test) #잉?

mpg$grade <- ifelse(mpg1$total >=30, "A", ifelse(mpg1$total >= 20, "B", "c"))
#ifelse 문 뒤가 몽땅 세번째인자임.

head(mpg, 3) #랜덤하게 보고싶으면?

mpg$grade2 <- ifelse(mpg1$total >=30, "A",
                     ifelse(mpg1$total >=25, "B",
                            ifelse(mpg1$total >=20, "C", "D")))
 
table(mpg$grade2)

###########################직접 해보기######################################
midwest <- as.data.frame(ggplot2::midwest)
##ggplot2 쓸일 없는데 그 안에 midwest만 쓰고싶을때

midwest
dim(midwest)
midwest <-rename(midwest, total = poptotal, asian = popasian)
attach(midwest)
search()
colnames(midwest)
midwest$asianper = (asian/total)*100 #백분률이면 곱하기 100 해줘야함
detach(midwest)
hist(midwest$asianper)
summary(asianper)
m = 0.004872 #평균
midwest$test <- ifelse(asianper >= m, "large", "small")
head(midwest, 10)
table(midwest$test) #빈도표
qplot(midwest$test) #빈도 막대그래프

################################10장##################################


# %>% 단축키 컨트롤+시프트+M
# %/% 나눗셈 몫, %% 나눗셈의 나머지 구하는 것.
# 논리연산자 ==같다, != 같지 않다. 순서 바뀌면 안됨. %% , ^ 둘 다 제곱 산술연산자.

exam <- read.csv("csv_exam (2).csv")
str(exam)
View(exam)

exam %>% filter(class ==1) #filter = 해당하는 데이터를 뽑아달라
#오른쪽 함수의 첫번쨰 인자로 들어감
# %in% = 값들중에 해당하는게 하나라도 매칭되면 뽑아달라.
exam %>% filter(class ==2) 
exam %>% filter(class !=1) 
exam %>% filter(class !=3) 

exam %>% filter(math >=50) 
exam %>% filter(english >80) # %>%  안쓰고 코딩하려면 어떻게 해야하지

exam %>% filter(class ==1 & math >= 50) # %>%  안쓰고 코딩하려면 어떻게 해야하지
exam %>% filter(class ==2 & math >= 80)

exam %>% filter(math >=90 | english >= 90)
exam %>% filter(science < 50 | english < 90)

exam %>% filter(class==1 | class==2 | class==3)
exam %>% filter(class %in% c(1,3,5)) #둘이 같은 맥락. 매치연산자

class1<- exam %>% filter(class ==1) #클래스가 1인 값의 모든 컬럼이 나옴.
class2 <- exam %>% filter(class ==2) 
class1
class2

mean(class1$math)
mean(class2$math)

5^2
5 **2
5/2
5 %/%2 #몫 =2
5%%2 #나머지 =1

###########################직접해보기######################
mpg
search()
attach(mpg)
colnames(mpg)
case1 <- mpg %>% filter(displ <=4)
case2 <- mpg %>% filter(displ >5)

ifelse(mean(case1$hwy) > mean(case2$hwy), "4의 배기량이 더 좋다", 
       ifelse(mean(case1$hwy) < mean(case2$hwy),"4와 5의 배기량이 같다", "5의 배기량이 더 좋다"))
#같을때도 신경써야함.
#ifelse 쓸때 괄호는 넣는 항목 전체를 감싸주어야함. 조건만이 아니라..

aud <- mpg %>% filter(manufacturer == "audi") #텍스트형 자료찾을때 꼭 따옴표표
toy <- mpg %>%  filter(manufacturer == "toyota")
ifelse(mean(aud$cty) > mean(toy$cty), "audi의 연비가 더 좋다", 
       ifelse(mean(aud$cty) < mean(toy$cty), "toyota의 연비가 더 좋다", "연비가 같다"))
the <- mpg %>% filter(manufacturer %in% c("audi", "ford", "honda"))
mean(the$cty)

#필터는 해당 값의 레코드를 추출하고, 설렉트는 해당 컬럼을 추출함.
str(exam)
exam %>%  select(math)
exam %>% select(english)
exam %>% select(class, math, english)
exam %>% select(-math)
exam %>% select(-math, -english)

exam %>%  filter(class ==1) %>% select(math)
exam %>% select(math) %>% filter(class ==1) #순서를 바꾸면 안됨... math민 뽑았으니까 
#class를 구분할 컬럼이 없어서 그런듯
#필터는 해당하는 항목의 모든 컬럼을 보여주지만 설렉트는 해당하는 컬럼 만 보여줌.. 구성에 유의
exam %>% select(id, math) %>% head() #기본인 6개만 추출됨.
exam %>% select(id, math) %>% head(4)

#######################################직접 해보기#######################

r1 <- mpg %>% select(class, cty)
tail(r1, n=20)
com <- r1 %>% filter(class == "compact")
su <- r1 %>% filter(class == "suv")
mean(com$cty)
mean(su$cty)

