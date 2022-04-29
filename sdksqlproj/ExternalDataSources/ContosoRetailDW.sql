CREATE EXTERNAL DATA SOURCE contosoretaildw_public
WITH
(  
  TYPE = HADOOP,
  LOCATION = 'wasbs://contosoretaildw-tables@contosoretaildw.blob.core.windows.net/'
);
