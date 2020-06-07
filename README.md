# SoundDisplay
The microphone of the PC obtains sound information.
Anlu's FPGA generates snowflakes on the screen based on the sound information.




Inspired by ssfx.




How it works:



The Python part:



![imagine](https://github.com/Callidora/SoundDisplay/blob/master/pict.bmp)





The FPGA part:


![imagine](https://github.com/Callidora/SoundDisplay/blob/master/picture2.bmp)



How to produce the snowflakes:
The snowflakes produces by the time.Each clock pulse arrives, part of the area is white and the other part is black. The next clock pulse arrives, the black and white area changes. Due to the short clock period,human eyes see the changing snowflakes. If the clock period is increased,the pattern gradually transforms into stripes.
The area of the black and white is generated by the counter. Each clock arrives, the counter is incremented. The value of the counter is used to take the modulus value of the horizontal and vertical resolution to generate random numbers of 0-1279 and 0-1023, then generating a random black and white area.




如何工作：

Python部分：

![imagine](https://github.com/Callidora/SoundDisplay/blob/master/1.bmp)

FPGA部分：

![imagine](https://github.com/Callidora/SoundDisplay/blob/master/2.bmp)


雪花如何生成：

雪花由时钟产生。每个时钟脉冲到达，显示区域一部分为白色，另一部分为黑色。下一个时钟脉冲到来，黑白区域改变。由于时钟周期短，人眼看到为不断变化的雪花。 增加时钟周期，图案逐渐变为条纹。

黑白区域由计数器生成，每个时钟脉冲到达，计数器递增。计数器对水平和垂直分辨率取模值，以生成0-1279和0-1023的随机数，然后生成随机的黑白区域。
