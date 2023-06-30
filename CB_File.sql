use fb_cb;
select * from dim_cities;
select * from dim_repondents;
select * from fact_survey_responses;

-- 1a)Who prefers energy drink more? (male/female/non-binary?)
select Gender, count(gender) as Total_No from dim_repondents group by Gender order by Total_No desc;

-- 1b)Which age group prefers energy drinks more?
select Age, count(age) as No_of_people_in_this_group from dim_repondents 
group by Age order by No_of_people_in_this_group desc;

-- 1c)Which type of marketing reaches the most Youth (15-30)?
select * from dim_repondents;
select * from fact_survey_responses;
select dr.age, fs.Marketing_channels, count(fs.Marketing_channels) as total_no_ads from fact_survey_responses as fs
join dim_repondents as dr on fs.Respondent_ID=dr.Respondent_ID
where age in ("15-18","19-30") group by dr.age, fs.Marketing_channels order by total_no_ads desc;

-- 2a)What are the preferred ingredients of energy drinks among respondents?
select Ingredients_expected, count(Ingredients_expected) as No_of_Ingredients_expected 
from fact_survey_responses group by Ingredients_expected order by No_of_Ingredients_expected Desc;

-- 2b)What packaging preferences do respondents have for energy drinks?
select Packaging_preference, count(Packaging_preference) as No_of_Packaging_preference
from fact_survey_responses group by Packaging_preference order by No_of_Packaging_preference Desc;

-- 3a)Who are the current market leaders?
select Current_brands, count(Current_brands) as No_of_Current_brands
from fact_survey_responses group by Current_brands order by No_of_Current_brands Desc;

-- 3b)What are the primary reasons consumers prefer those brands over ours?
select Reasons_for_choosing_brands, count(Reasons_for_choosing_brands) as No_of_people_choosing_brands
from fact_survey_responses group by Reasons_for_choosing_brands order by No_of_people_choosing_brands Desc;

-- 4a)Which marketing channel can be used to reach more customers?
select Marketing_channels, count(Marketing_channels) as No_of_Marketing_channels
from fact_survey_responses group by Marketing_channels order by No_of_Marketing_channels Desc;

-- 4b)How effective are different marketing strategies and channels in reaching our customers?
select Marketing_channels, COUNT(*) AS channel_counts
FROM fact_survey_responses
WHERE Heard_before = 'Yes'
GROUP BY Marketing_channels order by channel_counts desc ;

-- 5a)What do people think about our brand CodeX?
select Brand_perception, count(Brand_perception) as perception_count
from fact_survey_responses group by Brand_perception 
order by perception_count Desc;

-- 5b) Which cities do we need to focus more on?
select  dc.City, count(*) as Total_Respondents_from_cities from dim_cities as dc
join dim_repondents as dr on dc.City_Id=dr.City_Id
join fact_survey_responses as fc on dr.Respondent_ID=fc.Respondent_ID
where Brand_perception='Positive'
group by dc.City order by Total_Respondents_from_cities asc;

-- 6a)Where do respondents prefer to purchase energy drinks?
select Purchase_location, count(*) as Count_of_Purchase_location
from fact_survey_responses group by Purchase_location order by Count_of_Purchase_location Desc;

-- 6b) What are the typical consumption situations for energy drinks among respondents?
select Typical_consumption_situations, count(*) as Count_of_consumption_situations
from fact_survey_responses group by Typical_consumption_situations order by Count_of_consumption_situations Desc;

-- 6c) What factors influence respondents' purchase decisions, such as price range and limited edition packaging?
select Price_range, Limited_edition_packaging, count(*) as Respondent_Count
from fact_survey_responses group by Price_range, Limited_edition_packaging
order by Price_range, Limited_edition_packaging asc;


SELECT Price_range, Limited_edition_packaging, COUNT(*) AS Total_Purchases
FROM fact_survey_responses WHERE Price_range IS NOT NULL
AND Limited_edition_packaging IS NOT NULL
GROUP BY Price_range, Limited_edition_packaging
ORDER BY Total_Purchases DESC;



