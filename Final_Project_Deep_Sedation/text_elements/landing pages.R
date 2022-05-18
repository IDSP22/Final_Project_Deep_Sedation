
# Why is this a list? -----------------------------------------------------


#basically every element in this list is a full webpage. this is organized this way because it is all static
#and we dont want this to take up much space in either the ui or the server


# Why is this so ugly? ----------------------------------------------------

#I used a text to html converter because I didnt want to spend a bunch of time working in hmtl
#as a result the html is hard to work with but the fundamentals are all there
#I tried to organize this as best I could



landing <-list(
  
  intro = list(
    body = "
    
    <div id = 'introbg'>
      
      <p class = 'emphasis', id = 'introheader', style='line-height: normal; font-size: 18.0pt;'>
        Welcome to the CriticalCare dashboard. The open-source solution to your analytics problems.
      </p>

      <p id = 'introtext'>
        To get started, upload a CSV or excel into the Critical Care dashboard in the <strong> Collect </strong> tab. The critical care  works best with clean data with descriptive column names. 
      Nimble can tell you about what's in your data in the <strong> Describe </strong> tab, about hidden relationships 
    in your data with the <strong> Discover </strong> tab, and about future predictions in the <strong> Predict </strong> tab.
      </p>
      
    <div class = 'grid-container'> 

      <div class='grid-item'></div>

      <div class='grid-item'>

        <i class='introicon fas fa-clipboard circle-icon2' style='font-size: 3.5em;'></i>

        <p class = 'captiontext'>
          Describe Your Data Sets
        </p>
  
      </div>

      <div class='grid-item'></div>

      <div class='grid-item'>
    
        <i class='introicon fa fa-chart-line circle-icon4' style='font-size: 3.5em;'></i>

        <p class = 'captiontext'>
        Forecast Possibilities
        </p>

      </div>

      <div class='grid-item'></div>

      <div class='grid-item'>

        <i class='validateicon fa fa-check circle-icon6' style='font-size: 3.5em;'></i>
        
            <p class = 'captiontext'>
            Validate Models
            </p>


      </div>

    </div>

    
    <div class = 'grid-container'> 

      <div class='grid-item'>
        
        <i class = 'introicon fas fa-folder-open circle-icon1' style='font-size: 3.5em;'></i>
  
        <p class = 'captiontext'>
        Upload Clean Data
        </p>

      </div>

      <div class='grid-item'></div>

      <div class='grid-item'>
  
        <i class='introicon fa fa-chart-area circle-icon3' style='font-size: 3.5em;'></i>

        <p class = 'captiontext'>
          Discover Relationships
        </p>

      </div>  

      <div class='grid-item'></div>

      <div class='grid-item'>
  
        <i class='introicon fa fa-globe circle-icon5' style='font-size: 3.5em;'></i>

        <p class = 'captiontext'>
          Map Data
        </p>

      </div>

    </div>

</div>

    "
  ),
  
  describe = list(
    body = "

      <p class = 'emphasis', id = 'describeheader', style='line-height: normal; font-size: 17.0pt;'>
    What is Describe?</p>

  <p>
  Describe is all about learning what is in your data. This should be the first stop in taking an analytic approach 
  to using data. Knowing how data is distributed or how two variables are related can provide important sanity checks
  before beginning complex analysis. The Describe tab can answer such questions as:

  </p>
      <ul type='disc'>

      <li>
      What outliers exist in the data?
      </li>
      <li>
      How do two variables relate to each other?
      </li>
      </ul>
  <p>
      The CriticalCare Dashboard supports histograms, boxplots, and scatterplots. 
  </p>

<div class='describe-containers'>

  <h1 class = 'emphasis' id = 'describeheader2'>
  Understanding Distributions
  </h1>
  
  <p>
  Boxplots and histograms can quickly inform what sort of distribution exists in a variable. 
  Distributions can help us understand the central tendency-or the typical value-of features in a dataset.
  Histograms are a simple visual that immediately conveys both what is typical and what is atypically large and small.
  What a boxplot loses in simplicity, it gains in information. Importantly, a boxplot immediately show outliers.
  </p>
</div>
    "
  ),


# Predict landing page ---------------------------------------------------


predict = list(
  body = "
    <p class = 'emphasis', id = 'predictheader', style='line-height: normal; font-size: 17.0pt;'>
    What is Predict?</p>
  
  <p>
  Prediction is about using past observations to predict future observations. The more data there is the better the prediction is likely to be-assuming that the future will be anything like the past! Predictive analytics can answer questions like: 
  </p>
  <ul type='disc'>
  <li>
  What will citizens' needs be like in the future?
  </li>
  <li>
  When will city, state, and federal infrastructure need to be replaced?  
  </li>
  <li>
  Where will violent crimes occur?
  </li>
  </ul>
  <p>
  CriticalCare Dashboard currently supports Regression and Random Forest Analysis.
  </p>

  <div class='predict-containers'>
    <div class='predict-container'>
      <h1 class = 'emphasis' id = 'predictheader2'>
      When to use Linear Regression
      </h1>
      <p>
      Linear regressions work wonders when there is a simple relationship between the predictor variables and the response variable. What regressions lack in predictive power, they make up for in interpretability and speed-that is, they are easy to understand and work well with large datasets. Linear regressions tend to overfit the provided data, meaning that they are often not generalizable to new data. Regressions should be the first stop when testing the relationship between two things.
      </p>
    </div>
    <div class='predict-container'>

  <h1 class = 'emphasis' id = 'predictheader3'>
  When to use Random Forests
  </h1>
  <p>
  Random forests shine when there are complex relationships between variables.  This model can be used for both regression and classification problems. Random forests have strong predictive power but are resource intensive, making them slow. Because random forests aggregate hundreds of decision trees, they can be hard to interpret and explain.  
  </p>
</div>
</div>
  
  ",
  sidebar = "
  <div class = 'landingpage_side'>
  <h3 class = 'emphasis', id = 'predictheader4'>Use Case Example</h3>
  <h4><i><b>Random Forest for Public Health Improvement</b></i></h4>
  
  <p style='line-height: normal;'><span style='font-size: 11pt; color: black; font-family: calibri, sans-serif;'>
  Food safety is often a time-sensitive issue, and city governments need to be ahead of the curve
  in identifying potential hazards. The City of Chicago developed a random forest algorithm to predict
  which establishments had violations. 
  <br><br>
  Combining different information including weather, crime, and previous inspection data, Chicago created 
  individualized risk scores for more than ten thousand establishments. By reprioritizing resources, Chicago was 
  able to reduce the time needed to identify critical violations by seven days.
  
  </div>
  "
  
),
validate = list(
  body = "
   <p class = 'emphasis', id = 'geospatheader', style='line-height: normal; font-size: 17.0pt;'>
    What is Model Validation?</p>

  <p style='color: red;'>This is currently copied from the geospatial tab and needs to be updated.</p>  
  <p>
  Geospatial analysis allows you to solve location - oriented problems and better understand where and 
  what is occurring in your environment. Beyond mere mapping, it can let you study the characteristics
  of places and the relationships between them, thus lending new perspectives to decision - making.
  Geospatial analysis helps answer questions such as:
  </p>
  
  <ul type='disc'>
  <li>
  Which communities are in the path of a wildfire? 
  </li>
  <li>
  Where are areas of high crime?
  </li>
   <li>
  Where can naloxone kits be positioned to better help communities most afflicted by the opioid epidemic?
  </li>
  </ul>
   <p>
  CriticalCare Dashboard supports plotting data on the county and state level. 
  </p>
  ",
  sidebar = "
  <div class = 'landingpage_side'>
  <h3 class = 'emphasis', id = 'geospatheader2'>Use Case Example</h3>
  <h4><i><b>Finding and Effectively Helping Homeless and At-Risk Youth</b></i></h4>
  
  <p style='line-height: normal;'><span style='font-size: 11pt; color: black; font-family: calibri, sans-serif;'>
  Homeless youths are a difficult population to locate and help. Many youths are unaware they qualify as homeless. 
  In addition, depression, anxiety, and associated histories of abuse and betrayal can intensify their distrust of adults, shelters, and support services. 
  As a result, this marginalized population is largely under-counted, and therefore under-served.
  
  <br><br>
  Communities can map the known locations of adolescent homeless clients and use those as reference points to find others. They could study the similarities 
  between these locations (e.g., coffee shops, access to Wifi, drug hot-spots, volume of sex trafficking tips) to predict other locations where homeless teens 
  may hang out.
  </div>
  "
)
)
