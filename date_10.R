
exam <- read.csv("csv_exam (2).csv") #제발 따옴표좀 써
library("dplyr")
exam %>% arrange(math) #기본적으로 오름차순 정렬 ///
exam %>% arrange(desc(math)) #내림차순으로 정렬 
exam %>% arrange(class, math) #먼저 클라스를 기준으로 정렬하고, 그 안에서 매스로 정렬

#[[1]] 예제

#audi에서 생산한 자동차 중에 어떤 모델(class)이 hwy(고속도로 연비)가 높은지 확인.
#audi에서 생산된 차량중, hy가 1~5윙[ 해당하는 자동차 데이터 출력]

#문제를 찬찬히 잘 읽고 변수명과 데이터값이 어떤게 매칭되는지 확인부터 하자
# 기본 데이터셋은 최대한 더럽히지 말자

# 1-1) audi가 생산한 자동차중에 어떤 모델이 "평균적"으로 연비가 높은지 확인하기.
mpg1 <- mpg
aud <- mpg1 %>% filter( manufacturer== "audi")
aud_pack <- aud %>% select(manufacturer, class, hwy)
aud_fac <- as.factor(aud_pack$class)
aud_fac #audi의 class 종류가 총 2개이며 어떤 항목인지 확인함.
dim(aud)
aud
cl_com <- aud_pack %>% filter(class == "compact")
cl_mid <- aud_pack %>% filter(class == "midsize")
hw_com <- mean(cl_com$hwy)
hw_mid <- mean(cl_mid$hwy)

ifelse(hw_com > hw_mid, "평균적으로 compact 모델의 연비가 높습니다", 
       ifelse(hw_com < hw_mid, "평균적으로 midsize 모델의 연비가 높습니다", "모든 모델의 연비가 동일합니다."))

#1-2) audi의 생산 차량중 hwy가 1~5위에 해당하는 자동차의 데이터 출력하기.
head(aud %>% arrange(desc(hwy)), n=5) #주의!! 내림차순으로 정렬해야함!!
#혹은, 연산자를 여러번 이용하여
mpg %>% filter(manufacturer =="audi") %>% arrange(desc(hwy)) %>% head(5)
#mpg <- as.data.frame(ggplot2::mpg) ::를 쓰면 그 패키지 안에있는 그것만 빼내올수있다.

aud_pack$drv <- aud$drv #같은 행이었던데에 그대로 붙는다
aud_pack


#[[2]] 예제

# 2-1) exam 데이터에서 math, english, science 를 합해 total 변수만들고 저장, 
# test변수 만들어 science가 60점 이상이면 p 아니면 f, total 점수 높은사람 6명 출력
search()
attach(exam)
exam$total <- c(math + english + science)
exam
exam$test <- ifelse(science >=60, "pass", "fail")
exam
exam %>% arrange(desc(total)) %>% head(6)

#2-2) mutate 함수를 이용해 mean 값 넣기
#mutate 함수를 쓰면 attach를 하지 않더라도 앞에 데이터셋명을 붙이지 않아도 된다.
search()
detach(exam)
exam %>% mutate(total = math + english + science, mean = (math + english + science) /3) %>% head(5)
exam %>% mutate(test = ifelse(science >=60, "pass", "fail")) %>% head(4)
exam %>% arrange(total) %>% head(6) # %>% 앞에 쓰는게 약간 겉함수+attach 느낌이네
#낮은값 6개가 나옴.

#[[3]] 실습

#mpg 복사본 만들고, cty와 hwy 더한 총연비변수 추가, 총 연비변수 2로 나눈 평균 연비변수 추가,
# 평균 연비변수가 가장높은 자동차3종 데이터 출력.

detach(mpg)
attach(mpg)

mpg1 <- mpg
mpg1 %>% mutate(total = cty + hwy, mean = total/2) %>% arrange(desc(mean)) %>% head(3)

# [[4]] 연습

attach(exam)
exam
exam %>% summarise(mean_math = mean(math))
mean(math)

exam %>% group_by(class) %>% summarise(mean_math = mean(math), sum_math = sum(math))
#그룹바이 까지 하면 11111 22222 33333 이런식으로 함께 붙어서 나옴
#써머라이즈 해주면 1끼리의 평균, 2끼리의 평균 등을 내어줌.

exam %>% group_by(class) %>% summarise(mean_math = mean(math), sum_math = sum(math),
                                       median_math = median(math), n=n())
# n 은 빈도수를 말함.

mpg %>% group_by(manufacturer, drv) %>% summarise(mean_cty = mean(cty)) %>% 
  head()
#그룹바이 - 그룹별로 묶음(모이게함), 써머라이즈 - 그룹별로 묶인걸 계산
# 그룹바이 개체가 두개면 한번 묶고 다시 한번 더 묶어서 보여줌

#[[5]] 실습

#mean쓰는거 주의
#mpg에서 회사별로 suv 자동차의 도시 및 고속도로 통합 연비 평균을 구해 내림차순으로 정렬,
# 1~5위까지 출력

mpg3 <- mpg
attach(mpg3)
str(mpg)
mpg2 <- mpg #suv 이런것은 class 항목에 있음.
mpg2 %>% group_by(manufacturer, class) #이렇게만 되어있으면 모여있기만 할뿐
mpg2 %>% group_by(manufacturer) %>% summarise() #이렇게하면 manufac 전체 항목 확인가능

mpg3 %>% group_by(manufacturer, class) %>% filter(class == "suv")%>%
  summarise(total_mean = mean((cty + hwy)/2))%>% arrange(desc(total_mean)) %>% head(5)

# 이거 아님!!! mpg3 %>% group_by(manufacturer, class) %>% filter(class == "suv") %>%  
# summarise(total_mean = (cty + hwy)/2) %>% arrange(desc(total_mean)) %>% head(5)
#평균이면 나누기2 해주고,, mean 값,, 


#[[6]] 실습

#6-1) 자동차 차종(class)에 따라 도시 연비가 높은지 비교하기위해 cty 평균을 구하고,
# cty 평균이 높은 순으로 정렬하여 출력하라
search()
detach(mpg4)
mpg4 <- mpg
attach(mpg4)
mpg4 %>% group_by(class) %>% summarise(cty_mean = mean(cty)) %>% 
  arrange(desc(cty_mean))
#6-2) hwy 평균이 가장 높은회사 3곳을 출력하라.

mpg4 %>% group_by(manufacturer)%>% summarise(hw_mean = mean(hwy)) %>% 
 arrange(desc(hw_mean)) %>% head(3)

#6-3) 각 회사별 compact 차종의 수를 내림차순으로 정렬하여 출력하라.
mpg4 %>% group_by(manufacturer,class) %>% filter(class == "compact") %>% summarise(n=n()) %>% 
  arrange(desc(n))

# [[7]] 예제 

## 7-1) 가로합치기 : 가로합치기는 left_join, 키 는 by 파라미터로 지정, by 변수명 앞뒤에 따옴표
test1 <- data.frame( id=c(1,2,3,4,5), midterm = c(60,80,70,90,85))
test1
test2 <- data.frame( id=c(1,2,3,4,7), finalterm = c(73, 65, 92, 54, 45))
test2
total <- left_join(test1, test2, by ="id")
total <- left_join(test2, test1, by ="id")
total
#lefi_join 에서는 앞에오는 변수가 기준이 됨. 만일 값이 없거나 다른게 있다면 앞에꺼 기준으로 NA
name <- data.frame(class = c(1,2,3,4,5), 
                   teacher = c("kim", "lee", "park", "choi", "jung"))
name
exam_new <- left_join(exam, name, by = "class")
exam_new #1:다 의 기록또한 가능

# 7-2) 세로합치기 : bind_rows() 함수를 이용해 데이터 병합
group_a <- data.frame(id = c(1,2,3,4,5), test = c(60,80,70,90,85))
group_a
group_b <- data.frame(id = c(6,7,8,9,10), test = c(73, 65, 92, 54, 45))
group_b
group_all <- bind_rows(group_a, group_b)
group_all

# [[8]] 실습
# mpg 데이터의 fl 에 대한 이름, 가격표 의 fuel = 데이터프레임을 만들고, 
#mpg fl 과 fuel의 fl 을 참조(left_join) 하여 연료 가격인 price_fl 변수 추가
# mpdel, fl, price_fl 변수 추출해서 앞부분 5행 출력하기
search()
mpg5 <- mpg
attach(mpg5)
mpg5
mpg5 %>% group_by(fl) %>% summarise()

fuel <- data.frame(fl = c("c", "d", "e", "p", "r"), 
                   price_fl =c(2.35, 2.38, 2.11, 2.76, 2.22))
is.factor(fuel)
fuel
gr1 <- left_join(mpg5, fuel, by ="fl") #어떤걸 먼저(기준으로) 할지도 고민 필요
str(gr1)

gr1 %>% select(model, fl, price_fl) %>% head(5)


# [[9]] 실습

#ggplot2 패키지의 midwest 데이터이용.
# popadualts = 해당지역 성인인구, poptotal = 전체인구. midwest 데이터에 
#전체인구대비 미성년인구 백분율 변수 추가
#미성년 인구 백분율 상위 5개 county의 미성년 백분율 출력
#분류 기준에 따라 미성년 등급 변수 추가, 각 등급에 몇개의 지역 있는지 출력
#large = 40% 이상, middle = 30~40% 미만, small : 30$ 미만
#popasian = 해당지역 아시아인구임. 전체인구대비 아시아인 백분율 번수 추가
#하위 10개지역 state, county, 아시아인 인구 백분율 출력
#!! poptotal 이 아니라 total 임. popasian 이 아니라 asian 임.

# 내 풀이
search()
detach(midwest) 
attach(midwest2)
library("ggplot2")

midwest2 <- as.data.frame(midwest)
#분수식에서 처음에 쓰는게 분자임
child <- midwest2$total - popadults
midwest2$chBYtot <- child/midwest2$total
str(midwest2)
# 백분율 할때 *100 하기!!!
midwest2 %>% select(county, chBYtot) %>% arrange(desc(chBYtot)) %>% head(5)
midwest2$chec <- ifelse(chBYtot >= 0.4, "large", ifelse(chBYtot >=0.3, "middle", "small"))
midwest2 %>% group_by(chec) %>% summarise(numOFchec = n())
#실수로 summary라고 쓰지않게 조심하기.

midwest2$asBYtot <- asian/midwest$total
# midwest2 %>% select(state, county, asBYtot) %>% tail(10)
# 주의!!! 그냥 tail 해봤자 하위 10개가 아님!!!!!!!!!!!! 꼭 arrange 할것

midwest2 %>% select(state, county, asBYtot) %>% arrange(asBYtot) %>% head(10)

# [[9]] 실습 교수님 풀이

search()
detach(DF)
attach(midwest1)

midwest1 <- as.data.frame(ggplot2::midwest)
midwest1
View(midwest1)
midwest1 <- midwest1 %>% mutate(ratio_child = (poptotal - popadults)/poptotal *100)
midwest1
midwest1 %>% arrange(desc(ratio_child)) %>% select(county, ratio_child) %>% head(5)

midwest1 <- midwest %>% mutate( grade = ifelse(ratio_child >= 40, "large", 
                                               ifelse(ratio_child >=30, "middle", "small")))

table(midwest1$grade) #컬럼 내의 분포를 바로 알 수 있음.!!

midwest2 <- midwest1 %>% mutate(ratio_asian = (popasian/poptotal)*100) %>% 
  arrange(ratio_asian) %>% select(state, county, ratio_asian) %>% head(10)

midwest2

####################11장 :데이터 정제하기############################
#apply는 무조건 행렬에서만 사용 가능, 즉 같은 데이터 유형에서만 가능.
# 따라서 데이터프레임은 행렬로 변경 후 실행해주어야 함.

#첫 인자 객체(행렬), 2 인자 어떻게 적용시킬지 룰(행), 3 인자는 적용할 함수)
#1 은 row, 2는 column

theMAT<- matrix(1:12, nrow =3)
theMAT

apply(theMAT, 1, sum)
apply(theMAT, 2, sum)
#같은 기능을 하는 함수로는,
rowSums(theMAT)
colSums(theMAT)
#tapply 는 저번에 배움, lapply 는 리스트 각 요소에 함수적용시사용, 결과리스트
# sapply 함수는 벡터를 반환함.
# 두 함수는 반환하는 결과값 형태만 다르므로 원하는 반환값에 맞춰 사용
theLI <- list(A =matrix(1:9, 3), B =1:15, c = matrix(1:4,2), D=2)
theLI
#A는 행렬, B는 벡터, C는 행렬, D는 스칼라
lapply(theLI, sum)
sapply(theLI,sum)

theNA <- c("Lee", "choi", "chang")
theNA
class(theNA)
lapply(theNA, nchar)
sapply(theNA, nchar)
#nchar : 알파벳 숫자 수 알려주는 함수




exam
exam %>% filter(class %in% c(1, 2, 3))



runif(20, min = 0, max = 10)


welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg, sex)







