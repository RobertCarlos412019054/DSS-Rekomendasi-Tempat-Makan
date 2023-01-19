import tkinter as tk
from tkinter import ttk
from tkinter import *
import minizinc

#init
root = Tk()
root.title('Rest Rate')
root.geometry("400x400")

#variabel dan fungsi
def show():
    model = minizinc.Model("Restaurant2.1.mzn")
    model.add_file("rest_data.dzn")
    gecode = minizinc.Solver.lookup("gecode")
    instance = minizinc.Instance(gecode, model)
    result = instance.solve()

    print(result)


#tombol
tombol_sapa = Button(root,text="Show Selection", command=show)
tombol_sapa.pack(fill='x',expand=True,padx=10,pady=10)

root.mainloop()