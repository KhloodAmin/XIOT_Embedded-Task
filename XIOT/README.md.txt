Microcontroller : PIC16F877A 
IDE : MiKroC
Switch is on PortB pin 1 
Led is on PortD pin 1 
Temperature sensor is on Port A and Virtual Terminal is connected to (RC6 , RC7 ) as UART communication 
________________________________________________________

I have made 2 Drivers ( GPIO Driver and Timer Driver )
 
* GPIO Driver contains 4 Fuctions to set up the configurations of my pins
* The functions are like arduino Functions so user can use it easily to set the desired congigurations

* Timer Driver is set to compute 10ms
_____________________________________________________

Through my code I tried to accomplish the task so my code begin with the Main functions where i begin to Set 
1- Timer 
2- GPIO
3- ADC 

I have 3 Functions beside The main ( get temp , Print , LedControlFunction)

For the first task i use external interrupt (interrupt on change) using Port B , i attatched the switch to portB Pin 0
as it can work also as an external interrupt and when the state of the switch change the value of the Flag changes.
So when the Flag value become 1 the Led will be ON for 250 ms and it will be off and set the Flag to zero again so i 
can detect the net press on the switch. The function control this process is called LedControlFunction.

NOTE : for the serial , First time you press the switch is the only time the serial will show it and if you want to print 
it on the serial every time you press the switch just remove the " PrintFlag " variable from the code 
_____________________________________________________________________________________________________

For the Temperature sensor 
I used the LM53 , By connectiong the sensor to Port A  -as it works as Analog input- , I initialize the Analog Digital Converter 
(ADC) to read the value so converting it to array of chars so i can print it on the Serial 

ADC 
ADC read the voltage from sensor and then multiply it by the Vref ( referenced voltage ) anddivide it by ADC reslution , in our case 1024 
resolution of ADC = Vref/(2^{10}-1) = Vref/1023
The function control this process is called get temp  .
__________________________________________________________________________________________________

Print Function is specified for printing the data to the Virtual monitor
after intializing the timer(10 ms) , there is a counter set to 300 to calculate 3 seconds and everytime the counter reach 300 , the print function is called.
__________________________________________________________________________________________________

NOTES 
* Enter_Critical_Section_Area is set to prevent the 2 interrupts from interfing  

     
 
