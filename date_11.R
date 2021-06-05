#aggregate 함수 : 틸트(~)를 사이에 두고 왼쪽에는 계산하고자 하는 변수,
#오른쪽에는 그룹을 나눌때 기준이되는 변수가 위치 
#기준에 따라 묶고 묶은 상태로 그 안의 값들을 세번째 인자로 구함.
# + 기호는 기준이 두개 인것임.

data(diamonds, package = "ggplot2") #로딩안하고 쓸수있는 두 번째 방법.
head(diamonds)
aggregate(price~cut, diamonds, mean)
#diamonds 의 price를, cut을 기준으로 분류하고, 그 상태에서 속한 평균을 구하라.
#min, max, sum, median 등 가능. (n()은안됨)
aggregate(price~cut+color, diamonds, mean)
# 마찬가지로 ~의 price와 color를 ~ ~.
head(aggregate(price~cut, diamonds, mean))
head(aggregate(carat~cut, diamonds, mean))
aggregate(cbind(price, carat)~cut, diamonds, mean)
#cut을 기준으로 price와 carat을 bind로 합친 후 평균을 구함
aggregate(cbind(price, carat)~cut+color, diamonds, mean)
 
install.packages("data.table")
library("data.table")

theDF <- data.frame( A = 1:10, B = letters[1:10], c = LETTERS[11:20],
                     D = rep(c("one", "two", "three"), length.out = 10))
theDT <- data.table( A = 1:10, B = letters[1:10], c = LETTERS[11:20],
                     D = rep(c("one", "two", "three"), length.out = 10))
# letters[1:10] 하면 알파벳 첫번째(a) 부터 순서대로 나옴.
# 반복되게 할거면 rep 써주는게 좋음.
theDF
theDT

str(theDF)
str(theDT) #data.table 은 data.frame 의 확장임.
class(theDF$B) #교수님껀 기본적으로 펙터임. 왜 내껀 캐릭터지;;
class(theDT$B)

diamondsDF <- data.table(diamonds)
diamondsDF
tables() #지금까지 구현한 테이블들의 대략적인 정보 확인

aggregate(price~cut, diamonds, mean) #데이터 프레임은 이런식으로 가능
diamondsDF[, mean(price), by = cut] #테이블 데이터는 이런식으로 가능
diamondsDF[, list(price = mean(price)), by = cut]

###############################데이터 시각화#########################333
Nile #시계열 자료.1871 부터 1970 까지 1년당 하나씩
str(Nile)
plot(Nile, main = "Flow changes in he Nile", xlab = "year", ylab = "flow")
plot(Nile, type = "p", main = "Flow changes in he Nile", xlab = "year", ylab = "flow")
# type이 p면 포인트로 데이터 표현됨. main에는 차트의 제목


DF <- read.csv("example_studentlist.csv", stringsAsFactors = T)
str(DF)
DF$age
plot(DF$age)
plot(DF$height, DF$weight)
plot(DF$weight ~ DF$height) #~ 이용하면 x축과 y축이 바뀜
plot(DF$height, DF$sex)
# 에러 뜨면 factor형으로 받은건지 확인
DF2 <- data.frame(DF$height, DF$weight)
DF2
plot(DF2)
DF3 <- cbind(DF2, DF$age) #컬럼 병합(추가)하는 함수
DF3
plot(DF3)

warnings()
search()
attach(DF)
class(DF$sex)
DF$sex
plot(DF$weight~DF$height, pch =as.integer(DF$sex))
# pch = sex에 따라 기호를 다르게해줌 (동그라미, 세모)
legend("topleft", c("man", "woman"), pch = DF$sex)
# 왼쪽 상단에 범주를 위치시켜라.
plot(weight~height, ann=F) #컬럼명, 범주 등 다 없앰
title(main = "KyungHee Univ. Student's height and weight relationship")
title(xlab = "height")
title(ylab = "weight")
grid() #배경에 선 그어짐

weightMean = mean(height)
weightMean
FreqBlood = table(DF$bloodtype)
FreqBlood
barplot(FreqBlood)
title(main = "Blood type frequency")
title(xlab = "blood type")
title(ylab = "frequency")
Height = tapply(DF$height, DF$bloodtype, mean)
# 2 인자 기준 1의 3 구함
Height
barplot(DF$height, ylim = c(0,200))

boxplot(DF$height)
boxplot(DF$height~DF$bloodtype)

hist(DF$height)
hist(DF$height, breaks = 5) #간격을 조정하는 것
hist(DF$height, breaks = 10, prob = T)
#갯수가 아니라 위아래를 조정하는거같은뎀
Diffpoint <- c(min(DF$height), 160, 170, 175, 180, 185, 200)
Diffpoint
# x축 분할 경계 강제로 지정
hist(DF$height, breaks =Diffpoint) #빈도수

opar <- par(no.readonly=TRUE) #플롯 저장해서 여러개 볼수있게 해줌.
par(mfrow = c(2,3)) #2행 3열로 캔버스 나눔
plot(DF$weight,DF$height)
plot(DF$sex,DF$height)
barplot(table(DF$bloodtype))
boxplot(DF$height)
boxplot(DF$height~DF$bloodtype)
hist(DF$height,breaks=10)
par(opar) #원래 크기(갯수)로 돌아옴.
attach(DF)
plot(DF$weight ~ height + age + grade + absence + sex)

runif(5)*100 #0 부터 1 까지의 숫자를 무작위로 뽑아줌 5
round(runif(5)*100) #정수로만 나옴. 괄호 안에 뽑을 갯수
runif(40)
TS1 <- c(round(runif(30)*100))
TS1
TS2 <- c(round(runif(30)*100))
TS2
TS1 <- sort(TS1, decreasing = F) #오름차순으로 정렬
TS1 
TS2 <- sort(TS2, decreasing = F)
TS2
warnings()
plot(TS1, type="l") #라인으로 그리라는 뜻인듯
lines(TS2,lty="dashed",col="red") 
#lty = 점선


x1 <- seq(1,100,1) #1부터 100까지 1씩 증가
x1
y1 <- dbinom(x1,100,0.25)
# 이항분포. 100번 시행시 0.25의 성공확률
y1
plot(x1,y1,type="p")
plot(x1,y1,type="l")
plot(x1,y1,type="h")
plot(x1,y1,type="s")

###################ggplot2 시각화 기본 ####################

library("ggplot2")
library("dplyr")
ggplot(data = diamonds) #어떤 그래프 쓸지 말 안해줌
ggplot(data = diamonds) + geom_histogram(aes(x=carat))
# y 축은 지정안하면 일반적으로 빈도
ggplot(data= diamonds, aes(x=carat)) + geom_histogram()

ggplot(data = diamonds) + geom_density(aes(x=carat), fill = "grey50")
ggplot(data = diamonds) + geom_density(aes(x=carat), fill = "red")
#density = 밀집도 / 히스토그램이랑 비슷함
ggplot(data = diamonds, aes(x=carat, y = price)) + geom_point()
ggplot(data = diamonds) + geom_point(aes(x=carat, y = price))

g1 <- ggplot(data = diamonds,aes(x=carat, y = price))
g2 <- geom_point(aes(color = color))
g1 + g2
g3 <- ggplot(data= diamonds)
g4 <- geom_point(aes(x=carat, y = price, color = color))
g3 + g4


ggplot(diamonds, aes(x = carat)) + geom_histogram() + facet_wrap(~color) 
# 컬러별로 차트를 따로 만들겠다.
ggplot(diamonds, aes(y = carat, x = 1)) + geom_boxplot()
ggplot(diamonds, aes(y = carat, x = cut)) + geom_boxplot()
ggplot(diamonds, aes(y = carat, x = cut)) + geom_violin()
ggplot(diamonds, aes(y = carat, x = cut)) + geom_point() + geom_violin()
ggplot(diamonds, aes(y = carat, x = cut)) + geom_violin() + geom_point()
#다양한 그래프 활용 함수들이 있음.
 

economics #인구조사 내용?
str(economics)

ggplot(economics, aes( x = date, y = pop)) + geom_line()


install.packages("lubridate") #시간이 얼마나 지났는지 등 날짜에 관한 패키지
library("lubridate")

economics$year <- year(economics$date)
economics$year #연도만 뽑아오는 것
economics
economics$month <- month(economics$date , label = TRUE) #월만 뽑아옴
economics
econ2000 <- economics[which(economics$year >= 2000),]
# 년도가 2000 이상인 데이터만 추출
econ2000

library(scales)

g1 <- ggplot(econ2000, aes(x = month, y = pop))
g1 #아직 어떤 형태 그래프 쓸지안지정해서 안나옴.
g2 <- geom_line(aes(color = factor(year), group =year))
# 선 색은 year에 따라, group 도 꼭 붙여줘여함.
g1+g2 
g3 <- scale_color_discrete(name = "Year")
g1+g2+g3 #오른쪽에 기준되는 값 제목을 바꿈
g4 <- scale_y_continuous(labels = comma)
# y값에 콤마를 넣어줌.
g <- g1 + g2 + g3 + g4
g
g + labs( title = "Population Growth", x = "Month", y = "Population")

install.packages("ggthemes")
library(ggthemes)
g <- ggplot(data= diamonds,aes(x=carat, y = price)) + geom_point(aes(color = color))
g
g + theme_economist() + scale_colour_economist()
g + theme_excel() + scale_colour_excel()
g + theme_tufte()
g + theme_wsj()
# 테마 -> 전체적인 색, 글씨체 등 분위기를 바꿔줌

F <- c(12, NA, 32, NA, 44)
is.na(F)



                     t
                     