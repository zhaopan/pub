SELECT SUM(SinglePage_kb)+sum(MultiPage_kb) FROM
(
SELECT sum(single_Pages_kb) as SinglePage_kb,
	sum(multi_pages_kb) as MultiPage_kb
FROM sys.dm_os_memory_clerks
	GROUP BY type
) AS a 

UNION
SELECT COUNT(row_count) * 8.0 FROM sys.dm_os_buffer_descriptors

SELECT 
	ISNULL(DB_NAME(database_id),'ResourceDb') AS DatabaseName
	, CAST(COUNT(row_count) * 8.0 / (1024.0) AS DECIMAL(28,2))
												AS [Size (MB)]
FROM sys.dm_os_buffer_descriptors
GROUP BY database_id
ORDER BY DatabaseName