a <-1
a
b <-2
b
c <-3
c
d <-3.5
d
a+b
a+b+c
4/b
5*b

var1 <- c(1,2,5,7,8)
var1
var(var1)
var2 <- c(1:5)
var2
var3 <- seq(1,5) 
var3 
var3 <- (1:5) #C를 안넣고 저장하는건 무슨 의미일까?
var3
var4 <- seq(1,10, by = 2)
var4
# var4 <- ((1:10), by=2) 이런건 안됨. 배수 하고싶으면 seq 함수써서 할것
# var4 <- c(1:10, by=2) 이런것도 안됨.
var4
var5 <-seq(1,10, by=3)
var5
var5 +1
var1+var2
var4+var5

str1 <-"a"
str1
str2 <-'a' #따옴표 종류 상관없음
str2
str1==str2

str7 <- 'a'
str8 <- 'b'
str7=str8
str7==str8 #내가 똑같다고 해주면 똑같다고 하네


str3 <- 'text'
str3
str4<-"Hello World!!"
str4
str5 <- c("a", "b", "c")
str5
str6 <-c("Hello!", "world", "is", "good!")
str6
str7 <-"1" #숫자가 아니라 문자1을 넣었으니 수학적 계산 안됨
str7
str7 +1

x <-4
is.numeric(x) #숫자인가 확인
i <-5L
is.integer(i) #int는 뒤에 L이 붙음
is.numeric(i) #int는 numeric의 부분집합임.
class(4L)
class(2.8)
4L * 2.8 #당연히 int와 numeric은 계산 됨
class(5L/2L) #int와 numeric으로 나뉘는 기준은 뭘까?

x<- 'data'
nchar(x)
nchar('hello')
nchar(123)
length(x)

