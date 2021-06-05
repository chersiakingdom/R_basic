install.packages("readxl")
library(readxl)

df_exam <- read_excel("excel_exam.xlsx")
df_exam 
#df_exam <- read_excal("d:/folder_name/excel_exam.xlsx") <-절대경로

df_exam$english

mean(df_exam$english)
mean(df_exam$science)

df_exam_novar <- read_excel("excel_exam_novar.xlsx", col_names = F )
#첫번째 행에 변수명이 없는경우
df_exam_novar

df_exam_sheet <- read_excel("excel_exam_sheet.xlsx", sheet = 3)
df_exam_sheet
class(df_exam_sheet)
#엑셀의 3번시트에 있는거 보여줌

df_csv_exam <- read.csv("csv_exam.csv", stringsAsFactors = T)
df_csv_exam
df_csv_exam$class
class(df_csv_exam$class)
#펙터로 받으면 겹치는걸 하나로 묶어서 내부적으로 한다

df_csv_exam <- read.csv("csv_exam.csv", stringsAsFactors = F)
df_csv_exam
#만약에 T이면 스트링을 펙터로 읽어들이겠다는것
#즉, 겹치는 데이터가 많으면 펙터로 바꾼다 -> 일일히 저장 안한다.
#캐릭터형으로 받으면 겹치는걸 하나로 묶지 않는다.
df_csv_exam$class
class(df_csv_exam$class)

df_midterm <- data.frame(english = c(90, 80, 60, 70), 
                         math = c(50, 60, 100, 20), class = c(1, 1, 2, 2))

#데이터 프레임을 만드는데 잉글리시에 해당 점수, 매쓰에 해당 점수 등 보관함
df_midterm

write.csv(df_midterm, file = "df_midterm.csv")
#만든 파일을 데이터파일로 저장하는것, 위치는 지정한 경로에 있음.

x <- c(1,2,3,4,5)
x
y <- x+5
y

if(sum(x) < sum(y)) { print(x)}

if(TRUE) print(x)
if(TRUE & FALSE) 
{  print(x)}
if(T&T) print(x)


if (sum(x) < sum(y)) {
  print(x)
  print(mean(x))
  print(var(x))
}

if (mean(x) > mean(y)) {
  print(paste("mean(x) 가", mean(x)-mean(y), "만큼 크다."))
} else {
  print(paste("mean(y)가 ", mean(y)-mean(x), "만큼 크다."))
}

ifelse (mean(x) > mean(y), print("mean(x)가 크다."), print("mean(y)가 크다."))
# 왜 두번이나출력이되지?                                  

score = 70
if(score >=90){print("A")
  }else if(score >= 80) {
  print("B")
  }else if (score >= 70) { 
  print("c")
  }else {
    print("F")
  }
  
#주의, elseif쓸때 띄어쓰기, } 쓸때 else if 옆에다 꼭 붙이기.. 안쓰면안먹힘.

x <- "KHU"
switch(x, KHU = 100, SKKU = 200,SNU = 300)

for(i in 1:9) {
  result = i * 3
  print(result)
}

x <- c(1,3,5,7,9)
for (i in x) {
  print(i)
}
#for는 반복의 횟수가 정해져있을때
x <- 1
while (1) {
  x <- 2 * x
  print(x)
  if (x > 10000) break
}

x <- 1
while (x < 10) {
  print(x * 3)
  x <- x+1
}
#while은 어느 일정 조건까지 반복해야할때
i = 1
repeat {
  result = 2 * i
  print(result)
  if (i >=9) break
  i = i+1
}


                                 