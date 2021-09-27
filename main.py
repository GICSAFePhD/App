import sys
sys.path.append('.')


from RailML import railML
from RailML.Common import Metadata
from RailML.Common import Common
from RailML.Infrastructure import Infrastructure
from RailML.Interlocking import Interlocking
from RailML import aRailML

from RNA import RNA

INPUT_FILE = "F:\PhD\RailML\Example_1.railml"
OUTPUT_FILE = file = "F:\PhD\RailML\Example_1_B.railml"

RML = railML.railML()

if __name__ == "__main__":
    # Call RNA
    RNA.RNA(RML,INPUT_FILE,OUTPUT_FILE)
    
    
    
    # Call ATG
    # Call ACG
    # Call AGG
    
    
    #print(dir(RML.Common.Positioning.GeometricPositioningSystems.GeometricPositioningSystem))
    
    
        
    #x = RML.Infrastructure.Topology.Networks.Network[0]
    #y = get_attributes(x)
    #print(x,y)
    #for i in y:
    #    z = getattr(x,i)
    #    if z != None:
    #        print(i,z)   
