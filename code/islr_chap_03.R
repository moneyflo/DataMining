# Chapter 03 Linear Regression

## 3.6 Lab: Linear Regression

### 3.6.1 Libraries

# install.packages(c("MASS", "ILSR", "car"))
library(MASS)
library(ISLR)
library(car)

###3.6.2 Simple Linear Regression

head(Boston)
tail(Boston)

summary() str()
str(Boston)
lm()
?lm()
lm(y~x, data = )  # y:반응변수, x:설명변수
lm.fit <- lm(medv~lstat, data = Boston)

# 변수명 다 가져오려면 ($ 없이 쓰려면)
# 데이터 여러개 쓸때는 변수 중복때문에 조심해야됨
attach()
detach()
attach()

lm.fit
summary(lm.fit)

# 변수이름 확인 2가지 방법
# names() Boston$
names(Boston)
lm.fit$coefficients
coef(lm.fit) # 이방식이 더 선호됨
confint(lm.fit)

# predict( ) : confidence interval, prediction interval

predict(lm.fit, data.frame(lstat=c(5, 10, 15)), interval="confidence")
predict(lm.fit, data.frame(lstat=c(5, 10, 15)), interval="prediction")

# plot()
plot(Boston$lstat, Boston$medv)
abline(lm.fit)

par()
par(mfrow=c(2,2))
plot(lm.fit)

residuals(lm.fit)

### 3.6.3 multiple linear regression

lm() : 종속변수 ~ 독립변수+독립변수
~ .  # 모든 변수 쓰고 싶을때

lm.fit <- lm(medv~lstat+age, data = Boston)
summary(lm.fit)

lm.fit <- lm(medv~., data = Boston)
summary(lm.fit)

# 특정변수 제거 or 추가
lm.fit1 <- update(lm.fit, ~. -age)
summary(lm.fit1)

# 다중 공산성
# vif() : 'car'에 내장
vif(lm.fit)

### 3.6.4 interaction term
# 'X1+X2+X1:X2' 'X1*X2'로 간단하게 표현가능
summary(lm(medv~lstat:black, data=Boston))
summary(lm(medv~lstat*age, data=Boston))

lm() : 

변수에 대해서 수식을 사용하여 변환 : sqrt() X^2 I(X^2)
X^n = ploy(X, n) log()

lm.fit2 <- lm(medv~lstat+I(lstat^2), data=Boston)
I(X^n)
ploy()

# model comparsion
anova
lm.fit <- lm(medv~lstat, data=Boston)
anova(lm.fit, lm.fit2)

### 3.6.6

# 'Carseats' 400개 지역 세일즈 예측
head(Carseats)
tail(Carseats)
str(Carseats)

as.factor() contrasts()
lm.fit <- lm(Sales~.+Income:Advertising+Price:Age, data=Carseats)
summary(lm.fit)

# dummy variable 생성 : contrats()

attach(Carseats)
contrasts(ShelveLoc)
