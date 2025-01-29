
time = 1:timesteps;
% Initialize motivation
motivation = zeros(size(time));
motivation(1) = -2*(rand(1));

%%
malecount=0;
femalecount=0;
malepokevec1=[];
femalepokevec1=[];

% Simulate equal choice short dwell
for t = 2:timesteps
    % Exponential decay
    motivation(t) = motivation(t - 1) * exp(-1 / tau);

    if motivation(t)>=single_thresh,


        if rand(1)<MFchoice_prob,
            femalecount=femalecount+1;
            femalepokevec1=[femalepokevec1 t];
            tau=tau_f;

            %choose f
            if rand(1)<prob_interact_f,

                drivereduce = shortdwell_m(1) + (shortdwell_m(2)-shortdwell_m(1)).*rand(1);

            else
                drivereduce=nodwell_f;
            end

        else
            %choose male
            malecount=malecount+1;
            malepokevec1=[malepokevec1 t];
            tau=tau_m;

            if rand(1)<prob_interact_m,

                drivereduce = longdwell_f(1) + (longdwell_f(2)-longdwell_f(1)).*rand(1);

            else
                drivereduce=nodwell_m;
            end

        end
        motivation(t) = motivation(t) - drivereduce;

    end
end

ses1_lat=[femalepokevec1 malepokevec1];
ses1_id=[ones(1,length(femalepokevec1)) zeros(1,length(malepokevec1))];
[b,i]=sort(ses1_lat,'ascend');
ses1_lat=ses1_lat(i);
ses1_id=ses1_id(i);

ff1=length(find(ses1_id(1:end-1)==1&ses1_id(2:end)==1))./length(ses1_id);    
fm1=length(find(ses1_id(1:end-1)==1&ses1_id(2:end)==0))./length(ses1_id);     
mm1=length(find(ses1_id(1:end-1)==0&ses1_id(2:end)==0))./length(ses1_id);   
mf1=length(find(ses1_id(1:end-1)==0&ses1_id(2:end)==1))./length(ses1_id);      

stayswitch=[ff1 fm1 mm1 mf1];

ff1=(find(ses1_id(1:end-1)==1&ses1_id(2:end)==1));    
fm1=(find(ses1_id(1:end-1)==1&ses1_id(2:end)==0));     
mm1=(find(ses1_id(1:end-1)==0&ses1_id(2:end)==0));   
mf1=(find(ses1_id(1:end-1)==0&ses1_id(2:end)==1)); 

lats1=diff(ses1_lat);

stayswitch_lat=[nanmean(lats1(ff1)) nanmean(lats1(fm1)) nanmean(lats1(mm1)) nanmean(lats1(mf1))];