# MechaCar_Statistical_Analysis

R analysis of MechaCar data

## Linear Regression of Prototype MPG

The variable that are shown to play a non-random role in linear regression are:
    the intercept
    vehicle_length
    ground_clearance

The p-value for our linear regression model is far below the standard significance level of 0.05
For this reason, we can reject the null hypothesis to determine that the slope of our linear regression is not 0

The linear model might be overfit, seeing as how the intercept plays a significant role in the slope of the regression.
It might be best not to predict future prototypes based on this linear model.

## Summary of Suspension Data

<table>
  <tr>
    <th></th>
    <th>Mean</th>
    <th>Median</th>
    <th>Median</th>
    <th>Variance</th>
    <th>SD</th>
  </tr>
  <tr>
    <td>1</td>
    <td>1498.78</td>
    <td>1500</td>
    <td>62.29356</td>
    <td>7.892627</td>
  </tr>
</table>

We can see from the total summary of suspension data that the mean PSI for all groups is 1498.78 and the median is 1500 mmeaning that the data is normally distributed. However, the data do show a variance of 62. This does not surpass the threshhold set at 100, but does suggest some cause for concern.

<table>
  <tr>
    <th></th>
    <th>Manufacturing_Lot</th>
    <th>Mean</th>
    <th>Median</th>
    <th>Median</th>
    <th>Variance</th>
    <th>SD</th>
  </tr>
  <tr>
    <td>1</td>
    <td>Lot1</td>
    <td>1500.00</td>
    <td>1500.0</td>
    <td>0.9795918</td>
    <td>0.9897433</td>
  </tr>
  <tr>
    <td>2</td>
    <td>Lot2</td>
    <td>1500.20</td>
    <td>1500.0</td>
    <td>7.4693878</td>
    <td>2.7330181</td>
  </tr>
  <tr>
    <td>3</td>
    <td>Lot3</td>
    <td>1496.14</td>
    <td>1498.5</td>
    <td><b>170.2861224</b></td>
    <td>13.0493725</td>
  </tr>
</table>

Here the problem is clear. Lot3 shows a clear issue with the consistency of their coils, having a variance much higher than the threshhold at 170.29. This summary also exculpates the other two lots with negligible variance.

## Suspension Data Testing

**Lot1**
![Lot1 ttest](/ttest1.png)
**Lot2**
![Lot2 ttest](/ttest2.png)
**Lot3**
![Lot3 ttest](/ttest3.png)

Lot1 and Lot2 suspension data get p < .05 and thus accept the null hypothesis, they do not significantly deviate from the population mean.

The t-test for Lot3, however, calculates a p-value of 0.1589, thus the null-hypothesis is rejected, and we can say that the mean values of Lot3 and the population are statistically significant.

## Study Design: MechaCar vs Competition

A consumer might be very interested in the overall cost of owning a MechaCar compared to a competitor's car

To analyze this we would want to create a dataset including all of the following:
    - average mpg (highway and city)
    - maintenence costs
    - price of the vehicle can be included as well

We would want to limit this analysis, at least initially, to a specific city metropolitan area. Though, this will limit the predictive scope of our study, it will mean that our data truly is representative of the population of a city. With more testing this might even be extrapolated to other cities.

The first task would to be to determine a sample size based on the estimated population driving both the MechaCar and the analagous competitors' cars. Using power analysis, we can predetermine how many entries our data needs to be relevant to the population. Next, we would need to collect that sample data into something like a .csv file.

~~~
prices_df <- read.csv("prices.csv")
~~~

From there, we need to group the data by manufacturer, MechaCar, Nissan, Honda, etc... and determine wether both statistics (maintenance cost and average mpg) are normally distributed for each manufacturer. If not, we might need to throw out some outliers or combine the other manufacturers into one group.

for each manufacturer being tested
~~~
stats <- c("maintenance_price", "avg_mpg")
for (col_name in stats) {
    shapiro.test(prices_df[col_name])
}
~~~

If they are all normally distributed, we can then move on to using a t-test to find out if the differnece in the means of the MechaCar prices and the population prices are genuinely impactful.

~~~
mecha <- subset(prices_df, manufacturer=="MechaCar")
for (col_name in stats) {
    t.test(mecha[col_name], mu=mean(prices_df[col_name]))
}
~~~