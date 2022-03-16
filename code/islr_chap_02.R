# Chapter 2 Statistical Learning

## 2.3.1 Basic Commands

x <- c(1, 3, 2, 5)
x

x = c(1, 6, 2)
x

y = c(1, 4, 3)

lx = length(x)
ly = length(y)
lx == ly

# look at a list of all of the objects
ls()

# delete anyone
rm(x, y)

ls()

rm(list = ls())

# matrix
?matrix

x <- matrix(data = c(1,2,3,4), nrow=2, ncol=2)
x

x <- matrix(c(1,2,3,4), 2, 2)
x

# byrow
matrix(c(1,2,3,4), 2, 2, byrow=TRUE)

sqrt(x)

x^2

# generates a vector of random normal variables
x <- rnorm(50) # n size
y <- x + rnorm(50, mean=50, sd = .1)

cor(x, y) # correlation

# want reproduce
set.seed(1303)
rnorm(50)

# some func
set.seed(3)
y <- rnorm(100)
mean(y)
var(y)
sqrt(var(y))
sd(y)


## 2.3.2 Graphics

x <- rnorm(100)
y <- rnorm(100)

plot(x, y)  # scatter plot
plot(x, y, xlab="this is the x-axis",
     ylab="this is the y-axis",
     main = "Plot of X vs Y")

# create this file
pdf("Figure.pdf")
plot(x, y, col="green")
dev.off()

# make sequence
x <- seq(1, 10)
x
x <- 1:10
x
x <- seq(-pi, pi, length=50)

# topographical map
y <- x
f <- outer(x, y, function(x, y) cos(y) / (1+x^2))
contour(x, y, f)
contour(x, y, f, nlevels=45, add=T)

fa <- (f - t(f)) / 2
contour(x, y, fa, nlevels=15)

image(x, y, fa)
persp(x, y, fa)
persp(x, y, fa, theta=30)
persp(x, y, fa, theta=30, phi=20)
persp(x, y, fa, theta=30, phi=70)
persp(x, y, fa, theta=30, phi=40)


## 2.3.3 Indexing Data

A <- matrix(1:16, 4 ,4)
A

A[2, 3]

# multi indexing
A[c(1,3), c(2,4)]

A[1:3, 2:4]

A[1:2, ]

A[, 1:2]

A[1, ]

A[-c(1,3),] # except sign
A[-c(1,3), -c(1,3,4)]

# # of row and column
dim(A)


## 2.3.4 Loading Data
library(ISLR2)

Auto <- read.table("Auto.data")

View(Auto)
head(Auto)

Auto <- read.table("Auto.data", header=T, na.strings="?",
                   stringsAsFactors=T)
View(Auto)

Auto <- read.csv("Auto.csv", na.strings="?",
                 stringsAsFactors=T)
View(Auto)

dim(Auto)

Auto[1:4,]

# deal missing data
Auto <- na.omit(Auto)
dim(Auto)

names(Auto)


## 2.3.5 Additional Graphical and Numerical Summaries

# join with $
plot(Auto$cylinders, Auto$mpg)
attach(Auto) # make the variables
plot(cylinders, mpg)

# quantitative to qualitative
cylinders <- as.factor(cylinders)

# For  qualitative x-axis, plot make boxplot
plot(cylinders, mpg)
plot(cylinders, mpg, col="red")
plot(cylinders, mpg, col="red", varwidth=T)
plot(cylinders, mpg, col="red", varwidth=T,
     horizontal=T)
plot(cylinders, mpg, col="red", varwidth=T,
     xlab="cylinders", ylab="MPG")

# histogram
hist(mpg)
hist(mpg, col=2)
hist(mpg, col=2, breaks=15)

# scatterplot for every pair of variables
pairs(Auto)
pairs(
  ~ mpg + displacement + horsepower + weight + acceleration,
  data = Auto
)

plot(horsepower, mpg)
identify(horsepower, mpg, name)

summary(Auto)

savehistory()
