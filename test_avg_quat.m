
disp ('Testing un-weighted quaternion averaging');

% Average 100 times
numTrials = 100;
perturb = 5;
displayEachQ = 0;

errNaiveSum = 0;
errMarkleySum = 0;

% apply small perturbation to the quaternions
for i=1:numTrials;
    
    % Generate an random quaternion
    qinit = rand(4,1);
    
    % for comparison reasons, it has to be normalized
    % Note that this is not a requirement of "avg_quaternion_markley"
    qinit = qinit./norm(qinit); %  

    Q=repmat(qinit,1,10);
    Q2=Q+(rand(size(Q))-0.5)*perturb; 
    
    [Qavg]=avg_quaternion_markley(Q2');

    % sign can flip due to eigen computations
    Qavg = abs(Qavg) ; 
   
    % compute per element sad error: 
    errMarkley = sum (abs(Qavg - qinit))./4; 
    
    % Do the simple mean averaging now
    QavgNaive = mean(Q2,2);
    
    % re-normalize
    QavgNaive = QavgNaive./norm(QavgNaive);
    
    % compute the same error
    errNaive = sum (abs(QavgNaive - qinit))./4; 

    % accumulate
    errMarkleySum = errMarkleySum + errMarkley;
    errNaiveSum = errNaiveSum + errNaive;   
    
    if (displayEachQ)
        fprintf('Initial Quaternion : [%f %f %f %f]\n', qinit(1), qinit(2), qinit(3), qinit(4));
        fprintf('Naive Average Quaternion : [%f %f %f %f]\n', QavgNaive(1), QavgNaive(2), QavgNaive(3), QavgNaive(4));
        fprintf('Markley Average Quaternion : [%f %f %f %f]\n', Qavg(1), Qavg(2), Qavg(3), Qavg(4));
        fprintf('Per Element Deviation using Naive Averaging (Mean): %f\n', errNaive); % Should be small
        fprintf('Per Element Deviation using Markley et. al.: %f\n', errMarkley); % Should be small
    end

end

errMarkley = errMarkleySum./numTrials;
errNaive = errNaiveSum./numTrials;

% Report: Note that for small values of "perturb", mean is just as the same
% as Markley averages. But as the value increases, difference becomes more
% significant
disp (['Performed ' num2str(numTrials) ' averages using perturb = ' num2str(perturb)]);
fprintf('Per Element Deviation using Naive Averaging (Mean): %f\n', errNaive); % Should be small
fprintf('Per Element Deviation using Markley et. al.: %f\n', errMarkley); % Should be small
% Note that Deviation is not the same as error, because we are not really
% trying to recover the original signal but rather to average many likely
% rotations. 

% Both methods work when the quaternions are close. Nevertheless, if the
% quaternions are not somewhat close, averaging starts to become
% meaningless.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% disp ('Weighted quaternion averaging testing is not implemented yet');

