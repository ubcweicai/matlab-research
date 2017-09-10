import os
from gpcharts import figure

resultDict = {}

files = [f for f in os.listdir('.') if os.path.isfile(f) and f.endswith('msemic.log')]
for f in files:
    ratio, amount, name = f[:-4].split('-')
    with open(f, 'r') as file:
        data = [eval(fps.strip('\r\n')) for fps in file.readlines() if len(fps.strip('\r\n')) > 1]
        avgFps = sum(data[5:]) / float(len(data) - 5)
        if (amount not in resultDict):
            resultDict[amount] = [avgFps]
        else:
            resultDict[amount].append(avgFps)
        print("Amount: {}, Strategy: {}, fps: {}".format(amount, name, avgFps))


amountList = ['1000', '2000', '4000', '8000', '16000', '24000', '32000', '36000', '48000']
ratioList = ['10', '15', '20', '5', '8']

fig = figure(title="Test Result Strategy 4", ylabel="Avg Fps")
xVals = ['Amount'] + amountList
yVals = [ratioList] + [resultDict[amount] for amount in amountList]
print(yVals)
fig.plot(xVals, yVals)
