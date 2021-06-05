# @@@@@@@@@@@@@@@@@@@@@@@@@@데이터 시각화 예제 @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

library("ggplot2")
library("ggthemes")

DF <- read.csv("example_studentlist.csv")
str(DF)
g1 <- ggplot(DF, aes(x = height, y = weight, colour = bloodtype))
#어떤 데이터, x축, y축, 컬러 미리 설정
g1 + geom_point()
g1 + geom_line()
g1 + geom_point() + geom_line()
g1 + geom_point(size=10) + geom_line(size=1)
g1 + geom_point(size=10) + geom_line(aes(colour=sex),size=1)
# 남자랑 여자 한 그래프 내에서 따로 구분
g1 + geom_point(size=10) + geom_line(size=1) + facet_grid(.~sex)
# 남자랑 여자 각각의 그래프로 표현(양옆으로 나열)
g1 + geom_point(size=10) + geom_line(size=1) + facet_grid(sex~.)
#눕혀서 위아래로 나열
g1 + geom_point(size=10) + geom_line(size=1) + facet_grid(sex~., scales = "free")
# 값들의 범위를 적당히알맞게 고쳐줌.
g1 + geom_point() + geom_line() + theme_wsj()


str(diamonds) #데이터가.. 5만개..
ggplot(diamonds, aes(x=x, y=price)) + geom_point(aes(colour=clarity)) #변수중에 이름이 x 인게 있음.
# 변수명 포함해서 기재해줄때는 aes 로 묶고 써줘야하는것 잊지말기
ggplot(diamonds, aes(x=x, y=price, colour=clarity)) + geom_point()
ggplot(diamonds, aes(x=x, y=price, colour=clarity)) + geom_point() + theme_solarized_2()
ggplot(diamonds, aes(x=x, y=price, colour=clarity)) + geom_point(alpha=0.03) + theme_solarized_2()
# alpha값은 투명도, 이전것은점이 너무 진해서 비슷해보이지만 이거는 진한 정도를 알 수 있음 
ggplot(diamonds, aes(x=x, y=price, colour=clarity)) + geom_point(alpha=0.03) + 
  guides(colour= guide_legend(override.aes = list(alpha = 1))) + theme_solarized_2()
# 가이드 함수 = 오른편의 색깔 기준표 색상은 진하게하여(현재 alpha=1) 보기에 용이하게 하는 것.

ggplot(diamonds, aes(x=x, y=price, colour=clarity)) + geom_point(alpha=0.02) +
  geom_hline(yintercept=mean(diamonds$price), color="turquoise3", alpha=0.8) + 
  guides(colour = guide_legend(override.aes = list(alpha = 1))) +
  xlim(3,9) + theme_solarized_2()
# 여기에서의 hline 은 mean 값을 구해서 해당하는 y값에 맞춰 평행하게 선을 그어줌. 
  warnings()                                                                                     

  ########################## 시계열 데이터 ######################
  
TS <- read.csv("example_ts.csv")
TS

ggplot(TS, aes(x=Date, y=Sales)) + geom_line() #뭔가 이상?!
# 잉... 왜 이렇게 되는거? 14.5, 14.7 등 있는데 왜 안찍히지 포인트에
ggplot(TS, aes(x=Date, y=Sales)) + geom_line() + geom_point()
# 요인화가 되지 않아 간격이 뚝 떨어져버린것임. 
ggplot(TS, aes(x=factor(Date), y=Sales, group=1)) + geom_line()

ggplot(TS, aes(x=factor(Date), y=Sales, group=1)) + geom_line() + geom_point()
ggplot(TS, aes(x=factor(Date), y=Sales, group=1)) + geom_line() + geom_point() + theme_light()
ggplot(TS, aes(x=factor(Date), y=Sales, group=1)) + geom_line(colour="orange1", size=1) +
  geom_point(colour="orangered2", size=4) + theme_light()
ggplot(TS, aes(x=factor(Date), y=Sales, group=1)) +
  geom_line(colour="orange1", size=1) +
  geom_point(colour="orangered2", size=4) +
  xlab("년도")+ ylab("매출") + ggtitle("경희주식회사월별매출") +
  theme_light()
# 시계열 데이터는 날짜의 경우 넘버형이면 펙터형으로 반드시 바꿔줘야함. 

################ dplyr 패키지~데이터 처리 #################
attach(DF2)
library("dplyr")
DF <- read.csv("example_population_f.csv")
str(DF)
DF <- DF[,-1] #1번 열은 단순한 행이어서 뺌. 1-.
DF
class(DF)
DF <- tbl_df(DF) #기존의 형식(데이터 프레임)에서 데이블 형식으로 바꿈. 
class(DF)

DF2 <- filter(DF, Provinces=="충청북도" | Provinces=="충청남도")
DF2 #같더라도 반드시 변수명=변수값을 하나하나 작성해야함. 프로빈스!!
Graph <- ggplot(DF2, aes(x=City, y=Population, fill=Provinces)) + 
  geom_bar(stat='identity') + theme_wsj()
# 얜 저장하는거라 그려지지는 않음.!!!!!!!!!!!!!!!!!!!!!!!!
# province에 따라 색깔 다르게 해주는거.
# 컬러라고만 해주면 겉 색만 색칠되는데 fill이라고 해주면 안에까지 다 새칠됨
# 바 형태로 쓸땐 필로 쓰는게 적합함.
# stat 안써주면 안됨..
Graph


GraphReorder <- ggplot(DF2, aes(x=reorder(City, Population), y=Population, fill=Provinces)) +
  geom_bar(stat='identity') + theme_wsj()
GraphReorder
# 도시와 인구를 가지고 순서를 다시 정하는것.

DF3 <- filter(DF, SexRatio > 1, PersInHou < 2)
# 2인자 혹은 3인자에 해당하는거필터링
DF3
Graph <- ggplot(DF3, aes(x=City, y=SexRatio, fill=Provinces)) + geom_bar(stat='identity') + theme_wsj()
Graph


DF <- read.csv("example_population_f.csv")
DF <- DF[,c(-1,-2)] #이렇게 하면 두개 다 삭제됨.
DF <- DF[,-1:-2] #이렇게 해도 두개 다 삭제됨.
DF <- DF[,-1]
head(DF)

DF <- mutate(DF, SexF = ifelse(SexRatio < 1, "여자비율이높음", 
ifelse(SexRatio > 1, "남자비율이높음", "남여비율이 같음")))
head(DF)
class(DF$SexF)
DF$SexF <- factor(DF$SexF) 
DF2 <- filter(DF, Provinces=="경기도")
head(DF2)
Graph <- ggplot(DF2, aes(x=City, y=(SexRatio-1), fill=SexF)) + geom_bar(stat='identity', position='identity') +
  theme_wsj()
Graph
#sexRatio -1 해줌으로써 +와 -가 생기게 되고, 데이터 확인이 용이하게 됨.
# fill = 써줄때는 그래프형 안에 stat = 'identity' 써주기?!
# 포지션은 뭐지..?

DF4 <- filter(DF, Provinces=="서울특별시") # == 두개인거 조심 
Graph2 <- ggplot(DF4, aes(x=City, y=(SexRatio-1), fill=SexF)) + geom_bar(stat='identity', position='identity') +
  theme_wsj()
Graph2


#@@@@@@@@@@@@@@@@@@@@@@ 차트 그리기 실습 @@@@@@@@@@@@@@@@@@@@@@
# 모든 예제 나중에 한번 더 해보기
##### 산점도 예제 ####
mpg
ggplot(data = mpg, aes(x= displ, y = hwy))
ggplot(data = mpg, aes(x= displ, y = hwy)) + geom_point()
ggplot(data = mpg, aes(x= displ, y = hwy)) +
  geom_point() +
  xlim(3, 6) + ylim(10,30)

#### 산점도 실습 ######
#1) 
str(mpg)
search()
attach(mpg)
ggplot( data=mpg, aes(x=cty, y=hwy)) +geom_point()

# 지수 표시를 자연수로 하는 것: 
# options(scipen = 99) , options(scipen = 0)
#2)
str(midwest)
attach(midwest)
options(scipen = 99)
options(scipen = 0)
# scipen 에 따라 x 축의 수가 달라짐.. ! 지수 vs 자연수
ggplot(midwest, aes(x=total, y=asian)) + geom_point() +
  ylim(0,10000) + xlim(0,500000)


##### 막대그래프 예제 #######

mpg <- as.data.frame(ggplot2::mpg)
df_mpg <- mpg %>% group_by(drv) %>% summarise(mean_hwy = mean(hwy))
df_mpg
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) + geom_col()
# reorder 에x 값에 - 붙여주면, y 값 순대로 역순으로 순서 배열됨.


ggplot(data = mpg, aes( x = drv)) + geom_bar() #y는 빈도수가됨.
ggplot(data = mpg, aes( x = hwy)) + geom_bar() #마찬가지.


####### 막대그래프 실습###################

df_mpg <- mpg %>% filter(class=="suv") %>% group_by(manufacturer) %>% 
   summarise(mean_c = mean(cty)) %>% arrange(desc(mean_c)) %>% head(5)
df_mpg

ggplot(df_mpg, aes(x=reorder(manufacturer, -mean_c), y=mean_c)) + geom_bar(stat = 'identity')
#geom_col 하면 한번에 됨.
ggplot(mpg, aes(x=class)) +geom_bar()

######### 선/상자 그래프 예제 ############

economics
class(economics$date)
# 아까의 예시는 data가 numeric 이었는데 이 데이터셋의 데이터타입은 data 임.
# 펙터형이므로 펙터로 안바꿔도 오키
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

ggplot( data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()


##########선/상자 그래프 실습 ######################


class <- as.factor(mpg$class) #잉.. 펙터로 변환이 안됨..
class(mpg$class)
mpg$class %>% summarise()
table(mpg$class)
mpg2 <- mpg %>% filter(class %in% c("compact", "subcompact", "suv"))
ggplot( mpg2, aes(x=class, y=cty)) +geom_boxplot()


##
#######@@@@@@@@@@@@@@@ 확률분포 @@@@@@@@@@@@@@@@@@@@@@@@@@

#확률분포 - 정규분포
# 난수 = 랜덤한 수, 어떤 수가 나올지 예측X 정규분포에서 난수 얻을땐 rnorm()
# dnorm = 특정한 값에서의 확률을 표시. (특정 숫자가 발생할 확률)
# pnorm = 정규분포의 왼쪽부터 시작해서 주어진 숫자까지의 누적 확률 반환
# qnorm = qnorm의 반대, 누적확률 값을 주면 해당하는 분위수 (값) 반환

rnorm(n=10)
rnorm(n = 10, mean = 100, sd = 20) #정규분포의 평균, 표편 지정가능 
# 표준 정규분포는 아님!! 정규분포임. +정규분포는 좌우 대칭

randNorm10 <- rnorm(10)
randNorm10
dnorm(randNorm10) #해당 값이 나올 확률 반환
# 0에 가까운 수의 확률이 가장 높은것을 볼 수 있다.
dnorm(c(-1,0,1)) # -1이 생길 확률, 0, 1 이 생길 확률을 각각나타내줌. 0이 젤 높음.
dnorm(c(-10,0,10))

randNorm <- rnorm(30000)
randNorm
randDensity <- dnorm(randNorm)
randDensity
library(ggplot2)
ggplot(data.frame(x = randNorm, y = randDensity)) + aes(x = x,
                                                        y = y) + geom_point() + 
  labs(x = "Random Normal Variables", y = "Density")
# 발생할 난수와 그 확률에 관한 그래프. -> 정규분포모양.


randNorm10
pnorm(randNorm10) #왼쪽에서 주어진 숫자까지 면적.
pnorm(c(-3, 0, 3))
pnorm(-1)
pnorm(1.33)
pnorm(1) - pnorm(0)
pnorm(0) - pnorm(-1)
pnorm(1) - pnorm(-1)
p <- ggplot(data.frame(x = randNorm, y = randDensity)) + aes(x= x, y = y) + 
  geom_line() + labs(x = "X", y = "Density")

neg1Seq <- seq(from = min(randNorm), to = -1, by = 0.1)
# 0.1 단위로 잘라  가장 작은값부타 -1 까지 저장
neg1Seq
min(randNorm)
max(neg1Seq)

#영상의 30분쯤
lessThanNeg1 <- data.frame(x = neg1Seq, y = dnorm(neg1Seq))
head(lessThanNeg1)
#이거중요
lessThanNeg1 <- rbind( c(min(randNorm),0), lessThanNeg1,
                       c(max(lessThanNeg1$x), 0))
head(lessThanNeg1)
p + geom_polygon(data = lessThanNeg1, aes( x = x, y = y))
# 좌표를 찍어서 그 안에있는거 색칠하는 함수.
c(min(randNorm),0)
#max(lessThanNeg1$x)

neg1pos1Seq <- seq(from = -1, to = 1, by = 0.1)
neg1pos1Seq
neg1To1 <- data.frame( x = neg1pos1Seq, y = dnorm(neg1pos1Seq))
head(neg1To1)
tail(neg1To1)
neg1To1 <- rbind( c(min(neg1To1$x),0), neg1To1,
                  c(max(neg1To1$x), 0))
neg1To1
p + geom_polygon(data = neg1To1, aes( x = x, y = y))
randNorm10
pnorm(randNorm10)
qnorm(pnorm(randNorm10))
all.equal(randNorm10, qnorm(pnorm(randNorm10)))

#확률분포 - 이항분포
rbinom(n = 1, size = 10, prob = 0.4) #10번 수행 성공확률 0.4 ~ 몇번 선공했는지
rbinom(n = 5, size = 10, prob = 0.4) #10번 수행 성공확률 0.4인 실험을 5번 한다.
rbinom(n = 10, size = 10, prob = 0.4) 
rbinom(n = 1, size = 1, prob = 0.4)
rbinom(n = 5, size = 1, prob = 0.4)
rbinom(n = 10, size = 1, prob = 0.9)

binomData <- data.frame(Successes = rbinom(n = 10000, size = 10, prob = 0.3))
binomData
ggplot(binomData, aes(x = Successes)) + geom_histogram(binwidth = 1)
binom5 <- data.frame(Successes = rbinom(n = 10000, size = 5, prob = 0.3), Size =
                       5)
dim(binom5)
head(binom5)
binom10 <- data.frame(Successes = rbinom(n = 10000, size = 10, prob = 0.3), Size
                      = 10)
dim(binom10)
head(binom10)
binom100 <- data.frame(Successes = rbinom(n = 10000, size = 100, prob = 0.3),
                       Size = 100)
head(binom100)
binom1000 <- data.frame(Successes = rbinom(n = 10000, size = 10000, prob = 0.3),
                        Size = 10000)

binomAll <- rbind(binom5, binom10, binom100, binom1000) #각 데이터 행 합치기
dim(binomAll)
head(binomAll, 10)
tail(binomAll, 10)
# 주의. 확률 순대로 나열해서 나온게아니라 그냥 랜덤하게 끝에꺼가 나온것.

ggplot(binomAll, aes(x = Successes)) + geom_histogram(bins= 30) +
  facet_wrap(~Size, scales= "free")

dbinom( x =3, size = 10, prob = 0.3) 
pbinom( q =3, size = 10, prob = 0.3)
dbinom( x =1:10, size = 10, prob = 0.3)
pbinom( q = 1:10, size = 10, prob = 0.3)


midterm <- data.frame("국어" = c(10,20,30), "수학" = c(60,70,10), "영어" = c(20,40,70))

midterm















