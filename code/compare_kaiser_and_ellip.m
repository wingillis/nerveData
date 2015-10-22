audio_load=@(FILE) fw_audioload(FILE);
data_load=@(FILE) fw_lg373_dataload(FILE);

hd = kaiser_filter;
numtrials = 8;

p = '../data';
load(fullfile(p,'roboaggregate.mat'));

[b,a] = ellip(4, 0.2, 60, [300 5e3]/(ephys.fs/2), 'bandpass');

e1.data = double(ephys.data(:,:,1));
e2.data = double(ephys.data(:,:,2));
subtracted.data = double(e1.data - e2.data);

addition = [1:numtrials] .* 400;
addition = repmat(addition, size(e1.data,1),1);
e1.fdata300 = filtfilt(b,a, e1.data);
e1.fdata800 = filter(hd, e1.data);

e2.fdata300 = filtfilt(b,a, e2.data);
e2.fdata800 = filter(hd, e2.data);

subtracted.fdata300 = filtfilt(b,a, subtracted.data);
subtracted.fdata800 = filter(hd, subtracted.data);

e1.plot300 = e1.fdata300(:, 1:numtrials) + addition;
e1.plot800 = e1.fdata800(:, 1:numtrials) + addition;
e2.plot300 = e2.fdata300(:, 1:numtrials) + addition;
e2.plot800 = e2.fdata800(:, 1:numtrials) + addition;
subtracted.plot300 = subtracted.fdata300(:,1:numtrials) + addition;
subtracted.plot800 = subtracted.fdata800(:,1:numtrials) + addition;

% Compare raw waveforms of 20 traces from both filters
figure('Name', 'Elliptical filtering 0.3-5kHz');
sh(1) = subplot(3,1,1);
plot(ephys.t, e1.plot300, 'Color', [0.52156 0.372549 0.262745]);
title('E1: In nerve');
sh(2) = subplot(3,1,2);
plot(ephys.t, e2.plot300, 'Color', [0.52156 0.372549 0.262745]);
title('E2: Out of nerve');
sh(3) = subplot(3,1,3);
plot(ephys.t, subtracted.plot300, 'Color', [0.52156 0.372549 0.262745]);
title('Subtracted electrodes');
linkaxes(sh, 'x');
axis tight;


figure('Name', 'FIR filter 800Hz Highpass');
sh(1) = subplot(3,1,1);
plot(ephys.t, e1.plot800, 'Color', [0.52156 0.372549 0.262745]);
title('E1: In nerve')
sh(2) = subplot(3,1,2);
plot(ephys.t, e2.plot800, 'Color', [0.52156 0.372549 0.262745]);
title('E2: Out of nerve');
sh(3) = subplot(3,1,3);
plot(ephys.t, subtracted.plot800, 'Color', [0.52156 0.372549 0.262745]);
title('Subtracted electrode');
linkaxes(sh, 'x');
axis tight


e1.thresh=3.5*std(e1.fdata800);
e1.spikes=spikoclust_spike_detect(e1.fdata800,e1.thresh,ephys.fs,'method','n','window',[.001 .001]);

e2.thresh=3.5*std(e2.fdata800);
e2.spikes=spikoclust_spike_detect(e2.fdata800,e2.thresh,ephys.fs,'method','n','window',[.001 .001]);

subtracted.thresh=3.5*std(subtracted.fdata800);
subtracted.spikes=spikoclust_spike_detect(subtracted.fdata800,subtracted.thresh,ephys.fs,'method','n','window',[.001 .001]);

figure('Name', 'Spike time rasters');
sh(1) = subplot(7, 1, 1);
[s,f,t] = zftftb_pretty_sonogram(double(audio.data(:,1)), audio.fs, 'filtering', 300, 'clipping', -5, 'len', 80, 'overlap', 79);
imagesc(t, f./1000, s);
a = gca;
a.XTickLabel = [''];
title(sprintf('LG373 RBlk aligned song; CNT electrode implant; 41 days post implant\nraster of 800Hz kaiser filter'));
ylabel('Freq. (kHz)');
axis xy;

sh(2) = subplot(7, 1, 2:3);
spikoclust_raster(e1.spikes.times/ephys.fs,e1.spikes.trial);
ylabel('Trial');
title('Electrode 1: in nerve');
a = gca;
a.XTickLabel = [''];
axis tight;

sh(3) = subplot(7, 1, 4:5);
spikoclust_raster(e2.spikes.times/ephys.fs,e2.spikes.trial);
ylabel('Trial');
title('Electrode 2: out of nerve');
a = gca;
a.XTickLabel = [''];
axis tight;

sh(4) = subplot(7, 1, 6:7);
spikoclust_raster(subtracted.spikes.times/ephys.fs,subtracted.spikes.trial);
ylabel('Trial');
title('Subtracted: E1 - E2');
xlabel('Time (s)');
axis tight;
linkaxes(sh, 'x');
