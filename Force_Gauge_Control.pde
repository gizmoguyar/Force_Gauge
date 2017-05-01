import interfascia.*;
import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

GUIController c;

IFLookAndFeel greenLook, redLook;

IFTextField delimField, interField, outputField, comField;
IFLabel delimLabel, interLabel, consoleLabel, outputLabel, consoleBody, outputBody, comLabel;

IFRadioController autoScroll;
IFRadioButton as1, as2;

IFButton unit, mode, zero, reset, single, start, save, connect, memory, info, clear;

boolean serialInit = false;
int iter = 1;
boolean newLine = true;
boolean recording;
boolean autoscroll = true;
String outputString = "  Time(H:M:S:mS)  Track Sign Value Unit Mode Direction\n";
String consoleString;
String delimiter = ",";
int time = 0;
int outHeight = 0;
int consHeight = 0;
int outOffset = 15;
int consOffset = 15;
boolean singleMes = false;
boolean clearedPres = false;


int interval = 1000;

void setup() {
  
  size(1000, 600);
  background(200);
  textSize(12);
  textLeading(17);
  
  c = new GUIController(this);
  delimField = new IFTextField("Delim Field", 140, 20, 50, delimiter);
  delimLabel = new IFLabel("File Delimiter:", 20, 25);
  
  interField = new IFTextField("Interval Field", 140, 50, 50, Integer.toString(interval));
  interLabel = new IFLabel("Refresh Rate (mS):", 20, 55);
  
  //autoScroll = new IFRadioController("Mode Selector");
  //as1 = new IFRadioButton("Autoscroll On", 20, 100, autoScroll);
  //as2 = new IFRadioButton("Autoscroll Off", 20, 120, autoScroll);
  
  unit = new IFButton ("Change Units", 20, 120, 120, 20);
  mode = new IFButton ("Change Mode", 20, 150, 120, 20);
  zero = new IFButton ("Zero Offset", 20, 180, 120, 20);
  reset = new IFButton ("Reset Max/Min", 20, 210, 120, 20);
  
  memory = new IFButton ("Retrieve Memory", 20, 260, 120, 20);
  info = new IFButton ("Device Info", 20, 290, 120, 20);
  
  
  greenLook = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  greenLook.baseColor = color(100, 180, 100);
  greenLook.highlightColor = color(70, 135, 70);
  
  redLook = new IFLookAndFeel(this, IFLookAndFeel.DEFAULT);
  redLook.baseColor = color(175, 100, 100);
  redLook.highlightColor = color(175, 50, 50);
  
  
  single = new IFButton ("Measure Once", 20, 350, 120, 20);
  
  start = new IFButton ("", 20, 380, 120, 20);
  recording = false;
  start.setLabel("Start Recording");
  
  clear = new IFButton ("Clear Saved Data", 20, 410, 120, 20);
  
  save = new IFButton ("Save to File", 20, 460, 120, 20);
  
  //outputField = new IFTextField("Output Field", 630, 30, 350);
  outputLabel = new IFLabel("Force Gauge Output", 750, 585);
  //outputField.setHeight(550);
  
  consoleString = "Start: " + month() + "/" + day() + "/" +year() + "  " + hour() + ":" + minute() + ":" + second();
  consoleString += "\n";
  consHeight ++;
  consoleLabel = new IFLabel("Console Output", 350, 585);
  
  comLabel = new IFLabel("COM Port #:", 20, 540);
  comField = new IFTextField("COM Port Field", 100, 535, 40);
  connect = new IFButton("Connect", 20, 560, 120, 20);
  
  
  //c.setLookAndFeel(greenLook);
  
  c.add(delimField);
  c.add(delimLabel);
  c.add(interField);
  c.add(interLabel);
  //c.add(as1);
  //c.add(as2);
  c.add(unit);
  c.add(mode);
  c.add(zero);
  c.add(reset);
  c.add(single);
  c.add(start);
  c.add(save);
  //c.add(outputField);
  c.add(outputLabel);
  //c.add(outputBody);
  //c.add(consoleField);
  c.add(consoleLabel);
  c.add(comLabel);
  c.add(comField);
  c.add(connect);
  c.add(memory);
  c.add(info);
  c.add(clear);
  
  
    
  start.setLookAndFeel(greenLook);
  single.setLookAndFeel(greenLook);
  save.setLookAndFeel(greenLook);
  connect.setLookAndFeel(redLook);
  clear.setLookAndFeel(greenLook);
  
  //delimField.addActionListener(this);
  //interField.addActionListener(this);
  unit.addActionListener(this);
  mode.addActionListener(this);
  zero.addActionListener(this);
  reset.addActionListener(this);
  single.addActionListener(this);
  start.addActionListener(this);
  save.addActionListener(this);
  connect.addActionListener(this);
  memory.addActionListener(this);
  info.addActionListener(this);
  clear.addActionListener(this);
  
  //.addActionListener(this);
  //consoleField.addActionListener(this);
  //outputField.addActionListener(this);
  
  
  //consoleField.setLabel("Starting Serial Port...");
  
  
  
  
  
     
     consoleString += "Serial Devices Available:\n";
     consHeight ++;
     for (byte i = 0; i < Serial.list().length; i++) {
       consoleString += i+1 + "    " + Serial.list()[i] + "\n";
       consHeight ++;
     }
     //consoleString += "\n";
     
     if(Serial.list().length == 1) {
       String portName = Serial.list()[0];
       myPort = new Serial(this, portName, 38400);
       serialInit = true;
       outputString += "  " + hour() + ":" + minute() + ":" + second() + "\n";
       outHeight++;
       consoleString += "Connected to " + Serial.list()[0] + "\n";
       consHeight ++;
       comField.setValue("1");
       connect.setLabel("connected");
       connect.setLookAndFeel(greenLook);
     }else if (Serial.list().length < 1) {
       consoleString += "(No Serial Devices Found)\n";
       consHeight ++;
     }else {
       consoleString += "Please connect to desired COM port number.\n";
       consHeight ++;
     } 
  
  
  
  
  
  
}

void draw() {
 // if(!serialInit) {
    background(200);
    fill(255);
    textLeading(17);
    rect(220, 1, 350, 580);
    rect(590, 1, 390, 580);
    
    fill(0);
  //}
  
  
  if (consHeight > 34) {
    consOffset -= 17;
    consHeight --;
  }
  
  
    text(consoleString, 230, consOffset);
    text(outputString, 600, outOffset);
  //text(consoleString, 270, 40, 330, 540);
  //text(outputString, 640, 40, 330, 540);
  
  
  
  if(serialInit) {
    while (myPort.available() > 0) {  // If data is available,
      val = myPort.read();         // read it and store it in val
      //println(val);
      
      if(newLine && val != 13) {
        //println('~');
        newLine = false;
        outputString += iter + "  " + hour() + ":" + minute() + ":" + second() +":"+ millis()%1000  + "  ";
        if(singleMes) {
          if(val != (int)'T' && val != (int)'C') {
            singleMes = false;
            outputString += "  ";
          }
        }
        iter++;
      }
      
        
      //println((char)val);
      //print((char)val);
      if((char)val == '\t') {
        val = (int)' ';
      }
      
      if (val != 13) {
        outputString += (char)val;
      }
        
        
      if (val == (int)'\n') {              //  10 = decimal value of ascii newline "\n"
        newLine = true;
        outHeight++;
        
        if(outHeight > 32) {        //scroll the text window upwards by one lineheight (textSize)
          outOffset -= 17;
          outHeight --;
        }
        
        
        //outputField.setValue(outputString);
      }
    }
  }
  
  
  
  if(millis() - time > interval) {
    time = millis();
    if (recording) {
      myPort.write('l');
    }
  }
  
}

void actionPerformed(GUIEvent e) {
  if (e.getSource() == as1 && e.getMessage().equals("Checked")) {
    autoscroll = true;
  }else if (e.getSource() == as1 && e.getMessage().equals("Unchecked")) {
    autoscroll = false;
  }else if (e.getSource() == unit && serialInit) {
    myPort.write('u');
    consoleString += "Sent: u\n";
    consHeight ++;
  }else if (e.getSource()== mode && serialInit) {
    myPort.write('m');
    consoleString += "Sent: m\n";
    consHeight ++;
  }else if (e.getSource() == zero && serialInit) {
    myPort.write('z');
    consoleString += "Sent: z\n";
    consHeight ++;
  }else if (e.getSource() == memory && serialInit) {
    myPort.write('d');
    consoleString += "Sent: d\n";
    consHeight ++;
  }else if (e.getSource() == info && serialInit) {
    myPort.write('!');
    consoleString += "Sent: !\n";
    consHeight ++;
  }else if (e.getSource() == reset && serialInit) {
    myPort.write('r');
    consoleString += "Sent: r\n";
    consHeight ++;
  }else if (e.getSource() == single && serialInit) {
    singleMes = true;
      myPort.write('x');
      consoleString += "Sent: x\n";
      consHeight ++;
  }else if (e.getSource() == clear) {
    if (!clearedPres) {
      consoleString += "Are you sure? Press again to clear\n";
      consHeight++;
      clearedPres = true;
    }else{
      consoleString += "Contents cleared";
      consHeight++;
      outputString = "  Time(H:M:S:mS)  Track Sign Value Unit Mode Direction\n";
      outOffset = 15;
      outHeight = 0;
      clearedPres = false;
    }
  }else if (e.getSource() == save) {
    delimiter = delimField.getValue();
    //outputString.replaceAll(" ", delimiter);          // this is not a space!!!
    outputString.replaceAll("  ", delimiter);
    outputString = outputString.replaceAll(String.valueOf(' '), delimiter);
    outputString.replaceAll(",,", delimiter);
    //outputString.replaceAll("\n\n", "\n");
    String fileName = System.getProperty("user.home") + "\\Desktop\\" + month() + "-" + day() + "-" +year() + "_" + hour() + "-" + minute() + "-" + second()+".csv";
    String[] fileCont = {outputString};
    saveStrings(fileName, fileCont);
    consoleString += "File Saved. \n" + fileName + '\n';
    consHeight+=2;
  }else if (e.getSource() == start && serialInit) {
    if(!recording) {
      interval = Integer.parseInt(interField.getValue());
      recording = true;
      start.setLookAndFeel(redLook);
      start.setLabel("Stop Recording");
      myPort.write('l');
    }else{
      recording = false;
      start.setLookAndFeel(greenLook);
      start.setLabel("Start Recording");
    }
  }else if(e.getSource() == connect) {
    if(!serialInit) {
      int enteredCom = parseInt(comField.getValue());
      int range = Serial.list().length;
      if(enteredCom > 0 && enteredCom <= range) {
        String portName = Serial.list()[enteredCom-1];
        myPort = new Serial(this, portName, 38400);
        serialInit = true;
        outputString += "  " + hour() + ":" + minute() + ":" + second() + "\n";
        outHeight++;
        consoleString += "Connected to " + Serial.list()[enteredCom-1] + "\n";
        consHeight ++;
        connect.setLabel("Disconnect");
        connect.setLookAndFeel(greenLook);
        //delimiter = delimField.getValue();
      }
    }else{
      connect.setLabel("connect");
      connect.setLookAndFeel(redLook);
      myPort.clear();
      myPort.stop();
      consoleString += "Disconnected from serial port.\n";
      consHeight++;
      serialInit = false;
      
      consoleString += "Serial Devices Available:\n";
     consHeight ++;
     for (byte i = 0; i < Serial.list().length; i++) {
       consoleString += i+1 + "    " + Serial.list()[i] + "\n";
       consHeight ++;
     }
     //consoleString += "\n";
     
     if(Serial.list().length == 1) {
       String portName = Serial.list()[0];
       myPort = new Serial(this, portName, 38400);
       serialInit = true;
       outputString += "  " + hour() + ":" + minute() + ":" + second() + "\n";
       outHeight++;
       consoleString += "Connected to " + Serial.list()[0] + "\n";
       consHeight ++;
       comField.setValue("1");
       connect.setLabel("connected");
       connect.setLookAndFeel(greenLook);
     }else if (Serial.list().length < 1) {
       consoleString += "(No Serial Devices Found)\n";
       consHeight ++;
     }else {
       consoleString += "Please connect to desired COM port number.\n";
       consHeight ++;
     } 
     
     
    }
  }
}