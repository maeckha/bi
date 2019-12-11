library(rpart)
library(rpart.plot)
ebay.df = read.csv("http://www-home.htwg-konstanz.de/~oduerr/data/eBayAuctions.csv")
ebay.df$Competitive. = as.factor(ebay.df$Competitive.) 
ebay.df$Duration = as.factor(ebay.df$Duration)

#Aufspalten
set.seed(1) #
N = nrow(ebay.df)
train.idx = sample(1:N, size = 0.6 * N)
valid.idx = setdiff(1:N, train.idx)

tr = rpart(Competitive. ~ ., data=ebay.df[train.idx,])
tr
prp(tr)

pred = predict(tr, newdata = ebay.df[valid.idx,], type="class")
length(pred)
mean(ebay.df[valid.idx,]$Competitive. == pred)

