import os
from gpcharts import figure

resultDict = {}
amountList = ['1000', '2000', '4000', '8000', '16000', '24000', '32000', '36000', '48000']
ratioList = ['5', '8', '10', '15', '20']

files = [f for f in os.listdir('.') if os.path.isfile(f) and f.endswith('msemic.log')]
for f in files:
    ratio, amount, name = f[:-4].split('-')
    with open(f, 'r') as file:
        data = [eval(fps.strip('\r\n')) for fps in file.readlines() if len(fps.strip('\r\n')) > 1]
        avgFps = sum(data[5:]) / float(len(data) - 5)
        if (amount not in resultDict):
            resultDict[ratio] = [avgFps]
        else:
            resultDict[ratio].append(avgFps)
        print("Amount: {}, Strategy: {}, fps: {}".format(amount, name, avgFps))
list1 = [sum(resultDict[ratio])/float(len(resultDict[ratio])) for ratio in ratioList]

resultDict = {}

files = [f for f in os.listdir('.') if os.path.isfile(f) and f.endswith('ac.log')]
for f in files:
    ratio, amount, name = f[:-4].split('-')
    with open(f, 'r') as file:
        data = [eval(fps.strip('\r\n')) for fps in file.readlines() if len(fps.strip('\r\n')) > 1]
        avgFps = sum(data[5:]) / float(len(data) - 5)
        if (amount not in resultDict):
            resultDict[ratio] = [avgFps]
        else:
            resultDict[ratio].append(avgFps)
        print("Amount: {}, Strategy: {}, fps: {}".format(amount, name, avgFps))
list2 = [sum(resultDict[ratio])/float(len(resultDict[ratio])) for ratio in ratioList]

fig = figure(title="Test Result Strategy 4&5", ylabel="Avg Fps")
xVals = ['Ratio'] + ratioList
yVals = [['Strategy 4', 'Strategy 5']] + [[list1[i], list2[i]] for i in range(len(list1))] 
print(yVals)
fig.plot(xVals, yVals)
