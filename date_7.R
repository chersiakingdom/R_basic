#직접 해보기는 아래쪽에 있습니다!!

library(data.table) #ram에 저장됨, 닫고 키면 다시 부착해줘여함,
library(reshape2)
library("ggplot2")

DF <- read.csv("example_salary.csv", stringsAsFactors = F, na = '-')
colnames(DF)
colnames(DF) <- c("age", "salary", "specialsalary", "workinglime", 
                  "numberofworker", "career", "sex")
search() #이전에 썼던 DF 저장되어있는지 꼭 확인한 후 detach 할것
attach(DF)
salary
scale1 <- scale(salary) #비교를 위해 범위가 비슷하도록 갖도록 바꾸는 것. 
head(scale1, 10)
scale1
str(DF)
DF <-cbind(DF, scale = scale1) #데이터셋에 새로운 컬럼 붙이는 함수
#지정할 컬럼명, =, 붙일 컬럼 순으로 #컬럼을 빼고싶으면 어떻게하지?
colnames(DF)[9] = "null"
str(DF)
#ggplot -> 어떤 데이터로 그링믈 그릴건지 정하는 것(x축, y축 설정 등)
#geom_segment 등 지옴계열 함수 -> 어떤 형태로 차트를 표현할 것인지
#theme -> 이미 만들어둔 테마를 어떻게 쓸 것인가
g1 <- ggplot(DF, aes(x=scale, y=age))
g2 <- geom_segment(aes(yend=age), xend=0)
g3 <- g1+g2+geom_point(size=7, aes(colour=sex, shape=career)) + theme_minimal()
g3


DF <- read.csv("example_cancer.csv", stringsAsFactors = F, na="기록없음")
#na = ? 는 무엇을 na 로 받아들일지인데, 기록없음이라고 하면 띄어쓸 수도 있고
#오타도 있을 수 있어 위험하다.
str(DF)
search()
detach(DF)
attach(DF)
mean(age)
summary(age)

boxplot(age, range=1.5) #range 는 1.5 가 기본설정값임.
boxplot(age) #위/아래의 ㅡㅡㅡ 가 상/하한경계선, 벗어나면 이상치
grid() #차트 안에 격자모양이 만들어짐

distIQR <- IQR(age, na.rm=T) #IQR은 사분범위 구하는 함수..,
distIQR #상한 사분위수 - 하한 사분위수 한 값 (정상치의 범위)
posIQR <- quantile(age, probs = c(0.25, 0.75), na.rm =T)
posIQR #상/하한 사분위수 범위를 바꾸려면 이렇게 하면 됨. 

posIQR[[1]] #첫번째로 저장된 값(하한사분위), [[2]]는 두번째로 저장된 값인 72
# 꺽새 하나만 쓰면 23% 55 이런식으로 인덱스명까지 나옴.
Downwhisker <- posIQR[[1]] - distIQR*1.5 #박스의 맨아랫값에서 전체범위의 1.5 곱해서
#뺀 값이 상위의 ㅡㅡㅡ 값이 됨. 상한선. 1.5 는 경험치..
Upwhisker <- posIQR[[2]] + distIQR*1.5 #마찬가지로 맨 아래의 ㅡㅡㅡ 값. 하한선.
#더하기인지 빼기인지 주의해서 쓸것...
Downwhisker; Upwhisker

Outlier <- subset(DF, subset=(DF$age < Downwhisker | DF$age > Upwhisker))
Outlier



exam <-read.csv("csv_exam.csv", stringsAsFactors = T)
exam

head(exam)
head(exam, 10)
head(exam, n=10)

tail(exam)
tail(exam, 10)
tail(exam, n=10)

View(exam)

dim(exam)

str(exam)

summary(exam) #교수님이랑 char값 보여주는게 다르네. -> Factor로 받아야 보여줌.

##########################직접해보기(1)###################################

install.packages("ggplot2")
library("ggplot2")
diamonds
DF <- as.data.frame(diamonds) #as 붙이기!!
#원본 데이터는 오염되지 않은 상태로 놔둘것.
head(DF, 15)
tail(DF, n = 15)
View(DF)
dim(DF)
str(DF)
summary(DF)
help(diamonds)

##############################################################


install.packages("dplyr")
library("dplyr")

df_raw <- data.frame(var1 =c(1,2,1), var2 = c(2,3,2)) #데이터 새로만들기기
df_raw
df_new <- df_raw
df_new

df_new <- rename(df_new, class = var2)
# dataframe 이름 , 새로운 변수명 , = , 기존 변수명
df_new

############################직접 해보기(2)###################################

mpg
str(mpg)
summary(mpg)

mpg1 <- mpg

mpg1 <- rename(mpg1, city = cty, highway = hwy)
str(mpg1)

##########################################################################
df <- data.frame(var1 = c(4,3,8), var2 =c(2,6,1))
df

df$var_sum <- df$var1 + df$var2 #이렇게하면 자동으로 컬럼 새로 만들어짐
df

df$var_mean <- df$var_sum/2
df

#############################직접 해보기(3)################################

mpg$total <- (mpg$cty + mpg$hwy)/2
mpg$total
mean(mpg$total)
str(mpg)
  
