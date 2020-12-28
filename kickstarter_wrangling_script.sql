
###################### BRAIN STATION ADMISSIONS CHALLENGE: Step 1 ######################

# Author: Brandon F. Terrizzi

# In this script, I visually inspect the Kickstarter database and perform multiple joins to
# generate dataset that export for separate analysis and visualization in R. 


# NOTE: Technical issues exporting directly to .csv  so chose .xml and saved manually as .csv externally. 

# run code snippet provided by Brain Station to obtain uniform results  (google this to learn more...). 
SET GLOBAL sql_mode = 'ONLY_FULL_GROUP_BY';

#########################################################################################



####### CAMPAIGN DATA #######

# select and visually inspect 'campaign' table
SELECT *
FROM campaign; 

# how many id's are there? 
SELECT COUNT(*) 
FROM campaign;
# 150,000
# This output surprised me. 
# I had to troubleshoot to realize that default settings in wrokbench limited visible row to 1000. 

### These data are not ready for export since you need to add coutnry and currency data. 
### Category data are joined together and then to campaign data externally. 
 



####### CATEGORY DATA #######

# join category and sub_category tables and then export. the primary 'campaign' table does NOT contain any variable corresponding
# to the data in category, so we join here anticipating that we will join these data to campaign data based on sub_category info. 

CREATE TABLE categories AS 
SELECT sub_category.id AS sub_category_id, sub_category.name AS sub_category, category.name AS category
FROM sub_category
JOIN category ON category.id = sub_category.category_id; 


#### MANUAL STEP: must refresh schemas window to see newly created table 'categories'





#### JOIN COUNTRY to CAMPAIGN

SELECT
# from campaign
campaign.id, 
campaign.name,
campaign.launched,
campaign.deadline, 
campaign.goal, 
campaign.pledged,
campaign.backers, 
campaign.outcome, 
# from country
country.name AS country, 
# from currency
currency.name AS currency,
# from categories
categories.category,
categories.sub_category
FROM campaign
JOIN country ON campaign.country_id = country.id
JOIN currency ON campaign.currency_id = currency.id
JOIN categories ON campaign.sub_category_id = categories.sub_category_id;



#### MANUAL STEP: EXPORT AS .XML AND CONVERT TO .CSV EXTERNALLY 



