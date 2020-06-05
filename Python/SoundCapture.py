'''本代码实现实时发送来自麦克风的数据到串口'''
import pyaudio
import wave
import numpy as np
#from tqdm import tqdm    #进度条
import serial
from time import sleep

'''  本函数实现串口数据反馈，此处可注释
def recv(serial):
    while True:
        data = serial.read_all()
        if data == '':
            continue
        else:
            break
        sleep(0.02)
    return data
'''

def record_audio(record_second):
    CHUNK = 1024                      
    FORMAT = pyaudio.paInt16
    CHANNELS = 2
    RATE = 44100
  
    p = pyaudio.PyAudio()                             
    
    port = serial.Serial('COM3',115200, timeout=0.5)  #/dev/ttyUSB0
    if port.isOpen() :
        print("open success")
    else :
        print("open failed")

    stream = p.open(format=FORMAT,
                    channels=CHANNELS,
                    rate=RATE,
                    input=True,
                    frames_per_buffer=CHUNK)
    print("* recording")                                     #开始录音

    for i in range(0, int(RATE / CHUNK * record_second)):    #每收集CHUNK个数据就循环一次
        data = stream.read(CHUNK)                            #收集声音字符串信息，CHUNK个数据 
        datause = np.fromstring(data,dtype = np.short)       #收集声音数字信息
        datause.shape = -1,2 
        datause = datause.T                                  #矩阵转置
        datause = abs(datause[0])                            #声音数字信息有正负，取绝对值便于处理
        data1=np.mean(datause)                               #将n维数组转化为一个数据输出
        data2=int(data1/60)                                  #串口输出数据为8位
        
        if data2<=99:                                        #保证数据不溢出
            data3=str(data2).rjust(2,'0')                    #一位数据左补0，两位数据保持
            Hex_str = bytes.fromhex(data3)                   #将数据转为16进制输出
            print(data3)                                     #打印声音信息数值
            port.write(Hex_str)                              #串口输出
        
            ''' 查看数据是否发送，可注释
            sleep(0.1)
            
            data0 =recv(port)
            if data0 != b'' :
                print("receive : ",data0)
              '''
    
    print("* done recording")                                #结束录音
    stream.stop_stream()
    stream.close()
    p.terminate()


record_audio(record_second=100)                              #录音时间
    