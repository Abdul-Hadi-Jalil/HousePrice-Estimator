import pandas as pd
from sklearn.neighbors import KNeighborsRegressor

df = pd.read_csv(r"backend\dataset\Cleaned_data_for_model.csv")

# print(df)

del df["purpose"]
del df["Unnamed"]

print(df)

print(df.columns)
