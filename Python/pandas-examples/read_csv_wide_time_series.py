import pandas as pd
import io

str_data = r""",-,-,-,-
city,2018-01-01,2018-01-02,2018-01-03
syd,rain,cloudy,rain
mel,sunny,cloudy,rain
"""

df = pd.read_csv(io.StringIO(str_data), skiprows=1)
print(df)

df.set_index(df.columns[0], inplace=True)
df = df.transpose()
df.index = pd.to_datetime(df.index)

print(df)
