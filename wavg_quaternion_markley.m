
% by Tolga Birdal
% Q is an Mx4 matrix of quaternions. weights is an Mx1 vector, a weight for
% each quaternion.
% Qavg is the weightedaverage quaternion
% This function is especially useful for example when clustering poses
% after a matching process. In such cases a form of weighting per rotation
% is available (e.g. number of votes), which can guide the trust towards a
% specific pose. weights might then be interpreted as the vector of votes 
% per pose.
% Markley, F. Landis, Yang Cheng, John Lucas Crassidis, and Yaakov Oshman. 
% "Averaging quaternions." Journal of Guidance, Control, and Dynamics 30, 
% no. 4 (2007): 1193-1197.
function [Qavg]=wavg_quaternion_markley(Q, weights)

% Form the symmetric accumulator matrix
A=zeros(4,4);
M=size(Q,1);
wSum = 0;

for i=1:M
    q = Q(i,:)';
    w_i = weights(i);
    A=w_i.*(q*q')+A; % rank 1 update
    wSum = wSum + w_i;
end

% scale
A=(1.0/wSum)*A;

% Get the eigenvector corresponding to largest eigen value
[Qavg, Eval]=eigs(A,1);

end
