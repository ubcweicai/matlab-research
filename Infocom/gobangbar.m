clc;
clear;

dropbox='../../../';

pc_ai_auto=mean(csvread([dropbox,'/testbed/pc/ai-auto.log']));
pc_ai_cloud=mean(csvread([dropbox,'/testbed/pc/ai-cloud.log']));
pc_ai_terminal=mean(csvread([dropbox,'/testbed/pc/ai-terminal.log']));
pc_human_auto=mean(csvread([dropbox,'/testbed/pc/human-auto.log']));
pc_human_cloud=mean(csvread([dropbox,'/testbed/pc/human-cloud.log']));
pc_human_terminal=mean(csvread([dropbox,'/testbed/pc/human-terminal.log']));

ipad_ai_auto=mean(csvread([dropbox,'/testbed/ipad/ai-auto.log']));
ipad_ai_cloud=mean(csvread([dropbox,'/testbed/ipad/ai-cloud.log']));
ipad_ai_terminal=mean(csvread([dropbox,'/testbed/ipad/ai-terminal.log']));
ipad_human_auto=mean(csvread([dropbox,'/testbed/ipad/human-auto.log']));
ipad_human_cloud=mean(csvread([dropbox,'/testbed/ipad/human-cloud.log']));
ipad_human_terminal=mean(csvread([dropbox,'/testbed/ipad/human-terminal.log']));

mobile_ai_auto=mean(csvread([dropbox,'/testbed/mobile/ai-auto.log']));
mobile_ai_cloud=mean(csvread([dropbox,'/testbed/mobile/ai-cloud.log']));
mobile_ai_terminal=mean(csvread([dropbox,'/testbed/mobile/ai-terminal.log']));
mobile_human_auto=mean(csvread([dropbox,'/testbed/mobile/human-auto.log']));
mobile_human_cloud=mean(csvread([dropbox,'/testbed/mobile/human-cloud.log']));
mobile_human_terminal=mean(csvread([dropbox,'/testbed/mobile/human-terminal.log']));

lte_ai_auto=mean(csvread([dropbox,'/testbed/lte/ai-auto.log']));
lte_ai_cloud=mean(csvread([dropbox,'/testbed/lte/ai-cloud.log']));
lte_ai_terminal=mean(csvread([dropbox,'/testbed/lte/ai-terminal.log']));
lte_human_auto=mean(csvread([dropbox,'/testbed/lte/human-auto.log']));
lte_human_cloud=mean(csvread([dropbox,'/testbed/lte/human-cloud.log']));
lte_human_terminal=mean(csvread([dropbox,'/testbed/lte/human-terminal.log']));

data = [pc_ai_auto pc_human_auto pc_ai_cloud pc_human_cloud pc_ai_terminal pc_human_terminal
        ipad_ai_auto ipad_human_auto ipad_ai_cloud ipad_human_cloud ipad_ai_terminal ipad_human_terminal        
        mobile_ai_auto mobile_human_auto mobile_ai_cloud mobile_human_cloud mobile_ai_terminal mobile_human_terminal
        lte_ai_auto lte_human_auto lte_ai_cloud lte_human_cloud lte_ai_terminal lte_human_terminal
     ];
 
h = bar(data,'group', 'BarWidth', 1);

%choice = menu('Which ColorOrder do you want?', 'jet', 'random', 'hsv', 'hot', 'cool', 'spring', 'summer',... 'autumn', 'winter', 'lines', 'gray', 'bone', 'copper', 'pink');
n = length(data);
colormap(jet(n));

l{1}='AI-Auto'; l{2}='Latency-Auto';  l{3}='AI-Cloud'; l{4}='Latency-Cloud'; l{5}='AI-Terminal';  l{6}='Latency-Terminal'; 
legend(h,l);

str = {'PC-WiFi'; 'iPad-WiFi'; 'Mobile-WiFi';'Mobile-LTE'};
set(gca, 'XTickLabel',str, 'XTick',1:numel(str))
ylabel('Time (ms)');