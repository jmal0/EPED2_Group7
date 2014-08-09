% Biweekly 4 Question 2
% Authors: Leonard Chan, John Maloney
% Section 74 Group 7

clear; % Clear all variables from the workspace
clc; % Clear the command line

%% Generate 3D surface

% Create axes object for hgtransform
xyz_axes = axes('XLim',[-2 4],'YLim',[-2 4],'ZLim',[-2 4]);
% Set axes limits of plot
axis(xyz_axes);

view(3) % Set figure to use 3D view
grid on % Display gridlines
axis equal % Draw the plot with axes lengths reflecting limits

% Generate equation of marijuana plot
t = -pi:2*pi/1000:pi; % The time range
% Calculate radius of polar equation of line
r = (1+.9.*cos(8*t)).*(1+.1.*cos(24*t)).*(.9+.05.*cos(200*t)).*(1+sin(t));

% Initialize x, y, and z matrices
x = zeros(11,1001);
y = zeros(11,1001);
z = zeros(11,1001);

% Convert from polar coordinates to rectangular coordinates to populate x
% and y matrices
for i = 1:1001
    x(:,i) = r(i).*cos(t(i));
    y(:,i) = r(i).*sin(t(i));
end

t2 = 0:pi/10:pi; % Time range of scaling equation
for i = 1:11
    % X and Y matrices are scaled between 0 and 1 in the z axis so surface
    % appears rounded
    x(i,:) = x(i,:).*sin(t2(i));
    y(i,:) = y(i,:).*sin(t2(i));
    % Populate z matrix with height of each edge of surface
    z(i,:) = (i-1)/50-.1;
end

% Generate surface from matrices, set color to green and turn off edge
% lines
h = surface(x,y,z,'FaceColor','g','EdgeColor','none');

% Create the hg transform with the axes of the plot as its reference frame
t = hgtransform('Parent',xyz_axes);
% Make the surface part of the hg transform
set(h,'Parent',t);

% Rendering settings
camlight left;
lighting phong;
set(gcf,'Renderer','opengl');

title('Smoke Weed Erry''day')
xlabel('X');
ylabel('Y');
zlabel('Z');

% Make the surface slowly spin 5 full rotations
for i = 0:2*pi/100:10*pi
    % Rotate surface to be vertical and rotate it about the vertical axis
    % by an angle of i
    T = makehgtform('xrotate',pi/2,'yrotate',i);
    set(t,'Matrix',T); % Actually rotate the surface
    
    %drawnow; % Force matlab to draw the surface
    pause(.01); % Wait breifly before next frame
end
