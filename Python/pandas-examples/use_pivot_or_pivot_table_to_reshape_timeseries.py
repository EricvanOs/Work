import pandas as pd
import io

"""
https://pandas.pydata.org/pandas-docs/stable/reshaping.html
https://pandas.pydata.org/pandas-docs/stable/generated/pandas.pivot_table.html
"""

# data
data = r"""
date,variable,value
2000-01-03,A,0.469112
2000-01-04,A,-0.282863
2000-01-05,A,-1.509059

2000-01-03,B,-1.135632
2000-01-04,B,1.212112
2000-01-05,B,-0.173215

2000-01-03,C,0.119209
2000-01-04,C,-1.044236
2000-01-05,C,-0.861849

2000-01-03,D,-2.104569
2000-01-05,D,1.071804
"""
df = pd.read_csv(io.StringIO(data))

print('Use pivot:')
table = df.pivot(index='date', columns='variable', values='value')
print(table)

print('\nUse pivot_table:')
table = pd.pivot_table(df, index=['date'], values='value', columns=['variable'], aggfunc=lambda x: x)
print(table)

print('\nIn case that time stamps are the index:')
df = pd.read_csv(io.StringIO(data), index_col='date')
table = df.pivot(index=None, columns='variable', values='value')
print(table)
