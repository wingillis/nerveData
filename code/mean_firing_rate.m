brown = [0.52156 0.372549 0.262745];

smooth_factor = 30;

e1.srms = rectify(e1.fdata300(:,:), smooth_factor);
e2.srms = rectify(e2.fdata300(:,:), smooth_factor);
subtracted.srms = rectify(subtracted.fdata300(:,:), smooth_factor);

figure('Name', 'Mean std of signal');
sh(1) = subplot(7, 1, 1);
[s,f,t] = zftftb_pretty_sonogram(double(audio.data(:,1)), audio.fs, 'filtering', 300, 'clipping', -5, 'len', 80, 'overlap', 79);
imagesc(t, f./1000, s);
a = gca;
a.XTickLabel = [''];
title(sprintf('LG373 RBlk aligned song; CNT electrode implant; 41 days post implant\nsmoothed rms 0.3-5kHz elliptical filter'));
ylabel('Freq. (kHz)');
axis xy;

sh(2) = subplot(7, 1, 2:3);
shadedErrorBar(ephys.t, mean(e1.srms, 2), std(e1.srms')');
% ylabel('Rectified Voltage (uV)');
title('Electrode 1: in nerve');
a = gca;
a.XTickLabel = [''];
axis tight;

sh(3) = subplot(7, 1, 4:5);
shadedErrorBar(ephys.t, mean(e2.srms, 2), std(e2.srms')');
ylabel('Rectified Voltage (uV)');
title('Electrode 2: out of nerve');
a = gca;
a.XTickLabel = [''];
axis tight;

sh(4) = subplot(7, 1, 6:7);
shadedErrorBar(ephys.t, mean(subtracted.srms, 2), std(subtracted.srms')');
% ylabel('Rectified Voltage (uV)');
title('Subtracted: E1 - E2');
xlabel('Time (s)');
axis tight;
linkaxes(sh, 'x');
