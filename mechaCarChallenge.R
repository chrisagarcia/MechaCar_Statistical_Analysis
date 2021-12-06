
# challenge script
library(dplyr)

# deliverables
# 1. linear regression to predict mpg
# 2. summary statistics on suspension coils
# 3. T-test on suspension coils
# 4. design a study comparing the mecha car to the competition

# linear regression of prototype variables
car_mpg <- read.csv(file="MechaCar_mpg.csv", check.names=F, stringsAsFactors=F)
car_regression <- lm(formula=mpg ~ vehicle_length +
                       vehicle_weight +
                       spoiler_angle +
                       ground_clearance +
                       AWD, data=car_mpg)
summary(car_regression)


# summary of suspension data
suspension_data <- read.csv(file="Suspension_Coil.csv", check.names=F, stringsAsFactors=F)
total_summary <- summarize(.data=suspension_data,
                           Mean=mean(PSI),
                           Median=median(PSI),
                           Variance=var(PSI),
                           SD=sd(PSI))
lot_summary <- suspension_data %>% group_by(Manufacturing_Lot) %>%
  summarize(Mean=mean(PSI),
            Median=median(PSI),
            Variance=var(PSI),
            SD=sd(PSI), .groups="keep")

# t-testing manufacturing lots
pop_mean <- mean(suspension_data$PSI)


subset(suspension_data, Manufacturing_Lot=="Lot1")$PSI %>%
  t.test(mu=pop_mean)

subset(suspension_data, Manufacturing_Lot=="Lot2")$PSI %>%
  t.test(mu=pop_mean)

subset(suspension_data, Manufacturing_Lot=="Lot3")$PSI %>%
  t.test(mu=pop_mean)
