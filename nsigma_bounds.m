function [lower_bound, upper_bound] = nsigma_bounds(data, n)
%NSIGMA_BOUNDS Compute symmetric n-sigma bounds excluding zero values.
%
%   [LOWER_BOUND, UPPER_BOUND] = NSIGMA_BOUNDS(DATA, N)
%   returns bounds defined as:
%
%       mean(DATA) ± N * std(DATA)
%
%   where zero-valued elements are ignored.
arguments (Input)
    data (:,:) double
    n (1,1) double {mustBePositive} = 2
end

arguments (Output)
    lower_bound (1,1) double
    upper_bound (1,1) double
end

% Remove zero-valued elements
data_nonzero = data(data ~= 0);

% Calculate mean and standard deviation
mu = mean(data_nonzero, 'all');
sigma = std(data_nonzero, [], 'all');

% Define n-sigma bounds
lower_bound = mu - n*sigma;
upper_bound = mu + n*sigma;

end