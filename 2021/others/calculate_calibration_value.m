function [ calibration ] = calibration_value( y , fs )
  calibration = 1 / rms(y); % 感度校正
end
