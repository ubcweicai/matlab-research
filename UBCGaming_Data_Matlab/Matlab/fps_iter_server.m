x = [1000	2000	4000	6000	8000	10000];
y1 = [56.79957	56.05665	53.536	47.41579	44.97198	40.73006];
y2 = [56.16983	56.47361	53.30165	48.74248	45.24219	42.64106];
y3 = [56.97386	56.85764	53.57914	52.18955	48.06758	43.775];
y4 = [54.89338	54.07194	50.36174	45.79225	43.10321	37.59815];
y5 = [56.43042	53.86949	49.71727	47.63388	43.08025	38.53284];
y6 = [21.28988	22.39598	21.8747	22.59792	22.12136	21.92659];
y7 = [44.24541	44.43746	43.77682	44.33072	44.56364	43.7801];
y8 = [47.16627	46.38333	47.03825	46.28018	45.74933	45.80833];
y9 = [23.89667	23.375	23.86119	24.0107	23.44196	22.57226];
y10 = [22.87778	22.73081	23.02529	23.01508	23.17542	24.03333];
y11 = [23.09214	22.58015	22.80085	23.22826	23.74478	23.04932];


p = plot(x, y1, 'r.-', x, y2, 'go-', x, y3, 'bx-', x, y4, 'c+-', x, y5, 'm*-', x, y6, 'r.--', x, y7, 'go--', x, y8, 'bx--', x, y9, 'c+--', x, y10, 'm*--', x, y10, 'yS--');
xlabel('Total iterations');
ylabel('FPS');
grid on;
axis([1000, 10000, 0, 60]);
columnlegend(2, {'Experiment No.1', 'Experiment No.2', 'Experiment No.3', 'Experiment No.4', 'Experiment No.5', 'Experiment No.6', 'Experiment No.7', 'Experiment No.8', 'Experiment No.9', 'Experiment No.10', 'Experiment No.11'}, 'Location', 'southwest');

