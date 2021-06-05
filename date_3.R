TRUE * 5 # TRUE 등은 모두 대문자, TRUE = 1, FALSE = 0
FALSE * 5
True * 5
k <- TRUE
class(k) #어떤형태냐? --- 범주형
k <-FALSE
is.logical(k)

x <-'a'
y <- 'b'
x=y
x==y #텍스트가 아니라 객체를 가지고 같다고 해줘야 먹힘

2!=3
2 <3
2 <=3 # OR (또는)으로 해석
2>3
2>=3
3 >3
3 >=3
'data' == 'stats'

x <- c(1, 2, 3, 4, 5, 6, 7,8, 9, 10)
x
x * 3 #한 벡터 전체의 값들에 모두 *3
x+ 2
x -3
x /4
x ^2
sqrt(x) #양의 제곱근 구하기

x <-1:10
x
y <- -5 :4
y
x +y
x-y
x^y
length(x) #벡터의 항목 갯수를 알려주는 함수
length(y)
length(x+y)
x + c(1,2) #벡터 x에 순서대로 1 과 2 를 단독으로 더해감
x + c(1,2,3) # 벡터 x 에 순서대로 1, 2, 3 을 더함. 배수가 안맞아서 경고뜸
x <=5 #맞는 값만 T, 틀린 값은 F로 알려줌
x >y
x <- 10:1
x
y<- -4:5
y
any(x<y) #하나라도 해당하면 True, 항목별로 판단
all(x<y) # 모두 해당해야 True

q <-c('Lee sunggeun', 'choi jun', 'Hello world')
q

nchar(q) #각각 항목의 개별 숫자/문자 구성 갯수를 알려줌, 띄어쓰기도 포함됨
length(q) # 벡터 내의 개별 항목이 몇개인지 알려줌
nchar(y) #숫자에 - 가 있으면 그것도 포함됨
x <- 10:1
x[1] #벡터의 첫번째 항목을 알려줌
x[1:2] #벡터의 첫번째 ~ 두번째 항까지 모두 알려줌
x[3:6]
x[c(1,4)] # 벡터의 첫번째와 네번째 항목 값을 알려줌

c(one = 'a', two = 'y', last = 'r')
x<- 6:8
x
names(x) <- c('a', 'b', 'c') #x 데이터의 컬럼값을 a, b,c 로 정해줌
x
names(x) <- c(1:3)
x
q <- c('a', 'b', 'ab', 'o', 'b', 'ab', 'o', 'ab', 'o', 'a', 'a', 'b')
q
q2 <- as.factor(q) #펙터로 변환함. ~~ numeric 함수 사용가능해짐(?)
q2
as.numeric(q2) 
#자동설정된 레벨에따라 각 데이터를 각 레벨에따른 값으로 재지정하여 보여줌.
q2



factor(w<- c('a', 'b', 'ab', 'o', 'b', 'ab', 'o', 'ab', 'o', 'a', 'a', 'b'),
levels = c('b', 'a', "o", "ab"), ordered = TRUE)
# 굳이 factor로 추후 변경하지않고 처음부터 펙터로 저장. , 를 통해 레벨 지정가능,
# 괄호주의할것 

w #앞이랑은 다르게 " " 사이로 붙어남..
as.numeric(w) # 왜인지 오류남
x2 <-as.factor(w) #재지정하면 레벨이랑 order 등 처음에 지정해준거 초기화됨
x2
as.numeric(x2)

#--- 그러면 레벨 바꿔서 numeric 하고싶을땐 어떡하지? factor 변환해도 안먹히는데

z<- c(1,2,NA,8,3,NA,3) #NA는 결측값, = 이상한 값
z #NULL과는 달리 NA가 모두 표시되어 나옴

is.na(z) #항목 각각에 대해 TRUE, FALSE 구분하여 표시
mean(z) # T = 1, F = 0 기억
mean(z, na.rm=TRUE) #na.rm -> na 를 지울까 --- TRUE -> 지워라

z<-c(1,2,NULL,8,3,NULL,3)
z # NULL은 아예 값이 지워져서 나옴
is.null(z) #모두 NULL일때만 TRUE. (다 지워지니까..)
a <-c(NULL,NULL)
is.null(a)
mean(z) #NULL 지워진채로 계산
x <-c(1:4,NULL,7:10,NA,11)
x

install.packages("dplyr") # 스크립트에 패키지 저장
unlink("C:\\Users\\rlaek\\OneDrive\\Documents\\R\\win-library\\4.0", recursive = TRUE)
library(dplyr) #저장된 패키지 불러오기
x <-c(1:5)
mean(x)
x %>% mean() # 앞의 항목(x)을 뒤의 함수 F() 에 집어넣는 양식
z <- c(1,2, NA, 8, 3, NA, 3)
z
is.na(z)
sum(is.na(z)) #NA 가 있는 항목만 T, 총 2개임
z %>% mean()
z %>% mean(na.rm = TRUE)
z %>% is.na %>% sum()

x <- 10:1
y <- -4:5
q <-c("hotkey", "football", "baseball", "curling", "rugby", "lacrosse", "basketball", "tennis", "cricket", "soccer")
x
y
q
theDF <- data.frame (x, y, q) 
# 함수  괄호 안의 값들을 컬럼명으로하고 각 데이터를 row로 함.
theDF

theDF <-data.frame(First=x, second = y, sport = q) 
#괄호를 기준으로 새이름(First 등) 먼저오고 이후 기존 이룸 옴
theDF
#theDF <-data.frame(woo = y) 1. 하나만 바꾸는건 안먹힘!?, 2. 하나가지고 구성함
nrow(theDF)
ncol(theDF)
dim(theDF)#차원을 나타냄. 몇행 몇열이냐, 앞에 row, 뒤에 col

names(theDF) #데이터프레임 변수명(컬럼명)나열
names(theDF[3]) #몇번째 알고싶은지 지정
names(theDF)[3] #얘도 됨
names(theDF) <- c('ch','er','ry')
names(theDF)
theDF
names(theDF)[3] <- 'ru' #이렇게해서 하나만 바꾸기 가능
names(theDF)
names(theDF[2]) <- 'ri' #얘는 안바뀜...
names(theDF)

rownames(theDF)
rownames(theDF) <-c('one', 'two', 'three', 'four', 'five', 'six', 'seven', 'eight', 'nine','ten')
theDF
rownames(theDF[4]) <-c('cherry') #오류뜸 
rownames(theDF)[4] <-c('cherry') #이렇게해야됨
rownames(theDF)
rownames(theDF) <-NULL #R 기본 세팅으로 되돌리
rownames(theDF)


head(theDF) #수억수천개의 데이터를 다 불러오기 부담될때 사용.
# 기본적으로는 앞쪽의 6개의 row만 보여줌
head(theDF, n=3) #보고싶은 데이터갯수 지정가능
tail(theDF) #뒤의 6개를 보여줌
tail(theDF, n=5)
class(theDF)

theDF$ru # 컬럼명 ru의 데이터 구성을 알려줌, 테이블이름$변수명
# names(theDF)[3]은 3번째 컬럼'명'만 알려줌
theDF
theDF[4,3] #행,열 의 데이터값 보여줌. 앞의 1,2, 등의 숫자 메기는거는 열로 안침
theDF[3:6,2:3] #행(어디부터 어디까지), 열(어디부터 어디까지)보여줌
theDF[3:6,c(2:3)]#똑같은 결과. 괄호가 아니라 네모괄호 주의!!!!
theDF[,3] #3열인 데이터 몽땅출력
theDF[,2:3]#2열 ~ 3열 데이터 몽땅출력
theDF[2,]
theDF[2:3,]

