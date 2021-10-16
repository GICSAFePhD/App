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

INPUT_FILE  = "F:\PhD\RailML\Example_3.railml"
OUTPUT_FILE = "F:\PhD\RailML\Example_1_B.railml"

RML = railML.railML()

if __name__ == "__main__":
    # Call RNA
    RNA.RNA(RML,INPUT_FILE,OUTPUT_FILE,True)
    
    # Call ATA
    ATA.ATA()
    # Call ATG
    ATG.ATG()
    # Call ACG
    ACG.ACG()
    # Call AGG
    AGG.AGG()