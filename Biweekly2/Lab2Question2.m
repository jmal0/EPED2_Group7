function Lab2Question2
    % Authors: Leonard Chan, John Maloney
    
    gui_width = 600; % Width of gui window
    gui_height = 400; % Height of gui window
    border = 5; % buffer between edge of window and gui elements
    button_width = 80; % Width to use when creating buttons
    button_height = 30; % Height to use when creating buttons 
    spacing = (gui_width - 2*border)/5; % Spacing between buttons
    
    % Creates a gui that is not yet visible at a distance of 100 by 100 
    % pixels from the lower left corner
    f = figure('Visible','off','Position',[100,100,gui_width,gui_height]);
   
    %  Construct the components.
    setupSerialButton = uicontrol('Style', 'pushbutton', ...
        'String', 'Setup Serial', ...
        'Position',[border+0*spacing,border,button_width,button_height],...
        'Callback', {@setupSerialButton_Callback});
    calibrateButton = uicontrol('Style', 'pushbutton', ...
        'String', 'Calibrate', ...
        'Position',[border+1*spacing,border,button_width,button_height],...
        'Callback', {@calibrateButton_Callback});
    startSamplingButton = uicontrol('Style', 'pushbutton', ...
        'String', 'Start Sampling', ...
        'Position',[border+2*spacing,border,button_width,button_height],...
        'Callback', {@startSamplingButton_Callback});
    stopSamplingButton = uicontrol('Style', 'pushbutton', ...
        'String', 'Stop Sampling', ...
        'Position',[border+3*spacing,border,button_width,button_height],...
        'Callback', {@stopSamplingButton_Callback});
    closeSerialButton = uicontrol('Style', 'pushbutton', ...
        'String', 'Close Serial', ...
        'Position',[border+4*spacing,border,button_width,button_height],...
        'Callback', {@closeSerialButton_Callback});
    componentPlot = axes('Parent', f, ...
        'Position', [border, 2*border+button_height, gui_width-2*border,...
        gui_height-3*border-button_height]);

    % Specifies that the positions used are in reference to the lower left
    % corner of the gui window
    align([setupSerialButton, calibrateButton, startSamplingButton, ...
        stopSamplingButton, closeSerialButton, componentPlot], ...
        'LowerLeft','None');
    
    % Displays the gui
    set(f,'Visible','on');
    set(axes, 'Visible','on');
    
    % Setup accelerometer component time plot
    grid on; % Displays grid lines
    title('Accelerometer Component Values'); % Displays the plot title
    xlabel('Time'); % Displays the plot xlabel
    ylabel('Acceleration (g)'); % Displays the plot ylabel
    axis([0 200 -3 3]); % Sets the x and y axis limits


    function setupSerialButton_Callback(source, eventdata)
        % Allows the user to setup a connection to the accelerometer
        
        global accelerometer; % The accelerometer variable is used in multiple
                      % functions, so it is declared as global

        % COM3 is the port that the arduino connects to
        comPort = 'COM3';
        % Setup communications with arduino
        [accelerometer.s, serialPort] = setupSerial(comPort);
    end


    function calibrateButton_Callback(source, eventdata)
        % Allows the user to calibrate the accelerometer
        
        global accelerometer; % The accelerometer variable is used in 
                              % multiple functions, so it is declared as 
                              % global
        global calCo; % Information about calibration is returned by 
                      % calibrate() that is used in the main loop, so it is
                      % declared as global
        calCo = calibrate(accelerometer.s); % Calibrates the accelerometer
    end


    function startSamplingButton_Callback(source, eventdata)
        % When clicked, the accelerometer readings will be plotted
        
        global shouldPlot; % The shouldPlot variable is used here to 
                           % determine if accelerometer readings should be
                           % plotted.
        global accelerometer; % The accelerometer variable is used in 
                              % multiple functions, so it is declared as 
                              % global
        global calCo; % Contains information about calibration returned in 
                      % the calibrateButton_Callback function
        
        shouldPlot = 1;
        
        figure(1)
        
        % Time span of accelerometer readings to display
        buf_len = 200;

        % create variables for all the three axis and the resultant 
        gxdata = zeros(buf_len,1);
        gydata = zeros(buf_len,1);
        gzdata = zeros(buf_len,1);
        resultantBuffer = zeros(buf_len,1); % add another buffer for the resultant
        index = 1:buf_len;

        while(shouldPlot)
            [gx, gy, gz] = readAcc(accelerometer,calCo);
            fprintf('%f %f %f\n' , [gx, gy, gz]);
            gxdata = [gxdata(2:end) ; gx];
            gydata = [gydata(2:end) ; gy];
            gzdata = [gzdata(2:end) ; gz];    

            resultantLength = sqrt(gx^2+gy^2+gz^2); % length of resulting vector
            resultantBuffer = [resultantBuffer(2:end); resultantLength]; % plot data for resultant vector over time
            plot(index,resultantBuffer, 'k'); % plot the last 200 readings of the resultantBuffer
        end
    end


    function stopSamplingButton_Callback(source, eventdata)
        global shouldPlot;
        shouldPlot = 0;
    end


    function closeSerialButton_Callback(source, eventdata)
        closeSerial;
    end

end
