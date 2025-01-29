clear all

%%
%Single drive state
%parameters are probability of interaction, MF choice likelihood, and
%decay(tau)

% Parameters
tau_m = 50; % Time constant for decay
tau_f = 50;
tau=tau_f; % Time constant for decay start value

prob_interact_m=0.7; %prob of successful interaction with m
prob_interact_f=0.7; %prob of successful interaction with f

nodwell=0.1; % Strength of drive reduction with no interaction
shortdwell = 0.5; % Strength of drive reduction with short dwell
longdwell = 2.5; % Strength of the drive reduction with long dwell

single_thresh=-0.01;

MFchoice_prob=0.3; %bias for chosing f over m


% Time vector
timesteps = 100000; % Number of time steps for simulation

% timesteps = 10000; % Number of time steps for graphics

time = 1:timesteps;
% Initialize motivation
motivation = zeros(size(time));
motivation(1) = -2*(rand(1));


malecount=0;
femalecount=0;
malepokevec1=[];
femalepokevec1=[];

% Simulate choice short dwell
for t = 2:timesteps
    % Exponential decay
    motivation(t) = motivation(t - 1) * exp(-1 / tau);

    if motivation(t)>=single_thresh,


        if rand(1)<MFchoice_prob,
            femalecount=femalecount+1;
            femalepokevec1=[femalepokevec1 t];
            tau=tau_f;

            if rand(1)<prob_interact_f,

                            drivereduce = nodwell + (shortdwell-nodwell).*rand(1)

                % drivereduce=shortdwell;
            else
                drivereduce=nodwell;
            end

        else
            malecount=malecount+1;
            malepokevec1=[malepokevec1 t];
            tau=tau_m;

             if rand(1)<prob_interact_m,
                             drivereduce = nodwell + (shortdwell-nodwell).*rand(1)

                % drivereduce=shortdwell;
            else
                drivereduce=nodwell;
            end

        end
        motivation(t) = motivation(t) - drivereduce;

    end
end
n=[malecount,femalecount];
figure;
subplot(5,2,1:2)
for ff=1:length(femalepokevec1)
    hold on
    plot([femalepokevec1(ff) femalepokevec1(ff)],[0 1],'m-')
end
hold on
for mm=1:length(malepokevec1)
    hold on
    plot([malepokevec1(mm) malepokevec1(mm)],[0 -1],'g-')
end
title(n);

subplot(5,2,3:4)
plot(time, motivation, 'k-');

xlabel('Time');
ylabel('Motivation');


% Initialize motivation
motivation = zeros(size(time));
motivation(1) = -2*(rand(1));


malecount=0;
femalecount=0;
malepokevec2=[];
femalepokevec2=[];

% Simulate choice short dwell
for t = 2:timesteps
    % Exponential decay
    motivation(t) = motivation(t - 1) * exp(-1 / tau);

    if motivation(t)>=single_thresh,

     if rand(1)<MFchoice_prob,
            femalecount=femalecount+1;
            femalepokevec2=[femalepokevec2 t];
            tau=tau_f;

            if rand(1)<prob_interact_f,

                            drivereduce = shortdwell + (longdwell-shortdwell).*rand(1)

                % drivereduce=longdwell;
            else
                drivereduce=nodwell;
            end

        else
            malecount=malecount+1;
            malepokevec2=[malepokevec2 t];
            tau=tau_m;

             if rand(1)<prob_interact_m,

                             drivereduce = nodwell + (shortdwell-nodwell).*rand(1)

                % drivereduce=shortdwell;
            else
                drivereduce=nodwell;
            end

        end
        motivation(t) = motivation(t) - drivereduce;

    end
end
n=[malecount,femalecount];
subplot(5,2,7:8)
for ff=1:length(femalepokevec2)
    hold on
    plot([femalepokevec2(ff) femalepokevec2(ff)],[0 1],'m-')
end
hold on
for mm=1:length(malepokevec2)
    hold on
    plot([malepokevec2(mm) malepokevec2(mm)],[0 -1],'g-')
end
title(n);

subplot(5,2,9:10)
plot(time, motivation, 'k-');

xlabel('Time');
ylabel('Motivation');




%%

flat1=diff(femalepokevec1);
mlat1=diff(malepokevec1);
flat2=diff(femalepokevec2);
mlat2=diff(malepokevec2);





figure;
subplot(2,2,1)
title('shortm shortf')
[Hf1,STATS] = cdfplot(flat1);
xx=Hf1.XData;
yy=Hf1.YData;
plot(xx,yy,'k-')
hold on
[Hm1,STATS] = cdfplot(mlat1);
xx=Hm1.XData;
yy=Hm1.YData;
plot(xx,yy,'b-')
[h,p]=kstest2(flat1,mlat1);
title(p)


subplot(2,2,2)
title('shortm longf')
[Hf2,STATS] = cdfplot(flat2);
xx=Hf2.XData;
yy=Hf2.YData;
plot(xx,yy,'k-')
hold on
[Hm2,STATS] = cdfplot(mlat2);
xx=Hm2.XData;
yy=Hm2.YData;
plot(xx,yy,'r-')
[h,p]=kstest2(flat2,mlat2);
title(p)



subplot(2,2,3)
title('shortf longf')
[Hf1,STATS] = cdfplot(flat1);
xx=Hf1.XData;
yy=Hf1.YData;
plot(xx,yy,'k-')
hold on
[Hm1,STATS] = cdfplot(flat2);
xx=Hm1.XData;
yy=Hm1.YData;
plot(xx,yy,'b-')
[h,p]=kstest2(flat1,flat2);
title(p)

subplot(2,2,4)
title('shortm shortm')
[Hf2,STATS] = cdfplot(mlat1);
xx=Hf2.XData;
yy=Hf2.YData;
plot(xx,yy,'k-')
hold on
[Hm2,STATS] = cdfplot(mlat2);
xx=Hm2.XData;
yy=Hm2.YData;
plot(xx,yy,'r-')
[h,p]=kstest2(mlat1,mlat2);
title(p)




