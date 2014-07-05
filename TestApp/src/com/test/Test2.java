/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.test;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.pm.ActivityInfo;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.RectF;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.LinearLayout.LayoutParams;
import android.widget.TextView;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Random;

/**
 *
 * @author Pi_Joules
 */
public class Test2 extends Activity implements SensorEventListener{
    
    // drawable stuff
    CustomDrawableView mCustomDrawableView;
    
    // accelerometer stuff
    public float mLastX, mLastY, mLastZ;
    private boolean mInitialized;
    private SensorManager mSensorManager;
    private Sensor mAccelerometer;
    private final float NOISE = (float) 2.0;
    
    public TextView tvX, tvY, tvZ, tvXPos, tvYPos, tvXVel, tvYVel;

    @Override
    public void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        LinearLayout layout = (LinearLayout) findViewById(R.id.main_layout);
        
        tvX = (TextView)findViewById(R.id.x_axis);
        tvY = (TextView)findViewById(R.id.y_axis);
        tvZ = (TextView)findViewById(R.id.z_axis);
        tvXPos = (TextView) findViewById(R.id.xPos);
        tvYPos = (TextView) findViewById(R.id.yPos);
        tvXVel = (TextView) findViewById(R.id.xVel);
        tvYVel = (TextView) findViewById(R.id.yVel);
        
        setTitle("Test");
        
        // set screen vertical only
        setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
        
        // accelerometer stuff
        mInitialized = false;
        mSensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
        mAccelerometer = mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);
        mSensorManager.registerListener(this, mAccelerometer, SensorManager.SENSOR_DELAY_NORMAL);
        
        // custome drawable
        mCustomDrawableView = new CustomDrawableView(this);
        
        // set parameters
        LayoutParams params = new LayoutParams(LayoutParams.MATCH_PARENT, LayoutParams.MATCH_PARENT);
        params.setMargins(20,20,20,20);
        mCustomDrawableView.setLayoutParams(params);
        layout.addView(mCustomDrawableView);
        
        
        System.out.println("done loading");
    }
    
    public void quitGame(){
        new AlertDialog.Builder(this)
                .setTitle("You Lose")
                .setMessage("You suck so much that the game will shut down")
                .setPositiveButton(android.R.string.yes, new DialogInterface.OnClickListener(){
                    public void onClick(DialogInterface dialog, int which){
                        finish();
                    }
                }).show();
    }
    
    // stuff
    @Override
    protected void onResume() {
        super.onResume();
        mSensorManager.registerListener(this, mAccelerometer, SensorManager.SENSOR_DELAY_NORMAL);
    }
    @Override
    protected void onPause() {
        super.onPause();
        mSensorManager.unregisterListener(this);
    }

    
    // sensor methods
    public void onSensorChanged(SensorEvent event) {
        
        // the actual tilt angles
        float x = event.values[0];
        float y = event.values[1];
        float z = event.values[2];
        
        // get the current tilt angles
        if (!mInitialized) {
            mLastX = x;
            mLastY = y;
            mLastZ = z;
            tvX.setText("x: 0.0");
            tvY.setText("y: 0.0");
            tvZ.setText("z: 0.0");
            mInitialized = true;
        }
        else{
            
            // calculating the change in tilt and checking with noise
            float deltaX = Math.abs(mLastX - x);
            float deltaY = Math.abs(mLastY - y);
            float deltaZ = Math.abs(mLastZ - z);
            if (deltaX < NOISE) deltaX = (float)0.0;
            if (deltaY < NOISE) deltaY = (float)0.0;
            if (deltaZ < NOISE) deltaZ = (float)0.0;
            mLastX = x;
            mLastY = y;
            mLastZ = z;
            /*tvX.setText("x: " + Float.toString(deltaX));
            tvY.setText("y: " + Float.toString(deltaY));
            tvZ.setText("z: " + Float.toString(deltaZ));*/
            
            // display the absolute values
            tvX.setText("x: " + round(x,4));
            tvY.setText("y: " + round(y,4));
            tvZ.setText("z: " + round(z,4));
        }
    }
    public void onAccuracyChanged(Sensor sensor, int accuracy) {
        //throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    
    }
    
    public float round(float d, int decimalPlace){
        BigDecimal bd = new BigDecimal(Float.toString(d));
        bd = bd.setScale(decimalPlace, BigDecimal.ROUND_HALF_UP);
        return bd.floatValue();
    }

    private class CustomDrawableView extends View {
        
        // canvas setup
        public Paint p = new Paint();
        public float canvasWidth = 0, canvasHeight = 0;
        public boolean initialized = false; // make sure to get canvas width/height
        
        // controlled oval
        public RectF oval = new RectF();
        public float xPos = 0, yPos = 0, xVel = 0, yVel = 0;
        public float width = 10, height = 10;
        
        // other ovals
        public ArrayList<RectF> ovals = new ArrayList<RectF>();
        public ArrayList<float[][]> ovalsTraj = new ArrayList<float[][]>(); // first -> oval number, 2 -> oval pos/vel, 3 -> x/y
        public ArrayList<Float> ovalsSize = new ArrayList<Float>();
        //public float sWidth = 5, sHeight = 5; // starting width and height of first ovals

        public CustomDrawableView(Context context) {
            super(context);
            this.setBackgroundColor(Color.WHITE);
            
            // add circle every 5 seconds
            final Handler h = new Handler();
            new Thread(new Runnable(){
                public void run() {
                    while (2<3){
                        try{
                            Thread.sleep(1000);
                            h.post(new Runnable(){
                                public void run(){
                                    if (ovals.size() < 10){
                                        Random r = new Random();
                                        ovals.add(new RectF());
                                        float w = r.nextFloat()*2*width;
                                        ovalsSize.add(w);
                                        float[][] ovalTraj = {
                                            {
                                                // start at random corner
                                                Math.round(r.nextFloat())*(canvasWidth-w),
                                                Math.round(r.nextFloat())*(canvasHeight-w)
                                            },
                                            {
                                                // with random velocity
                                                r.nextFloat()*2+ (float) 0.5,
                                                r.nextFloat()*2+ (float) 0.5
                                            }
                                        }; 
                                        ovalsTraj.add(ovalTraj);
                                    }
                                }
                            });
                        }
                        catch (InterruptedException e){
                            // handle exceptions
                        }
                    }
                }
            }).start();
        }
        
        @Override
        public void onDraw(Canvas canvas) {
            
            if (initialized){
                
                // for xVel, tilting right is negative, so flip it
                // add tilt to vel to accelerate it and friction to slow it down
                //xVel += -mLastX/friction;
                //yVel += mLastY/friction;
                // set tilt to vel to make it easier to control
                xVel = -mLastX;
                yVel = mLastY;
                
                xPos += xVel;
                yPos += yVel;

                if (xPos < 0){
                    xPos = 0;
                    xVel = Math.abs(xVel);
                }
                if (xPos > this.getWidth()-width){
                    xPos = this.getWidth()-width;
                    xVel = -Math.abs(xVel);
                }
                if (yPos < 0){
                    yPos = 0;
                    yVel = Math.abs(yVel);
                }
                if (yPos > this.getHeight()-height){
                    yPos = this.getHeight()-height;
                    yVel = -Math.abs(yVel);
                }

                tvXPos.setText("xPos: " + round(xPos,4));
                tvYPos.setText("yPos: " + round(yPos,4));
                tvXVel.setText("xVel: " + round(xVel,4));
                tvYVel.setText("yVel: " + round(yVel,4));
                
                oval.set(xPos, yPos, width + xPos, height + yPos);
                p.setColor(Color.BLACK);
                canvas.drawOval(oval, p);
                
                
                for (int i = 0; i < ovals.size(); i++){
                    
                    float[][] traj = ovalsTraj.get(i);
                    float x2Pos = traj[0][0];
                    float y2Pos = traj[0][1];
                    float x2Vel = traj[1][0];
                    float y2Vel = traj[1][1];
                    
                    x2Pos += x2Vel;
                    y2Pos += y2Vel;

                    if (x2Pos < 0){
                        x2Pos = 0;
                        x2Vel = Math.abs(x2Vel);
                    }
                    if (x2Pos > this.getWidth()-ovalsSize.get(i)){
                        x2Pos = this.getWidth()-ovalsSize.get(i);
                        x2Vel = -Math.abs(x2Vel);
                    }
                    if (y2Pos < 0){
                        y2Pos = 0;
                        y2Vel = Math.abs(y2Vel);
                    }
                    if (y2Pos > this.getHeight()-ovalsSize.get(i)){
                        y2Pos = this.getHeight()-ovalsSize.get(i);
                        y2Vel = -Math.abs(y2Vel);
                    }

                    p.setColor(Color.GREEN);
                    ovals.get(i).set(x2Pos, y2Pos, ovalsSize.get(i) + x2Pos, ovalsSize.get(i) + y2Pos);
                    canvas.drawOval(ovals.get(i), p);
                    
                    traj[0][0] = x2Pos;
                    traj[0][1] = y2Pos;
                    traj[1][0] = x2Vel;
                    traj[1][1] = y2Vel;
                    ovalsTraj.set(i,traj);
                    
                    if (oval.intersect(ovals.get(i))){
                        /*if (ovalsSize.get(i) <= width){
                            float area = (float) (Math.PI*Math.pow(ovalsSize.get(i)/2,2));
                            width += (float) (2*Math.sqrt(area/Math.PI))/10;
                            height = width;
                            ovals.remove(i);
                            ovalsTraj.remove(i);
                            ovalsSize.remove(i);
                        }*/
                        double d = Math.sqrt(Math.pow(oval.centerX()-ovals.get(i).centerX(),2)+Math.pow(oval.centerY()-ovals.get(i).centerY(),2));
                        if (d < width/2 + ovalsSize.get(i)/2){
                            float area = (float) (Math.PI*Math.pow(ovalsSize.get(i)/2,2));
                            width += (float) (2*Math.sqrt(area/Math.PI))/10;
                            height = width;
                            ovals.remove(i);
                            ovalsTraj.remove(i);
                            ovalsSize.remove(i);
                        }
                        else{
                            quitGame();
                            return;
                        }
                    }
                    
                }
                
            }
            else {
                canvasWidth = this.getWidth();
                canvasHeight = this.getHeight();
                initialized = true;
                
                xPos = (canvasWidth-width)/2;
                yPos = (canvasHeight-height)/2;
                
                ovals.add(new RectF());
                ovals.add(new RectF());
                
                // set size of first 2 ovals to half the starting size of controlled oval
                ovalsSize.add(width/2);
                ovalsSize.add(height/2);
                
                float[][] oval1Traj = {{0,0}, {1,1}}; // set the first oval's xPos and yPos to zero and vel of 1
                ovalsTraj.add(oval1Traj);
                float[][] oval2Traj = {{canvasWidth-width/2,0}, {1,1}}; // start 2nd one on upper right and vel of 1
                ovalsTraj.add(oval2Traj);
                
                
                System.out.println(this.getWidth() + ", " + this.getHeight());
            }
            
            // redraw on canvas
            invalidate();
            
        }

    }
    
}
