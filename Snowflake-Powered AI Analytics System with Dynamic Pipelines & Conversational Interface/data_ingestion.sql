USE WAREHOUSE CANADA_WH;
USE DATABASE RENT_DB;
USE SCHEMA RAW;

-- Make connection
CREATE STAGE RawDataIngestion
  URL='s3://canada-rent'
  CREDENTIALS=(AWS_KEY_ID=' ' AWS_SECRET_KEY=' ');

-- Create tables
CREATE OR REPLACE TABLE raw_rent_apartments (
    listing_id          VARCHAR(20),
    city                VARCHAR(60),
    province            VARCHAR(5),
    home_type           VARCHAR(30),
    bedrooms            INTEGER,
    bathrooms           INTEGER,
    sqft                INTEGER,
    monthly_rent        INTEGER,
    price_per_sqft      INTEGER,
    pet_friendly        VARCHAR(2),
    parking_included    VARCHAR(2),
    listed_date         DATE,
    listing_year        INTEGER,
    listing_month       INTEGER,
    _loaded_at          TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);


CREATE OR REPLACE TABLE raw_rent_houses (
    listing_id          VARCHAR(20),
    city                VARCHAR(60),
    province            VARCHAR(5),
    home_type           VARCHAR(30),
    bedrooms            INTEGER,
    bathrooms           INTEGER,
    sqft                INTEGER,
    monthly_rent        INTEGER,
    price_per_sqft      INTEGER,
    pet_friendly        VARCHAR(2),
    parking_included    VARCHAR(2),
    listed_date         DATE,
    listing_year        INTEGER,
    listing_month       INTEGER,
    _loaded_at          TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

CREATE OR REPLACE TABLE raw_rent_condos (
    listing_id          VARCHAR(20),
    city                VARCHAR(60),
    province            VARCHAR(5),
    home_type           VARCHAR(30),
    bedrooms            INTEGER,
    bathrooms           INTEGER,
    sqft                INTEGER,
    monthly_rent        INTEGER,
    price_per_sqft      INTEGER,
    pet_friendly        VARCHAR(2),
    parking_included    VARCHAR(2),
    listed_date         DATE,
    listing_year        INTEGER,
    listing_month       INTEGER,
    _loaded_at          TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

CREATE OR REPLACE TABLE raw_rent_basements (
    listing_id          VARCHAR(20),
    city                VARCHAR(60),
    province            VARCHAR(5),
    home_type           VARCHAR(30),
    bedrooms            INTEGER,
    bathrooms           INTEGER,
    sqft                INTEGER,
    monthly_rent        INTEGER,
    price_per_sqft      INTEGER,
    pet_friendly        VARCHAR(2),
    parking_included    VARCHAR(2),
    listed_date         DATE,
    listing_year        INTEGER,
    listing_month       INTEGER,
    _loaded_at          TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP()
);

-- Ingest Data from AWS to Snowflake
COPY INTO raw_rent_apartments (listing_id, city, province, home_type, bedrooms, bathrooms, sqft, monthly_rent, price_per_sqft, pet_friendly, parking_included, listed_date, listing_year, listing_month)
FROM '@RawDataIngestion/rent_apartments.csv'
FILE_FORMAT = (
  TYPE = 'CSV'
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
)
ON_ERROR = 'CONTINUE';

COPY INTO raw_rent_houses (listing_id, city, province, home_type, bedrooms, bathrooms, sqft, monthly_rent, price_per_sqft, pet_friendly, parking_included, listed_date, listing_year, listing_month)
FROM '@RawDataIngestion/rent_houses.csv'
FILE_FORMAT = (
  TYPE = 'CSV'
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
)
ON_ERROR = 'CONTINUE';

COPY INTO raw_rent_condos (listing_id, city, province, home_type, bedrooms, bathrooms, sqft, monthly_rent, price_per_sqft, pet_friendly, parking_included, listed_date, listing_year, listing_month)
FROM '@RawDataIngestion/rent_condos.csv'
FILE_FORMAT = (
  TYPE = 'CSV'
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
)
ON_ERROR = 'CONTINUE';

COPY INTO raw_rent_basements (listing_id, city, province, home_type, bedrooms, bathrooms, sqft, monthly_rent, price_per_sqft, pet_friendly, parking_included, listed_date, listing_year, listing_month)
FROM '@RawDataIngestion/rent_basements.csv'
FILE_FORMAT = (
  TYPE = 'CSV'
  SKIP_HEADER = 1
  FIELD_OPTIONALLY_ENCLOSED_BY = '"'
)
ON_ERROR = 'CONTINUE';

select * from raw_rent_basements;