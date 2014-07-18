function varargout = Lab2Question2(varargin)
    % LAB2QUESTION2 MATLAB code for Lab2Question2.fig
    %      LAB2QUESTION2, by itself, creates a new LAB2QUESTION2 or raises the existing
    %      singleton*.
    %
    %      H = LAB2QUESTION2 returns the handle to a new LAB2QUESTION2 or the handle to
    %      the existing singleton*.
    %
    %      LAB2QUESTION2('CALLBACK',hObject,eventData,handles,...) calls the local
    %      function named CALLBACK in LAB2QUESTION2.M with the given input arguments.
    %
    %      LAB2QUESTION2('Property','Value',...) creates a new LAB2QUESTION2 or raises the
    %      existing singleton*.  Starting from the left, property value pairs are
    %      applied to the GUI before Lab2Question2_OpeningFcn gets called.  An
    %      unrecognized property name or invalid value makes property application
    %      stop.  All inputs are passed to Lab2Question2_OpeningFcn via varargin.
    %
    %      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
    %      instance to run (singleton)".
    %
    % See also: GUIDE, GUIDATA, GUIHANDLES

    % Edit the above text to modify the response to help Lab2Question2

    % Last Modified by GUIDE v2.5 09-Jul-2014 18:36:22

    % Begin initialization code - DO NOT EDIT
    gui_Singleton = 1;
    gui_State = struct('gui_Name',       mfilename, ...
                       'gui_Singleton',  gui_Singleton, ...
                       'gui_OpeningFcn', @Lab2Question2_OpeningFcn, ...
                       'gui_OutputFcn',  @Lab2Question2_OutputFcn, ...
                       'gui_LayoutFcn',  [] , ...
                       'gui_Callback',   []);
    if nargin && ischar(varargin{1})
        gui_State.gui_Callback = str2func(varargin{1});
    end

    if nargout
        [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
    else
        gui_mainfcn(gui_State, varargin{:});
    end
    % End initialization code - DO NOT EDIT


    % --- Executes just before Lab2Question2 is made visible.
    function Lab2Question2_OpeningFcn(hObject, eventdata, handles, varargin)
        % This function has no output args, see OutputFcn.
        % hObject    handle to figure
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
        % varargin   command line arguments to Lab2Question2 (see VARARGIN)

        % Choose default command line output for Lab2Question2
        handles.output = hObject;

        % Update handles structure
        guidata(hObject, handles);

        % UIWAIT makes Lab2Question2 wait for user response (see UIRESUME)
        % uiwait(handles.figure1);
            

    % --- Outputs from this function are returned to the command line.
    % This function is used to update the rolling plot
    function varargout = Lab2Question2_OutputFcn(hObject, eventdata, handles) 
        % varargout  cell array for returning output args (see VARARGOUT);
        % hObject    handle to figure
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)

        % Get default command line output from handles structure
        varargout{1} = handles.output;

        
        % The following two variables are declared as global because they
        % are initialized in another function        
        global accelerometer; % The accelerometer object
        global calCo; % The calibration settings
        
        % The number of data points to include in the rolling plot
        buffLen = 200;
        
        % The x vector which contains the values 1 to buffLen
        indices = 1:buffLen;
        
        % Creaty empty vectors for acceleration components
        gxdata = zeros(buffLen, 1); % x acceleration data
        gydata = zeros(buffLen, 1); % y acceleration data
        gzdata = zeros(buffLen, 1); % z acceleration data
        
        % Sets the active graph to the empty axes2 object
        axes(handles.axes2);
        
        % This statement clears the axes grid marks. This axes object will
        % display the game interface in the final app. It will consist of a
        % black circle that can move around the screen by rotatting the
        % accelerometer. Green circles will be spawned and the black circle
        % will grow larger when it collides with black circles. If it
        % touches a larger circle, the user loses the game.
        set(handles.axes2,'xtick',[],'ytick',[]);
        
        % Sets the active graph to the rolling plot
        axes(handles.axes1);
        
        % Set up rolling plot
        grid on; % Show gridlines
        axis([0 200 -3 3]); % Set axis limits
        xlabel('Time'); % Display x label
        ylabel('Acceleration (g)'); % Display y label
        title('Rolling Acceleration Component Plot'); % Display title
            
        % This is the loop that draws the rolling plot. It should exit if
        % the gui has been exited as the handles variable will have been
        % deleted
        while(exist('handles','var'))
            % Update the plot if the sampling button reads "Stop Sampling"
            % In other words, the user has pressed "Start Sampling"
            % fprintf('%d\n', exist('handles','var'));
            if(strcmp(get(handles.samplingButton,'String'),'Stop Sampling'))
                % Get the components of the acceleration
                [gx, gy, gz] = readAcc(accelerometer, calCo);
                
                % Update the set of data to plot with the newest value and
                % remove the first oldest value
                gxdata = [gxdata(2:end) ; gx]; % Append newest x accel
                gydata = [gydata(2:end) ; gy]; % Append newest x accel
                gzdata = [gzdata(2:end) ; gz]; % Append newest x accel
                
                % Plot the past 200 accelerometer readings
                plot(indices, gxdata, 'b', ... % Plot x component in blue
                     indices, gydata, 'r', ... % Plot y component in red
                     indices, gzdata, 'g') % Plot z component in green
                
                % Set the axis limits
                axis([0 200 -3 3]);
                
                % Show gridlines
                grid on;
                
                % Update the rolling plot
                handles.axes1;
                
                % Forces matlab to draw the plot
                drawnow;
            else
                % The plot should not be updated so the thread rests .01
                % seconds
                pause(.01);
            end
        end


    % --- Executes on button press in setupButton.
    % Sets up communication with the accelerometer and prompts the user to
    % calibrate it
    function setupButton_Callback(hObject, eventdata, handles)
        % hObject    handle to pushbutton1 (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)

        
        % The following two variables are declared as global because they
        % are used in another function
        global accelerometer; % The accelerometer object
        global calCo; % Contains the calibration coefficients
        
        % The port which connects to the accelerometer
        comPort = 'COM6';
        
        % This loop repeatedly tries to connect to comPort, unless a
        % desired port is not indicated.
        while(~strcmp(comPort, ''))
            % This statement checks if the serialFlag variable exists,
            % indicating that the acclerometer is already initialized
            if (~exist('serialFlag','var'))
                % This statement catches errors that could occur in
                % initializing the accelerometer if it is not connected to
                % comPort
                try
                    % Initializes the accelerometer
                    [accelerometer.s,serialFlag] = setupSerial(comPort);
                    % Calibrates the accelerometer and saves the calibration results
                    calCo = calibrate(accelerometer.s);
                    % If this statement is reached, then the acclerometer
                    % has been created without any issues, so the function
                    % is exited
                    return;
                catch
                    % An error occured in initizalizing the accelerometer.
                    % message is the warning message to display
                    message = sprintf('Port %s not found. Indicate another port', ...
                        comPort);
                    % This statement creates an input dialog box which
                    % displays the previously mentioned message and saves
                    % the user input as the new comPort to try. If the
                    % cancel button is clicked, then the comPort will be ''
                    % and this function will complete without connecting to
                    % the accelerometer
                    comPort = char(inputdlg(message));
                end
            end
        end
        
        % This statement displays a warning message indicating that the
        % accelerometer was not initialized
        warndlg('No available comPorts. Please connect the accelerometer');
           

    % --- Executes on button press in samplingButton.
    % Changes the text of the sampling button so that the main thread knows
    % whether or not to plot accelerometer data.
    function samplingButton_Callback(hObject, eventdata, handles)
        % hObject    handle to samplingButton (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)
        
        % This if else statement changes the text of the sampling button
        % according to what it currently says
        if(strcmp(get(handles.samplingButton,'String'), 'Start Sampling'))
            % The current text is "Start Sampling", change it to "Stop
            % Sampling"
            set(handles.samplingButton,'String','Stop Sampling');
        else
            % The current text is "Stop Sampling", change it to "Start
            % Sampling"
            set(handles.samplingButton,'String','Start Sampling');
        end
        
        
    % --- Executes on button press in closeSerialButton.
    % Calls closeSerial to close connection to the accelerometer and close
    % the gui.
    function closeSerialButton_Callback(hObject, eventdata, handles)
        % hObject    handle to closeSerialButton (see GCBO)
        % eventdata  reserved - to be defined in a future version of MATLAB
        % handles    structure with handles and user data (see GUIDATA)

        closeSerial; % Closes connection to the accelerometer
    
    % This function will change the difficulty level when the difficulty
    % slider is moved
    function difficultySliderChanged_Callback(hObject, eventdata, handles)
        fprintf('Difficulty Changed\n'); % Prints 'Difficulty Changed' to 
                                         % the command window
    
    
    % This function will be used to start and pause the game in the final
    % app
    function startpauseButton_Callback(hObject, eventdata, handles)
        if(strcmp(get(handles.samplingButton,'String'), 'Start'))
            % The current text is "Start" and the game is pasued. Change
            % it to "Pause" and start the game
            set(handles.startpauseButton,'String','Pause');
        else
            % The current text is "Pause" and the game is running. Change
            % it to "Start" and pause the game
            set(handles.startpauseButton,'String','Start');
        end
    
    
    % In the final app this function will be used to quit the game when the
    % quit button is pressed
    function quitButton_Callback(hObject, eventdata, handles)
        fprintf('Quitting\n'); % Prints 'quitting' to the command window
    