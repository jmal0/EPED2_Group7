% Biweekly 3 Question 2
% Authors: Leonard Chan, John Maloney
% Section 74 Group 7

clc; % Clear command line
clear; % Clears all variables from the workspace

%% Create 2D Shape

hold off; % Clear plot before each plot command

% The following lines initialize vectors containing the vertices of a
% 2 by 2 square centered at 0,0 and then display the square
x_vertices = [-1, -1, 1, 1]; % The x coordinates of the square's vertices 
y_vertices = [-1, 1, 1, -1]; % The y coordinates of the square's vertices

fill(x_vertices, y_vertices,'r'); % Display a red square on the plot

grid on; % Display gridlines
axis([-10, 10, -10, 10]); % Set axis limits
axis square; % Forces the plot to display axes of equal length
title('2D Animation Demo'); % Display a title message

pause(1); % Wait 1 second without doing anything to the square

%% Translation

% This loop moves the square in a circle of radius 1 centered at (-1,0)
% It iterates 100 times using an angle t between 0 and 2 pi as the loop
% variable
for t = pi/100:2*pi/100:2*pi
    % Calculate the new center of the square using the parametric equations
    % of the circle
    x_translation = cos(t) - 1; % The x coordinate of the center
    y_translation = sin(t); % The y coordinate of the center
    
    % Calculate the new x and y vertex positions by adding the coordinates
    % of the center
    x_vertices_new = x_vertices + x_translation; % New x position of the vertices
    y_vertices_new = y_vertices + y_translation; % New y position of the vertices
    
    fill(x_vertices_new, y_vertices_new,'r'); % Draw the translated square
    
    axis([-10, 10, -10, 10]); % Set axis limits
    axis square; % Forces the plot to display axes of equal length
    grid on; % Displays gridlines
    title('Translating'); % Displays the title
    
    drawnow; % Forces matlab to display the plot
    pause(.01); % Wait breifly before executing the next iteration
end

%% Scaling

% This loop scales the square by a factor that varies between 1 and 2
% The scale factor is determined by a sin function
% The loop iterates 100 times using a value between 0 and pi as the loop
% variable
for t = pi/100:pi/100:pi
    scale_factor = sin(t) + 1; % Calculate the scaling factor
    
    % Calculate the new vertex positions determined by multiplying the 
    % original vertex positions by the scale factor
    x_vertices_new = scale_factor*x_vertices; % Scaled x vertices
    y_vertices_new = scale_factor*y_vertices; % Scaled y vertices
    
    % Display the scaled square in red
    fill(x_vertices_new, y_vertices_new,'r');
    
    grid on; % Display gridlines
    axis([-10, 10, -10, 10]); % Set axis
    axis square; % Forces the plot to display axes of equal length
    title('Scaling'); % Display the title
    
    drawnow; % Forces matlab to draw the plot
    pause(.01); % Waits breifly before executing the next iteration
end

%% Rotation
syms theta % A symbolic variable representing the angle to rotate by

% Initialize the rotation matrix using the 
rot_matrix = [  cos(theta),-sin(theta); ...
                sin(theta), cos(theta);];
            
% Initialize a symbolic function to allow multiplication by the rotation
% matrix using a simple function call
rot = symfun(rot_matrix, theta);

% This loop rotates the square through one full rotation. It executes 100
% times using a loop variable i that goes from 0 to 2 pi
for i = 2*pi/100:2*pi/100:2*pi
    % Declare empty vectors to contain the new vertices of the square
    x_vertices_new = zeros(1,4); % New x vertex positions
    y_vertices_new = zeros(1,4); % New y vertex positions
    
    % This loops calculates each vertex by multiplying the rotation matrix 
    % by each a column vector for each xy pair 
    for j = 1:length(x_vertices)
        % Rotate the vertex about the center by an angle i
        xy_prime = rot(i)*[x_vertices(j); ...
                           y_vertices(j)];
                       
        x_vertices_new(j) = xy_prime(1); % New x vertex position
        y_vertices_new(j) = xy_prime(2); % New y vertex position
    end
    
    % Display the rotated square
    fill(x_vertices_new, y_vertices_new, 'r');
    
    grid on; % Display gridlines
    axis([-10, 10, -10, 10]); % Sets the axis limits
    axis square; % Forces the plot to display axes of equal length 
    title('Rotating'); % Display the title;
    
    drawnow; % Forces matlab to display the plot
    pause(.01); % Wait breifly before executing the next iteration
end

%% All together now!

for i = 2*pi/100:2*pi/100:2*pi
    x_vertices_new = zeros(1,4); % New x vertex positions
    y_vertices_new = zeros(1,4); % New y vertex positions
    
    % This loops calculates each vertex by multiplying the rotation matrix 
    % by each a column vector for each xy pair 
    for j = 1:length(x_vertices)
        % Rotate the vertex about the center by an angle i
        xy_prime = rot(i)*[x_vertices(j); ...
                           y_vertices(j)];
                       
        x_vertices_new(j) = xy_prime(1); % New x vertex position
        y_vertices_new(j) = xy_prime(2); % New y vertex position
    end
    
    % Calculate the new scaling factor using the loop variable. The scaling
    % factor varies from 1 to 2
    scale_factor = sin(i/2) + 1;
    
    % Scale by multiplying the vertex vectors by the scale factor
    x_vertices_new = scale_factor*x_vertices_new; % New scaled x vertices
    y_vertices_new = scale_factor*y_vertices_new; % New scaled y vertices
    
    % Translate the circle around a circle of radius 3 centered at (-3,0)
    center_x = 3*(cos(i) - 1); % New x position of the center of the square
    center_y = 3*sin(i); % New y position of the center of the square
    
    % Move the center of the square to the coordinates of the center
    x_vertices_new = x_vertices_new + center_x; % The translated x value
    y_vertices_new = y_vertices_new + center_y; % The translated y value
    
    % Change the color as the square moves. The color cycles sinusoidally
    % from red to purple to blue to green to yellow. Why? I dunno because
    % why not
    color = [1-sin(i/2), .5-.5*cos(i/2), sin(i/2)];
    
    % Display the colored, scaled, translated, rotated square
    fill(x_vertices_new, y_vertices_new, color);
    
    grid on; % Show gridlines
    axis([-10 10 -10 10]); % Set the axis limits
    axis square; % Forces the plot to display axes of equal length
    title('All together now!'); % Display a title
    
    drawnow; % Force matlab to draw the plot
    pause(.01); % Pause breifly before executing the next iteration
end

%% The End
title('That''s all folks'); % The end
pause(3); % Wait 3 seconds
close; % Close the plot
