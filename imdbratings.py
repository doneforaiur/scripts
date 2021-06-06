import csv
import matplotlib.pyplot as plt
import pandas as pd
from matplotlib.ticker import (MultipleLocator, AutoMinorLocator)

num_of_samples = 150000

titles = pd.read_table('IMDb movies.csv',sep=",",header=0, nrows=num_of_samples)

years = {}
total_score = {}
runtime = {}

for index, title in titles.iterrows():
#	if title["titleType"] == "movie":
	if int(title["year"]) in years:
		years[int(title["year"])] += 1
		total_score[int(title["year"])] += int(title["avg_vote"])
		runtime[int(title["year"])] += int(title["duration"])
	else:
		years[int(title["year"])] = 1
		total_score[int(title["year"])] = int(title["avg_vote"])
		runtime[int(title["year"])] = int(title["duration"])
		
for index in years:
	total_score[index] = total_score[index] / years[index]
	runtime[index] = runtime[index] / years[index]


runtime = sorted(runtime.items())
runtimex, runtimey = zip(*runtime)

runtime_shorts = sorted(total_score.items())
shortx, shorty = zip(*runtime_shorts)


fig, ax1 = plt.subplots()

ax1.plot(runtimex, runtimey)
ax1.plot(shortx, shorty)


ax1.xaxis.set_minor_locator(MultipleLocator(5))
ax1.yaxis.set_minor_locator(MultipleLocator(5))

ax1.legend(loc="center left")


plt.show()
#plt.savefig("ortalama_süre.png", dpi=400)





			