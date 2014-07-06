/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.test;

import android.app.Activity;
import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Pi_Joules
 */
public class MainMenu extends Activity {

    Button play;
    
    public final String scores = "Game_Scores.txt";
    
    @Override
    public void onCreate(Bundle icicle) {
        super.onCreate(icicle);
        // ToDo add your GUI initialization code here     
        
        setContentView(R.layout.main_menu_layout);
        
        setTitle("Test App Game");
        
        play = (Button) findViewById(R.id.play);
        play.setOnClickListener(new View.OnClickListener(){
            public void onClick(View v){
                Intent playScreen = new Intent(getApplicationContext(), Test2.class);
                startActivity(playScreen);
            }
        });
        
        checkFile(scores);
        // add read scores part here
    }
    
    public String readSavedData(String file){
        // note: stringbuffer is synchronized, stringbuilder is not, but both essentially do same
        StringBuffer datax = new StringBuffer("");
        try {
            FileInputStream in = openFileInput(file);
            InputStreamReader isr = new InputStreamReader(in);
            BufferedReader br = new BufferedReader(isr);
            
            String readString = br.readLine();
            while (readString != null){
                datax.append(readString);
                readString = br.readLine();
            }
            
            isr.close();
        }
        catch (IOException e){
            return "";
        }
        return datax.toString();
    }
    
    public void writeData(String data, String file){
        try {
            FileOutputStream fOut = openFileOutput(file,Context.MODE_PRIVATE);
            fOut.write(data.getBytes());
            fOut.close();
        }
        catch (IOException e){}
    }
    
    public void checkFile(String file){
        boolean exists = readSavedData(file).equals("");
        if (!exists) writeData("", file);
    }
    
    
    @Override
    protected void onResume(){
        super.onResume();
        
    }
    
}
