smooth_factor = 50;

e1.srms = rectify(e1.fdata800(:,1:20), smooth_factor);
e2.srms = rectify(e2.fdata800(:,1:20), smooth_factor);
subtracted.srms = rectify(subtracted.fdata800(:,1:20), smooth_factor);



figure('Name', 'Smoothed rms of signal');
sh(1) = subplot(7, 1, 1);
[s,f,t] = zftftb_pretty_sonogram(double(audio.data(:,1)), audio.fs, 'filtering', 300, 'clipping', -5, 'len', 80, 'overlap', 79);
imagesc(t, f./1000, s);
axis xy;

sh(2) = subplot(7, 1, 2:3);
plot(ephys.t, e1.srms);
ylabel('Voltage');
title('Electrode 1: in nerve');
a = gca;
a.XTickLabel = [''];
axis tight;

sh(3) = subplot(7, 1, 4:5);
plot(ephys.t, e2.srms);
ylabel('Voltage');
title('Electrode 2: out of nerve');
a = gca;
a.XTickLabel = [''];
axis tight;

sh(4) = subplot(7, 1, 6:7);
plot(ephys.t, subtracted.srms);
ylabel('Voltage');
title('Subtracted: E1 - E2');
xlabel('Time (s)');
axis tight;
