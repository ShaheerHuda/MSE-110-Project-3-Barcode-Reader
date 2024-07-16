#pragma config(Sensor, S1,     lightSensor,    sensorEV3_Color, modeEV3Color_Reflected_Raw)
#pragma config(Motor,  motorA,          leftMotor,     tmotorEV3_Large, PIDControl, driveLeft, encoder)
#pragma config(Motor,  motorB,          rightMotor,    tmotorEV3_Large, PIDControl, driveRight, encoder)
#pragma config(Motor,  motorC,           ,             tmotorEV3_Large, openLoop)
#pragma config(Motor,  motorD,           ,             tmotorEV3_Large, openLoop)
//*!!Code automatically generated by 'ROBOTC' configuration wizard               !!*//

task main()
{
	// The first argument is a datalog index number.
	// The filename will be saved in the rc-data folder as
	// datalog-<INDEX>.txt
	// The format is a comma separated value file.
	// The 2nd argument is the number of columns you wish to have in the file

	datalogFlush();
	datalogClose();
	if (!datalogOpen(111, 2, false)){
		displayCenteredTextLine(4,"Unable to open datalog");
	}
	// You can add an entry at the specified column number
	int i = 0;
	while(getMotorEncoder(rightMotor) < 360){
		setMotorSpeed(rightMotor, 5);
		setMotorSpeed(leftMotor, 5);

		if (i < 10) {
			int garbage = getColorReflected(S1);
			datalogAddShort(1,100);
			i++;
		} else {
			datalogAddShort(1, getColorReflected(S1));
		}

		sleep(1);
	}
	// Make sure you close the file properly
		datalogClose();
}

//csvread
