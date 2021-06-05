 x <-c(1,1,1,2,2,2,2,3,3,31,31,32,32,32,32,33,33,33)
 median(x)
mean(x) 

install.packages("data.table")
library(data.table)
DF = fread("example_studentlist.csv", data.table=F)
?fread

DF
class(DF)
summary(DF)
DF$name
search() #저장되어있는 패키지들을 볼 수 있음. 
attach(DF) #달러 표시 안쓰고 그냥 컬럼명만 쓰면 보이게끔 할 수 있음.
name
search()
View(DF)
mean(height, na.rm = T) #na 없애버리고 나머지 가지고 구하는 것.
median(height, na.rm = T)
range(height, na.rm = T)
quantile(height, na.rm = T)
max(height,  na.rm = T)
IQR(height, na.rm = T) #사분범위를 구하는 것. 176.1 - 165.3
?IQR
#사분범위를 구하는 방식이 다양함. 기본적인게 상한 - 하한임.
IQR(height, na.rm = T, type = 7) #가장 많이쓰는게 7
IQR(height, na.rm = T, type = 5)
IQR(height, na.rm = T, type = 3)
summary(height, na.rm = T)
boxplot(height)

cor(height, weight) #공분산,  1에 가까우면 H가 증가할때 W 도 증가
#-1에 가까우면 H 증가할때 W 감소. 0이면 관계없음. 0.5 보다 크면 관계가 있다고 봄. 

DF2 = DF #DF를 복사해서 DF2를 새롭게 만듬.
DF2[2,7] = NA # 2행 7열 값을 NA로 바꿈.
DF2[4,8] = NA
View(DF2)
attach(DF2)
search()
detach(DF)
cor(height, weight) #NA가 들어있기 때문에 NA로 나옴
cor(height, weight, use="complete.obs") #공분산 구할때 NA 제외하는 법 -> use ~
detach(DF2) #attach 했던 것을 삭제.
search()
var(height, na.rm = T)
var(DF[,c(3,7,8)], na.rm = T) #3열, 7열, 8열의 분산'
sd(height)
sd(height, na.rm= T) #표준편차

(height-mean(height))/sd(height) #각각에 대한 표준점수

sd(height)/mean(height)
sd(weight)/mean(weight)

##########################################################

search()
detach(DF)
DF <- read.csv("example_salary.csv", stringsAsFactors = T, na = "-") #문자열을 펙터로 읽어옴
head(DF, 5)
str(DF) #변수 특성에 대한 설명, 데이터의 속성을 보여줌
# sumary는 데이터를 요약해준것.

colnames(DF)
colnames(DF) <- c("age", "salary", "specialSalary", 

                                  "workingTime", "numberofworker", "career", "sex")

DF
str(DF)
search()
detach(DF)
attach(DF)
mean(salary)
salary
mean1 <- mean(salary, na.rm = T)
mean1
mid <- median(salary, na.rm = T)
mid
range1 <- range(salary, na.rm=T)
range1
w <- which(salary==4064286) #max값을 가진 사람은 누구?
w #salary가 ~인것을찾아서 행번호를 저장함. 
DF[w,] #w 행인 사람 행을 다 보여줌.
qnt <- quantile(salary,na.rm=T) #샐러리의 사분위수 저장
qnt
salary1 <- list(평균월급 = mean1, 중앙값월급 = mid, 월급범위 = range1, 
                    월급사분위수 = qnt)
salary1

##################################################################
search()
  detach(DF)
  DF <- read.csv("example_salary.csv", stringsAsFactors = F, na="-")
  summary(DF)
  str(DF)
  head(DF, 5)
  colnames(DF)
  colnames(DF) <- c("age", "salary", "specialSalary", 
                     "workingTime", "numberofworker", "career", "sex")
  attach(DF)
  age #Attach 한번 바꿔줘야함!!! 컬럼명 바꿔줬으니까..
  temp <- tapply(salary, sex, mean, na.rm = T)
  #두번째 인자를 기준으로 첫번째 인자를 세번째 함수로 값을 구함.
  # sex 기준으로 salary의 mean을 구하라. 
  temp
  class(temp)
  install.packages("reshape2")
  library(reshape2)
  library("ggplot2")
  melt <- melt(temp) #array를 data.frame으로 저장
  ?melt 
  class(melt)
  ggplot(melt, aes(x=Var1, y=value, fill=var1)) + geom_bar(stat="identity")
#어떤 데이터로 x축 y축에 뭐를 표시? , geam -> 어떤 형태의 그래프로 표시?
  m <- tapply(salary, sex, sd, na.rm=T)
  class(m)
  n <- tapply(salary, sex, range, na.rm=T)
  class(n)
  n
  melt2 <- melt(n)
  melt2
  temp <-  tapply(DF$salary, DF$career, mean, na.rm=T)
  temp
  class(temp)
  ggplot(melt, aes(x=Var1, y=value, group=1)) + geom_line(colour = "skyblue2",size=2) 
  + coord_polar() + ylin(0, max(melt$value))
  tapply(DF$salary,DF$career, sd, na.rm=T)
  tapply(DF$salary,DF$career, range, na.rm=T)
  a1 <- DF[which(DF$salary == 1172399),]
  a1
  a2 <- DF[which(DF$salary == 1685204),]
  a3 <- DF[which(DF$salary == 1117605),]
  a4 <- DF[which(DF$salary == 1245540),]
  a5 <- DF[which(DF$salary == 1548036),]
  list2 <- list(a1, a2, a3, a4, a5)
  list2
  nchar(list2)
  length(list2)
  ###########################################
