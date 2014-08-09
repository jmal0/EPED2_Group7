% Biweekly 4 Question 2
% Authors: Leonard Chan, John Maloney
% Section 74 Group 7

clear; % Clear all variables from the workspace
clc; % Clear the command line

%% Generate 3D surface

% Create axes object for hgtransform
xyz_axes = axes('XLim',[-20 20],'YLim',[-20 20],'ZLim',[-20 20]);
% Set axes limits of plot
axis(xyz_axes);

view(3) % Set figure to use 3D view
grid on % Display gridlines
axis equal % Draw the plot with axes lengths reflecting limits

% Initialize x, y, and z matrices representing a 3D surface
x = zeros(10,100);
y = zeros(10,100);
z = zeros(10,100);

% Generate the edge lines using the parametric equations of a heart
t = -pi:2*pi/99:pi; % The domain of the parametric equations
for i = 1:100
    x(:,i) = 16*sin(t(i))^3;
    z(:,i) = 13*cos(t(i))-5*cos(2*t(i))-2*cos(3*t(i))-cos(4*t(i));
end

t2 = 0:pi/9:pi; % Time range of scaling equation
for i = 1:10
    % X and Y matrices are scaled between 0 and 1 in the z axis so surface
    % appears rounded
    x(i,:) = x(i,:).*sqrt(sin(t2(i)));
    z(i,:) = z(i,:).*sqrt(sin(t2(i)));
    % Populate z matrix with height of each edge of surface
    y(i,:) = i/2-2.5;
end

% Generate surface from matrices, set color to red and turn off edges
h = surface(x,y,z,'FaceColor','r','EdgeColor','none');

% Create the hg transform with the axes of the plot as its reference frame
t = hgtransform('Parent',xyz_axes);

% Make the surface part of the hg transform
set(h,'Parent',t);

%% Set up the plot

% Put a light source on the left of the object to better show contours of
% object
camlight left;

% Set title and axes labels
title('3D Surface Manipulation')
xlabel('X');
ylabel('Y');
zlabel('Z');

pause(1); % Wait for one second before continuing to scaling

%% Scaling

% Make the shape scale between 1 and 2 times its original size
for i = 0:2*pi/99:2*pi
    % Generate the transform to scale the surface
    T = makehgtform('scale',-cos(i)/2+1.5);
    set(t,'Matrix',T); % Set the surface's transform
    
    drawnow; % Force matlab to draw the surface
    pause(.01); % Wait breifly before next frame
end

%% Translation

% Make the shape scale between 1 and 2 times its original size
for i = 0:2*pi/99:2*pi
    % The position to move the heart to. Positions draw out a heart
    x_pos = 1/5*16*sin(i)^3;
    z_pos = -1 + 1/5*(13*cos(i)-5*cos(2*i)-2*cos(3*i)-cos(4*i));
    
    % Calculate the transform to translate the object
    T = makehgtform('translate',[x_pos, 0, z_pos]);
    % Move the heart in a heart shaped path
    set(t,'Matrix',T);
    
    drawnow; % Force matlab to draw the surface
    pause(.01); % Wait breifly before next frame
end

%% Rotation

% Make the surface slowly spin 5 full rotations
for i = 0:2*pi/99:2*pi
    % Rotate surface to be vertical and rotate it about the vertical axis
    % by an angle of i
    T = makehgtform('zrotate',i);
    set(t,'Matrix',T); % Actually rotate the surface
    
    drawnow; % Force matlab to draw the surface
    pause(.01); % Wait breifly before next frame
end

% Wait 3 seconds before closing the plot5
pause(3);
close;