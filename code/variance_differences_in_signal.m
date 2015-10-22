e1.average300 = repmat(mean(e1.plot300, 2), 1, numtrials);
e2.average300 = repmat(mean(e2.plot300, 2), 1, numtrials);
subtracted.average300 = repmat(mean(subtracted.plot300, 2), 1, numtrials);

e1.average800 = repmat(mean(e1.plot800, 2),1, numtrials);
e2.average800 = repmat(mean(e2.plot800, 2),1, numtrials);
subtracted.average800 = repmat(mean(subtracted.plot800, 2), 1, numtrials);

e1.dprime300 = sum(e1.plot300 - e1.average300, 2);
e2.dprime300 = sum(e2.plot300 - e2.average300, 2);
subtracted.dprime300 = sum(subtracted.plot300 - subtracted.average300, 2);

e1.dprime800 = sum(e1.plot800 - e1.average800, 2);
e2.dprime800 = sum(e2.plot800 - e2.average800, 2);
subtracted.dprime800 = sum(subtracted.plot800 - subtracted.average800, 2);

e1.std = mean(std(e1.plot800));
e2.std = mean(std(e2.plot800));
subtracted.std = mean(std(subtracted.plot800));

figure('Name','Mean Standard devations across trials');
bar([e1.std e2.std subtracted.std]);
a = gca;
a.XTickLabel = {'E1', 'E2','Subtracted'};

% figure('Name', '800Hz filter deviations');
% sh(1) = subplot(3,1,1);
% plot(ephys.t, e1.dprime800);
% title('Electrode 1: sum of deviations from mean');
% sh(2) = subplot(3,1,2);
% plot(ephys.t, e2.dprime800);
% title('Electrode 2: sum of deviations from mean');
% sh(3) = subplot(3,1,3);
% plot(ephys.t, subtracted.dprime800)
% title('Subtracted: sum of deviations');
