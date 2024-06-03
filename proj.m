clc;
clear all;
close all;

c = webcam;

while true
    e = snapshot(c);
    FDetect = vision.CascadeObjectDetector('EyePairBig', 'MergeThreshold', 30);
    I = e;
    BB_Mouth = step(FDetect, I);
    imshow(I);
    
    if isempty(BB_Mouth)
        title('Eyes Closed');
        defaultString = 'Please open your eyes';
        % Use system command to invoke text-to-speech
        system(['powershell -Command "Add-Type –AssemblyName System.Speech; ' ...
                '$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer; ' ...
                '$speak.Speak(''' defaultString ''')"']);
    else
        title('Eyes Open');
        hold on;
        for i = 1:size(BB_Mouth, 1)
            rectangle('Position', BB_Mouth(i, :), 'Linewidth', 5, 'LineStyle', '-', 'EdgeColor', 'r');
        end
        hold off;
    end
end
