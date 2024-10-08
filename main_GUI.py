import sys
sys.path.append('.')
from os import path

from RailML import railML
from RailML.Common import Metadata
from RailML.Common import Common
from RailML.Infrastructure import Infrastructure
from RailML.Interlocking import Interlocking
from RailML import aRailML

from RNA import RNA
from ATA import ATA
from ATG import ATG
from ACG import ACG
from AGG import AGG
from tkinter import *

root = Tk()

root.title('Railway Network Analyzer')
root.geometry('500x450')
root.configure(bg='#DDDDDD')

frame1 = Label(root, bg='#DDDDDD')
frame1.pack()
frame3 = LabelFrame(frame1, text='Example', padx=40, pady=20)
frame2 = LabelFrame(frame1, text='Configuration', padx=40, pady=10)

slider = StringVar()
slider.set('300.00')

slider2 = StringVar()
slider2.set('300.00')

languages = ['Example_1', 'Example_2', 'Example_3', 'Example_4', 'Example_5', 'Example_6', 'Example_7', 'Example_8', 'Example_9']

n = StringVar(frame3)
n.set(languages[0])

Checkbutton1 = IntVar(value = 1)
Checkbutton2 = IntVar(value = 1)
Checkbutton3 = IntVar(value = 1)
Checkbutton4 = IntVar(value = 1)
Checkbutton5 = IntVar(value = 1)
Checkbutton6 = IntVar(value = 1)
Checkbutton7 = IntVar(value = 0)
Checkbutton8 = IntVar(value = 1)

var_r = StringVar()
var_r.set('')

var_l = StringVar()
var_l.set('')

r = Label(root, textvariable = var_r)
r.pack()

l = Label(frame3, textvariable = var_l)
l.grid (row = 2, column = 0)

option_menu = OptionMenu(frame3, n ,*languages)
slide_bar =  Scale(frame2, from_= 300, to =  500, orient = HORIZONTAL, label = 'Distance Lc-Ptf')
slide_bar2 =  Scale(frame2, from_= 200, to =  500, orient = HORIZONTAL, label = 'Max Track length')

slide_bar.set(300)
slide_bar2.set(200)

RML = railML.railML()

def callback(selection):
    print(n.get())

def launchSystem():
    #Label(root, text=f'Running RNA ... {Checkbutton1.get()}').pack()
    #Label(root, text=f'Running RNA ... ').pack()
    # Call RNA
    try:
        config = [Checkbutton1.get(),Checkbutton2.get(),Checkbutton3.get(),Checkbutton4.get(),Checkbutton5.get(),Checkbutton6.get(),Checkbutton7.get(),Checkbutton8.get(),slide_bar.get(),slide_bar2.get()]
        
        #print(n.get()[-1])

        INPUT_FILE= "App\\Layouts\\"+str(n.get())+"\\"+str(n.get())+".railml"
        OUTPUT_FILE= "App\\Layouts\\"+str(n.get())+"\\"+str(n.get())+"_B.railml"

        #EXPORT_TO = path.relpath(OUTPUT_FILE)
    
        x,routes = RNA.RNA(RML,INPUT_FILE,OUTPUT_FILE,False,True,config,int(n.get()[-1]))
        #Label(root, text=f'{x}').pack()
        var_r.set(f'Analysis for {n.get()} done > {x[1]}')
        var_l.set(x[0])
        #Label(root, text=f'Analysis done!').pack()
        # Call ACG
        try:
            ACGx = ACG.ACG(RML,routes,example = int(n.get()[-1]))
            parameters = ACGx.get_data()
            print(parameters)
        except Exception as e:
            print(f'ACG had an error: {e}') 
        # Call AGG
        try:
            AGG.AGG(RML,routes,parameters)
        except Exception as e:
            print(f'AGG had an error: {e}')      
    except Exception as e:
        print(f'RNA had an error: {e}')

    # Call ATA
    try:
        ATA.ATA()    
        # Call ATG
        try:
            ATG.ATG()
        except Exception as e:
            print(f'ATG had an error: {e}')
    except Exception as e:
        print(f'ATA had an error: {e}')

button = Button(frame2, text='Run RNA!', state=NORMAL, padx=20, pady=5, command = launchSystem)

def isChecked():
    if (Checkbutton1.get() == 1 or Checkbutton2.get() == 1 or Checkbutton3.get() == 1 or Checkbutton4.get() == 1 or Checkbutton5.get() == 1 or Checkbutton6.get() == 1):
        button['state'] = NORMAL
        button.configure(text='Run RNA!',command = launchSystem)
    elif (Checkbutton1.get() == 0 and Checkbutton2.get() == 0 and Checkbutton3.get() == 0 and Checkbutton4.get() == 0 and Checkbutton5.get() == 0 and Checkbutton6.get() == 0):
        button['state'] = DISABLED
        button.configure(text='No RNA!',command = launchSystem)
    
def main():
    
    #root.withdraw()
    #root.geometry("500x300")
    frame3.pack(padx = 10 , pady = 10 , side = LEFT)
    
    #option_menu.pack()
    #label = Label(frame3, text='')
    
    option_menu.grid(row=1, column=0)
    slide_bar.pack()#grid(row=1, column=0)
    slide_bar2.pack()

    frame2.pack(padx = 10 , pady = 10 , side = RIGHT)

    Checkbutton(frame2, text="Analyze bufferStops", variable=Checkbutton1, onvalue=1, offvalue=0, command=isChecked).pack()
    Checkbutton(frame2, text="Analyze lineBorders", variable=Checkbutton2, onvalue=1, offvalue=0, command=isChecked).pack()
    Checkbutton(frame2, text="Analyze railJoints", variable=Checkbutton3, onvalue=1, offvalue=0, command=isChecked).pack()
    Checkbutton(frame2, text="Analyze levelCrossings", variable=Checkbutton4, onvalue=1, offvalue=0, command=isChecked).pack()
    Checkbutton(frame2, text="Analyze platforms", variable=Checkbutton5, onvalue=1, offvalue=0, command=isChecked).pack()
    Checkbutton(frame2, text="Analyze switches", variable=Checkbutton6, onvalue=1, offvalue=0, command=isChecked).pack()
    Checkbutton(frame2, text="One direction only", variable=Checkbutton7, onvalue=1, offvalue=0, command=isChecked).pack()
    Checkbutton(frame2, text="Simplify signals", variable=Checkbutton8, onvalue=1, offvalue=0, command=isChecked).pack()

    button.pack() 
    
    root.mainloop()

if __name__ == '__main__':
    main()