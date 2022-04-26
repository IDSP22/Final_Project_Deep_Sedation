library(dplyr)

#I can try to do this code more efficient later, I usually work in little steps at the time. 

# Patient characteristics by ethnicity or race (Hispanic)

n <- 471
t_h <- 48

set.seed(0)

#Simulating data

#Vector binomial distribution

male_v <- rbinom(n=t_h, size=1, prob= 0.521)
f_smoker_v <- rbinom(n=t_h, size=1, prob= 0.167)
c_smoker_v <- rbinom(n=t_h, size=1, prob= 0.188)
leukemia_v <- rbinom(n=t_h, size=1, prob= 0.063)
metatastic_cancer_v <- rbinom(n=t_h, size=1, prob= 0.021)
immune_suppression_v <- rbinom(n=t_h, size=1, prob= 0.208)
cirrhosis_v <- rbinom(n=t_h, size=1, prob= 0.167)
diabetes_v <- rbinom(n=t_h, size=1, prob= 0.354)
hypertension_v <- rbinom(n=t_h, size=1, prob= 0.458)
myocardal_infarction_v <- rbinom(n=t_h, size=1, prob= 0.063)
heart_f_v <- rbinom(n=t_h, size=1, prob= 0.063)
stroke_v <- rbinom(n=t_h, size=1, prob= 0.083)
dementia_v <- rbinom(n=t_h, size=1, prob= 0.104)
chronic_ld_v <- rbinom(n=t_h, size=1, prob= 0.104)
dialysis_v <- rbinom(n=t_h, size=1, prob= 0.042)
neuromuscular_v <- rbinom(n=t_h, size=1, prob= 0.354)

hispanic <- data.frame(patients = c(rep(x=1, times=t_h), rep(x=0, times=(n-t_h))),
                       age = c(rnorm(n=t_h, mean = 54.4, sd=15.4), rep(x=0, times=(n-t_h))),
                       male = c(male_v, rep(x=0, times=(n-t_h))),
                       f_smoker = c(f_smoker_v, rep(x=0, times=(n-t_h))),
                       c_smoker = c(c_smoker_v, rep(x=0, times=(n-t_h))), 
                       leukemia = c(leukemia_v, rep(x=0, times=(n-t_h))), 
                       metatastic_cancer = c(metatastic_cancer_v, rep(x=0, times=(n-t_h))),
                       immune_suppression = c(immune_suppression_v, rep(x=0, times=(n-t_h))),
                       cirrhosis = c(cirrhosis_v, rep(x=0, times=(n-t_h))),
                       diabetes = c(diabetes_v, rep(x=0, times=(n-t_h))),
                       hypertension = c(hypertension_v, rep(x=0, times=(n-t_h))),
                       myocardal_infarction = c(myocardal_infarction_v, rep(x=0, times=(n-t_h))),
                       heart_f = c(heart_f_v, rep(x=0, times=(n-t_h))),
                       stroke = c(stroke_v, rep(x=0, times=(n-t_h))),
                       dementia = c(dementia_v, rep(x=0, times=(n-t_h))),
                       chronic_ld = c(chronic_ld_v, rep(x=0, times=(n-t_h))),
                       dialysis = c(dialysis_v, rep(x=0, times=(n-t_h))),
                       deep_sedation = c(rnorm(n=t_h, mean = 114.4, sd=35.9), rep(x=0, times=(n-t_h))),
                       bmi = c(rnorm(n=t_h, mean = 29.5, sd=8.2), rep(x=0, times=(n-t_h))),
                       baseline_pf = c(rnorm(n=t_h, mean = 114.4, sd=35.9), rep(x=0, times=(n-t_h))),
                       neuromuscular = c(neuromuscular_v, rep(x=0, times=(n-t_h)))
                       )


sum(hispanic$patients)
sum(hispanic$patients)/length(hispanic$patients)

mean(hispanic$age[1:t_h])
sd(hispanic$age[1:t_h])

sum(hispanic$male)
sum(hispanic$male)/t_h

sum(hispanic$f_smoker)
sum(hispanic$f_smoker)/t_h

sum(hispanic$c_smoker)
sum(hispanic$c_smoker)/t_h

sum(hispanic$leukemia)
sum(hispanic$leukemia)/t_h

sum(hispanic$metatastic_cancer)
sum(hispanic$metatastic_cancer)/t_h

sum(hispanic$immune_suppression)
sum(hispanic$immune_suppression)/t_h

sum(hispanic$cirrhosis)
sum(hispanic$cirrhosis)/t_h

sum(hispanic$diabetes)
sum(hispanic$diabetes)/t_h

sum(hispanic$hypertension)
sum(hispanic$hypertension)/t_h

sum(hispanic$myocardal_infarction)
sum(hispanic$myocardal_infarction)/t_h

sum(hispanic$heart_f)
sum(hispanic$heart_f)/t_h

sum(hispanic$stroke)
sum(hispanic$stroke)/t_h

sum(hispanic$dementia)
sum(hispanic$dementia)/t_h

sum(hispanic$chronic_ld)
sum(hispanic$chronic_ld)/t_h

sum(hispanic$dialysis)
sum(hispanic$dialysis)/t_h

mean(hispanic$bmi[1:t_h])
sd(hispanic$bmi[1:t_h])

mean(hispanic$baseline_pf[1:t_h])
sd(hispanic$baseline_pf[1:t_h])

sum(hispanic$neuromuscular)
sum(hispanic$neuromuscular)/t_h


# Patient characteristics by ethnicity or race (Black)

t_b <- 70

set.seed(21)

#Simulating data

#Vector binomial distribution

male_v_b <- rbinom(n=t_b, size=1, prob= 0.557)
f_smoker_v_b <- rbinom(n=t_b, size=1, prob= 0.157)
c_smoker_v_b <- rbinom(n=t_b, size=1, prob= 0.30)
leukemia_v_b <- rbinom(n=t_b, size=1, prob= 0.043)
metatastic_cancer_v_b <- rbinom(n=t_b, size=1, prob= 0.043)
immune_suppression_v_b <- rbinom(n=t_b, size=1, prob= 0.143)
cirrhosis_v_b <- rbinom(n=t_b, size=1, prob= 0.071)
diabetes_v_b <- rbinom(n=t_b, size=1, prob= 0.329)
hypertension_v_b <- rbinom(n=t_b, size=1, prob= 0.529)
myocardal_infarction_v_b <- rbinom(n=t_b, size=1, prob= 0.057)
heart_f_v_b <- rbinom(n=t_b, size=1, prob= 0.143)
stroke_v_b <- rbinom(n=t_b, size=1, prob= 0.057)
dementia_v_b <- rbinom(n=t_b, size=1, prob= 0.029)
chronic_ld_v_b <- rbinom(n=t_b, size=1, prob= 0.129)
dialysis_v_b <- rbinom(n=t_b, size=1, prob= 0.086)
neuromuscular_v_b <- rbinom(n=t_b, size=1, prob= 0.214)

black <- data.frame(patients = c(rep(x=1, times=t_b), rep(x=0, times=(n-t_b))),
                       age = c(rnorm(n=t_b, mean = 53.2, sd=14.9), rep(x=0, times=(n-t_b))),
                       male = c(male_v_b, rep(x=0, times=(n-t_b))),
                       f_smoker = c(f_smoker_v_b, rep(x=0, times=(n-t_b))),
                       c_smoker = c(c_smoker_v_b, rep(x=0, times=(n-t_b))), 
                       leukemia = c(leukemia_v_b, rep(x=0, times=(n-t_b))), 
                       metatastic_cancer = c(metatastic_cancer_v_b, rep(x=0, times=(n-t_b))),
                       immune_suppression = c(immune_suppression_v_b, rep(x=0, times=(n-t_b))),
                       cirrhosis = c(cirrhosis_v_b, rep(x=0, times=(n-t_b))),
                       diabetes = c(diabetes_v_b, rep(x=0, times=(n-t_b))),
                       hypertension = c(hypertension_v_b, rep(x=0, times=(n-t_b))),
                       myocardal_infarction = c(myocardal_infarction_v_b, rep(x=0, times=(n-t_b))),
                       heart_f = c(heart_f_v_b, rep(x=0, times=(n-t_b))),
                       stroke = c(stroke_v_b, rep(x=0, times=(n-t_b))),
                       dementia = c(dementia_v_b, rep(x=0, times=(n-t_b))),
                       chronic_ld = c(chronic_ld_v_b, rep(x=0, times=(n-t_b))),
                       dialysis = c(dialysis_v_b, rep(x=0, times=(n-t_b))),
                       deep_sedation = c(rnorm(n=t_b, mean = 114.4, sd=35.9), rep(x=0, times=(n-t_b))),
                       bmi = c(rnorm(n=t_b, mean = 29.5, sd=8.2), rep(x=0, times=(n-t_b))),
                       baseline_pf = c(rnorm(n=t_b, mean = 114.4, sd=35.9), rep(x=0, times=(n-t_b))),
                       neuromuscular = c(neuromuscular_v_b, rep(x=0, times=(n-t_b)))
)

#Characteristics 

sum(black$patients)
sum(black$patients)/length(black$patients)

mean(black$age[1:t_b])
sd(black$age[1:t_b])

sum(black$male)
sum(black$male)/t_b

sum(black$f_smoker)
sum(black$f_smoker)/length(black$f_smoker[1:t_b])

sum(black$c_smoker)
sum(black$c_smoker)/length(black$c_smoker[1:t_b])

sum(black$leukemia)
(sum(black$leukemia)/length(black$leukemia[1:t_b]))


sum(black$metatastic_cancer)
sum(black$leukemia)/length(black$leukemia[1:t_b])

sum(black$immune_suppression)
sum(black$immune_suppression)/length(black$immune_suppression[1:t_b])

sum(black$cirrhosis)
sum(black$cirrhosis)/t_b

sum(black$diabetes)
sum(black$diabetes)/t_b

sum(black$hypertension)
sum(black$hypertension)/t_b

sum(black$myocardal_infarction)
sum(black$myocardal_infarction)/t_b

sum(black$heart_f)
sum(black$heart_f)/t_b

sum(black$stroke)
sum(black$stroke)/t_b

sum(black$dementia)
sum(black$dementia)/t_b

sum(black$chronic_ld)
sum(black$chronic_ld)/t_b

sum(black$dialysis)
sum(black$dialysis)/t_b

mean(black$bmi[1:t_b])
sd(black$bmi[1:t_b])

mean(black$baseline_pf[1:t_b])
sd(black$baseline_pf[1:t_b])

sum(black$neuromuscular)
sum(black$neuromuscular)/t_b



# Patient characteristics by ethnicity or race (Black)

t_b <- 70

set.seed(21)

#Simulating black data

#Vector binomial distribution

male_v_b <- rbinom(n=t_b, size=1, prob= 0.557)
f_smoker_v_b <- rbinom(n=t_b, size=1, prob= 0.157)
c_smoker_v_b <- rbinom(n=t_b, size=1, prob= 0.30)
leukemia_v_b <- rbinom(n=t_b, size=1, prob= 0.043)
metatastic_cancer_v_b <- rbinom(n=t_b, size=1, prob= 0.05)
immune_suppression_v_b <- rbinom(n=t_b, size=1, prob= 0.175)
cirrhosis_v_b <- rbinom(n=t_b, size=1, prob= 0.079)
diabetes_v_b <- rbinom(n=t_b, size=1, prob= 0.268)
hypertension_v_b <- rbinom(n=t_b, size=1, prob= 0.47)
myocardal_infarction_v_b <- rbinom(n=t_b, size=1, prob= 0.06)
heart_f_v_b <- rbinom(n=t_b, size=1, prob= 0.053)
stroke_v_b <- rbinom(n=t_b, size=1, prob= 0.03)
dementia_v_b <- rbinom(n=t_b, size=1, prob= 0.02)
chronic_ld_v_b <- rbinom(n=t_b, size=1, prob= 0.202)
dialysis_v_b <- rbinom(n=t_b, size=1, prob= 0.02)
neuromuscular_v_b <- rbinom(n=t_b, size=1, prob= 0.248)

black <- data.frame(patients = c(rep(x=1, times=t_b), rep(x=0, times=(n-t_b))),
                    age = c(rnorm(n=t_b, mean = 54.4, sd=15.4), rep(x=0, times=(n-t_b))),
                    male = c(male_v_b, rep(x=0, times=(n-t_b))),
                    f_smoker = c(f_smoker_v_b, rep(x=0, times=(n-t_b))),
                    c_smoker = c(c_smoker_v_b, rep(x=0, times=(n-t_b))), 
                    leukemia = c(leukemia_v_b, rep(x=0, times=(n-t_b))), 
                    metatastic_cancer = c(metatastic_cancer_v_b, rep(x=0, times=(n-t_b))),
                    immune_suppression = c(immune_suppression_v_b, rep(x=0, times=(n-t_b))),
                    cirrhosis = c(cirrhosis_v_b, rep(x=0, times=(n-t_b))),
                    diabetes = c(diabetes_v_b, rep(x=0, times=(n-t_b))),
                    hypertension = c(hypertension_v_b, rep(x=0, times=(n-t_b))),
                    myocardal_infarction = c(myocardal_infarction_v_b, rep(x=0, times=(n-t_b))),
                    heart_f = c(heart_f_v_b, rep(x=0, times=(n-t_b))),
                    stroke = c(stroke_v_b, rep(x=0, times=(n-t_b))),
                    dementia = c(dementia_v_b, rep(x=0, times=(n-t_b))),
                    chronic_ld = c(chronic_ld_v_b, rep(x=0, times=(n-t_b))),
                    dialysis = c(dialysis_v_b, rep(x=0, times=(n-t_b))),
                    deep_sedation = c(rnorm(n=t_b, mean = 114.4, sd=35.9), rep(x=0, times=(n-t_b))),
                    bmi = c(rnorm(n=t_b, mean = 29.5, sd=8.2), rep(x=0, times=(n-t_b))),
                    baseline_pf = c(rnorm(n=t_b, mean = 114.4, sd=35.9), rep(x=0, times=(n-t_b))),
                    neuromuscular = c(neuromuscular_v_b, rep(x=0, times=(n-t_b)))
)



