function out = rectify(data_in, sm)
  out = data_in .^ 2;
  % disp(size(out));
  out = sqrt(out);
  % disp(size(out));
  % disp(size(repmat(mean(out, 2), 1, size(out, 2))));
  % out = out - repmat(mean(out, 2), 1, size(out, 2));
  for i=1:size(out, 2)
    out(:,i) = smooth(out(:,i), sm);
    % out(:,i) = out(:,i) - mean(out(:,i));
    % out(:,i) = out(:,i)./(max(out(:,i))/2) + i;
  end
end
