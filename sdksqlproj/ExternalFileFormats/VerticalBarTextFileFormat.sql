CREATE EXTERNAL FILE FORMAT VerticalBarTextFileFormat
WITH
(
  FORMAT_TYPE = DELIMITEDTEXT,
  FORMAT_OPTIONS ( FIELD_TERMINATOR = '|'
                   ,STRING_DELIMITER = ''
                   ,DATE_FORMAT = 'yyyy-MM-dd HH:mm:ss.fff'
                   ,USE_TYPE_DEFAULT = FALSE
                 )
);