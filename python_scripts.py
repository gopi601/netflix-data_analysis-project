!pip install kaggle
import kaggle
import pandas as pd
df=pd.read_csv('netflix_titles.csv')
df.head()

!pip install pandas sqlalchemy pymysql
from sqlalchemy import create_engine
engine = create_engine('mysql+pymysql://root:root@localhost:3306/netflix')

df.to_sql('netflix_raw', con=engine, if_exists='append', index=False)
df[df.show_id=='s5023']
max(df.duration.dropna().str.len())
