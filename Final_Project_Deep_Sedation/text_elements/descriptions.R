### Text Descriptions for 
descriptions<-list(
  ## describe descriptions
  
  
  histogram = "A histogram shows how often any given value occurs in a variable, which is also known as the 
              distribution of a variable. Only numeric variables can be plotted on a histogram.
              The value is on the x-axis and the frequency is on the y-axis.",
  
  boxplot = "A box and whisker plot (boxplot) presents information from a five-number summary. 
            The top of the rectangle indicates the third quartile, the horizontal line near the middle of the rectangle indicates the median, and the bottom of the rectangle indicates the first quartile. 
            A vertical line extends from the top of the rectangle to indicate the maximum value, and another vertical line extends from the bottom of the rectangle to indicate the minimum value.
            A boxplot is especially useful for indicating whether a distribution is skewed and
            whether there are potential unusual observations (outliers) in the data set. An outlier is a value so far removed from other values in the distribution that its presence 
            cannot be attributed to the random combination of chance causes.",
  
  binning = "Binning, also known as discretization, is the process of transforming a continuous characteristic into a finite number of intervals (the bins),
             which allows for a better understanding of its distribution and its relationship with a binary/categorical variable (which in this case is the grouping variable above). ",
  
  scatter = "Scatter plots show how much one variable is affected by another variable. This relationship is called
            the correlation. The closer the points come to make a straight line the stronger the relationship between the two
            variables. If the line is going up, there is a positive correlation--that is, increasing one variable increases the other.
            If the line is going down, there is a negative correlation--that is, decreasing one variable decreases the other. The steepness of the line
            shows the sensitivity of the relationship. A very steep line indicates that a small change in the x variable causes a large
            change in the y variable.",
  
  #discover descriptions
  kmeans = "K-means systematically groups data together based on the minimizing average distance between the provided data points and the calculated centeroids.
    <ul>
    <li><strong>The 'K'</strong> is number of groups that the user wants the data clustered into. For each 'K' the algorithm will calculate a center.</li>
  <li><strong>Centriods</strong> are middle point of a group that the data is clustered around. The number of centers are determined by the k value. </li>
  <li><strong>Labels </strong> are the name of the group that each data point is put into by the K-means algorithm. </li>
  ",
  
  correlations = "Correlations show the relationship between two variables.
  <ul>
  <li> <strong>A correlation of -1 </strong> indicates a perfectly negative relationship </li>
  <li><strong>A correlation of 1 </strong> indicates a perfectly positive relationship </li>
  <li><strong>A correlation of greater than 0.5 or less than -0.5 </strong>indicates a strong positive or negative relationship respectively </li>
  <li><strong>A correlation of less than 0.3 or greater than -0.3 </strong>indicates a weak positive or negative relationship respectively </li>
  </ul>
  When two variables are strongly or perfectly correlated with each other, they are considered <strong>
  colinear </strong> and cannot be considered independent of eachother. Colinear variables should not be
  used in models that assume independent variables-such as linear regression. You will have to pick one to use!
  ",
  
  #predict descriptions
  regression = "A regression analysis examines the relationship between two or more variables and predicts the value of a response variable based on a set of predictor variables.<br>
  <ul>
    <li><strong>The Intercept</strong> is the expected value of the y-value (which is the response variable) if all the predictor variables are zero. </li>
    <li><strong>Coefficients</strong> are the average change in the response variable for a one unit increase in the predicting variable. </li>
    <li><strong>Standard Errors </strong> represents the average distance of the observed values (the dots) from the regression line. The lower the standard error the better.
    <li><strong>p-values</strong> measure how likely the effect of the predictor on the response variable is due to randomness. The p-value 
                                  is probability that the observed change occurs due to randomness in the data. The lower the p-value the better. </li>
  
  ",
  logistic_regression = " A multinomial logistic regression uses logistic functions to model the relationships between a set of independent predictor variables and each class of a categorical dependent variable. <br>
  <ul>
    <li><strong>The Intercept</strong> is the probability estimate for the specified class relative to the reference class when the predictor variables in the model are zero. </li>
    <li><strong>Coefficients</strong> are the probability estimate change for a one unit increase in the predictor variable for the class of interest relative to the reference class, given the other variables in the model are held constant. </li>
    <li><strong>p-values</strong> measure how likely the effect of the predictor on the class of interest relative to the reference class is due to randomness. The p-value 
                                  is probability that the observed change occurs due to randomness in the data. The lower the p-value the better. </li>
    "
)
