import matplotlib as mpl
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import numpy as np
import datetime as dt
from itertools import cycle
import os

def plt_set_default(c ='r',figsize=(10, 10), dpi=300, lw=2):
    plt.style.use('bmh')
    plt.rcParams['axes.grid'] = False
    plt.rc('lines',lw=lw,c=c)
    plt.rc('figure', figsize=figsize, dpi=dpi)
    return 

def plot_loss(figtitle = "", figpath = "", figname = "", savefig = False, **losses):
    """
    Plot several loss functions on one figure.
    
    Inputs:
    
        figtitle - type: str
                   title of the saved figure
                   
        figname - type: str
                  name of the saved figure
                  
        figpath - type: str
                  path where the figure is saved
                  
        savefig - type: boolean
                  a flag indicating whether or not to save figure
                  
        **losses - type: keyworded lists 
                   loss functions to be plotted
    """
    if savefig:
        if figtitle == "":
            raise error("Figure Title Required to Save Figure")
        if figname == "":
            raise error("Figure Name Required!")
        if figname[-4:] != '.png':
            figname = figname + '.png'
        if figpath == "":
            raise error("Figure Path Required")
        if figpath[-1] != '/':
            figpath = figpath + '/'
        if not os.path.isdir(figpath):
            os.makedirs(figpath)
        
    lines = ['-']#,'--']
    linecycler = cycle(lines)
    newFig = plt.figure(figsize = (8,6))
    ax = newFig.add_subplot()
    plt.xlabel("epochs",fontsize = 20)
    plt.ylabel("Loss Value",fontsize = 20)
    plt.title(figtitle, fontsize = 14)
    for key, loss in losses.items():
        ax.semilogy(np.arange(1,len(loss)+1),loss,next(linecycler),label=key)
    ax.legend()
    
    if savefig:
        newFig.savefig(figpath+figname,dpi=300)
    
    return