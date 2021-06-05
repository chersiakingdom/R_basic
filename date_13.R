# 데이터 분석 예제 1.
# 성별, 월급 변수 뽑기, 성별에 월급 평균 만들고 그래프 그려보기

install.packages("foreign")
install.packages("readxl")
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)

raw_welfare <- read.spss( file = "koweps_hpc10_2015_beta1.sav", to.data.frame = T)
welfare <- raw_welfare
View(welfare)
str(welfare)
head(welfare)
dim(welfare)

welfare <- rename(welfare,
                  sex = h10_g3,
                  birth = h10_g4,
                  marriage = h10_g10,
                  religion = h10_g11, 
                  income = p1002_8aq1,
                  code_job = h10_eco9,
                  code_region = h10_reg7)

class(welfare$sex)
table(welfare$sex)
table(is.na(welfare$sex)) #몽땅 false만 나옴 --- na 없음
welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)
qplot(welfare$sex)
class(welfare$income)
summary(welfare$income)
qplot(welfare$income) #확인했더니 이상치 존재
qplot(welfare$income) + xlim(0, 1000)
table(is.na(welfare$income))
welfare$income <- ifelse(welfare$income %in% c(0,9999), NA, welfare$income)
# 0 이나 9999 면 NA 로 하겠다, 아니면 원래거 그대로.
table(is.na(welfare$income))
sex_income <- welfare %>%
  filter( !is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income = mean(income))
#인컴이 NA가 아닌 것들을 뽑아서, 성별 별로 분류하고, 인컴의 평균을 구한다.

sex_income
ggplot(data = sex_income, aes(x=sex, y=mean_income)) + geom_col()
# 막대로 그리기. 


#@@@@@@@@@@@@@@@@@@@@@@@
# 데이터 분석 예제 2.
raw_welfare <- read.spss( file = "koweps_hpc10_2015_beta1.sav", to.data.frame = T)
welfare2 <- raw_welfare


welfare2 <- rename( welfare2,
                   sex = h10_g3,
                   birth = h10_g4,
                   marriage = h10_g10,
                   religion = h10_g11,
                   income = p1002_8aq1,
                   code_job = h10_eco9,
                   code_region = h10_reg7)

welfare2$sex <- ifelse(welfare2$sex == 1, "male", "female")
table(welfare2$sex)
list_job <- read_excel("Koweps_Codebook.xlsx", col_names = T, sheet =2)
View(list_job)
welfare2 <- left_join(welfare2, list_job, id = "code_job")
welfare2$age <- 2019 - welfare2$birth + 1


class(welfare2$birth)
summary(welfare2$birth)
qplot(welfare2$birth)
table(is.na(welfare2$birth))
welfare2$birth <- ifelse(welfare2$birth == 9999, NA, welfare2$birth)
table(is.na(welfare2$birth))
welfare2$age <- 2019 - welfare2$birth + 1
summary(welfare2$age)
qplot(welfare2$age)
age_income <- welfare2 %>%
  filter( !is.na(income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income))
head(age_income)
ggplot(data = age_income, aes(x=age, y=mean_income)) + geom_line()


######################################################### 

welfare2 <- welfare2 %>%
  mutate(ageg = ifelse(age < 30, "young", ifelse(age <= 59, "middle","old")))
table(welfare2$ageg)
qplot(welfare2$ageg)
ageg_income <- welfare2 %>%
  filter(!is.na(income)) %>%
  group_by(ageg) %>%
  summarise(mean_income = mean(income))
ageg_income
ggplot(data = ageg_income, aes(x=ageg, y=mean_income)) + geom_col()
ggplot(data = ageg_income, aes(x=ageg, y=mean_income)) + geom_col() +
  scale_x_discrete(limits = c("young","middle","old"))
# x 축 순서를 young, middle, old로 함.

################################################ 

sex_income <- welfare2 %>%
  filter(!is.na(income)) %>%
  group_by(ageg, sex) %>%
  summarise(mean_income = mean(income))
sex_income
ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col() +
  scale_x_discrete(limits = c("young","middle","old"))
# 이렇게 하면 항목별로 구분한게 위 아래로 올라감.
ggplot(data = sex_income, aes(x = ageg, y = mean_income, fill = sex)) +
  geom_col(position = "dodge") + 
  scale_x_discrete(limits = c("young","middle","old"))
# 이렇게 하면 항목별로 구분한게 양쪽으로 따로 기재됨.

##################################################  

class(welfare2$code_job)
table(welfare2$code_job)
View(welfare2)
list_job <- read_excel("Koweps_Codebook.xlsx", col_names = T, sheet =2)
head(list_job)
dim(list_job)
welfare2 <- left_join(welfare2, list_job, id = "code_job")
welfare2 %>%
  filter(!is.na(code_job)) %>%
  select(code_job, job) %>%
  head(10)

job_income <- welfare2 %>%
  filter(!is.na(job) & !is.na(income)) %>%
  group_by(job) %>%
  summarise(mean_income = mean(income))
head(job_income)
top10 <- job_income %>%
  arrange(desc(mean_income)) %>%
  head(10)
top10
ggplot(data = top10, aes(x =reorder(job, mean_income)  , y = mean_income ))+
  geom_col() + coord_flip()
# x축이 job, y축이 mean_income , mean_income 순으로 x값들 reorder,
# coord_flip 하면 가로일렬 배치되었던 x 항목들이 y 축으로 바뀌면서 보이게 됨, 

#미리 뽑아둔 데이터 다시 이용
bottom10 <- job_income %>%
  arrange(mean_income) %>%
  head(10)
bottom10
ggplot(data = bottom10, aes(x = reorder(job, -mean_income), y = mean_income)) +
  geom_col() + coord_flip() + ylim(0,580)
# - 붙으면 큰것부터 작은것순으로(내림차순) (세로로 보일땐 y=0부터 기준)
# y lim 해주면 y로 지정한 값이 보여주는 스케일이 바뀜 .!

# 데이터 분석 예제 3. 
#준비
welfare3 <- raw_welfare
welfare3 <- rename( welfare3,
                   sex = h10_g3,
                   birth = h10_g4,
                   marriage = h10_g10,
                   religion = h10_g11,
                   income = p1002_8aq1,
                   code_job = h10_eco9,
                   code_region = h10_reg7)
welfare3$sex <- ifelse(welfare3$sex == 1, "male", "female")
list_job <- read_excel("Koweps_Codebook.xlsx", col_names = T, sheet =2)
head(list_job)
welfare3 <- left_join(welfare3, list_job, id = "code_job")
welfare3$age <- 2020 - welfare3$birth + 1


# 직접 해보기 1111##########################
agse <- welfare3 %>% select(age, income, sex) %>% 
  filter(!is.na(welfare3$income)) %>% group_by(age, sex) %>%
  summarise(mean_income = mean(income)) %>% arrange(age)
head(agse, 30)

ggplot(data=agse, aes(x=age, y=mean_income, col = sex)) + geom_line() 
# 라인 그래프에서 색 다르게하고 싶으면 fill 이 아니라, col 로 해줘야함.

#직접 해보기 2222##########################
#(1) 수 안세고 그래프로 시각화해서 대략적으로 파악
sejo <- welfare3 %>% filter(!is.na(code_job)) %>% select(sex, code_job, job) %>% group_by(sex, code_job) %>% arrange(code_job)
head(sejo, 30)
ggplot(data = sejo, aes(x = sex, y =code_job, col = sex)) + geom_point()

#(2) 수 세서 파악하기
fejo <- sejo %>% filter(sex == "female") %>% summarise(n = n()) %>% arrange(desc(n)) 
head(fejo, 10)
mejo <- sejo %>% filter(sex == "male") %>% summarise(n = n()) %>% arrange(desc(n))
head(mejo, 10)

welfare3 %>% select(code_job, job) %>%  filter(code_job == "611") %>% summarise(n())

# 주의!!!!! summarise 할때 n() 과같은 함수 쓸때 이름 지칭하기. 그래야 arrange 할때 이름 지칭해서 배열됨.
# 왜 job 은 없어졌지?

# 직접 해보기 2 : 교수님 코드
job_male <- welfare3 %>%  filter(!is.na(job) & sex == "male") %>% 
  group_by(job) %>% summarise(n=n()) %>% arrange(desc(n)) %>% head(10)
job_male
# 굳이 select 안해도 summarise 하면 그룹으로 묶은거랑 그 요약 결과. 이렇게만 띄워주는군.
# 주의! summarise 할때 a 임.. e 가 아니라
job_female <- welfare3 %>%filter(!is.na(job) & sex == "female") %>% 
  group_by(job) %>% summarise(n=n()) %>% arrange(desc(n)) %>% head(10)
job_female

# 직접 해보기 2 : 교수님 코드_ 그래프
ggplot(job_male, aes(x=reorder(job, n), y = n)) + geom_col() +
  coord_flip()
# geom 에서 bar랑 col 의 차이는 뭐지?
# x값들 이름이길어서 안보일땐 coord_flip 써줄것!

ggplot(job_female, aes(x=reorder(job, n), y=n)) + geom_col() +
  coord_flip()
#직접해보기 3333 ##################################################
# 종교 1 = 있음, 2 = 없음
#데이터 확인 및 전처리 단계. @@@@@@@@
class(welfare3$religion) #이걸 확인해야 " " 쓸지 그냥 쓸지 판단가능.
table(welfare3$religion)
welfare3$religion <- ifelse(welfare3$religion == 1, "yes", "no")
table(welfare3$religion)

class(welfare3$marriage)
table(welfare3$marriage)
# 이혼 = 3, 유배우자 = 1
welfare3$marri <- ifelse(welfare3$marriage == 1, 
                        "marr", ifelse(welfare3$marriage == 3, "divor", NA))
table(welfare3$marri)
# NA 쓸때는 " " 안붙이고 그냥 쓰는거.

table(is.na(welfare3$marri))
qplot(welfare3$marri)

# 분석 단계@@@@@ 직접한것.

#welfare3$ageg <- ifelse(age < 30, "young", ifelse(age <= 59, "middle", "old"))
# 이러면 attach 해주지 않는이상 하나하나 다 써줘야대서 번거로움.

welfare3 <- welfare3 %>% mutate(ageg = 
                                  ifelse(age <30, "young", ifelse(age <=59, "middle", "old")))

table(welfare3$ageg)
mid <- welfare3 %>% filter(ageg == "middle" & !is.na(marri)) %>% group_by(marri) %>% summarise(n=n())
mid_divo <-(mid[1,2]/(mid[2,2] + mid[1,2]))
mid_divo #0.0805652
yon <- welfare3 %>% filter(ageg == "young" & !is.na(marri)) %>% group_by(marri) %>% summarise(n=n())
yon
yon_divo <- 0 #0
class(yon_divo)
old <-  welfare3 %>% filter(ageg == "old" & !is.na(marri)) %>% group_by(marri) %>% summarise(n=n())
old_divo <- (old[1,2]/(old[2,2] + old[1,2]))
old_divo #0.075921212

#1# 연령대별 이혼율 표 ##
df1 <- data.frame(ageg = c("middle", "young", "old"), divo= c(mid_divo[1,1], yon_divo, old_divo[1,1]))
# 데이터프레임 넣어줄때 다 같은 형식 이어야함. 다르면 안들어감.. 
df1 

#2# 연령대별 이혼율 그래프 ##
ggplot(df1, aes(x=ageg, y=divo)) + geom_col() 

#ㅇㄴ.... 종교 유무를 또 나눠야하는데 안함.. !!!!!
#3# 연령대, 종교 유무에 따른 이혼율 표 ##
welfare3 <- left_join(df1, welfare3, id= "ageg" )
df2 <- welfare3 %>% group_by(ageg, religion, divo) %>% summarise()
# id = " " 이렇게 지정해줘야함.
# 레프트조인만 하면 되는게 아니라 다시 동일한 데이터셋에 저장해줘야 반영됨.
df2

#4# 연령대, 종교 유무에 따른 이혼율 그래프##
ggplot(df2, aes(x=ageg, y=divo, fill=religion)) + geom_col(position = "dodge")


  ###################위에거 다시######################
# 처음에 구할때 아예 다 구했어야 함
relimarr <- welfare3 %>% filter(!is.na(marri)) %>% group_by(religion, marri) %>% 
  summarise(n=n()) %>% mutate(tot = sum(n)) %>% mutate(p = round(n/tot*100, 1))
# 마지막에 붙인 1은 뭐지?????
relimarr

divorce <- relimarr %>% filter(marri == "divor") %>% select(religion, p)
divorce

ggplot(divorce, aes(x=religion, y=p)) +geom_col()
# 별 차이 없음.

agegmarr <- welfare3 %>% filter(!is.na(marri)) %>% group_by(ageg, marri) %>% 
  summarise(n =n()) %>% mutate(tot = sum(n)) %>% mutate( p = round(n/tot*100, 1))
agegmarr

agegdivo <- agegmarr %>% filter(marri == "divor") %>% select(ageg, p)
agegdivo
ggplot(agegdivo, aes(x=ageg, y=p)) +geom_col()

agegrelimarr <- welfare3 %>% filter(!is.na(marri)) %>% group_by(ageg, religion, marri) %>% 
  summarise(n =n()) %>% mutate(tot =sum(n)) %>% mutate(p =round(n/tot*100, 1))
agegrelimarr
# 굳이 left_join 써가면서 할필요 XXX 그냥 그룹만 잘 짓고 뮤테이트만 잘하면 됨,.. 

df_divo <- agegrelimarr %>% filter(marri == "divor") %>% select(ageg, religion, p)
df_divo

######################################### # #