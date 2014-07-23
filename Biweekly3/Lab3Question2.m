% Biweekly 2 Question 3
% Authors: Leonard Chan, John Maloney

clc;
clear;

%% Create 2D Shape

hold off;
grid on;
axis([-10, 10, -10, 10]);

x_vertices = [-1, -1, 1, 1];
y_vertices = [-1, 1, 1, -1];

fill(x_vertices, y_vertices,'r');

%% Translation

for t = 0:2*pi/100:2*pi;
    x_translation = cos(t) - 1;
    y_translation = sin(t);
    
    x_vertices_new = x_vertices + x_translation;
    y_vertices_new = y_vertices + y_translation;
    
    fill(x_vertices_new, y_vertices_new,'r');
    axis([-10, 10, -10, 10]);
    axis square;
    
    title('Translating');
    drawnow;
    pause(.05);
end

%% Scaling

for t = 0:pi/100:pi
    scale_factor = sin(t) + 1;
    
    x_vertices_new = scale_factor*x_vertices;
    y_vertices_new = scale_factor*y_vertices;
    
    fill(x_vertices_new, y_vertices_new,'r');
    
    axis([-10, 10, -10, 10]);
    axis square;
    title('Scaling');
    drawnow;
end

%% Rotation
syms theta

center = [0, 0];

rot_matrix = [  cos(theta),-sin(theta); ...
                sin(theta), cos(theta);];
rot = symfun(rot_matrix, theta);
for i = 0:2*pi/100:2*pi
    x_vertices_new = zeros(1,4);
    y_vertices_new = zeros(1,4);
    
    for j = 1:length(x_vertices)
        xy_prime = rot(i)*[x_vertices(j) - center(1); ...
                           y_vertices(j) - center(2)];
        x_vertices_new(j) = xy_prime(1) + center(1);
        y_vertices_new(j) = xy_prime(2) + center(2);
    end
    
    fill(x_vertices_new, y_vertices_new, 'r');
    axis([-10, 10, -10, 10]);
    axis square;
    title('Rotating');
    drawnow;
end