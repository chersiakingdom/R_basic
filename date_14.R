
Prop <- runif(3500000, min = 15500, max = 17000) #랜덤 소수값 뽑기.. 350000개
Prop
Prop <- as.integer(Prop)
Prop #t소수였던 애들을 정수로 받기.

Samples <- integer(10^6) #정수가 들어갈 10의 6승 만큼의 빈 집을만듬. 
for( i in 1:10^6){ 
  s <- Prop[sample(Prop, 20,replace= T)]
  # Prop 에서 20개 샘플 복원추출
  mean_s <- mean(s)
  Samples[i] <- mean_s
}

Samples
table(Samples)
FreqHeights <- table(Samples)
hist(Samples,breaks=1000,prob=T) # 히스토그램 ~ 정규분포의 형태를 띄고있음.
# break 1000은 뭔뜻이더라..?

x <- seq(from = 15800, to=16200, length.out = 1000)
head(x, 30)
ylim <- c(0,0.01)
plot(x, dnorm(x,mean=16000, sd=52.7), main = "Normal", type='l',ylim=ylim)
# 이거 패키지 안쓰고 한거당..

# 직접 해보기 : 정규분포 사용하기
x_mean <- 190
y_mean <- 150
x_var <- 500
y_var <- 400
xy_mean <- x_mean + y_mean
xy_var <- 1^2*x_var + 1**2*y_var
xy_sig <- sqrt(xy_var)
h <- 380
pnorm(h, mean =xy_mean, sd = xy_sig)
# 0.9087888 이 나옴.