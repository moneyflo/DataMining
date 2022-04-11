# Resampling methods

#cross-validation

library(ISLR)
library(boot)

# the validation set approach

set.seed(970711)
train <- sample(392, 196) # 392개 중 196개 고름

attach(Auto)
lm.fit1 <- lm(mpg~horsepower, data=Auto, subset=train)
summary(lm.fit1)
aa <- mean((mpg-predict(lm.fit1, Auto))[-train]^2)

lm.fit2 <- lm(mpg~poly(horsepower,2), data=Auto, subset=train)
a1 <- mean((mpg-predict(lm.fit2, Auto))[-train]^2)

lm.fit3 <- lm(mpg~poly(horsepower,3), data=Auto, subset=train)
a2 <- mean((mpg-predict(lm.fit3, Auto))[-train]^2)

aa
a1
a2

set.seed(2)
train <- sample(392, 196)
lm.fit1_2 <- lm(mpg~horsepower, data=Auto, subset=train)
a3 <- mean((mpg-predict(lm.fit1_2, Auto))[-train]^2)
a3


# LOOVC
# glm(), cv.glm()

glm.fit <- glm(mpg~horsepower, data=Auto, family=gaussian(link='identity'))
coef(glm.fit)
lm.fit <- lm(mpg~horsepower, data=Auto)
coef(lm.fit)

glm.fit <- glm(mpg~horsepower, data=Auto)
cv.err <- cv.glm(Auto, glm.fit)
cv.err$delta  # 교차검증의 결과



cv.error <- rep(0,5)
for (i in 1:5){
  glm.fit=glm(mpg~poly(horsepower, i), data=Auto)
  cv.error[i]=cv.glm(Auto, glm.fit)$delta[1]
}
cv.error

plot(cv.error, type='b', xlab='Degree of Polynomial', ylab='Mean Squared Error', ylim=c(16,28), main='LOOCV', col='blue',
     lwd='1.5', pch=19)


# k-fold c-v

set.seed(970711)
cv.error.10 <- rep(0, 10)
for(i in 1:10){
  glm.fit=glm(mpg~poly(horsepower, i), data=Auto)
  cv.error.10[i]=cv.glm(Auto, glm.fit, K=10)$delta[1]
}
cv.error.10

plot(cv.error.10, type='b', xlab='Degree of Polynomial', ylab='Mean Squared Error', ylim=c(16,28), main='K-FOLD', col='blue',
     lwd='1.5', pch=19)


# Bootstrap
# estimating the accuracy of a statistic of interest
# boot()

alpha.fn <- function(data, index){
  X=data$X[index]
  Y=data$Y[index]
  return((var(Y)-cov(X,Y))/(var(X)+var(Y)-2*cov(X,Y)))
}

alpha.fn(Portfolio, 1:100)

set.seed(1)
alpha.fn(Portfolio, sample(100,100,replace=T))

# boot(data, 함수, bootstrap의 수)
boot(Portfolio, alpha.fn, R=1000)

# 선형회귀모델의 정확도 추정

boot.fn <- function(data, index){
  return(coef(lm(mpg~horsepower, data=data, subset=index)))
}
boot.fn(Auto, 1:392)

set.seed(1)
boot.fn(Auto, sample(392,392, replace=T)) # sample이 난수 발생시킴
boot.fn(Auto, sample(392,392, replace=T))

boot(Auto, boot.fn, 1000)

summary(lm(mpg~horsepower, data=Auto))$coef


boot.fn <- function(data, index) coefficients((lm(mpg~horsepower+I(horsepower^2), data=data, subset=index)))
set.seed(1)
boot(Auto, boot.fn, 1000)
summary(lm(mpg~horsepower+I(horsepower^2), data=Auto))$coef

