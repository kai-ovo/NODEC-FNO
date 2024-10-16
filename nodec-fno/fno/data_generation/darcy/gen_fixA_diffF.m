%% Generate darcy flow dataset with 1200 different ef's and all-1 coeff

clear all;
num_ef = 1200; % number of forcing terms
s = 512; % grid size
[X,Y] = meshgrid(0:(1/(s-1)):1);

%Parameters of covariance C = tau^(2*alpha-2)*(-Laplacian + tau^2 I)^(-alpha)
%Note that we need alpha > d/2 (here d= 2) 
%Laplacian has zero Neumann boundry
%alpha and tau control smoothness; the bigger they are, the smoother the
%function
% alpha = 2;
% tau = 3;
% tic;
% generate different forcing terms
% f ~ iid standard gaussian
forcing = zeros(num_ef,s,s);
for i = 1:num_ef
    f = randn(s,s);
    forcing(i,:,:) = f;
end

% generate different coeff functions
coeff = ones(s,s);

% generate solution
% size of solution is (num_coeff, num_ef, res, res)
solution = zeros(num_ef, s, s);
for jj = 1:num_ef
    ff = squeeze(forcing(jj,:,:));
    solution(jj,:,:) = solve_gwf(coeff,ff);
end

data('u') = solution;
filename = strcat('darcy-fixCoeff-',num2str(num_ef), ...
           'force-gridSize',num2str(s),'.mat');
data = struct('a',coeff,'u',solution,'f',forcing);
save(filename, 'data');
% toc;
% Generate random coefficients from N(0,C)
% norm_a = GRF(alpha, tau, s);

%Exponentiate it, so that a(x) > 0
%Now a ~ Lognormal(0, C)
%This is done so that the PDE is elliptic
% lognorm_a = exp(norm_a);

%Another way to achieve ellipticity is to threshhold the coefficients
% thresh_a = zeros(s,s);
% thresh_a(norm_a >= 0) = 12;
% thresh_a(norm_a < 0) = 4;

%Solve PDE: - div(a(x)*grad(p(x))) = f(x)
% lognorm_p = solve_gwf(lognorm_a,f);
% thresh_p = solve_gwf(thresh_a,f);