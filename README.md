# Force_Gauge
Controller Software for Nextech Force Gauges


Quick Start:


To use the force gauge, plug it into the computer, allow Windows to initialize the device, and then start the application. If more than one serial device is detected, a list of COM ports will be presented. Enter the number corresponding to the desired COM port and click “Connect”. 
If only one COM port is detected it will be connected automatically. 
If no COM ports are detected, close the app, make sure windows properly initialized the device and restart the app. 

Once connected, the “Connect” button should turn green, and the date will be displayed in the output window. 
The force gauge can now be controlled by clicking the green and purple buttons.


Button Descriptions:

Change Units

the “Change Units” will cycle the units of measure on the device. The device should beep to confirm the change.
The device does not report the current units to the serial port. However, the units cycle in the following order: N > gf > kgf > ozf > lbf > mN > 

Change Mode

The “Change Mode” button will change the behavior of the “Measure Once” Button.
The modes cycle between “Track”, “Peak Tension”, and “Peak Compression”.
In “Track” mode, the device will return the current absolute value of force as well as the mode and “Compression” or “Tension” depending on the direction of the force.
In the two “Peak” modes, the device will return the currently stored peak value. 

Zero Offset

The “Zero Offset” Button will set the current force being applied to the gauge as the zero point. This will not effect the peak values stored.

Reset Max/Min

The “Reset Max/Min” button will clear the currently stored peak value. This does not effect the zero point or current measurement of the device.

Retrieve Memory

The “Retrieve Memory” button will cause the device to send all previously stored values as well as their corresponding force directions and units to the output window. Line numbers and the current date and time (plus milliseconds) will be displayed in front of each measurement. The date displayed is the date the data was retrieved from the unit, NOT the date the measurement was taken.

Device Info

The “Device Info” button will retrieve the gauges model number, capacity, serial number, firmware revision, original offset, current offset, and overload count.

Measure Once

The “Measure Once” button will retrieve a single measurement from the device as well as the unit, mode, and force direction. The value returned will be dependent upon the mode of the device (track, compression, tension).

Start Recording

The “Start Recording” button will poll the device at the interval entered in the “Refresh Rate” box. The values returned will always be the currently applied force independent of the mode of the device.

Clear Saved Data

The “Clear Saved Data” button will erase all previously recorded values. They are not recoverable. You will be asked to confirm the delete by pressing the button a second time. 

Save To File

The “Save To File” button will save all recorded values and dates, etc. to a .CSV file readable by Excel. The fields will be delimited by the character (or multiple characters) entered into the “File Delimiter” box. The file will be saved with the current date and time to your Desktop.

Limitations

The application has been successfully tested up to 1 hour of continuous recording and over 20,000 data. The theoretical time limit is up to 50 days. The theoretical number of data is determined by file size which must be less than 4 GB (approximately 100 million data).
The refresh rate has not been tested to less than 50 mS. Keep in mind that the device is not rated for a refresh rate faster than 10 samples / second (100 ms). The theoretical maximum refresh rate is approximately 50 days (4.2 billion milliseconds).
