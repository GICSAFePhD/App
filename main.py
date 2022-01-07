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

i = 8


INPUT_FILE  = "F:\PhD\RailML\Example_"+str(i)+".railml"
OUTPUT_FILE = "F:\PhD\RailML\Example_"+str(i)+"_B.railml"

RML = railML.railML()

if __name__ == "__main__":
    # Call RNA
    try:
        RNA.RNA(RML,INPUT_FILE,OUTPUT_FILE,False,True)
        # Call ACG
        try:
            ACG.ACG()
        except Exception as e:
            print(f'ACG had an error: {e}') 
        # Call AGG
        try:
            AGG.AGG()
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