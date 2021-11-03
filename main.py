import sys
sys.path.append('.')

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

# NOT 5

i = 5

INPUT_FILE  = "F:\PhD\RailML\Example_"+str(i)+".railml"
OUTPUT_FILE = "F:\PhD\RailML\Example_"+str(i)+"_B.railml"

RML = railML.railML()

if __name__ == "__main__":
    # Call RNA
    try:
        RNA.RNA(RML,INPUT_FILE,OUTPUT_FILE,True,True)
        # Call ACG
        try:
            ACG.ACG()
        except:
            print("ACG had an error")   
        # Call AGG
        try:
            AGG.AGG()
        except:
            print("AGG had an error")       
    except:
        print("RNA had an error")

    # Call ATA
    try:
        ATA.ATA()    
        # Call ATG
        try:
            ATG.ATG()
        except:
            print("ATG had an error")
    except:
        print("ATA had an error")