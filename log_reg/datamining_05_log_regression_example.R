# See also https://www.kaggle.com/lowecoryr/universalbank
bank.df = read.csv("http://www-home.htwg-konstanz.de/~oduerr/data/UniversalBank.csv")

head(bank.df[1:5,])
# Drop ID and ZIP code
bank.df$ID = NULL
bank.df$ZIP.Code = NULL

# Make proper cat. variables from Education
bank.df$Education = factor(bank.df$Education, levels = c(1,2,3), labels = c('undergrad', 'grad', 'advanced prof'))

# Make predition variable a categorical
bank.df$Personal.Loan = as.factor(bank.df$Personal.Loan)

# Split into training and testset
set.seed(2)
train.idx = sample(1:nrow(bank.df), 0.6*nrow(bank.df)) #60% for training
train.df = bank.df[train.idx,]
valid.df = bank.df[-train.idx,]

# Fitting the model to the training data
model = glm(Personal.Loan ~ ., data=train.df, family = 'binomial') #family binomial is for log-reg
summary(model)

# Predicting on the validation data
preds = predict(model, valid.df, type = "response") #Response for predicting probability

# Some examples
preds[1:5]
valid.df$Personal.Loan[1:5]

# Accuracy
pred_class = ifelse(preds > 0.5, 1, 0) #to class 1 if > 0.5
pred_class[0:5]
mean(pred_class == valid.df$Personal.Loan)



