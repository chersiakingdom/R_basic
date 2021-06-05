x <- 10:1
y <- -4:5
q <-c("hotkey", "football", "baseball", "curling", "rugby", "lacrosse", "basketball", "tennis", "cricket", "soccer")
class(x)
class(q)

x
y
q
theDF <- data.frame (x, y, q) 
# 함수  괄호 안의 값들을 컬럼명으로하고 각 데이터를 row로 함.
theDF

theDF <-data.frame(first=x, second = y, sport = q) 
#괄호를 기준으로 새이름(First 등) 먼저오고 이후 기존 이룸 옴
theDF
#theDF <-data.frame(woo = y) 1. 하나만 바꾸는건 안먹힘!?, 2. 하나가지고 구성함

a <- theDF[,c('first','sport')]
a
b <- theDF[,'sport'] #나는 펙터가 아니라 바로 캐릭터로 저장되는데..?
b
class(a) #데이터프레임
class(b) #펙터(캐릭터)
theDF['sport']
c<-theDF['sport'] #데이터프레임
c
class(c) #데이터프레임
d <- theDF[['sport']] #펙터(캐릭터)
class(d) #캐릭터. 괄호 하나 더붙여주면 데이터프레임에서 변경됨
d
e <- theDF$sport
e
class(e) #캐릭터

list(1,2,3) #인자 3개, 리스트함수
list(c(1,2,3)) #리스트의 인자 1개, C 함수의 인자 3개
list(theDF,1:10)
list3 <- list(c(1,2,3),3:7)
list3
list5 <- list(theDF, 1:10, list3)
list5
names(list5)
names(list5) <- c('data.frame', 'vector', 'list') #컬럼명 저장
names(list5)
list5

list6 <- list(theDataFrame = theDF, theVector = 1:10, theList = list3)
# 만들때부터 바꿔서쓰기 가능 앞에 이름 = 뒤에 저장할 값.
names(list6)
list6

list5[[1]] #리스트5의 첫번째 원소, 데이터프레임을 가지고 나옴
class(list5[[1]])
list5[1] #리스트를 가지고 나옴.
class(list5[1])
list5[['data.frame']]
list5[[1]]$sport#데이터프레임안에 스포츠 가져올수있음
list5[1]$sport #리스트 안에 스포츠라는 변수는없음. 그 안에 있는것
length(list5)
list5
list5[[4]] <-2 #4라고 컬럼명을 지칭해서 새로 만듬
length(list5)
list5
list5[['newelement']] <-3:6
list5
length(list5)

#matrix
A <-matrix(1:10, nrow=5)
B <- matrix(21:30, nrow=5)
C <-matrix(21:40, nrow=2)
A
B
C
nrow(A)
ncol(A)
dim(A)
A + B
A * B #행렬의 곱이 아니라 같은 위치에 있는걸 단순 곱하는것
A == B  #항목값 각각에 대해
colnames(A)
rownames(B)
colnames(A) <- c('left', 'right')
rownames(A) <-c('1st', '2nd', '3rd', '4th', '5th')
A

#Array
theArray <- array(1:12, dim=c(2,3,2)) 
# 2행 3열짜리를 2개 만들라는 것.
theArray
theArray[1,,] #행, 열, 차원(행렬의 갯수) 1행에 있는 데이터 다 뽑아온다
theArray[1,,1] # 첫번째 행렬에서 1행 데이터 뽑아온다.
theArray[,,1] #첫번째 배열에 있는 2차원 데이터 가져온다.
theArray1 <- array(1:12, dim = c(2,6)) #dim <- 파라미터:함수의 동작제어
theArray1
t(theArray[,,1]) #열과 행을 서로 바꾸는것
t(theArray1)

#함수
x <- c(1,2,3)
x <- c(1:1000)
mean(x)
max(x)
min(x)

str6 <-c("Hello!", 'world', 'is','good')
str6
paste(str6, collapse = " ") #어떤거로 묶을거냐. 기재안하면 그냥 문자들 합침.
paste(str6)


mean_x <- mean(x)
mean_x
str_paste <- paste(str6, collapse = " ")
str_paste


install.packages("ggplot2") #꼭 큰따옴표로 묶기!!
library("ggplot2") #웬만하면 묶자
# qplot() 출현한 빈도 막대그래프 표시
x <- c("a", 'b', 'c', 'a')
x
qplot(x)

mpg #패키지 안에있는 예시로 쓸수있는 데이터
View(mpg) #엑셀파일로 보여줌
head(mpg, n=15) 
tail(mpg, n=5)
diamonds #또다른 데이터셋
summary(mpg) #데이터셋에 대한 대략적인 통계 정보를 알려줌. 
help(mpg) #데이터에 대한 소개를 알수 있음.
?qplot #이 함수에 대해 알수 있음. -> 

qplot(data = mpg, x = hwy) 
#데이터셋으로 뭐쓸지. 뭘 x 축에 쓸지.
#고속도로 연비수(x)에 따른 빈도
qplot(data = mpg, x = cty)
# y축에는 빈도
qplot(data = mpg, x = drv, y = hwy)
# x 축이랑 y 축에 어떤것을 쓸지 지칭
qplot(data = mpg, x = drv, y = hwy, geom = 'line')
#geom 은 그래프의 형태를 나타냄
qplot(data = mpg, x = drv, y = hwy, geom = 'boxplot')
# 4분의 범위 형태로 보여주는 .
qplot(data = mpg, x = drv, y = hwy, geom = 'boxplot', colour = drv)
# drv 에 따라 색깔을 다르게 해주겠다.

