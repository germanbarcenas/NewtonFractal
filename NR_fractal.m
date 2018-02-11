function [Map] = NR_fractal(dx,l)
%% Fractal Art
% This script is meant to plot the basin of convergence of a function to create a fractal
% The plot must be centered at (0,0) and have an absolute length of l
% 
% This plot will be generated using the Newton-Raphson Method
% dx will be the number of guesses.
% l will be the legnth of the plot.
% Written by: German Barcenas
% Date: March 22, 2017
%% Constants
    maxit = 100;

% Plot setting 
    cx=0;                      % Center of plot (Real axis)
    cy=0;                      % Center of plot (Imag axis)
    tol = 1e-10;               % Tolerance to determine closeness to 0.0
    x=linspace((cx-l)/2,(cx+l)/2,dx);  % Real space
    y=linspace((cy-l)/2,(cy+l)/2,dx);  % Imaginary space
    [X,Y]=meshgrid(x,y);
    Z=X+1i.*Y;                   % Real + Imaginary*j matrix declaration
%% Newton Raphson
for j = 1 : maxit
    Z = Z - func_eval(Z)./deriv(Z); 
end
%% Ploting 
Map = zeros(dx,dx);             % Declare array to hold color results
%Zroot = zeros(size(Map))
for k = 1 : 4                   % 1 : degree of function
    % de Moivre’s formula for complex roots.
    Zroot = (exp(2*pi*1i*k/4));
    % distance Zth element from root
    dist = abs(Z-Zroot);        
    % Root ID, ignored distances that are larger than our set tolerance. It
    % will only record the roots that converge in other words.
    fractal = (dist <= tol )*k ; 
    % Sets roots into Map to be plotted
    Map = Map+fractal;          
end
    colormap(cool);          % Set the color map
    imagesc(Map);           % Creates Fractal
    axis('square','off');
end