
--cases going back to 1970, this dataset provides an interesting perspective into Scottsdale development
--are case_id and CaseNumber the same thing?
--a large number of hearings have no date, or no vote, what's up with that?
--what is the trend is cases being approved/denied?
--what is the trend in vote count?
--why are there so many different vote count numbers? shouldn't the council making the votes be a simliar size from year to year?
----------------------
select * from [dbo].[pds_CaseMeetings]

--dataset showing records of meetings with case#, vote, and date
--approximately 10K records that meet these criteria
select *
from [City_of_Scottsdale].[dbo].[pds_CaseMeetings]
where case_id <> '' and Vote <> '' and MeetingDate <> ''

--how frequenly are case numbers revisited for vote?  E.g. if it fails the first time is it voted on again?
select * 
	--,B._count_
from [City_of_Scottsdale].[dbo].[pds_CaseMeetings] as A
inner join 

	(select case_id
		,count(case_id) as _count_
	from [City_of_Scottsdale].[dbo].[pds_CaseMeetings]
	where case_id <> '' and Vote <> ''
	group by case_id) as B on B.case_id = A.case_id

order by B._count_ desc

--how many different meeting types are there?
--10 different types total, how has the frequncy of these changed over the years?
select 
	[MeetingType]
	,count(*)
from [dbo].[pds_CaseMeetings]
group by [MeetingType]
order by count(*) desc

--how many of each meeting type are taking place each year?

select 
	[MeetingType]
	,year([MeetingDate]) as _year_
	,count(*) as _count_
from [dbo].[pds_CaseMeetings]
where [MeetingType] <> '' and [MeetingType] <> 'Other'
group by [MeetingType], year([MeetingDate])
order by year([MeetingDate])

