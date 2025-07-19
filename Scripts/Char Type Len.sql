
WITH words (lang, word) AS (
	 SELECT 'Persian',
			'درود'
	 FROM DUAL d
	   UNION ALL
	 SELECT 'English',
			'Hello'
	 FROM DUAL d
	   UNION ALL
	 SELECT 'China',
			'问候'
	 FROM DUAL d
	   UNION ALL
	 SELECT 'Emoji',
			'😊'
	 FROM DUAL d
   ),
tp_char AS (
	 SELECT lang,
			--CAST(word AS nvarCHAR2(10)) AS word, -- ORA-12704: character set mismatch	  
			word,
			'char' Type,
			LENGTH(CAST(word AS CHAR(10))) len_char,
			LENGTHB(CAST(word AS CHAR(10))) len_byte,
			LENGTHB(CAST(word AS CHAR(10))) / LENGTH(CAST(word AS CHAR(10))) Coefficient

	 FROM words
   ),
tp_varchar AS (
	 SELECT lang,
			word,
			'varchar' Type,
			LENGTH(CAST(word AS VARCHAR2(10))) len_char,
			LENGTHB(CAST(word AS VARCHAR2(10))) len_byte,
			LENGTHB(CAST(word AS VARCHAR2(10))) / LENGTH(CAST(word AS VARCHAR(10))) Coefficient

	 FROM words
   ),
tp_nvarchar AS (
	 SELECT lang,
			word,
			'nvarchar' Type,
			LENGTH(CAST(word AS NVARCHAR2(10))) len_char,
			LENGTHB(CAST(word AS NVARCHAR2(10))) len_byte,
			LENGTHB(CAST(word AS NVARCHAR2(10))) / LENGTH(CAST(word AS NVARCHAR2(10))) Coefficient

	 FROM words
   ),
final AS (

	 SELECT *
	 FROM tp_char
	   UNION
	 SELECT *
	 FROM tp_varchar
	   UNION
	 SELECT *
	 FROM tp_nvarchar
   )
SELECT (
		   SELECT VALUE
		   FROM NLS_DATABASE_PARAMETERS
		   WHERE PARAMETER = 'NLS_CHARACTERSET'
	   ) NLS_CHARACTERSET,
	   lang,
	   word,
	   TYPE,
	   len_char,
	   len_byte,
	   round(Coefficient,2) AS Coefficient

FROM final
--ORDER BY word, TYPE
ORDER BY  TYPE

;