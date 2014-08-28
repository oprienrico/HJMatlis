function [ hours,mins,secs ] = sec2hms( secs )
%SEC2HMS convert seconds in hours,mins,secs

    hours = floor(secs / 3600);
    secs = secs - hours * 3600;
    mins = floor(secs / 60);
    secs = secs - mins * 60;
end

